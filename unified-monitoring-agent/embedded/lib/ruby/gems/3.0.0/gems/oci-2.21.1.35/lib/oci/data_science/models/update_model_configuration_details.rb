# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20190101
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The model configuration details for update.
  class DataScience::Models::UpdateModelConfigurationDetails
    # **[Required]** The OCID of the model you want to update.
    # @return [String]
    attr_accessor :model_id

    # @return [OCI::DataScience::Models::InstanceConfiguration]
    attr_accessor :instance_configuration

    # @return [OCI::DataScience::Models::ScalingPolicy]
    attr_accessor :scaling_policy

    # The minimum network bandwidth for the model deployment.
    # @return [Integer]
    attr_accessor :bandwidth_mbps

    # The maximum network bandwidth for the model deployment.
    # @return [Integer]
    attr_accessor :maximum_bandwidth_mbps

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'model_id': :'modelId',
        'instance_configuration': :'instanceConfiguration',
        'scaling_policy': :'scalingPolicy',
        'bandwidth_mbps': :'bandwidthMbps',
        'maximum_bandwidth_mbps': :'maximumBandwidthMbps'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'model_id': :'String',
        'instance_configuration': :'OCI::DataScience::Models::InstanceConfiguration',
        'scaling_policy': :'OCI::DataScience::Models::ScalingPolicy',
        'bandwidth_mbps': :'Integer',
        'maximum_bandwidth_mbps': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :model_id The value to assign to the {#model_id} property
    # @option attributes [OCI::DataScience::Models::InstanceConfiguration] :instance_configuration The value to assign to the {#instance_configuration} property
    # @option attributes [OCI::DataScience::Models::ScalingPolicy] :scaling_policy The value to assign to the {#scaling_policy} property
    # @option attributes [Integer] :bandwidth_mbps The value to assign to the {#bandwidth_mbps} property
    # @option attributes [Integer] :maximum_bandwidth_mbps The value to assign to the {#maximum_bandwidth_mbps} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.model_id = attributes[:'modelId'] if attributes[:'modelId']

      raise 'You cannot provide both :modelId and :model_id' if attributes.key?(:'modelId') && attributes.key?(:'model_id')

      self.model_id = attributes[:'model_id'] if attributes[:'model_id']

      self.instance_configuration = attributes[:'instanceConfiguration'] if attributes[:'instanceConfiguration']

      raise 'You cannot provide both :instanceConfiguration and :instance_configuration' if attributes.key?(:'instanceConfiguration') && attributes.key?(:'instance_configuration')

      self.instance_configuration = attributes[:'instance_configuration'] if attributes[:'instance_configuration']

      self.scaling_policy = attributes[:'scalingPolicy'] if attributes[:'scalingPolicy']

      raise 'You cannot provide both :scalingPolicy and :scaling_policy' if attributes.key?(:'scalingPolicy') && attributes.key?(:'scaling_policy')

      self.scaling_policy = attributes[:'scaling_policy'] if attributes[:'scaling_policy']

      self.bandwidth_mbps = attributes[:'bandwidthMbps'] if attributes[:'bandwidthMbps']

      raise 'You cannot provide both :bandwidthMbps and :bandwidth_mbps' if attributes.key?(:'bandwidthMbps') && attributes.key?(:'bandwidth_mbps')

      self.bandwidth_mbps = attributes[:'bandwidth_mbps'] if attributes[:'bandwidth_mbps']

      self.maximum_bandwidth_mbps = attributes[:'maximumBandwidthMbps'] if attributes[:'maximumBandwidthMbps']

      raise 'You cannot provide both :maximumBandwidthMbps and :maximum_bandwidth_mbps' if attributes.key?(:'maximumBandwidthMbps') && attributes.key?(:'maximum_bandwidth_mbps')

      self.maximum_bandwidth_mbps = attributes[:'maximum_bandwidth_mbps'] if attributes[:'maximum_bandwidth_mbps']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        model_id == other.model_id &&
        instance_configuration == other.instance_configuration &&
        scaling_policy == other.scaling_policy &&
        bandwidth_mbps == other.bandwidth_mbps &&
        maximum_bandwidth_mbps == other.maximum_bandwidth_mbps
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
      [model_id, instance_configuration, scaling_policy, bandwidth_mbps, maximum_bandwidth_mbps].hash
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
