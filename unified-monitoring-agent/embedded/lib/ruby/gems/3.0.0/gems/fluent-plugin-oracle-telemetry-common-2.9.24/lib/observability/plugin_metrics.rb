# Copyright (c) 2024, Oracle and/or its affiliates.  All rights reserved.

require 'observability/base_metrics'

module AgentObservability
  module PluginMetrics
    include AgentObservability::BaseMetrics

    # frozen_string_literal: true
    UMA_METRICS_PLUGIN_TYPE = "uma_metrics"
    GRIFFIN_METRICS_PLUGIN_TYPE = "agent_metrics"
    EMIT_RECORDS_METRIC_NAME = "emit_records"
    EMIT_RECORDS_UMA_METRIC_NAME = "EmitRecords"
    OUTPUT_LOGLINES = "output.logLinesProduced"

    # Metric names and the default values of some variables
    EMIT_SIZE_METRIC_NAME = "EmitSize"
    RETRY_COUNT_METRIC_NAME = "RetryCount"
    EMIT_COUNT_METRIC_NAME = "EmitCount"
    WRITE_COUNT_METRIC_NAME = "WriteCount"
    ROLLBACK_COUNT_METRIC_NAME = "RollbackCount"
    SLOW_FLUSH_COUNT_METRIC_NAME = "SlowFlushCount"
    FLUSH_TIME_COUNT_METRIC_NAME = "FlushTimeCount"
    BUFFER_STAGE_LENGTH_METRIC_NAME = "BufferStageLength"
    BUFFER_STAGE_BYTE_SIZE_METRIC_NAME = "BufferStageByteSize"
    BUFFER_QUEUE_LENGTH_METRIC_NAME = "BufferQueueLength"
    BUFFER_QUEUE_BYTE_SIZE_METRIC_NAME = "BufferQueueByteSize"
    BUFFER_AVAILABLE_BUFFER_SPACE_RATIOS_METRIC_NAME = "BufferSpaceAvailable"
    BUFFER_TOTAL_QUEUED_SIZE_METRIC_NAME = "BufferTotalQueuedSize"

    EMIT_SIZE_QUERY_NAME = "emit_size"
    RETRY_COUNT_QUERY_NAME = "retry_count"
    EMIT_COUNT_QUERY_NAME = "emit_count"
    WRITE_COUNT_QUERY_NAME = "write_count"
    ROLLBACK_COUNT_QUERY_NAME = "rollback_count"
    SLOW_FLUSH_COUNT_QUERY_NAME = "slow_flush_count"
    FLUSH_TIME_COUNT_QUERY_NAME = "flush_time_count"
    BUFFER_STAGE_LENGTH_QUERY_NAME = "buffer_stage_length"
    BUFFER_STAGE_BYTE_SIZE_QUERY_NAME = "buffer_stage_byte_size"
    BUFFER_QUEUE_LENGTH_QUERY_NAME = "buffer_queue_length"
    BUFFER_QUEUE_BYTE_SIZE_QUERY_NAME = "buffer_queue_byte_size"
    BUFFER_AVAILABLE_BUFFER_SPACE_RATIOS_QUERY_NAME = "buffer_available_buffer_space_ratios"
    BUFFER_TOTAL_QUEUED_SIZE_QUERY_NAME = "buffer_total_queued_size"

    def get_output_plugins
      op = []
      ret_op = []
      # get all output plugins
      op.concat(Fluent::Engine.root_agent.outputs)

      # also from labels: https://docs.fluentd.org/quickstart/life-of-a-fluentd-event#labels
      Fluent::Engine.root_agent.labels.each { |_, l| op.concat(l.outputs) }

      op.map do |pe|
        # This will work with all types of output plugins except for the out_monitoring plugin corresponding to in_uma_metrics input plugin.
        # The way it is filtered is using the @id field which has the specific value of uma_metrics.
        if pe.respond_to?(:statistics)
          if pe.config['@type'] == OCI_MONITORING_PLUGIN_TYPE && pe.config.has_key?("@id") && pe.config['@id'].start_with?(UMA_METRICS_PLUGIN_TYPE)
            next
          end
          ret_op.append(pe)
        end
      end
      ret_op
    end


    def emit_plugin_metrics(es, time)
      @output_plugins.map do |pe|
        stats = pe.statistics['output']
        match_line  = pe.config.to_s.lines.first.chomp.split[1]
        match_tag = match_line.nil? ? '' : match_line[0...-1]

        stats.each do |key, val|
          rec = base_record()
          rec[:datapoints] = [datapoint(time, val)]
          dims = rec.fetch(DIMENSIONS, {})
          dims[CONFIG_TAG] = match_tag
          populate_default_dims(dims)
          rec[DIMENSIONS] = dims

          if key == EMIT_RECORDS_METRIC_NAME && @is_uma_metrics == false
            rec[NAME] = OUTPUT_LOGLINES
          elsif key == EMIT_RECORDS_METRIC_NAME && @is_uma_metrics == true && @metrics.include?(EMIT_RECORDS_UMA_METRIC_NAME)
            rec[NAME] = EMIT_RECORDS_UMA_METRIC_NAME
          else
            if @metrics_map.values.include?(key) && (@is_uma_metrics == false || (@is_uma_metrics == true && @metrics.include?(@metrics_map.key(key))))
              rec[NAME] = @metrics_map.key(key)
            else
              next
            end
          end

          if @is_uma_metrics == true
            populate_default_dims_instanceLevel(dims)
          end

          if key == EMIT_RECORDS_METRIC_NAME || is_uma_metrics == true
            es.add(time, rec)
          end

          if @is_uma_metrics == false
            rec_instance_level = base_record()
            rec_instance_level[NAME] = @hostClass+'.' + rec[NAME] + INSTANCE_LEVEL_METRIC_NAME_SUFFIX
            rec_instance_level[RESOURCE_GROUP] = @hostClass
            rec_instance_level[:datapoints] = [datapoint(time, val)]
            dims_instanceLevel = Marshal.load(Marshal.dump(dims))
            dims_instanceLevel.delete(HOSTCLASS) if dims_instanceLevel.key?(HOSTCLASS)
            populate_default_dims_instanceLevel(dims_instanceLevel)
            rec_instance_level[DIMENSIONS] = dims_instanceLevel
            es.add(time, rec_instance_level)
          end
        end
      end
    end

    ## Mapping between external metrics name and the query name
    # External metrics name will be included in the record
    # query name will be used to get value of the metric

    def set_metrics_map(query_map)
      query_map[EMIT_SIZE_METRIC_NAME] = EMIT_SIZE_QUERY_NAME
      query_map[RETRY_COUNT_METRIC_NAME] = RETRY_COUNT_QUERY_NAME
      query_map[EMIT_COUNT_METRIC_NAME] = EMIT_COUNT_QUERY_NAME
      query_map[WRITE_COUNT_METRIC_NAME] = WRITE_COUNT_QUERY_NAME
      query_map[ROLLBACK_COUNT_METRIC_NAME] = ROLLBACK_COUNT_QUERY_NAME
      query_map[SLOW_FLUSH_COUNT_METRIC_NAME] = SLOW_FLUSH_COUNT_QUERY_NAME
      query_map[FLUSH_TIME_COUNT_METRIC_NAME] = FLUSH_TIME_COUNT_QUERY_NAME
      query_map[BUFFER_STAGE_LENGTH_METRIC_NAME] = BUFFER_STAGE_LENGTH_QUERY_NAME
      query_map[BUFFER_STAGE_BYTE_SIZE_METRIC_NAME] = BUFFER_STAGE_BYTE_SIZE_QUERY_NAME
      query_map[BUFFER_QUEUE_LENGTH_METRIC_NAME] = BUFFER_QUEUE_LENGTH_QUERY_NAME
      query_map[BUFFER_QUEUE_BYTE_SIZE_METRIC_NAME] = BUFFER_QUEUE_BYTE_SIZE_QUERY_NAME
      query_map[BUFFER_AVAILABLE_BUFFER_SPACE_RATIOS_METRIC_NAME] = BUFFER_AVAILABLE_BUFFER_SPACE_RATIOS_QUERY_NAME
      query_map[BUFFER_TOTAL_QUEUED_SIZE_METRIC_NAME] = BUFFER_TOTAL_QUEUED_SIZE_QUERY_NAME
    end
  end
end