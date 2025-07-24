require_relative 'kubernetes_metadata_common'

module KubernetesMetadata
  module WatchNamespaces
    include ::KubernetesMetadata::Common

    def set_up_namespace_thread
      log.info("set_up_namespace_thread")
      # Any failures / exceptions in the initial setup should raise
      # Fluent:ConfigError, so that users can inspect potential errors in
      # the configuration.
      namespace_watcher = start_namespace_watch
      Thread.current[:namespace_watch_retry_backoff_interval] = @watch_retry_interval
      Thread.current[:namespace_watch_retry_count] = 0

      # Any failures / exceptions in the followup watcher notice
      # processing will be swallowed and retried. These failures /
      # exceptions could be caused by Kubernetes API being temporarily
      # down. We assume the configuration is correct at this point.
      loop do
        namespace_watcher ||= get_namespaces_and_start_watcher
        process_namespace_watcher_notices(namespace_watcher)
      rescue GoneError => e
        # Expected error. Quietly go back through the loop in order to
        # start watching from the latest resource versions
        @stats.bump(:namespace_watch_gone_errors)
        log.info('410 Gone encountered. Restarting namespace watch to reset resource versions.', e)
        namespace_watcher = nil
      rescue KubeException => e
        if e.error_code == 401
          # recreate client to refresh token
          log.info("Encountered '401 Unauthorized' exception in watch, recreating client to refresh token")
          create_client()
          namespace_watcher = nil
        else
          # treat all other errors the same as StandardError, log, swallow and reset
          @stats.bump(:namespace_watch_failures)
          if Thread.current[:namespace_watch_retry_count] < @watch_retry_max_times
            # Instead of raising exceptions and crashing Fluentd, swallow
            # the exception and reset the watcher.
            log.info(
              'Exception encountered parsing namespace watch event. ' \
              'The connection might have been closed. Sleeping for ' \
              "#{Thread.current[:namespace_watch_retry_backoff_interval]} " \
              'seconds and resetting the namespace watcher.', e
            )
            sleep(Thread.current[:namespace_watch_retry_backoff_interval])
            Thread.current[:namespace_watch_retry_count] += 1
            Thread.current[:namespace_watch_retry_backoff_interval] *= @watch_retry_exponential_backoff_base
            namespace_watcher = nil
          else
            # Since retries failed for many times, log as errors instead
            # of info and raise exceptions and trigger Fluentd to restart.
            message =
              'Exception encountered parsing namespace watch event. The ' \
              'connection might have been closed. Retried ' \
              "#{@watch_retry_max_times} times yet still failing. Restarting."
            log.error(message, e)
            raise Fluent::UnrecoverableError, message
          end
        end
      rescue StandardError => e
        @stats.bump(:namespace_watch_failures)
        if Thread.current[:namespace_watch_retry_count] < @watch_retry_max_times
          # Instead of raising exceptions and crashing Fluentd, swallow
          # the exception and reset the watcher.
          log.info(
            'Exception encountered parsing namespace watch event. ' \
            'The connection might have been closed. Sleeping for ' \
            "#{Thread.current[:namespace_watch_retry_backoff_interval]} " \
            'seconds and resetting the namespace watcher.', e
          )
          sleep(Thread.current[:namespace_watch_retry_backoff_interval])
          Thread.current[:namespace_watch_retry_count] += 1
          Thread.current[:namespace_watch_retry_backoff_interval] *= @watch_retry_exponential_backoff_base
          namespace_watcher = nil
        else
          # Since retries failed for many times, log as errors instead
          # of info and raise exceptions and trigger Fluentd to restart.
          message =
            'Exception encountered parsing namespace watch event. The ' \
            'connection might have been closed. Retried ' \
            "#{@watch_retry_max_times} times yet still failing. Restarting."
          log.error(message, e)
          raise Fluent::UnrecoverableError, message
        end
      end
    end

    def start_namespace_watch
      get_namespaces_and_start_watcher
    rescue StandardError => e
      message = 'start_namespace_watch: Exception encountered setting up ' \
                "namespace watch from Kubernetes API #{@apiVersion} endpoint " \
                "#{@kubernetes_url}: #{e.message}"
      message += " (#{e.response})" if e.respond_to?(:response)
      log.debug(message)

      raise Fluent::ConfigError, message
    end

    # List all namespaces, record the resourceVersion and return a watcher
    # starting from that resourceVersion.
    def get_namespaces_and_start_watcher
      log.info("get_namespaces_and_start_watcher")
      options = get_namespaces
      # continue watching from most recent resourceVersion (in options)
      watcher = @client.watch_namespaces(options)
      reset_namespace_watch_retry_stats
      watcher
    end

    def get_namespaces
      options = {
        resource_version: '0' # Fetch from API server cache instead of etcd quorum read
      }
      namespaces = @client.get_namespaces(options)
      namespaces[:items].each do |namespace|
        cache_key = namespace[:metadata][:name]
        @namespace_cache[cache_key] = parse_namespace_metadata(namespace)
        @stats.bump(:namespace_cache_init_size)
      end
      options[:resource_version] = namespaces[:metadata][:resourceVersion]
    end

    # Reset namespace watch retry count and backoff interval as there is a
    # successful watch notice.
    def reset_namespace_watch_retry_stats
      Thread.current[:namespace_watch_retry_count] = 0
      Thread.current[:namespace_watch_retry_backoff_interval] = @watch_retry_interval
    end

    # Process a watcher notice and potentially raise an exception.
    def process_namespace_watcher_notices(watcher)
      log.info("process_namespace_watcher_notices")

      watcher.each do |notice|
        case notice[:type]
        when 'MODIFIED'
          reset_namespace_watch_retry_stats
          cache_key = notice[:object][:metadata][:name]
          if @namespace_cache[cache_key]
            @stats.bump(:namespace_cache_modify)
          else
            @stats.bump(:namespace_cache_modify_no_init)
          end
          @namespace_cache[cache_key] = parse_namespace_metadata(notice[:object])
        when 'ADDED'
          reset_namespace_watch_retry_stats
          cache_key = notice[:object][:metadata][:name]
          if @namespace_cache[cache_key]
            @stats.bump(:namespace_cache_add_already_init)
          else
            @stats.bump(:namespace_cache_add)
          end
          @namespace_cache[cache_key] = parse_namespace_metadata(notice[:object])
        when 'DELETED'
          reset_namespace_watch_retry_stats
          # ignore and let age out for cases where
          # deleted but still processing logs
          @stats.bump(:namespace_cache_deletes_ignored)
        when 'ERROR'
          if notice[:object] && notice[:object][:code] == 410
            @stats.bump(:namespace_watch_gone_notices)
            raise GoneError
          else
            @stats.bump(:namespace_watch_error_type_notices)
            message = notice[:object][:message] if notice[:object] && notice[:object][:message]
            raise "Error while watching namespaces: #{message}"
          end
        else
          reset_namespace_watch_retry_stats
          @stats.bump(:namespace_cache_watch_ignored)
        end
      end
    end
  end
end
