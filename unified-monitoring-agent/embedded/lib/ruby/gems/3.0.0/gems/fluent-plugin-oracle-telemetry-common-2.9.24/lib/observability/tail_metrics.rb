# Copyright (c) 2024, Oracle and/or its affiliates.  All rights reserved.
require 'observability/base_metrics'

module AgentObservability
    module TailMetrics
        include AgentObservability::BaseMetrics

        # frozen_string_literal: true
        # Metric names and the default values of some variables
        OPEN_FILE_COUNT_METRIC_NAME = "OpenFileCount"
        ROTATED_FILE_COUNT_METRIC_NAME = "RotatedFileCount"
        CLOSED_FILE_COUNT_METRIC_NAME = "ClosedFileCount"

        OPEN_FILE_COUNT_QUERY_NAME = "opened_file_count"
        ROTATED_FILE_COUNT_QUERY_NAME = "rotated_file_count"
        CLOSED_FILE_COUNT_QUERY_NAME = "closed_file_count"

        def get_tail_plugins
            ip = []
            ret_op = []
            ip.concat(Fluent::Engine.root_agent.instance_variable_get(:@inputs))

            ip.map do |pe|
                if pe.config['@type'] == 'tail'
                    ret_op.append(pe)
                end
            end
            ret_op
        end

        def emit_tail_metrics(es, time)
            @tail_plugins.map do |pe|
                stats = pe.statistics['input']

                match_tag  = pe.config['tag']
                match_path = pe.config['path']

                stats.each do |key, val|
                    next if key.include? "emit" # Not interested in these records for now

                    rec = base_record()
                    
                    is_tail_metric = false
                    if key == OPEN_FILE_COUNT_QUERY_NAME
                        rec[NAME] = OPEN_FILE_COUNT_METRIC_NAME
                        is_tail_metric = true
                    elsif key == ROTATED_FILE_COUNT_QUERY_NAME
                        rec[NAME] = ROTATED_FILE_COUNT_METRIC_NAME
                        is_tail_metric = true
                    elsif key == CLOSED_FILE_COUNT_QUERY_NAME
                        rec[NAME] = CLOSED_FILE_COUNT_METRIC_NAME
                        is_tail_metric = true
                    end
                    if is_tail_metric == true
                        rec[:datapoints] = [datapoint(time, val)]
                        dims = rec.fetch(DIMENSIONS, {})

                        dims[CONFIG_TAG] = match_tag
                        dims['path'] = match_path

                        populate_default_dims(dims)

                        rec[DIMENSIONS] = dims
                        if @is_uma_metrics == true && @metrics.include?(rec[NAME])
                            es.add(time, rec)
                        elsif @is_uma_metrics == false
                            rec_instance_level = base_record()
                            rec_instance_level[NAME] = @hostClass + "." + rec[NAME] + INSTANCE_LEVEL_METRIC_NAME_SUFFIX
                            rec_instance_level[RESOURCE_GROUP] = @hostClass
                            rec_instance_level[:datapoints] = [datapoint(time, val)]
                            dims_instanceLevel = Marshal.load(Marshal.dump(dims))
                            dims_instanceLevel.delete(HOSTCLASS) if dims_instanceLevel.key?(HOSTCLASS)
                            populate_default_dims_instanceLevel(dims_instanceLevel)
                            rec_instance_level[DIMENSIONS] = dims_instanceLevel
                            es.add(time, rec_instance_level)
                        else
                            next
                        end
                    end
                end
            end
        end
    end
end
