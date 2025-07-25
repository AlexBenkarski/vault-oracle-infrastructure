# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: v1
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # This extension defines attributes used to manage Multi-Factor Authentication within a service provider. The extension is typically applied to a User resource, but MAY be applied to other resources that use MFA.
  class IdentityDomains::Models::ExtensionMfaUser
    PREFERRED_AUTHENTICATION_FACTOR_ENUM = [
      PREFERRED_AUTHENTICATION_FACTOR_EMAIL = 'EMAIL'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_SMS = 'SMS'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_TOTP = 'TOTP'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_PUSH = 'PUSH'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_OFFLINETOTP = 'OFFLINETOTP'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_USERNAME_PASSWORD = 'USERNAME_PASSWORD'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_SECURITY_QUESTIONS = 'SECURITY_QUESTIONS'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_VOICE = 'VOICE'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_PHONE_CALL = 'PHONE_CALL'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_THIRDPARTY = 'THIRDPARTY'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_FIDO_AUTHENTICATOR = 'FIDO_AUTHENTICATOR'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_YUBICO_OTP = 'YUBICO_OTP'.freeze,
      PREFERRED_AUTHENTICATION_FACTOR_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    MFA_STATUS_ENUM = [
      MFA_STATUS_ENROLLED = 'ENROLLED'.freeze,
      MFA_STATUS_IGNORED = 'IGNORED'.freeze,
      MFA_STATUS_UN_ENROLLED = 'UN_ENROLLED'.freeze,
      MFA_STATUS_DISABLED = 'DISABLED'.freeze,
      MFA_STATUS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # The preferred authentication factor type.
    #
    # **Added In:** 18.3.6
    #
    # **SCIM++ Properties:**
    #  - caseExact: true
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :preferred_authentication_factor

    # The user opted for MFA.
    #
    # **Added In:** 18.3.6
    #
    # **SCIM++ Properties:**
    #  - caseExact: true
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readOnly
    #  - idcsRequiresWriteForAccessFlows: true
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :mfa_status

    # The preferred third-party vendor name.
    #
    # **Added In:** 19.2.1
    #
    # **SCIM++ Properties:**
    #  - caseExact: true
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :preferred_third_party_vendor

    # The preferred authentication method.
    #
    # **Added In:** 2009232244
    #
    # **SCIM++ Properties:**
    #  - caseExact: true
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :preferred_authentication_method

    # The number of incorrect multi factor authentication sign in attempts made by this user. The user is  locked if this reaches the threshold specified in the maxIncorrectAttempts attribute in AuthenticationFactorSettings.
    #
    # **Added In:** 18.3.6
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readOnly
    #  - idcsRequiresWriteForAccessFlows: true
    #  - idcsRequiresImmediateReadAfterWriteForAccessFlows: true
    #  - required: false
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :login_attempts

    # The date when the user enrolled in multi factor authentication. This will be set to null, when the user resets their factors.
    #
    # **Added In:** 18.3.6
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: request
    #  - type: dateTime
    #  - uniqueness: none
    # @return [String]
    attr_accessor :mfa_enabled_on

    # User MFA Ignored Apps Identifiers
    #
    # **Added In:** 19.2.1
    #
    # **SCIM++ Properties:**
    #  - caseExact: true
    #  - idcsSearchable: true
    #  - multiValued: true
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [Array<String>]
    attr_accessor :mfa_ignored_apps

    # @return [OCI::IdentityDomains::Models::UserExtPreferredDevice]
    attr_accessor :preferred_device

    # A list of devices enrolled by the user.
    #
    # **Added In:** 18.3.6
    #
    # **SCIM++ Properties:**
    #  - idcsCompositeKey: [value]
    #  - multiValued: true
    #  - mutability: readOnly
    #  - required: false
    #  - returned: request
    #  - type: complex
    #  - uniqueness: none
    # @return [Array<OCI::IdentityDomains::Models::UserExtDevices>]
    attr_accessor :devices

    # A list of bypass codes that belongs to the user.
    #
    # **Added In:** 18.3.6
    #
    # **SCIM++ Properties:**
    #  - idcsCompositeKey: [value]
    #  - multiValued: true
    #  - mutability: readOnly
    #  - required: false
    #  - returned: request
    #  - type: complex
    #  - uniqueness: none
    # @return [Array<OCI::IdentityDomains::Models::UserExtBypassCodes>]
    attr_accessor :bypass_codes

    # A list of trusted User Agents owned by this user. Multi-Factored Authentication uses Trusted User Agents to authenticate users.  A User Agent is software application that a user uses to issue requests. For example, a User Agent could be a particular browser (possibly one of several executing on a desktop or laptop) or a particular mobile application (again, oneof several executing on a particular mobile device). A User Agent is trusted once the Multi-Factor Authentication has verified it in some way.
    #
    # **Added In:** 18.3.6
    #
    # **SCIM++ Properties:**
    #  - idcsCompositeKey: [value]
    #  - multiValued: true
    #  - mutability: readWrite
    #  - required: false
    #  - returned: request
    #  - type: complex
    #  - uniqueness: none
    # @return [Array<OCI::IdentityDomains::Models::UserExtTrustedUserAgents>]
    attr_accessor :trusted_user_agents

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'preferred_authentication_factor': :'preferredAuthenticationFactor',
        'mfa_status': :'mfaStatus',
        'preferred_third_party_vendor': :'preferredThirdPartyVendor',
        'preferred_authentication_method': :'preferredAuthenticationMethod',
        'login_attempts': :'loginAttempts',
        'mfa_enabled_on': :'mfaEnabledOn',
        'mfa_ignored_apps': :'mfaIgnoredApps',
        'preferred_device': :'preferredDevice',
        'devices': :'devices',
        'bypass_codes': :'bypassCodes',
        'trusted_user_agents': :'trustedUserAgents'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'preferred_authentication_factor': :'String',
        'mfa_status': :'String',
        'preferred_third_party_vendor': :'String',
        'preferred_authentication_method': :'String',
        'login_attempts': :'Integer',
        'mfa_enabled_on': :'String',
        'mfa_ignored_apps': :'Array<String>',
        'preferred_device': :'OCI::IdentityDomains::Models::UserExtPreferredDevice',
        'devices': :'Array<OCI::IdentityDomains::Models::UserExtDevices>',
        'bypass_codes': :'Array<OCI::IdentityDomains::Models::UserExtBypassCodes>',
        'trusted_user_agents': :'Array<OCI::IdentityDomains::Models::UserExtTrustedUserAgents>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :preferred_authentication_factor The value to assign to the {#preferred_authentication_factor} property
    # @option attributes [String] :mfa_status The value to assign to the {#mfa_status} property
    # @option attributes [String] :preferred_third_party_vendor The value to assign to the {#preferred_third_party_vendor} property
    # @option attributes [String] :preferred_authentication_method The value to assign to the {#preferred_authentication_method} property
    # @option attributes [Integer] :login_attempts The value to assign to the {#login_attempts} property
    # @option attributes [String] :mfa_enabled_on The value to assign to the {#mfa_enabled_on} property
    # @option attributes [Array<String>] :mfa_ignored_apps The value to assign to the {#mfa_ignored_apps} property
    # @option attributes [OCI::IdentityDomains::Models::UserExtPreferredDevice] :preferred_device The value to assign to the {#preferred_device} property
    # @option attributes [Array<OCI::IdentityDomains::Models::UserExtDevices>] :devices The value to assign to the {#devices} property
    # @option attributes [Array<OCI::IdentityDomains::Models::UserExtBypassCodes>] :bypass_codes The value to assign to the {#bypass_codes} property
    # @option attributes [Array<OCI::IdentityDomains::Models::UserExtTrustedUserAgents>] :trusted_user_agents The value to assign to the {#trusted_user_agents} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.preferred_authentication_factor = attributes[:'preferredAuthenticationFactor'] if attributes[:'preferredAuthenticationFactor']

      raise 'You cannot provide both :preferredAuthenticationFactor and :preferred_authentication_factor' if attributes.key?(:'preferredAuthenticationFactor') && attributes.key?(:'preferred_authentication_factor')

      self.preferred_authentication_factor = attributes[:'preferred_authentication_factor'] if attributes[:'preferred_authentication_factor']

      self.mfa_status = attributes[:'mfaStatus'] if attributes[:'mfaStatus']

      raise 'You cannot provide both :mfaStatus and :mfa_status' if attributes.key?(:'mfaStatus') && attributes.key?(:'mfa_status')

      self.mfa_status = attributes[:'mfa_status'] if attributes[:'mfa_status']

      self.preferred_third_party_vendor = attributes[:'preferredThirdPartyVendor'] if attributes[:'preferredThirdPartyVendor']

      raise 'You cannot provide both :preferredThirdPartyVendor and :preferred_third_party_vendor' if attributes.key?(:'preferredThirdPartyVendor') && attributes.key?(:'preferred_third_party_vendor')

      self.preferred_third_party_vendor = attributes[:'preferred_third_party_vendor'] if attributes[:'preferred_third_party_vendor']

      self.preferred_authentication_method = attributes[:'preferredAuthenticationMethod'] if attributes[:'preferredAuthenticationMethod']

      raise 'You cannot provide both :preferredAuthenticationMethod and :preferred_authentication_method' if attributes.key?(:'preferredAuthenticationMethod') && attributes.key?(:'preferred_authentication_method')

      self.preferred_authentication_method = attributes[:'preferred_authentication_method'] if attributes[:'preferred_authentication_method']

      self.login_attempts = attributes[:'loginAttempts'] if attributes[:'loginAttempts']

      raise 'You cannot provide both :loginAttempts and :login_attempts' if attributes.key?(:'loginAttempts') && attributes.key?(:'login_attempts')

      self.login_attempts = attributes[:'login_attempts'] if attributes[:'login_attempts']

      self.mfa_enabled_on = attributes[:'mfaEnabledOn'] if attributes[:'mfaEnabledOn']

      raise 'You cannot provide both :mfaEnabledOn and :mfa_enabled_on' if attributes.key?(:'mfaEnabledOn') && attributes.key?(:'mfa_enabled_on')

      self.mfa_enabled_on = attributes[:'mfa_enabled_on'] if attributes[:'mfa_enabled_on']

      self.mfa_ignored_apps = attributes[:'mfaIgnoredApps'] if attributes[:'mfaIgnoredApps']

      raise 'You cannot provide both :mfaIgnoredApps and :mfa_ignored_apps' if attributes.key?(:'mfaIgnoredApps') && attributes.key?(:'mfa_ignored_apps')

      self.mfa_ignored_apps = attributes[:'mfa_ignored_apps'] if attributes[:'mfa_ignored_apps']

      self.preferred_device = attributes[:'preferredDevice'] if attributes[:'preferredDevice']

      raise 'You cannot provide both :preferredDevice and :preferred_device' if attributes.key?(:'preferredDevice') && attributes.key?(:'preferred_device')

      self.preferred_device = attributes[:'preferred_device'] if attributes[:'preferred_device']

      self.devices = attributes[:'devices'] if attributes[:'devices']

      self.bypass_codes = attributes[:'bypassCodes'] if attributes[:'bypassCodes']

      raise 'You cannot provide both :bypassCodes and :bypass_codes' if attributes.key?(:'bypassCodes') && attributes.key?(:'bypass_codes')

      self.bypass_codes = attributes[:'bypass_codes'] if attributes[:'bypass_codes']

      self.trusted_user_agents = attributes[:'trustedUserAgents'] if attributes[:'trustedUserAgents']

      raise 'You cannot provide both :trustedUserAgents and :trusted_user_agents' if attributes.key?(:'trustedUserAgents') && attributes.key?(:'trusted_user_agents')

      self.trusted_user_agents = attributes[:'trusted_user_agents'] if attributes[:'trusted_user_agents']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] preferred_authentication_factor Object to be assigned
    def preferred_authentication_factor=(preferred_authentication_factor)
      # rubocop:disable Style/ConditionalAssignment
      if preferred_authentication_factor && !PREFERRED_AUTHENTICATION_FACTOR_ENUM.include?(preferred_authentication_factor)
        OCI.logger.debug("Unknown value for 'preferred_authentication_factor' [" + preferred_authentication_factor + "]. Mapping to 'PREFERRED_AUTHENTICATION_FACTOR_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @preferred_authentication_factor = PREFERRED_AUTHENTICATION_FACTOR_UNKNOWN_ENUM_VALUE
      else
        @preferred_authentication_factor = preferred_authentication_factor
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] mfa_status Object to be assigned
    def mfa_status=(mfa_status)
      # rubocop:disable Style/ConditionalAssignment
      if mfa_status && !MFA_STATUS_ENUM.include?(mfa_status)
        OCI.logger.debug("Unknown value for 'mfa_status' [" + mfa_status + "]. Mapping to 'MFA_STATUS_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @mfa_status = MFA_STATUS_UNKNOWN_ENUM_VALUE
      else
        @mfa_status = mfa_status
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        preferred_authentication_factor == other.preferred_authentication_factor &&
        mfa_status == other.mfa_status &&
        preferred_third_party_vendor == other.preferred_third_party_vendor &&
        preferred_authentication_method == other.preferred_authentication_method &&
        login_attempts == other.login_attempts &&
        mfa_enabled_on == other.mfa_enabled_on &&
        mfa_ignored_apps == other.mfa_ignored_apps &&
        preferred_device == other.preferred_device &&
        devices == other.devices &&
        bypass_codes == other.bypass_codes &&
        trusted_user_agents == other.trusted_user_agents
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
      [preferred_authentication_factor, mfa_status, preferred_third_party_vendor, preferred_authentication_method, login_attempts, mfa_enabled_on, mfa_ignored_apps, preferred_device, devices, bypass_codes, trusted_user_agents].hash
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
