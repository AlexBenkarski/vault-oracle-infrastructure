# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20180401
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A timestamped alarm state entry for a metric stream.
  #
  class Monitoring::Models::AlarmDimensionStatesEntry
    STATUS_ENUM = [
      STATUS_FIRING = 'FIRING'.freeze,
      STATUS_OK = 'OK'.freeze,
      STATUS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Customizable alarm summary (`alarmSummary` [alarm message parameter](https://docs.cloud.oracle.com/iaas/Content/Monitoring/alarm-message-format.htm)).
    # Optionally include [dynamic variables](https://docs.cloud.oracle.com/iaas/Content/Monitoring/Tasks/update-alarm-dynamic-variables.htm).
    # The alarm summary appears within the body of the alarm message and in responses to
    # {#list_alarms_status list_alarms_status}
    # {#get_alarm_history get_alarm_history} and
    # {#retrieve_dimension_states retrieve_dimension_states}.
    #
    # @return [String]
    attr_accessor :alarm_summary

    # **[Required]** Indicator of the metric stream associated with the alarm state entry. Includes one or more dimension key-value pairs.
    #
    # @return [Hash<String, String>]
    attr_accessor :dimensions

    # **[Required]** Transition state (status value) associated with the alarm state entry.
    #
    # Example: `FIRING`
    #
    # @return [String]
    attr_reader :status

    # **[Required]** Identifier of the alarm's base values for alarm evaluation, for use when the alarm contains overrides.
    # Default value is `BASE`. For information about alarm overrides, see {#alarm_override alarm_override}.
    #
    # @return [String]
    attr_accessor :rule_name

    # **[Required]** Transition time associated with the alarm state entry. Format defined by RFC3339.
    #
    # Example: `2022-02-01T01:02:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :timestamp

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'alarm_summary': :'alarmSummary',
        'dimensions': :'dimensions',
        'status': :'status',
        'rule_name': :'ruleName',
        'timestamp': :'timestamp'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'alarm_summary': :'String',
        'dimensions': :'Hash<String, String>',
        'status': :'String',
        'rule_name': :'String',
        'timestamp': :'DateTime'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :alarm_summary The value to assign to the {#alarm_summary} property
    # @option attributes [Hash<String, String>] :dimensions The value to assign to the {#dimensions} property
    # @option attributes [String] :status The value to assign to the {#status} property
    # @option attributes [String] :rule_name The value to assign to the {#rule_name} property
    # @option attributes [DateTime] :timestamp The value to assign to the {#timestamp} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.alarm_summary = attributes[:'alarmSummary'] if attributes[:'alarmSummary']

      raise 'You cannot provide both :alarmSummary and :alarm_summary' if attributes.key?(:'alarmSummary') && attributes.key?(:'alarm_summary')

      self.alarm_summary = attributes[:'alarm_summary'] if attributes[:'alarm_summary']

      self.dimensions = attributes[:'dimensions'] if attributes[:'dimensions']

      self.status = attributes[:'status'] if attributes[:'status']

      self.rule_name = attributes[:'ruleName'] if attributes[:'ruleName']

      raise 'You cannot provide both :ruleName and :rule_name' if attributes.key?(:'ruleName') && attributes.key?(:'rule_name')

      self.rule_name = attributes[:'rule_name'] if attributes[:'rule_name']

      self.timestamp = attributes[:'timestamp'] if attributes[:'timestamp']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] status Object to be assigned
    def status=(status)
      # rubocop:disable Style/ConditionalAssignment
      if status && !STATUS_ENUM.include?(status)
        OCI.logger.debug("Unknown value for 'status' [" + status + "]. Mapping to 'STATUS_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @status = STATUS_UNKNOWN_ENUM_VALUE
      else
        @status = status
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        alarm_summary == other.alarm_summary &&
        dimensions == other.dimensions &&
        status == other.status &&
        rule_name == other.rule_name &&
        timestamp == other.timestamp
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
      [alarm_summary, dimensions, status, rule_name, timestamp].hash
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
