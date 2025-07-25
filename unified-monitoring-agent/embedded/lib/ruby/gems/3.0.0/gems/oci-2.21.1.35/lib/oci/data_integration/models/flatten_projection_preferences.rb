# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200430
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The preferences for the flatten operation.
  class DataIntegration::Models::FlattenProjectionPreferences
    CREATE_ARRAY_INDEX_ENUM = [
      CREATE_ARRAY_INDEX_ALLOW = 'ALLOW'.freeze,
      CREATE_ARRAY_INDEX_DO_NOT_ALLOW = 'DO_NOT_ALLOW'.freeze,
      CREATE_ARRAY_INDEX_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    RETAIN_ALL_ATTRIBUTES_ENUM = [
      RETAIN_ALL_ATTRIBUTES_ALLOW = 'ALLOW'.freeze,
      RETAIN_ALL_ATTRIBUTES_DO_NOT_ALLOW = 'DO_NOT_ALLOW'.freeze,
      RETAIN_ALL_ATTRIBUTES_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    IGNORE_NULL_VALUES_ENUM = [
      IGNORE_NULL_VALUES_ALLOW = 'ALLOW'.freeze,
      IGNORE_NULL_VALUES_DO_NOT_ALLOW = 'DO_NOT_ALLOW'.freeze,
      IGNORE_NULL_VALUES_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    RETAIN_PARENT_NAME_LINEAGE_ENUM = [
      RETAIN_PARENT_NAME_LINEAGE_ALLOW = 'ALLOW'.freeze,
      RETAIN_PARENT_NAME_LINEAGE_DO_NOT_ALLOW = 'DO_NOT_ALLOW'.freeze,
      RETAIN_PARENT_NAME_LINEAGE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Property defining whether to create array indexes in flattened result.
    # @return [String]
    attr_reader :create_array_index

    # **[Required]** Property defining whether to retain all attributes in flattened result.
    # @return [String]
    attr_reader :retain_all_attributes

    # **[Required]** Property defining whether to ignore null values in flattened result.
    # @return [String]
    attr_reader :ignore_null_values

    # **[Required]** Property defining whether to retain parent name lineage.
    # @return [String]
    attr_reader :retain_parent_name_lineage

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'create_array_index': :'createArrayIndex',
        'retain_all_attributes': :'retainAllAttributes',
        'ignore_null_values': :'ignoreNullValues',
        'retain_parent_name_lineage': :'retainParentNameLineage'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'create_array_index': :'String',
        'retain_all_attributes': :'String',
        'ignore_null_values': :'String',
        'retain_parent_name_lineage': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :create_array_index The value to assign to the {#create_array_index} property
    # @option attributes [String] :retain_all_attributes The value to assign to the {#retain_all_attributes} property
    # @option attributes [String] :ignore_null_values The value to assign to the {#ignore_null_values} property
    # @option attributes [String] :retain_parent_name_lineage The value to assign to the {#retain_parent_name_lineage} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.create_array_index = attributes[:'createArrayIndex'] if attributes[:'createArrayIndex']

      raise 'You cannot provide both :createArrayIndex and :create_array_index' if attributes.key?(:'createArrayIndex') && attributes.key?(:'create_array_index')

      self.create_array_index = attributes[:'create_array_index'] if attributes[:'create_array_index']

      self.retain_all_attributes = attributes[:'retainAllAttributes'] if attributes[:'retainAllAttributes']

      raise 'You cannot provide both :retainAllAttributes and :retain_all_attributes' if attributes.key?(:'retainAllAttributes') && attributes.key?(:'retain_all_attributes')

      self.retain_all_attributes = attributes[:'retain_all_attributes'] if attributes[:'retain_all_attributes']

      self.ignore_null_values = attributes[:'ignoreNullValues'] if attributes[:'ignoreNullValues']

      raise 'You cannot provide both :ignoreNullValues and :ignore_null_values' if attributes.key?(:'ignoreNullValues') && attributes.key?(:'ignore_null_values')

      self.ignore_null_values = attributes[:'ignore_null_values'] if attributes[:'ignore_null_values']

      self.retain_parent_name_lineage = attributes[:'retainParentNameLineage'] if attributes[:'retainParentNameLineage']

      raise 'You cannot provide both :retainParentNameLineage and :retain_parent_name_lineage' if attributes.key?(:'retainParentNameLineage') && attributes.key?(:'retain_parent_name_lineage')

      self.retain_parent_name_lineage = attributes[:'retain_parent_name_lineage'] if attributes[:'retain_parent_name_lineage']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] create_array_index Object to be assigned
    def create_array_index=(create_array_index)
      # rubocop:disable Style/ConditionalAssignment
      if create_array_index && !CREATE_ARRAY_INDEX_ENUM.include?(create_array_index)
        OCI.logger.debug("Unknown value for 'create_array_index' [" + create_array_index + "]. Mapping to 'CREATE_ARRAY_INDEX_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @create_array_index = CREATE_ARRAY_INDEX_UNKNOWN_ENUM_VALUE
      else
        @create_array_index = create_array_index
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] retain_all_attributes Object to be assigned
    def retain_all_attributes=(retain_all_attributes)
      # rubocop:disable Style/ConditionalAssignment
      if retain_all_attributes && !RETAIN_ALL_ATTRIBUTES_ENUM.include?(retain_all_attributes)
        OCI.logger.debug("Unknown value for 'retain_all_attributes' [" + retain_all_attributes + "]. Mapping to 'RETAIN_ALL_ATTRIBUTES_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @retain_all_attributes = RETAIN_ALL_ATTRIBUTES_UNKNOWN_ENUM_VALUE
      else
        @retain_all_attributes = retain_all_attributes
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] ignore_null_values Object to be assigned
    def ignore_null_values=(ignore_null_values)
      # rubocop:disable Style/ConditionalAssignment
      if ignore_null_values && !IGNORE_NULL_VALUES_ENUM.include?(ignore_null_values)
        OCI.logger.debug("Unknown value for 'ignore_null_values' [" + ignore_null_values + "]. Mapping to 'IGNORE_NULL_VALUES_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @ignore_null_values = IGNORE_NULL_VALUES_UNKNOWN_ENUM_VALUE
      else
        @ignore_null_values = ignore_null_values
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] retain_parent_name_lineage Object to be assigned
    def retain_parent_name_lineage=(retain_parent_name_lineage)
      # rubocop:disable Style/ConditionalAssignment
      if retain_parent_name_lineage && !RETAIN_PARENT_NAME_LINEAGE_ENUM.include?(retain_parent_name_lineage)
        OCI.logger.debug("Unknown value for 'retain_parent_name_lineage' [" + retain_parent_name_lineage + "]. Mapping to 'RETAIN_PARENT_NAME_LINEAGE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @retain_parent_name_lineage = RETAIN_PARENT_NAME_LINEAGE_UNKNOWN_ENUM_VALUE
      else
        @retain_parent_name_lineage = retain_parent_name_lineage
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        create_array_index == other.create_array_index &&
        retain_all_attributes == other.retain_all_attributes &&
        ignore_null_values == other.ignore_null_values &&
        retain_parent_name_lineage == other.retain_parent_name_lineage
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
      [create_array_index, retain_all_attributes, ignore_null_values, retain_parent_name_lineage].hash
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
