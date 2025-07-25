# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200630
require 'date'
require_relative 'database_configuration_metric_group'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Initialization parameters for a database.
  class Opsi::Models::DBParameters < Opsi::Models::DatabaseConfigurationMetricGroup
    # **[Required]** Database instance number.
    # @return [Integer]
    attr_accessor :instance_number

    # **[Required]** Database parameter name.
    # @return [String]
    attr_accessor :parameter_name

    # **[Required]** Database parameter value.
    # @return [String]
    attr_accessor :parameter_value

    # AWR snapshot id for the parameter value
    # @return [Integer]
    attr_accessor :snapshot_id

    # Indicates whether the parameter's value changed in given snapshot or not.
    # @return [String]
    attr_accessor :is_changed

    # Indicates whether this value is the default value or not.
    # @return [String]
    attr_accessor :is_default

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'metric_name': :'metricName',
        'time_collected': :'timeCollected',
        'instance_number': :'instanceNumber',
        'parameter_name': :'parameterName',
        'parameter_value': :'parameterValue',
        'snapshot_id': :'snapshotId',
        'is_changed': :'isChanged',
        'is_default': :'isDefault'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'metric_name': :'String',
        'time_collected': :'DateTime',
        'instance_number': :'Integer',
        'parameter_name': :'String',
        'parameter_value': :'String',
        'snapshot_id': :'Integer',
        'is_changed': :'String',
        'is_default': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [DateTime] :time_collected The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationMetricGroup#time_collected #time_collected} proprety
    # @option attributes [Integer] :instance_number The value to assign to the {#instance_number} property
    # @option attributes [String] :parameter_name The value to assign to the {#parameter_name} property
    # @option attributes [String] :parameter_value The value to assign to the {#parameter_value} property
    # @option attributes [Integer] :snapshot_id The value to assign to the {#snapshot_id} property
    # @option attributes [String] :is_changed The value to assign to the {#is_changed} property
    # @option attributes [String] :is_default The value to assign to the {#is_default} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['metricName'] = 'DB_PARAMETERS'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.instance_number = attributes[:'instanceNumber'] if attributes[:'instanceNumber']

      raise 'You cannot provide both :instanceNumber and :instance_number' if attributes.key?(:'instanceNumber') && attributes.key?(:'instance_number')

      self.instance_number = attributes[:'instance_number'] if attributes[:'instance_number']

      self.parameter_name = attributes[:'parameterName'] if attributes[:'parameterName']

      raise 'You cannot provide both :parameterName and :parameter_name' if attributes.key?(:'parameterName') && attributes.key?(:'parameter_name')

      self.parameter_name = attributes[:'parameter_name'] if attributes[:'parameter_name']

      self.parameter_value = attributes[:'parameterValue'] if attributes[:'parameterValue']

      raise 'You cannot provide both :parameterValue and :parameter_value' if attributes.key?(:'parameterValue') && attributes.key?(:'parameter_value')

      self.parameter_value = attributes[:'parameter_value'] if attributes[:'parameter_value']

      self.snapshot_id = attributes[:'snapshotId'] if attributes[:'snapshotId']

      raise 'You cannot provide both :snapshotId and :snapshot_id' if attributes.key?(:'snapshotId') && attributes.key?(:'snapshot_id')

      self.snapshot_id = attributes[:'snapshot_id'] if attributes[:'snapshot_id']

      self.is_changed = attributes[:'isChanged'] if attributes[:'isChanged']

      raise 'You cannot provide both :isChanged and :is_changed' if attributes.key?(:'isChanged') && attributes.key?(:'is_changed')

      self.is_changed = attributes[:'is_changed'] if attributes[:'is_changed']

      self.is_default = attributes[:'isDefault'] if attributes[:'isDefault']

      raise 'You cannot provide both :isDefault and :is_default' if attributes.key?(:'isDefault') && attributes.key?(:'is_default')

      self.is_default = attributes[:'is_default'] if attributes[:'is_default']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        metric_name == other.metric_name &&
        time_collected == other.time_collected &&
        instance_number == other.instance_number &&
        parameter_name == other.parameter_name &&
        parameter_value == other.parameter_value &&
        snapshot_id == other.snapshot_id &&
        is_changed == other.is_changed &&
        is_default == other.is_default
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
      [metric_name, time_collected, instance_number, parameter_name, parameter_value, snapshot_id, is_changed, is_default].hash
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
