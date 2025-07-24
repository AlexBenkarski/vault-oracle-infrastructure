# Copyright (c) 20[0-9][0-9], Oracle and/or its affiliates. All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License
# (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License
# 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
# either license.

# frozen_string_literal: true

require 'fluent/plugin/formatter'

module Fluent
  module Plugin
    # json formatter for metrics, taking care of additional dimensions.
    class OCIMonitoringMetricsFormatter < Fluent::Plugin::Formatter
      MANDATORY_FIELDS = %w[
        name
        namespace
        datapoints
        compartmentId
        resourceGroup
      ].freeze

      ALL_FIELDS = %w[
        name
        namespace
        datapoints
        resourceGroup
        compartmentId
        dimensions
      ].freeze

      Fluent::Plugin.register_formatter('oci_monitoring', self)

      # Dimensions to pick up from instance metadata
      config_param :metrics_dimensions, :array, default: ['compartmentId']
      config_param :removeDimensions, :array, default: []

      # for internal metrics, it has to be t2 compartment
      attr_accessor :compartment_id, :instance_metadata, :remove_dimensions_keys, :metrics_namespace

      def configure(conf)
        super
        @log = $log # use the global logger
        @remove_dimensions_keys = @removeDimensions.to_set
      end

      ## Reduce redundancy in an array of metric records by compacting datapoints
      #  belonging to the same timeseries together, into a single metric record.
      #
      #  TODO Refactor to human comprehensible form.
      #
      # @param arr [Array] an array of metric records
      #
      # @return [Array] the updated array
      def compact(arr)
        arr
          .group_by { |record| ALL_FIELDS.map { |k| record[k] } }
          .map do |_key, records|
            if records.size > 1
              compacted_record = records[0].dup
              compacted_record['datapoints'] = Set.new(records.collect { |r| r['datapoints'] }.flatten).to_a
              compacted_record
            else
              records[0]
            end
          end.sort_by { |r| r['name'] }
      end

      def format(_tag, _time, records)
        arr = []
        records.each do |metric|
          metric['compartmentId'] = @compartment_id

          next unless MANDATORY_FIELDS.map { |field_name| check_field(field_name, metric) }.all?

          if metric['dimensions'].is_a? String
            metric['dimensions'] = JSON.parse(metric.fetch('dimensions', {}).gsub('=>', ':'))
          end

          metric['dimensions'] = update_dimensions(metric['dimensions'])

          metric['datapoints'].each do |datapoint|
            time = datapoint.fetch('timestamp', nil)
            value = datapoint.fetch('value', nil)
            count = datapoint.fetch('count', nil)

            # basic validation, just filter out
            next if time.nil?
            next if value.nil?
            next if !count.nil? && count.to_i <= 0

            datapoint['value'] = value.to_f unless value.instance_of?(Float)
            datapoint['count'] = count.to_i unless count.nil? || count.instance_of?(Integer)
            datapoint['timestamp'] = DateTime.strptime(time.to_s, '%Q').rfc3339(3) if time.instance_of?(Integer)
          end
          metric['namespace'] = @metrics_namespace unless @metrics_namespace.nil? || @metrics_namespace.empty?

          arr << metric
        end
        # { 'metricData' => compact(arr) }.to_json
        { 'metricData' => arr }
      end

      ## Update the metric dimensions hash based on configured dimensions from instance metadata
      #  Also, filter out empty and nil values.
      #
      # @param original_dimensions [Hash]
      #
      # @return [Hash] the updated dimensions
      def update_dimensions(original_dimensions)
        original_dimensions ||= {'hostname'=> Socket.gethostname}  # add a minimal dimension
        @metrics_dimensions.each do |key|
          metadata_value = @instance_metadata.fetch(key, nil)
          original = original_dimensions[key]
          if original.nil?
            original_dimensions[key] = metadata_value # only add it when it's not specified
          elsif original.empty?
            original_dimensions.delete(key) # original is empty, do not send anything
          end
        end
        original_dimensions.delete_if { |_, v| v.nil? }
        # Remove Dimensions which are not allowed
        original_dimensions.delete_if { |key, _| remove_dimensions_keys.include?(key) }
        original_dimensions
      end

      ## Check for missing fields in a metric hash and log accordingly
      #
      # @param attr [String] attribute name
      # @param metric [Hash] the metric hash
      #
      # @return [Bool] true if attribute is in the hash, false otherwise
      def check_field(attr, metric)
        v = metric.fetch(attr, nil)
        if v.nil?
          @log.warn "Missing attribute: #{attr} in #{metric}"
          false
        else
          true
        end
      end
    end
  end
end
