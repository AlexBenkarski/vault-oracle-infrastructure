# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200601
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # LogAnalyticsLookupFields
  class LogAnalytics::Models::LogAnalyticsLookupFields
    # The common field name.
    # @return [String]
    attr_accessor :common_field_name

    # The default match value.
    # @return [String]
    attr_accessor :default_match_value

    # The display name.
    # @return [String]
    attr_accessor :display_name

    # A flag indicating whether or not the field is a common field.
    #
    # @return [BOOLEAN]
    attr_accessor :is_common_field

    # The match operator.
    # @return [String]
    attr_accessor :match_operator

    # The field name.
    # @return [String]
    attr_accessor :name

    # The position.
    # @return [Integer]
    attr_accessor :position

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'common_field_name': :'commonFieldName',
        'default_match_value': :'defaultMatchValue',
        'display_name': :'displayName',
        'is_common_field': :'isCommonField',
        'match_operator': :'matchOperator',
        'name': :'name',
        'position': :'position'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'common_field_name': :'String',
        'default_match_value': :'String',
        'display_name': :'String',
        'is_common_field': :'BOOLEAN',
        'match_operator': :'String',
        'name': :'String',
        'position': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :common_field_name The value to assign to the {#common_field_name} property
    # @option attributes [String] :default_match_value The value to assign to the {#default_match_value} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [BOOLEAN] :is_common_field The value to assign to the {#is_common_field} property
    # @option attributes [String] :match_operator The value to assign to the {#match_operator} property
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [Integer] :position The value to assign to the {#position} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.common_field_name = attributes[:'commonFieldName'] if attributes[:'commonFieldName']

      raise 'You cannot provide both :commonFieldName and :common_field_name' if attributes.key?(:'commonFieldName') && attributes.key?(:'common_field_name')

      self.common_field_name = attributes[:'common_field_name'] if attributes[:'common_field_name']

      self.default_match_value = attributes[:'defaultMatchValue'] if attributes[:'defaultMatchValue']

      raise 'You cannot provide both :defaultMatchValue and :default_match_value' if attributes.key?(:'defaultMatchValue') && attributes.key?(:'default_match_value')

      self.default_match_value = attributes[:'default_match_value'] if attributes[:'default_match_value']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.is_common_field = attributes[:'isCommonField'] unless attributes[:'isCommonField'].nil?

      raise 'You cannot provide both :isCommonField and :is_common_field' if attributes.key?(:'isCommonField') && attributes.key?(:'is_common_field')

      self.is_common_field = attributes[:'is_common_field'] unless attributes[:'is_common_field'].nil?

      self.match_operator = attributes[:'matchOperator'] if attributes[:'matchOperator']

      raise 'You cannot provide both :matchOperator and :match_operator' if attributes.key?(:'matchOperator') && attributes.key?(:'match_operator')

      self.match_operator = attributes[:'match_operator'] if attributes[:'match_operator']

      self.name = attributes[:'name'] if attributes[:'name']

      self.position = attributes[:'position'] if attributes[:'position']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        common_field_name == other.common_field_name &&
        default_match_value == other.default_match_value &&
        display_name == other.display_name &&
        is_common_field == other.is_common_field &&
        match_operator == other.match_operator &&
        name == other.name &&
        position == other.position
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
      [common_field_name, default_match_value, display_name, is_common_field, match_operator, name, position].hash
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
