# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: v1
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Custom claims associated with the specific tenant
  class IdentityDomains::Models::SettingsTenantCustomClaims
    MODE_ENUM = [
      MODE_ALWAYS = 'always'.freeze,
      MODE_REQUEST = 'request'.freeze,
      MODE_NEVER = 'never'.freeze,
      MODE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    TOKEN_TYPE_ENUM = [
      TOKEN_TYPE_AT = 'AT'.freeze,
      TOKEN_TYPE_IT = 'IT'.freeze,
      TOKEN_TYPE_BOTH = 'BOTH'.freeze,
      TOKEN_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Custom claim name
    #
    # **Added In:** 18.4.2
    #
    # **SCIM++ Properties:**
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: server
    # @return [String]
    attr_accessor :name

    # **[Required]** Custom claim value
    #
    # **Added In:** 18.4.2
    #
    # **SCIM++ Properties:**
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :value

    # **[Required]** Indicates under what scenario the custom claim will be return
    #
    # **Added In:** 18.4.2
    #
    # **SCIM++ Properties:**
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :mode

    # **[Required]** Indicates if the custom claim is an expression
    #
    # **Added In:** 18.4.2
    #
    # **SCIM++ Properties:**
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: boolean
    #  - uniqueness: none
    # @return [BOOLEAN]
    attr_accessor :expression

    # **[Required]** Indicates if the custom claim is associated with all scopes
    #
    # **Added In:** 18.4.2
    #
    # **SCIM++ Properties:**
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: boolean
    #  - uniqueness: none
    # @return [BOOLEAN]
    attr_accessor :all_scopes

    # **[Required]** Indicates what type of token the custom claim will be embedded
    #
    # **Added In:** 18.4.2
    #
    # **SCIM++ Properties:**
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :token_type

    # Scopes associated with a specific custom claim
    #
    # **Added In:** 18.4.2
    #
    # **SCIM++ Properties:**
    #  - multiValued: true
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [Array<String>]
    attr_accessor :scopes

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'name',
        'value': :'value',
        'mode': :'mode',
        'expression': :'expression',
        'all_scopes': :'allScopes',
        'token_type': :'tokenType',
        'scopes': :'scopes'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'String',
        'value': :'String',
        'mode': :'String',
        'expression': :'BOOLEAN',
        'all_scopes': :'BOOLEAN',
        'token_type': :'String',
        'scopes': :'Array<String>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :value The value to assign to the {#value} property
    # @option attributes [String] :mode The value to assign to the {#mode} property
    # @option attributes [BOOLEAN] :expression The value to assign to the {#expression} property
    # @option attributes [BOOLEAN] :all_scopes The value to assign to the {#all_scopes} property
    # @option attributes [String] :token_type The value to assign to the {#token_type} property
    # @option attributes [Array<String>] :scopes The value to assign to the {#scopes} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.name = attributes[:'name'] if attributes[:'name']

      self.value = attributes[:'value'] if attributes[:'value']

      self.mode = attributes[:'mode'] if attributes[:'mode']

      self.expression = attributes[:'expression'] unless attributes[:'expression'].nil?

      self.all_scopes = attributes[:'allScopes'] unless attributes[:'allScopes'].nil?

      raise 'You cannot provide both :allScopes and :all_scopes' if attributes.key?(:'allScopes') && attributes.key?(:'all_scopes')

      self.all_scopes = attributes[:'all_scopes'] unless attributes[:'all_scopes'].nil?

      self.token_type = attributes[:'tokenType'] if attributes[:'tokenType']

      raise 'You cannot provide both :tokenType and :token_type' if attributes.key?(:'tokenType') && attributes.key?(:'token_type')

      self.token_type = attributes[:'token_type'] if attributes[:'token_type']

      self.scopes = attributes[:'scopes'] if attributes[:'scopes']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] mode Object to be assigned
    def mode=(mode)
      # rubocop:disable Style/ConditionalAssignment
      if mode && !MODE_ENUM.include?(mode)
        OCI.logger.debug("Unknown value for 'mode' [" + mode + "]. Mapping to 'MODE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @mode = MODE_UNKNOWN_ENUM_VALUE
      else
        @mode = mode
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] token_type Object to be assigned
    def token_type=(token_type)
      # rubocop:disable Style/ConditionalAssignment
      if token_type && !TOKEN_TYPE_ENUM.include?(token_type)
        OCI.logger.debug("Unknown value for 'token_type' [" + token_type + "]. Mapping to 'TOKEN_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @token_type = TOKEN_TYPE_UNKNOWN_ENUM_VALUE
      else
        @token_type = token_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        name == other.name &&
        value == other.value &&
        mode == other.mode &&
        expression == other.expression &&
        all_scopes == other.all_scopes &&
        token_type == other.token_type &&
        scopes == other.scopes
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
      [name, value, mode, expression, all_scopes, token_type, scopes].hash
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
