# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Representation of storage performance summary per shapeType .
  #
  class Database::Models::DbSystemStoragePerformanceSummary
    SHAPE_TYPE_ENUM = [
      SHAPE_TYPE_AMD = 'AMD'.freeze,
      SHAPE_TYPE_INTEL = 'INTEL'.freeze,
      SHAPE_TYPE_INTEL_FLEX_X9 = 'INTEL_FLEX_X9'.freeze,
      SHAPE_TYPE_AMPERE_FLEX_A1 = 'AMPERE_FLEX_A1'.freeze,
      SHAPE_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** ShapeType of the DbSystems INTEL , AMD, INTEL_FLEX_X9 or AMPERE_FLEX_A1
    # @return [String]
    attr_reader :shape_type

    # **[Required]** List of storage performance for the DATA disks
    # @return [Array<OCI::Database::Models::StoragePerformanceDetails>]
    attr_accessor :data_storage_performance_list

    # **[Required]** List of storage performance for the RECO disks
    # @return [Array<OCI::Database::Models::StoragePerformanceDetails>]
    attr_accessor :reco_storage_performance_list

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'shape_type': :'shapeType',
        'data_storage_performance_list': :'dataStoragePerformanceList',
        'reco_storage_performance_list': :'recoStoragePerformanceList'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'shape_type': :'String',
        'data_storage_performance_list': :'Array<OCI::Database::Models::StoragePerformanceDetails>',
        'reco_storage_performance_list': :'Array<OCI::Database::Models::StoragePerformanceDetails>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :shape_type The value to assign to the {#shape_type} property
    # @option attributes [Array<OCI::Database::Models::StoragePerformanceDetails>] :data_storage_performance_list The value to assign to the {#data_storage_performance_list} property
    # @option attributes [Array<OCI::Database::Models::StoragePerformanceDetails>] :reco_storage_performance_list The value to assign to the {#reco_storage_performance_list} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.shape_type = attributes[:'shapeType'] if attributes[:'shapeType']

      raise 'You cannot provide both :shapeType and :shape_type' if attributes.key?(:'shapeType') && attributes.key?(:'shape_type')

      self.shape_type = attributes[:'shape_type'] if attributes[:'shape_type']

      self.data_storage_performance_list = attributes[:'dataStoragePerformanceList'] if attributes[:'dataStoragePerformanceList']

      raise 'You cannot provide both :dataStoragePerformanceList and :data_storage_performance_list' if attributes.key?(:'dataStoragePerformanceList') && attributes.key?(:'data_storage_performance_list')

      self.data_storage_performance_list = attributes[:'data_storage_performance_list'] if attributes[:'data_storage_performance_list']

      self.reco_storage_performance_list = attributes[:'recoStoragePerformanceList'] if attributes[:'recoStoragePerformanceList']

      raise 'You cannot provide both :recoStoragePerformanceList and :reco_storage_performance_list' if attributes.key?(:'recoStoragePerformanceList') && attributes.key?(:'reco_storage_performance_list')

      self.reco_storage_performance_list = attributes[:'reco_storage_performance_list'] if attributes[:'reco_storage_performance_list']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] shape_type Object to be assigned
    def shape_type=(shape_type)
      # rubocop:disable Style/ConditionalAssignment
      if shape_type && !SHAPE_TYPE_ENUM.include?(shape_type)
        OCI.logger.debug("Unknown value for 'shape_type' [" + shape_type + "]. Mapping to 'SHAPE_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @shape_type = SHAPE_TYPE_UNKNOWN_ENUM_VALUE
      else
        @shape_type = shape_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        shape_type == other.shape_type &&
        data_storage_performance_list == other.data_storage_performance_list &&
        reco_storage_performance_list == other.reco_storage_performance_list
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
      [shape_type, data_storage_performance_list, reco_storage_performance_list].hash
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
