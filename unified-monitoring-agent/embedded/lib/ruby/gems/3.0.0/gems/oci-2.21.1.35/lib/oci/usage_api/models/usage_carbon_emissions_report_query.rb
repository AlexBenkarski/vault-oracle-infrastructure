# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200107
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The request of the generated usage carbon emissions report.
  class UsageApi::Models::UsageCarbonEmissionsReportQuery
    DATE_RANGE_NAME_ENUM = [
      DATE_RANGE_NAME_LAST_TWO_MONTHS = 'LAST_TWO_MONTHS'.freeze,
      DATE_RANGE_NAME_LAST_THREE_MONTHS = 'LAST_THREE_MONTHS'.freeze,
      DATE_RANGE_NAME_LAST_SIX_MONTHS = 'LAST_SIX_MONTHS'.freeze,
      DATE_RANGE_NAME_LAST_ONE_YEAR = 'LAST_ONE_YEAR'.freeze,
      DATE_RANGE_NAME_CUSTOM = 'CUSTOM'.freeze,
      DATE_RANGE_NAME_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Tenant ID.
    # @return [String]
    attr_accessor :tenant_id

    # The usage start time.
    # @return [DateTime]
    attr_accessor :time_usage_started

    # The usage end time.
    # @return [DateTime]
    attr_accessor :time_usage_ended

    # Specifies whether aggregated by time. If isAggregateByTime is true, all usage or cost over the query time period will be added up.
    # @return [BOOLEAN]
    attr_accessor :is_aggregate_by_time

    # Specifies what to aggregate the result by.
    # For example:
    #   `[\"tagNamespace\", \"tagKey\", \"tagValue\", \"service\", \"skuName\", \"skuPartNumber\", \"unit\",
    #     \"compartmentName\", \"compartmentPath\", \"compartmentId\", \"platform\", \"region\", \"logicalAd\",
    #     \"resourceId\", \"tenantId\", \"tenantName\"]`
    #
    # @return [Array<String>]
    attr_accessor :group_by

    # GroupBy a specific tagKey. Provide the tagNamespace and tagKey in the tag object. Only supports one tag in the list.
    # For example:
    #   `[{\"namespace\":\"oracle\", \"key\":\"createdBy\"]`
    #
    # @return [Array<OCI::UsageApi::Models::Tag>]
    attr_accessor :group_by_tag

    # The compartment depth level.
    # @return [Integer]
    attr_accessor :compartment_depth

    # @return [OCI::UsageApi::Models::Filter]
    attr_accessor :filter

    # The UI date range, for example, LAST_THREE_MONTHS. It will override timeUsageStarted and timeUsageEnded properties.
    # @return [String]
    attr_reader :date_range_name

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'tenant_id': :'tenantId',
        'time_usage_started': :'timeUsageStarted',
        'time_usage_ended': :'timeUsageEnded',
        'is_aggregate_by_time': :'isAggregateByTime',
        'group_by': :'groupBy',
        'group_by_tag': :'groupByTag',
        'compartment_depth': :'compartmentDepth',
        'filter': :'filter',
        'date_range_name': :'dateRangeName'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'tenant_id': :'String',
        'time_usage_started': :'DateTime',
        'time_usage_ended': :'DateTime',
        'is_aggregate_by_time': :'BOOLEAN',
        'group_by': :'Array<String>',
        'group_by_tag': :'Array<OCI::UsageApi::Models::Tag>',
        'compartment_depth': :'Integer',
        'filter': :'OCI::UsageApi::Models::Filter',
        'date_range_name': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :tenant_id The value to assign to the {#tenant_id} property
    # @option attributes [DateTime] :time_usage_started The value to assign to the {#time_usage_started} property
    # @option attributes [DateTime] :time_usage_ended The value to assign to the {#time_usage_ended} property
    # @option attributes [BOOLEAN] :is_aggregate_by_time The value to assign to the {#is_aggregate_by_time} property
    # @option attributes [Array<String>] :group_by The value to assign to the {#group_by} property
    # @option attributes [Array<OCI::UsageApi::Models::Tag>] :group_by_tag The value to assign to the {#group_by_tag} property
    # @option attributes [Integer] :compartment_depth The value to assign to the {#compartment_depth} property
    # @option attributes [OCI::UsageApi::Models::Filter] :filter The value to assign to the {#filter} property
    # @option attributes [String] :date_range_name The value to assign to the {#date_range_name} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.tenant_id = attributes[:'tenantId'] if attributes[:'tenantId']

      raise 'You cannot provide both :tenantId and :tenant_id' if attributes.key?(:'tenantId') && attributes.key?(:'tenant_id')

      self.tenant_id = attributes[:'tenant_id'] if attributes[:'tenant_id']

      self.time_usage_started = attributes[:'timeUsageStarted'] if attributes[:'timeUsageStarted']

      raise 'You cannot provide both :timeUsageStarted and :time_usage_started' if attributes.key?(:'timeUsageStarted') && attributes.key?(:'time_usage_started')

      self.time_usage_started = attributes[:'time_usage_started'] if attributes[:'time_usage_started']

      self.time_usage_ended = attributes[:'timeUsageEnded'] if attributes[:'timeUsageEnded']

      raise 'You cannot provide both :timeUsageEnded and :time_usage_ended' if attributes.key?(:'timeUsageEnded') && attributes.key?(:'time_usage_ended')

      self.time_usage_ended = attributes[:'time_usage_ended'] if attributes[:'time_usage_ended']

      self.is_aggregate_by_time = attributes[:'isAggregateByTime'] unless attributes[:'isAggregateByTime'].nil?
      self.is_aggregate_by_time = false if is_aggregate_by_time.nil? && !attributes.key?(:'isAggregateByTime') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isAggregateByTime and :is_aggregate_by_time' if attributes.key?(:'isAggregateByTime') && attributes.key?(:'is_aggregate_by_time')

      self.is_aggregate_by_time = attributes[:'is_aggregate_by_time'] unless attributes[:'is_aggregate_by_time'].nil?
      self.is_aggregate_by_time = false if is_aggregate_by_time.nil? && !attributes.key?(:'isAggregateByTime') && !attributes.key?(:'is_aggregate_by_time') # rubocop:disable Style/StringLiterals

      self.group_by = attributes[:'groupBy'] if attributes[:'groupBy']

      raise 'You cannot provide both :groupBy and :group_by' if attributes.key?(:'groupBy') && attributes.key?(:'group_by')

      self.group_by = attributes[:'group_by'] if attributes[:'group_by']

      self.group_by_tag = attributes[:'groupByTag'] if attributes[:'groupByTag']

      raise 'You cannot provide both :groupByTag and :group_by_tag' if attributes.key?(:'groupByTag') && attributes.key?(:'group_by_tag')

      self.group_by_tag = attributes[:'group_by_tag'] if attributes[:'group_by_tag']

      self.compartment_depth = attributes[:'compartmentDepth'] if attributes[:'compartmentDepth']

      raise 'You cannot provide both :compartmentDepth and :compartment_depth' if attributes.key?(:'compartmentDepth') && attributes.key?(:'compartment_depth')

      self.compartment_depth = attributes[:'compartment_depth'] if attributes[:'compartment_depth']

      self.filter = attributes[:'filter'] if attributes[:'filter']

      self.date_range_name = attributes[:'dateRangeName'] if attributes[:'dateRangeName']

      raise 'You cannot provide both :dateRangeName and :date_range_name' if attributes.key?(:'dateRangeName') && attributes.key?(:'date_range_name')

      self.date_range_name = attributes[:'date_range_name'] if attributes[:'date_range_name']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] date_range_name Object to be assigned
    def date_range_name=(date_range_name)
      # rubocop:disable Style/ConditionalAssignment
      if date_range_name && !DATE_RANGE_NAME_ENUM.include?(date_range_name)
        OCI.logger.debug("Unknown value for 'date_range_name' [" + date_range_name + "]. Mapping to 'DATE_RANGE_NAME_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @date_range_name = DATE_RANGE_NAME_UNKNOWN_ENUM_VALUE
      else
        @date_range_name = date_range_name
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        tenant_id == other.tenant_id &&
        time_usage_started == other.time_usage_started &&
        time_usage_ended == other.time_usage_ended &&
        is_aggregate_by_time == other.is_aggregate_by_time &&
        group_by == other.group_by &&
        group_by_tag == other.group_by_tag &&
        compartment_depth == other.compartment_depth &&
        filter == other.filter &&
        date_range_name == other.date_range_name
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
      [tenant_id, time_usage_started, time_usage_ended, is_aggregate_by_time, group_by, group_by_tag, compartment_depth, filter, date_range_name].hash
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
