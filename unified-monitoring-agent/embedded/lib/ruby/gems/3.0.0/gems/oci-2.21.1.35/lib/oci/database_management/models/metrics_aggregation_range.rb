# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20201101
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The set of aggregated data returned for a metric.
  class DatabaseManagement::Models::MetricsAggregationRange
    # @return [OCI::DatabaseManagement::Models::DbManagementAnalyticsMetric]
    attr_accessor :header

    # The list of metrics returned for the specified request. Each of the metrics
    # has a `metricName` and additional properties like `metadata`, `dimensions`.
    # If a property is not set, then use the value from `header`.
    #
    # Suppose `m` be an item in the `metrics` array:
    # - If `m.metricName` is not set, use `header.metricName` instead
    # - If `m.durationInSeconds` is not set, use `header.durationInSeconds` instead
    # - If `m.dimensions` is not set, use `header.dimensions` instead
    # - If `m.metadata` is not set, use `header.metadata` instead
    #
    # @return [Array<OCI::DatabaseManagement::Models::DbManagementAnalyticsMetric>]
    attr_accessor :metrics

    # The beginning of the time range (inclusive) of the returned metric data.
    # @return [Integer]
    attr_accessor :range_start_time_in_epoch_seconds

    # The end of the time range (exclusive) of the returned metric data.
    # @return [Integer]
    attr_accessor :range_end_time_in_epoch_seconds

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'header': :'header',
        'metrics': :'metrics',
        'range_start_time_in_epoch_seconds': :'rangeStartTimeInEpochSeconds',
        'range_end_time_in_epoch_seconds': :'rangeEndTimeInEpochSeconds'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'header': :'OCI::DatabaseManagement::Models::DbManagementAnalyticsMetric',
        'metrics': :'Array<OCI::DatabaseManagement::Models::DbManagementAnalyticsMetric>',
        'range_start_time_in_epoch_seconds': :'Integer',
        'range_end_time_in_epoch_seconds': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [OCI::DatabaseManagement::Models::DbManagementAnalyticsMetric] :header The value to assign to the {#header} property
    # @option attributes [Array<OCI::DatabaseManagement::Models::DbManagementAnalyticsMetric>] :metrics The value to assign to the {#metrics} property
    # @option attributes [Integer] :range_start_time_in_epoch_seconds The value to assign to the {#range_start_time_in_epoch_seconds} property
    # @option attributes [Integer] :range_end_time_in_epoch_seconds The value to assign to the {#range_end_time_in_epoch_seconds} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.header = attributes[:'header'] if attributes[:'header']

      self.metrics = attributes[:'metrics'] if attributes[:'metrics']

      self.range_start_time_in_epoch_seconds = attributes[:'rangeStartTimeInEpochSeconds'] if attributes[:'rangeStartTimeInEpochSeconds']

      raise 'You cannot provide both :rangeStartTimeInEpochSeconds and :range_start_time_in_epoch_seconds' if attributes.key?(:'rangeStartTimeInEpochSeconds') && attributes.key?(:'range_start_time_in_epoch_seconds')

      self.range_start_time_in_epoch_seconds = attributes[:'range_start_time_in_epoch_seconds'] if attributes[:'range_start_time_in_epoch_seconds']

      self.range_end_time_in_epoch_seconds = attributes[:'rangeEndTimeInEpochSeconds'] if attributes[:'rangeEndTimeInEpochSeconds']

      raise 'You cannot provide both :rangeEndTimeInEpochSeconds and :range_end_time_in_epoch_seconds' if attributes.key?(:'rangeEndTimeInEpochSeconds') && attributes.key?(:'range_end_time_in_epoch_seconds')

      self.range_end_time_in_epoch_seconds = attributes[:'range_end_time_in_epoch_seconds'] if attributes[:'range_end_time_in_epoch_seconds']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        header == other.header &&
        metrics == other.metrics &&
        range_start_time_in_epoch_seconds == other.range_start_time_in_epoch_seconds &&
        range_end_time_in_epoch_seconds == other.range_end_time_in_epoch_seconds
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines

    # @see the `==` method
    # @param [Object] other the other object to be compared
    def eql?(other)
      self == other
    end

    # rubocop:disable Metrics/AbcSize, Layout/EmptyLines


    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [header, metrics, range_start_time_in_epoch_seconds, range_end_time_in_epoch_seconds].hash
    end
    # rubocop:enable Metrics/AbcSize, Layout/EmptyLines

    # rubocop:disable Metrics/AbcSize, Layout/EmptyLines


    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)

      self.class.swagger_types.each_pair do |key, type|
        if type =~ /^Array<(.*)>/i
          # check to ensure the input is an array given that the the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            public_method("#{key}=").call(
              attributes[self.class.attribute_map[key]]
                .map { |v| OCI::Internal::Util.convert_to_type(Regexp.last_match(1), v) }
            )
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          public_method("#{key}=").call(
            OCI::Internal::Util.convert_to_type(type, attributes[self.class.attribute_map[key]])
          )
        end
        # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end
    # rubocop:enable Metrics/AbcSize, Layout/EmptyLines

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = public_method(attr).call
        next if value.nil? && !instance_variable_defined?("@#{attr}")

        hash[param] = _to_hash(value)
      end
      hash
    end

    private

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end
  end
end
# rubocop:enable Lint/UnneededCopDisableDirective, Metrics/LineLength
