# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200601
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A parser used by another parser.
  class LogAnalytics::Models::DependentParser
    PARSER_TYPE_ENUM = [
      PARSER_TYPE_XML = 'XML'.freeze,
      PARSER_TYPE_JSON = 'JSON'.freeze,
      PARSER_TYPE_REGEX = 'REGEX'.freeze,
      PARSER_TYPE_ODL = 'ODL'.freeze,
      PARSER_TYPE_DELIMITED = 'DELIMITED'.freeze,
      PARSER_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # The parser name.
    # @return [String]
    attr_accessor :parser_name

    # The parser display name.
    # @return [String]
    attr_accessor :parser_display_name

    # The parser unique identifier.
    # @return [Integer]
    attr_accessor :parser_id

    # The system flag.  A value of false denotes a custom, or user
    # defined object.  A value of true denotes a built in object.
    #
    # @return [BOOLEAN]
    attr_accessor :is_system

    # The parser type
    # @return [String]
    attr_reader :parser_type

    # The list of dependencies of the parser.
    # @return [Array<OCI::LogAnalytics::Models::Dependency>]
    attr_accessor :dependencies

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'parser_name': :'parserName',
        'parser_display_name': :'parserDisplayName',
        'parser_id': :'parserId',
        'is_system': :'isSystem',
        'parser_type': :'parserType',
        'dependencies': :'dependencies'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'parser_name': :'String',
        'parser_display_name': :'String',
        'parser_id': :'Integer',
        'is_system': :'BOOLEAN',
        'parser_type': :'String',
        'dependencies': :'Array<OCI::LogAnalytics::Models::Dependency>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :parser_name The value to assign to the {#parser_name} property
    # @option attributes [String] :parser_display_name The value to assign to the {#parser_display_name} property
    # @option attributes [Integer] :parser_id The value to assign to the {#parser_id} property
    # @option attributes [BOOLEAN] :is_system The value to assign to the {#is_system} property
    # @option attributes [String] :parser_type The value to assign to the {#parser_type} property
    # @option attributes [Array<OCI::LogAnalytics::Models::Dependency>] :dependencies The value to assign to the {#dependencies} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.parser_name = attributes[:'parserName'] if attributes[:'parserName']

      raise 'You cannot provide both :parserName and :parser_name' if attributes.key?(:'parserName') && attributes.key?(:'parser_name')

      self.parser_name = attributes[:'parser_name'] if attributes[:'parser_name']

      self.parser_display_name = attributes[:'parserDisplayName'] if attributes[:'parserDisplayName']

      raise 'You cannot provide both :parserDisplayName and :parser_display_name' if attributes.key?(:'parserDisplayName') && attributes.key?(:'parser_display_name')

      self.parser_display_name = attributes[:'parser_display_name'] if attributes[:'parser_display_name']

      self.parser_id = attributes[:'parserId'] if attributes[:'parserId']

      raise 'You cannot provide both :parserId and :parser_id' if attributes.key?(:'parserId') && attributes.key?(:'parser_id')

      self.parser_id = attributes[:'parser_id'] if attributes[:'parser_id']

      self.is_system = attributes[:'isSystem'] unless attributes[:'isSystem'].nil?

      raise 'You cannot provide both :isSystem and :is_system' if attributes.key?(:'isSystem') && attributes.key?(:'is_system')

      self.is_system = attributes[:'is_system'] unless attributes[:'is_system'].nil?

      self.parser_type = attributes[:'parserType'] if attributes[:'parserType']

      raise 'You cannot provide both :parserType and :parser_type' if attributes.key?(:'parserType') && attributes.key?(:'parser_type')

      self.parser_type = attributes[:'parser_type'] if attributes[:'parser_type']

      self.dependencies = attributes[:'dependencies'] if attributes[:'dependencies']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] parser_type Object to be assigned
    def parser_type=(parser_type)
      # rubocop:disable Style/ConditionalAssignment
      if parser_type && !PARSER_TYPE_ENUM.include?(parser_type)
        OCI.logger.debug("Unknown value for 'parser_type' [" + parser_type + "]. Mapping to 'PARSER_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @parser_type = PARSER_TYPE_UNKNOWN_ENUM_VALUE
      else
        @parser_type = parser_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        parser_name == other.parser_name &&
        parser_display_name == other.parser_display_name &&
        parser_id == other.parser_id &&
        is_system == other.is_system &&
        parser_type == other.parser_type &&
        dependencies == other.dependencies
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
      [parser_name, parser_display_name, parser_id, is_system, parser_type, dependencies].hash
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
