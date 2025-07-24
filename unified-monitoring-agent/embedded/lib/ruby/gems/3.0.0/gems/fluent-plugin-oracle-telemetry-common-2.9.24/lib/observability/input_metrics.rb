# Copyright (c) 2024, Oracle and/or its affiliates.  All rights reserved.
require 'observability/base_metrics'
require 'uri'

module AgentObservability
  module InputPluginMetrics
    include AgentObservability::BaseMetrics

    # This map keeps track of "up" metrics per plugin.
    # for e.g. {"openmetrics"=>{"up"=>{"target1"=>0/1}}}, "openmetrics_k8s"=>{"up"=>{"target2"=>0/1}}}
    UP_METRIC_NAME = "Up".freeze
    ENDPOINT = "endpoint".freeze
    ENDPOINT_STATUS_MAP = {}
    @@endpoint_lock = Thread::Mutex.new

    # Update the status for a given plugin/target endpoint
    def update_target_status_map(plugin_type, full_target, tag, is_up)
      log.debug "update_target_status_map(#{plugin_type}, #{full_target}, #{tag}, #{is_up})" 

      begin
        uri = URI.parse(full_target)
        if uri.kind_of?(URI::HTTP)
          target = "#{uri.scheme}://#{uri.host}:#{uri.port}#{uri.path}"
        else
          target = full_target.downcase
        end
        @@endpoint_lock.synchronize do
          if !ENDPOINT_STATUS_MAP.key?(plugin_type)
            ENDPOINT_STATUS_MAP[plugin_type] = {}
          end

          ENDPOINT_STATUS_MAP[plugin_type][target] = {}
          ENDPOINT_STATUS_MAP[plugin_type][target]["tag"] = tag
          ENDPOINT_STATUS_MAP[plugin_type][target]["up"] = is_up
        end
      rescue => e
        log.warn "Unable generate metric for #{full_target}: #{e}"
      end
    end

    def emit_input_plugin_metrics(es, time)

      if ENDPOINT_STATUS_MAP.empty?
        return
      end
      # Grab a copy to process, reset the global map for more updates
      copy_map = {}
      @@endpoint_lock.synchronize do
        copy_map = ENDPOINT_STATUS_MAP.clone()
        ENDPOINT_STATUS_MAP.clear()
      end

      copy_map.each_pair do |plugin_type, plugin_type_value|
        if !copy_map.key?(plugin_type)
          next
        end
        plugin_type_value.each_pair do |target, record|
          if @metrics.include?(UP_METRIC_NAME)
            rec = base_record()
            rec[NAME] = UP_METRIC_NAME
            rec[:datapoints] = [datapoint(time, record["up"])]
            dims = rec.fetch(DIMENSIONS, {})
            unless record["tag"] == nil
              dims[CONFIG_TAG] = record["tag"]
            end
            dims[TYPE] = plugin_type
            dims[ENDPOINT] = target
            unless @agentVersion == nil
              dims[UMA_VERSION] = @agentVersion
            end
            populate_default_dims(dims)

            rec[DIMENSIONS] = dims
            es.add(time, rec)
          end
        end
      end
    end
  end
end
