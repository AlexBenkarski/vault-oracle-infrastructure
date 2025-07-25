# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20171215
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details of each keytab entry read from the keytab file.
  #
  class FileStorage::Models::KerberosKeytabEntry
    ENCRYPTION_TYPE_ENUM = [
      ENCRYPTION_TYPE_AES128_CTS_HMAC_SHA256_128 = 'AES128_CTS_HMAC_SHA256_128'.freeze,
      ENCRYPTION_TYPE_AES256_CTS_HMAC_SHA384_192 = 'AES256_CTS_HMAC_SHA384_192'.freeze,
      ENCRYPTION_TYPE_AES128_CTS_HMAC_SHA1_96 = 'AES128_CTS_HMAC_SHA1_96'.freeze,
      ENCRYPTION_TYPE_AES256_CTS_HMAC_SHA1_96 = 'AES256_CTS_HMAC_SHA1_96'.freeze,
      ENCRYPTION_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Keytab principal.
    # @return [String]
    attr_accessor :principal

    # **[Required]** Encryption type with with keytab was generated.
    # Secure: aes128-cts-hmac-sha256-128
    # Secure: aes256-cts-hmac-sha384-192
    # Less Secure: aes128-cts-hmac-sha1-96
    # Less Secure: aes256-cts-hmac-sha1-96
    #
    # @return [String]
    attr_reader :encryption_type

    # **[Required]** Kerberos KVNO (key version number) for key in keytab entry.
    # @return [Integer]
    attr_accessor :key_version_number

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'principal': :'principal',
        'encryption_type': :'encryptionType',
        'key_version_number': :'keyVersionNumber'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'principal': :'String',
        'encryption_type': :'String',
        'key_version_number': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :principal The value to assign to the {#principal} property
    # @option attributes [String] :encryption_type The value to assign to the {#encryption_type} property
    # @option attributes [Integer] :key_version_number The value to assign to the {#key_version_number} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.principal = attributes[:'principal'] if attributes[:'principal']

      self.encryption_type = attributes[:'encryptionType'] if attributes[:'encryptionType']

      raise 'You cannot provide both :encryptionType and :encryption_type' if attributes.key?(:'encryptionType') && attributes.key?(:'encryption_type')

      self.encryption_type = attributes[:'encryption_type'] if attributes[:'encryption_type']

      self.key_version_number = attributes[:'keyVersionNumber'] if attributes[:'keyVersionNumber']

      raise 'You cannot provide both :keyVersionNumber and :key_version_number' if attributes.key?(:'keyVersionNumber') && attributes.key?(:'key_version_number')

      self.key_version_number = attributes[:'key_version_number'] if attributes[:'key_version_number']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] encryption_type Object to be assigned
    def encryption_type=(encryption_type)
      # rubocop:disable Style/ConditionalAssignment
      if encryption_type && !ENCRYPTION_TYPE_ENUM.include?(encryption_type)
        OCI.logger.debug("Unknown value for 'encryption_type' [" + encryption_type + "]. Mapping to 'ENCRYPTION_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @encryption_type = ENCRYPTION_TYPE_UNKNOWN_ENUM_VALUE
      else
        @encryption_type = encryption_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        principal == other.principal &&
        encryption_type == other.encryption_type &&
        key_version_number == other.key_version_number
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
      [principal, encryption_type, key_version_number].hash
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
