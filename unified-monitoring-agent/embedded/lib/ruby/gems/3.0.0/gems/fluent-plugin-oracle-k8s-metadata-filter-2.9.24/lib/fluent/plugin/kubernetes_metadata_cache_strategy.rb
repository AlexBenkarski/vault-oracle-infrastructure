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
module KubernetesMetadata
  module CacheStrategy
    def get_pod_metadata(pod_name, namespace_name)
      log.trace("get_pod_metadata: #{namespace_name}/#{pod_name}")

      cache_key = "#{namespace_name}:#{pod_name}"
      metadata = @pod_cache.fetch(cache_key)
      metadata = fetch_pod_metadata(namespace_name, pod_name)  if metadata.nil?
      # TODO: need this??
      metadata.delete_if { |_k, v| v.nil? }
    end

    def get_ns_metadata(namespace_name)
      log.debug("get_ns_metadata: #{namespace_name}")

      metadata = @namespace_cache.fetch(namespace_name)
      metadata = fetch_namespace_metadata(namespace_name) if metadata.nil?
      metadata.delete_if { |_k, v| v.nil? }
    end

    def get_node_metadata(node_name)
      log.trace("get_node_metadata: #{node_name}")

      metadata = @node_cache.fetch(node_name)
      metadata = fetch_node_metadata(node_name) if metadata.nil?
      metadata.delete_if { |_k, v| v.nil? }
    end

    def fetch_pod_metadata(namespace_name, pod_name)
      begin
        options = {
          resource_version: '0' # Fetch from API server cache instead of etcd quorum read
        }
        pod_object = @client.get_pod(pod_name, namespace_name, options)
        log.trace("raw metadata for #{namespace_name}/#{pod_name}: #{pod_object}")
        metadata = parse_pod_metadata(pod_object)
        @stats.bump(:pod_cache_api_updates)
        cache_key = namespace_name + ':' + pod_name
        @pod_cache[cache_key] = metadata
      rescue KubeException => e
        if e.error_code == 401
          # recreate client to refresh token
          log.info("Encountered '401 Unauthorized' exception, recreating client to refresh token")
          create_client()
        elsif e.error_code == 404
          log.debug "Encountered '404 Not Found' exception, pod not found"
          @stats.bump(:pod_cache_api_nil_error)
        else
          log.error "Exception '#{e}' encountered fetching pod metadata from Kubernetes API #{@apiVersion} endpoint #{@kubernetes_url}"
          @stats.bump(:pod_cache_api_nil_error)
        end
        {}
      rescue StandardError => e
        @stats.bump(:pod_cache_api_nil_error)
        log.error "Exception '#{e}' encountered fetching pod metadata from Kubernetes API #{@apiVersion} endpoint #{@kubernetes_url}"
        {}
      end
    end

    def fetch_namespace_metadata(namespace_name)
      begin
        options = {
          resource_version: '0' # Fetch from API server cache instead of etcd quorum read
        }
        namespace_object = @client.get_namespace(namespace_name, nil, options)
        log.trace("raw metadata for #{namespace_name}: #{namespace_object}")
        metadata = parse_namespace_metadata(namespace_object)
        @stats.bump(:namespace_cache_api_updates)
        @namespace_cache[namespace_name] = metadata
      rescue KubeException => e
        if e.error_code == 401
          # recreate client to refresh token
          log.info("Encountered '401 Unauthorized' exception, recreating client to refresh token")
          create_client()
        else
          log.error "Exception '#{e}' encountered fetching namespace metadata from Kubernetes API #{@apiVersion} endpoint #{@kubernetes_url}"
          @stats.bump(:namespace_cache_api_nil_error)
        end
        {}
      rescue StandardError => e
        @stats.bump(:namespace_cache_api_nil_error)
        log.error "Exception '#{e}' encountered fetching namespace metadata from Kubernetes API #{@apiVersion} endpoint #{@kubernetes_url}"
        {}
      end
    end

    def fetch_node_metadata(node_name)
      begin
        options = {
          resource_version: '0' # Fetch from API server cache instead of etcd quorum read
        }
        node_object = @client.get_node(node_name, nil, options)
        log.trace("raw metadata for #{node_name}: #{node_object}")
        metadata = parse_node_metadata(node_object)
        @stats.bump(:node_cache_api_updates)
        @node_cache[node_name] = metadata
      rescue KubeException => e
        if e.error_code == 401
          # recreate client to refresh token
          log.info("Encountered '401 Unauthorized' exception, recreating client to refresh token")
          create_client()
        else
          log.error "Exception '#{e}' encountered fetching node metadata from Kubernetes API #{@apiVersion} endpoint #{@kubernetes_url}"
          @stats.bump(:node_cache_api_nil_error)
        end
        {}
      rescue StandardError => e
        @stats.bump(:node_cache_api_nil_error)
        log.error "Exception '#{e}' encountered fetching node metadata from Kubernetes API #{@apiVersion} endpoint #{@kubernetes_url}"
        {}
      end
    end
  end
end
