# frozen_string_literal: true

require 'fluent/plugin/formatter'

require 'oci/environment'

module Fluent::Plugin
    # json formatter for metrics, this takes care of additional dimensions.
    class MetricsFormatter < Fluent::Plugin::Formatter
      Fluent::Plugin.register_formatter('metrics', self)

      config_param :t2_metrics_dimensions, :array, default: []

      # for internal metrics, it has to be t2 compartment
      attr_accessor :compartment_id

      def initialize()
        super
        @env = ::OCI::Environment.new
      end

      # reduce redundancy in an array of metric records by compacting datapoints
      # belonging to the same timeseries together, into a single metric record.
      def compact(arr)
        arr.
          group_by{ |record| %w[name namespace resourceGroup compartmentId dimensions].map{|k| record[k]} }.
          map do |key, records|
            if records.size > 1 then
              compacted_record = records[0].dup
              compacted_record['datapoints'] = Set.new( records.collect {|r| r['datapoints']}.flatten ).to_a
              compacted_record
            else
              records[0]
            end
          end.sort_by{|r| r['name']}
      end

      def format(_, _, records)
        arr = []
        records.each do |metric|
          # set internal compartment if it's given and resourceGroup must be given
          if @compartment_id
            metric['compartmentId'] = @compartment_id
            next if check_field('resourceGroup', metric)
          end

          # namespace, data points must be there
          next if check_field('name', metric)
          next if check_field('namespace', metric)
          next if check_field('datapoints', metric)
          next if metric['compartmentId'].nil? && check_field('resourceGroup', metric)

          metric['dimensions'] = update_dimensions(metric.fetch('dimensions', {}))
          metric['datapoints'].each do |dp|
            # check data points
            time = dp['timestamp']
            value = dp['value']
            count = dp['count']
            # basic validation, just filer out
            next if time.nil?
            next if value.nil?
            next if !count.nil? && count.to_i <= 0

            dp['value'] = value.to_f unless value.class == Float
            dp['count'] = count.to_i unless count.nil? || count.class == Integer
            dp['timestamp'] = DateTime.strptime(time.to_s, '%Q').rfc3339(3) if time.class == Integer
          end
          arr << metric
        end
        {'metricData' => compact(arr)}.to_json
      end

      def update_dimensions(dims)
        t2_metrics_dimensions.each do |key|
          env = @env[key]
          original = dims[key]
          if original.nil?
            # only add it when it's not specified
            dims[key] = env
          elsif original.empty?
            # original is empty, do not send anything
            dims.delete(key)
          end
        end
        dims.delete_if { |_, v| v.nil? }
        dims
      end

      def check_field(attr, metric)
        v = metric[attr]
        if v.nil?
          log.warn "Missing attribute: #{attr} in #{metric}"
          true
        else
          false
        end
      end

    end
end
