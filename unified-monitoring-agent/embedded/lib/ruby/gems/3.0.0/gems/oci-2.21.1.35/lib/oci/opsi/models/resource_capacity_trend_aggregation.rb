# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200630
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Resource Capacity samples
  class Opsi::Models::ResourceCapacityTrendAggregation
    # **[Required]** The timestamp in which the current sampling period ends in RFC 3339 format.
    # @return [DateTime]
    attr_accessor :end_timestamp

    # **[Required]** The maximum allocated amount of the resource metric type  (CPU, STORAGE) for a set of databases.
    #
    # @return [Float]
    attr_accessor :capacity

    # **[Required]** The base allocated amount of the resource metric type  (CPU, STORAGE) for a set of databases.
    #
    # @return [Float]
    attr_accessor :base_capacity

    # The maximum host CPUs (cores x threads/core) on the underlying infrastructure. This only applies to CPU and does not not apply for Autonomous Databases.
    #
    # @return [Float]
    attr_accessor :total_host_capacity

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'end_timestamp': :'endTimestamp',
        'capacity': :'capacity',
        'base_capacity': :'baseCapacity',
        'total_host_capacity': :'totalHostCapacity'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'end_timestamp': :'DateTime',
        'capacity': :'Float',
        'base_capacity': :'Float',
        'total_host_capacity': :'Float'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [DateTime] :end_timestamp The value to assign to the {#end_timestamp} property
    # @option attributes [Float] :capacity The value to assign to the {#capacity} property
    # @option attributes [Float] :base_capacity The value to assign to the {#base_capacity} property
    # @option attributes [Float] :total_host_capacity The value to assign to the {#total_host_capacity} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.end_timestamp = attributes[:'endTimestamp'] if attributes[:'endTimestamp']

      raise 'You cannot provide both :endTimestamp and :end_timestamp' if attributes.key?(:'endTimestamp') && attributes.key?(:'end_timestamp')

      self.end_timestamp = attributes[:'end_timestamp'] if attributes[:'end_timestamp']

      self.capacity = attributes[:'capacity'] if attributes[:'capacity']

      self.base_capacity = attributes[:'baseCapacity'] if attributes[:'baseCapacity']

      raise 'You cannot provide both :baseCapacity and :base_capacity' if attributes.key?(:'baseCapacity') && attributes.key?(:'base_capacity')

      self.base_capacity = attributes[:'base_capacity'] if attributes[:'base_capacity']

      self.total_host_capacity = attributes[:'totalHostCapacity'] if attributes[:'totalHostCapacity']

      raise 'You cannot provide both :totalHostCapacity and :total_host_capacity' if attributes.key?(:'totalHostCapacity') && attributes.key?(:'total_host_capacity')

      self.total_host_capacity = attributes[:'total_host_capacity'] if attributes[:'total_host_capacity']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        end_timestamp == other.end_timestamp &&
        capacity == other.capacity &&
        base_capacity == other.base_capacity &&
        total_host_capacity == other.total_host_capacity
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
      [end_timestamp, capacity, base_capacity, total_host_capacity].hash
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
