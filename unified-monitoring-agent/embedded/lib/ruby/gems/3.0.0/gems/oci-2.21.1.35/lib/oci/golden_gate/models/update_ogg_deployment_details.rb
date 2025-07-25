# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200407
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Deployment Details for updating an OggDeployment
  #
  class GoldenGate::Models::UpdateOggDeploymentDetails
    CREDENTIAL_STORE_ENUM = [
      CREDENTIAL_STORE_GOLDENGATE = 'GOLDENGATE'.freeze,
      CREDENTIAL_STORE_IAM = 'IAM'.freeze
    ].freeze

    # The type of credential store for OGG.
    #
    # @return [String]
    attr_reader :credential_store

    # The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the Identity Domain when IAM credential store is used.
    #
    # @return [String]
    attr_accessor :identity_domain_id

    # The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the Secret where the deployment password is stored.
    #
    # @return [String]
    attr_accessor :password_secret_id

    # The GoldenGate deployment console username.
    #
    # @return [String]
    attr_accessor :admin_username

    # The password associated with the GoldenGate deployment console username.
    # The password must be 8 to 30 characters long and must contain at least 1 uppercase, 1 lowercase, 1 numeric,
    # and 1 special character. Special characters such as '$', '^', or '?' are not allowed.
    # This field will be deprecated and replaced by \"passwordSecretId\".
    #
    # @return [String]
    attr_accessor :admin_password

    # The base64 encoded content of the PEM file containing the SSL certificate.
    #
    # @return [String]
    attr_accessor :certificate

    # The base64 encoded content of the PEM file containing the private key.
    #
    # @return [String]
    attr_accessor :key

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'credential_store': :'credentialStore',
        'identity_domain_id': :'identityDomainId',
        'password_secret_id': :'passwordSecretId',
        'admin_username': :'adminUsername',
        'admin_password': :'adminPassword',
        'certificate': :'certificate',
        'key': :'key'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'credential_store': :'String',
        'identity_domain_id': :'String',
        'password_secret_id': :'String',
        'admin_username': :'String',
        'admin_password': :'String',
        'certificate': :'String',
        'key': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :credential_store The value to assign to the {#credential_store} property
    # @option attributes [String] :identity_domain_id The value to assign to the {#identity_domain_id} property
    # @option attributes [String] :password_secret_id The value to assign to the {#password_secret_id} property
    # @option attributes [String] :admin_username The value to assign to the {#admin_username} property
    # @option attributes [String] :admin_password The value to assign to the {#admin_password} property
    # @option attributes [String] :certificate The value to assign to the {#certificate} property
    # @option attributes [String] :key The value to assign to the {#key} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.credential_store = attributes[:'credentialStore'] if attributes[:'credentialStore']
      self.credential_store = "GOLDENGATE" if credential_store.nil? && !attributes.key?(:'credentialStore') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :credentialStore and :credential_store' if attributes.key?(:'credentialStore') && attributes.key?(:'credential_store')

      self.credential_store = attributes[:'credential_store'] if attributes[:'credential_store']
      self.credential_store = "GOLDENGATE" if credential_store.nil? && !attributes.key?(:'credentialStore') && !attributes.key?(:'credential_store') # rubocop:disable Style/StringLiterals

      self.identity_domain_id = attributes[:'identityDomainId'] if attributes[:'identityDomainId']

      raise 'You cannot provide both :identityDomainId and :identity_domain_id' if attributes.key?(:'identityDomainId') && attributes.key?(:'identity_domain_id')

      self.identity_domain_id = attributes[:'identity_domain_id'] if attributes[:'identity_domain_id']

      self.password_secret_id = attributes[:'passwordSecretId'] if attributes[:'passwordSecretId']

      raise 'You cannot provide both :passwordSecretId and :password_secret_id' if attributes.key?(:'passwordSecretId') && attributes.key?(:'password_secret_id')

      self.password_secret_id = attributes[:'password_secret_id'] if attributes[:'password_secret_id']

      self.admin_username = attributes[:'adminUsername'] if attributes[:'adminUsername']

      raise 'You cannot provide both :adminUsername and :admin_username' if attributes.key?(:'adminUsername') && attributes.key?(:'admin_username')

      self.admin_username = attributes[:'admin_username'] if attributes[:'admin_username']

      self.admin_password = attributes[:'adminPassword'] if attributes[:'adminPassword']

      raise 'You cannot provide both :adminPassword and :admin_password' if attributes.key?(:'adminPassword') && attributes.key?(:'admin_password')

      self.admin_password = attributes[:'admin_password'] if attributes[:'admin_password']

      self.certificate = attributes[:'certificate'] if attributes[:'certificate']

      self.key = attributes[:'key'] if attributes[:'key']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] credential_store Object to be assigned
    def credential_store=(credential_store)
      raise "Invalid value for 'credential_store': this must be one of the values in CREDENTIAL_STORE_ENUM." if credential_store && !CREDENTIAL_STORE_ENUM.include?(credential_store)

      @credential_store = credential_store
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        credential_store == other.credential_store &&
        identity_domain_id == other.identity_domain_id &&
        password_secret_id == other.password_secret_id &&
        admin_username == other.admin_username &&
        admin_password == other.admin_password &&
        certificate == other.certificate &&
        key == other.key
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
      [credential_store, identity_domain_id, password_secret_id, admin_username, admin_password, certificate, key].hash
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
