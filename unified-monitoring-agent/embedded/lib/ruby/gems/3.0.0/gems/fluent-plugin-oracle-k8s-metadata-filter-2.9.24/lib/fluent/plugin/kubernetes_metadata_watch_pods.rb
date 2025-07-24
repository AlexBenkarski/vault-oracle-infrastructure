# frozen_string_literal: true

#
# Fluentd Kubernetes Metadata Filter Plugin - Enrich Fluentd events with
# Kubernetes metadata
#
# Copyright 2017 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# TODO: this is mostly copy-paste from kubernetes_metadata_watch_namespaces.rb unify them
require_relative 'kubernetes_metadata_common'

module KubernetesMetadata
  module WatchPods
    include ::KubernetesMetadata::Common

    def set_up_pod_thread
      log.info("set_up_pod_thread")
      # Any failures / exceptions in the initial setup should raise
      # Fluent:ConfigError, so that users can inspect potential errors in
      # the configuration.
      pod_watcher = start_pod_watch
      Thread.current[:pod_watch_retry_backoff_interval] = @watch_retry_interval
      Thread.current[:pod_watch_retry_count] = 0

      # Any failures / exceptions in the followup watcher notice
      # processing will be swallowed and retried. These failures /
      # exceptions could be caused by Kubernetes API being temporarily
      # down. We assume the configuration is correct at this point.
      loop do
        pod_watcher ||= get_pods_and_start_watcher
        process_pod_watcher_notices(pod_watcher)
      rescue GoneError => e
        # Expected error. Quietly go back through the loop in order to
        # start watching from the latest resource versions
        @stats.bump(:pod_watch_gone_errors)
        log.info('410 Gone encountered. Restarting pod watch to reset resource versions.', e)
        pod_watcher = nil
        @last_seen_resource_version = nil
      rescue KubeException => e
        if e.error_code == 401
          # recreate client to refresh token
          log.info("Encountered '401 Unauthorized' exception in watch, recreating client to refresh token")
          create_client()
          pod_watcher = nil
        else
          # treat all other errors the same as StandardError, log, swallow and reset
          @stats.bump(:pod_watch_failures)
          if Thread.current[:pod_watch_retry_count] < @watch_retry_max_times
            # Instead of raising exceptions and crashing Fluentd, swallow
            # the exception and reset the watcher.
            log.info(
              'Exception encountered parsing pod watch event. The ' \
              'connection might have been closed. Sleeping for ' \
              "#{Thread.current[:pod_watch_retry_backoff_interval]} " \
              'seconds and resetting the pod watcher.', e
            )
            sleep(Thread.current[:pod_watch_retry_backoff_interval])
            Thread.current[:pod_watch_retry_count] += 1
            Thread.current[:pod_watch_retry_backoff_interval] *= @watch_retry_exponential_backoff_base
            pod_watcher = nil
          else
            # Since retries failed for many times, log as errors instead
            # of info and raise exceptions and trigger Fluentd to restart.
            message =
              'Exception encountered parsing pod watch event. The ' \
              'connection might have been closed. Retried ' \
              "#{@watch_retry_max_times} times yet still failing. Restarting."
            log.error(message, e)
            raise Fluent::UnrecoverableError, message
          end
        end
      rescue StandardError => e
        @stats.bump(:pod_watch_failures)
        if Thread.current[:pod_watch_retry_count] < @watch_retry_max_times
          # Instead of raising exceptions and crashing Fluentd, swallow
          # the exception and reset the watcher.
          log.info(
            'Exception encountered parsing pod watch event. The ' \
            'connection might have been closed. Sleeping for ' \
            "#{Thread.current[:pod_watch_retry_backoff_interval]} " \
            'seconds and resetting the pod watcher.', e
          )
          sleep(Thread.current[:pod_watch_retry_backoff_interval])
          Thread.current[:pod_watch_retry_count] += 1
          Thread.current[:pod_watch_retry_backoff_interval] *= @watch_retry_exponential_backoff_base
          pod_watcher = nil
        else
          # Since retries failed for many times, log as errors instead
          # of info and raise exceptions and trigger Fluentd to restart.
          message =
            'Exception encountered parsing pod watch event. The ' \
            'connection might have been closed. Retried ' \
            "#{@watch_retry_max_times} times yet still failing. Restarting."
          log.error(message, e)
          raise Fluent::UnrecoverableError, message
        end
      end
    end

    def start_pod_watch
      get_pods_and_start_watcher
    rescue StandardError => e
      message = 'start_pod_watch: Exception encountered setting up pod watch ' \
                "from Kubernetes API #{@apiVersion} endpoint " \
                "#{@kubernetes_url}: #{e.message}"
      message += " (#{e.response})" if e.respond_to?(:response)
      log.debug(message)

      raise Fluent::ConfigError, message
    end

    # List all pods, record the resourceVersion and return a watcher starting
    # from that resourceVersion.
    def get_pods_and_start_watcher
      log.info("get_pods_and_start_watcher")
      options = get_pods
      # continue watching from most recent resourceVersion (in options)
      watcher = @client.watch_pods(options)
      reset_pod_watch_retry_stats
      watcher
    end

    def get_pods
      options = {
        resource_version: '0' # Fetch from API server cache instead of etcd quorum read
      }
      # TODO: why do this just for pods?
      if @node_agent
        options[:field_selector] = 'spec.nodeName=' + ENV['NODE_NAME']
      end
      if @last_seen_resource_version
        options[:resource_version] = @last_seen_resource_version
      else
        pods = @client.get_pods(options)
        pods[:items].each do |pod|
          cache_key = pod[:metadata][:namespace] + ":" + pod[:metadata][:name]
          @pod_cache[cache_key] = parse_pod_metadata(pod)
          @stats.bump(:pod_cache_init_size)
        end

        options[:resource_version] = pods[:metadata][:resourceVersion]
      end
      options
    end

    # Reset pod watch retry count and backoff interval as there is a
    # successful watch notice.
    def reset_pod_watch_retry_stats
      Thread.current[:pod_watch_retry_count] = 0
      Thread.current[:pod_watch_retry_backoff_interval] = @watch_retry_interval
    end

    # Process a watcher notice and potentially raise an exception.
    def process_pod_watcher_notices(watcher)
      log.info("process_pod_watcher_notices")

      watcher.each do |notice|
        # store version we processed to not reprocess it ... do not unset when there is no version in response
        version = ( # TODO: replace with &.dig once we are on ruby 2.5+
          notice[:object] && notice[:object][:metadata] && notice[:object][:metadata][:resourceVersion]
        )
        @last_seen_resource_version = version if version

        case notice[:type]
        when 'MODIFIED'
          reset_pod_watch_retry_stats
          cache_key = notice.dig(:object, :metadata, :namespace) + ':' + notice.dig(:object, :metadata, :name)
          if @pod_cache[cache_key]
            @stats.bump(:pod_cache_modify)
          else
            @stats.bump(:pod_cache_modify_no_init)
          end
          @pod_cache[cache_key] = parse_pod_metadata(notice[:object])
        when 'ADDED'
          reset_pod_watch_retry_stats
          cache_key = notice.dig(:object, :metadata, :namespace) + ':' + notice.dig(:object, :metadata, :name)
          if @pod_cache[cache_key]
            @stats.bump(:pod_cache_add_already_init)
          else
            @stats.bump(:pod_cache_add)
          end
          @pod_cache[cache_key] = parse_pod_metadata(notice[:object])
        when 'DELETED'
          reset_pod_watch_retry_stats
          # ignore and let age out for cases where pods
          # deleted but still processing logs
          @stats.bump(:pod_cache_deletes_ignored)
        when 'ERROR'
          if notice[:object] && notice[:object][:code] == 410
            @stats.bump(:pod_watch_gone_notices)
            raise GoneError
          else
            @stats.bump(:pod_watch_error_type_notices)
            message = notice[:object][:message] if notice[:object] && notice[:object][:message]
            raise "Error while watching pods: #{message}"
          end
        else
          reset_pod_watch_retry_stats
          @stats.bump(:pod_cache_watch_ignored)
        end
      end
    end
  end
end
