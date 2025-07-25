# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Configuration details for IPSec phase two configuration parameters.
  class VnMonitoring::Models::PhaseTwoConfigDetails
    AUTHENTICATION_ALGORITHM_ENUM = [
      AUTHENTICATION_ALGORITHM_HMAC_SHA2_256_128 = 'HMAC_SHA2_256_128'.freeze,
      AUTHENTICATION_ALGORITHM_HMAC_SHA1_128 = 'HMAC_SHA1_128'.freeze
    ].freeze

    ENCRYPTION_ALGORITHM_ENUM = [
      ENCRYPTION_ALGORITHM_AES_256_GCM = 'AES_256_GCM'.freeze,
      ENCRYPTION_ALGORITHM_AES_192_GCM = 'AES_192_GCM'.freeze,
      ENCRYPTION_ALGORITHM_AES_128_GCM = 'AES_128_GCM'.freeze,
      ENCRYPTION_ALGORITHM_AES_256_CBC = 'AES_256_CBC'.freeze,
      ENCRYPTION_ALGORITHM_AES_192_CBC = 'AES_192_CBC'.freeze,
      ENCRYPTION_ALGORITHM_AES_128_CBC = 'AES_128_CBC'.freeze
    ].freeze

    PFS_DH_GROUP_ENUM = [
      PFS_DH_GROUP_GROUP2 = 'GROUP2'.freeze,
      PFS_DH_GROUP_GROUP5 = 'GROUP5'.freeze,
      PFS_DH_GROUP_GROUP14 = 'GROUP14'.freeze,
      PFS_DH_GROUP_GROUP19 = 'GROUP19'.freeze,
      PFS_DH_GROUP_GROUP20 = 'GROUP20'.freeze,
      PFS_DH_GROUP_GROUP24 = 'GROUP24'.freeze
    ].freeze

    # Indicates whether custom configuration is enabled for phase two options.
    # @return [BOOLEAN]
    attr_accessor :is_custom_phase_two_config

    # The authentication algorithm proposed during phase two tunnel negotiation.
    #
    # @return [String]
    attr_reader :authentication_algorithm

    # The encryption algorithm proposed during phase two tunnel negotiation.
    #
    # @return [String]
    attr_reader :encryption_algorithm

    # Lifetime in seconds for the IPSec session key set in phase two. The default is 3600 which is equivalent to 1 hour.
    #
    # @return [Integer]
    attr_accessor :lifetime_in_seconds

    # Indicates whether perfect forward secrecy (PFS) is enabled.
    # @return [BOOLEAN]
    attr_accessor :is_pfs_enabled

    # The Diffie-Hellman group used for PFS, if PFS is enabled.
    # @return [String]
    attr_reader :pfs_dh_group

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'is_custom_phase_two_config': :'isCustomPhaseTwoConfig',
        'authentication_algorithm': :'authenticationAlgorithm',
        'encryption_algorithm': :'encryptionAlgorithm',
        'lifetime_in_seconds': :'lifetimeInSeconds',
        'is_pfs_enabled': :'isPfsEnabled',
        'pfs_dh_group': :'pfsDhGroup'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'is_custom_phase_two_config': :'BOOLEAN',
        'authentication_algorithm': :'String',
        'encryption_algorithm': :'String',
        'lifetime_in_seconds': :'Integer',
        'is_pfs_enabled': :'BOOLEAN',
        'pfs_dh_group': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [BOOLEAN] :is_custom_phase_two_config The value to assign to the {#is_custom_phase_two_config} property
    # @option attributes [String] :authentication_algorithm The value to assign to the {#authentication_algorithm} property
    # @option attributes [String] :encryption_algorithm The value to assign to the {#encryption_algorithm} property
    # @option attributes [Integer] :lifetime_in_seconds The value to assign to the {#lifetime_in_seconds} property
    # @option attributes [BOOLEAN] :is_pfs_enabled The value to assign to the {#is_pfs_enabled} property
    # @option attributes [String] :pfs_dh_group The value to assign to the {#pfs_dh_group} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.is_custom_phase_two_config = attributes[:'isCustomPhaseTwoConfig'] unless attributes[:'isCustomPhaseTwoConfig'].nil?

      raise 'You cannot provide both :isCustomPhaseTwoConfig and :is_custom_phase_two_config' if attributes.key?(:'isCustomPhaseTwoConfig') && attributes.key?(:'is_custom_phase_two_config')

      self.is_custom_phase_two_config = attributes[:'is_custom_phase_two_config'] unless attributes[:'is_custom_phase_two_config'].nil?

      self.authentication_algorithm = attributes[:'authenticationAlgorithm'] if attributes[:'authenticationAlgorithm']

      raise 'You cannot provide both :authenticationAlgorithm and :authentication_algorithm' if attributes.key?(:'authenticationAlgorithm') && attributes.key?(:'authentication_algorithm')

      self.authentication_algorithm = attributes[:'authentication_algorithm'] if attributes[:'authentication_algorithm']

      self.encryption_algorithm = attributes[:'encryptionAlgorithm'] if attributes[:'encryptionAlgorithm']

      raise 'You cannot provide both :encryptionAlgorithm and :encryption_algorithm' if attributes.key?(:'encryptionAlgorithm') && attributes.key?(:'encryption_algorithm')

      self.encryption_algorithm = attributes[:'encryption_algorithm'] if attributes[:'encryption_algorithm']

      self.lifetime_in_seconds = attributes[:'lifetimeInSeconds'] if attributes[:'lifetimeInSeconds']

      raise 'You cannot provide both :lifetimeInSeconds and :lifetime_in_seconds' if attributes.key?(:'lifetimeInSeconds') && attributes.key?(:'lifetime_in_seconds')

      self.lifetime_in_seconds = attributes[:'lifetime_in_seconds'] if attributes[:'lifetime_in_seconds']

      self.is_pfs_enabled = attributes[:'isPfsEnabled'] unless attributes[:'isPfsEnabled'].nil?

      raise 'You cannot provide both :isPfsEnabled and :is_pfs_enabled' if attributes.key?(:'isPfsEnabled') && attributes.key?(:'is_pfs_enabled')

      self.is_pfs_enabled = attributes[:'is_pfs_enabled'] unless attributes[:'is_pfs_enabled'].nil?

      self.pfs_dh_group = attributes[:'pfsDhGroup'] if attributes[:'pfsDhGroup']

      raise 'You cannot provide both :pfsDhGroup and :pfs_dh_group' if attributes.key?(:'pfsDhGroup') && attributes.key?(:'pfs_dh_group')

      self.pfs_dh_group = attributes[:'pfs_dh_group'] if attributes[:'pfs_dh_group']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] authentication_algorithm Object to be assigned
    def authentication_algorithm=(authentication_algorithm)
      raise "Invalid value for 'authentication_algorithm': this must be one of the values in AUTHENTICATION_ALGORITHM_ENUM." if authentication_algorithm && !AUTHENTICATION_ALGORITHM_ENUM.include?(authentication_algorithm)

      @authentication_algorithm = authentication_algorithm
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] encryption_algorithm Object to be assigned
    def encryption_algorithm=(encryption_algorithm)
      raise "Invalid value for 'encryption_algorithm': this must be one of the values in ENCRYPTION_ALGORITHM_ENUM." if encryption_algorithm && !ENCRYPTION_ALGORITHM_ENUM.include?(encryption_algorithm)

      @encryption_algorithm = encryption_algorithm
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] pfs_dh_group Object to be assigned
    def pfs_dh_group=(pfs_dh_group)
      raise "Invalid value for 'pfs_dh_group': this must be one of the values in PFS_DH_GROUP_ENUM." if pfs_dh_group && !PFS_DH_GROUP_ENUM.include?(pfs_dh_group)

      @pfs_dh_group = pfs_dh_group
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        is_custom_phase_two_config == other.is_custom_phase_two_config &&
        authentication_algorithm == other.authentication_algorithm &&
        encryption_algorithm == other.encryption_algorithm &&
        lifetime_in_seconds == other.lifetime_in_seconds &&
        is_pfs_enabled == other.is_pfs_enabled &&
        pfs_dh_group == other.pfs_dh_group
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
      [is_custom_phase_two_config, authentication_algorithm, encryption_algorithm, lifetime_in_seconds, is_pfs_enabled, pfs_dh_group].hash
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
