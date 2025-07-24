# Copyright (c) 2024, Oracle and/or its affiliates.  All rights reserved.
require 'observability/base_metrics'

module AgentObservability
  module OutputPluginResponseMetrics
    include AgentObservability::BaseMetrics

    RESPONSE_2XX_METRIC_NAME = "OutputResponse_2XX"
    RESPONSE_4XX_METRIC_NAME = "OutputResponse_4XX"
    RESPONSE_5XX_METRIC_NAME = "OutputResponse_5XX"

    RESPONSE_CODE = :response_code
    # This map keeps count corresponding to various response code(2XX, 4XX, 5XX) for output plugins.
    # for e.g. {"oci_logging"=>{"2xx"=>{"200"=>{"tag1"=>2, "tag2"=>1}}}, "oci_monitoring"=>{"2xx"=>{"200"=>{"monitoring"=>1}}}}
    RESPONSE_CODE_MAP = {"oci_monitoring"=>{"2XX"=>{"200"=>{}}, "4XX"=>{"400"=>{}}, "5XX"=> {"500"=>{}}}}

    # This method updates the RESPONSE_CODE_MAP hash i,e, update count for the plugin_type, response_code and tag combination
    def update_output_plugin_response_map(plugin_type, response_code, tag)
      response_code_category = ""
      if response_code.class == String
        response_code = response_code.to_i
      end
      if response_code >= 200 && response_code < 300
        response_code_category = "2XX"
      elsif response_code >= 400 && response_code < 500
        response_code_category = "4XX"
      elsif response_code >= 500 && response_code < 600
        response_code_category = "5XX"
      end
      response_code = response_code.to_s
      if response_code_category == ""
        log.info "response code is not in valid range: Got response code = #{response_code} from plugin = #{plugin_type} and tag = #{tag}"
        return
      end

      if !RESPONSE_CODE_MAP.key?(plugin_type)
        RESPONSE_CODE_MAP[plugin_type] = {}
      end

      if !RESPONSE_CODE_MAP[plugin_type].key?(response_code_category)
        RESPONSE_CODE_MAP[plugin_type][response_code_category] = {}
        if !RESPONSE_CODE_MAP[plugin_type][response_code_category].key(response_code)
          RESPONSE_CODE_MAP[plugin_type][response_code_category][response_code]={}
        end
      end

      if RESPONSE_CODE_MAP[plugin_type][response_code_category][response_code].key?(tag)
        RESPONSE_CODE_MAP[plugin_type][response_code_category][response_code][tag] = RESPONSE_CODE_MAP[plugin_type][response_code_category][response_code][tag] + 1
      else
        RESPONSE_CODE_MAP[plugin_type][response_code_category][response_code][tag] = 1
      end
    end

    def get_response_metric_name(response_code)
      if response_code == "2XX"
        return RESPONSE_2XX_METRIC_NAME
      elsif response_code == "4XX"
        return RESPONSE_4XX_METRIC_NAME
      elsif response_code == "5XX"
        return RESPONSE_5XX_METRIC_NAME
      end
      return nil
    end

    def add_metric_to_stream(plugin_type, metric_name, response_code, tag, tag_count, es, time)
      if (@is_uma_metrics == true && @metrics.include?(metric_name)) || @is_uma_metrics == false
        rec = base_record()
        rec[NAME] = metric_name
        rec[:datapoints] = [datapoint(time, tag_count)]
        dims = rec.fetch(DIMENSIONS, {})
        if tag!= nil
          dims[RESPONSE_CODE] = response_code
          dims[TYPE] = plugin_type
        end
        populate_default_dims(dims)

        if @is_uma_metrics == true
          if plugin_type == OCI_MONITORING_PLUGIN_TYPE && tag != nil
            dims[CONFIG_TAG] = @monitoring_plugin_tag ? @monitoring_plugin_tag : tag
          elsif tag!= nil
            dims[CONFIG_TAG] = tag
          end
          populate_default_dims_instanceLevel(dims)
          rec[DIMENSIONS] = dims
          es.add(time, rec)
        else
          rec[DIMENSIONS] = dims
          es.add(time, rec)
          rec_instance_level = base_record()
          rec_instance_level[NAME] = @hostClass + "." + metric_name + INSTANCE_LEVEL_METRIC_NAME_SUFFIX
          rec_instance_level[RESOURCE_GROUP] = @hostClass
          rec_instance_level[:datapoints] = [datapoint(time, tag_count)]
          dims_instanceLevel = Marshal.load(Marshal.dump(dims))
          if plugin_type == OCI_MONITORING_PLUGIN_TYPE && tag != nil
            dims_instanceLevel[CONFIG_TAG] = @monitoring_plugin_tag ? @monitoring_plugin_tag : tag
          elsif tag != nil
            dims_instanceLevel[CONFIG_TAG] = tag
          end
          dims_instanceLevel.delete(HOSTCLASS) if dims_instanceLevel.key?(HOSTCLASS)
          populate_default_dims_instanceLevel(dims_instanceLevel)
          rec_instance_level[DIMENSIONS] = dims_instanceLevel
          es.add(time, rec_instance_level)
        end
      end
    end

    def emit_output_response_metric(es, time)
      RESPONSE_CODE_MAP.each_pair do |plugin_type, plugin_type_value|
        if !RESPONSE_CODE_MAP.key?(plugin_type)
          next
        end
        plugin_type_value.each_pair do |response_code_category, response_code_category_map|
          metric_name = get_response_metric_name(response_code_category)
          if metric_name == nil
            next
          end
          response_code_category_map.each_pair do |response_code,response_code_map|
            if response_code_map.empty?
              add_metric_to_stream(plugin_type, metric_name, response_code, nil, 0, es, time)
            end
            response_code_map.each_pair do |tag, tag_count|
              add_metric_to_stream(plugin_type, metric_name, response_code, tag, tag_count, es, time)
              RESPONSE_CODE_MAP[plugin_type][response_code_category][response_code][tag] = 0
            end
          end
        end
      end
    end
  end
end
