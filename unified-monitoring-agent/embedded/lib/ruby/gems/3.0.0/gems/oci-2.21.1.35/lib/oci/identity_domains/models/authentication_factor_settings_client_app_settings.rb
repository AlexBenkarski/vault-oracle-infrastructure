# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: v1
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Settings related to compliance, Personal Identification Number (PIN) policy, and so on
  #
  # **SCIM++ Properties:**
  #  - idcsSearchable: false
  #  - multiValued: false
  #  - mutability: readWrite
  #  - required: true
  #  - returned: default
  #  - type: complex
  #  - uniqueness: none
  class IdentityDomains::Models::AuthenticationFactorSettingsClientAppSettings
    REQUEST_SIGNING_ALGO_ENUM = [
      REQUEST_SIGNING_ALGO_SHA256WITH_RSA = 'SHA256withRSA'.freeze,
      REQUEST_SIGNING_ALGO_SHA384WITH_RSA = 'SHA384withRSA'.freeze,
      REQUEST_SIGNING_ALGO_SHA512WITH_RSA = 'SHA512withRSA'.freeze,
      REQUEST_SIGNING_ALGO_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    SHARED_SECRET_ENCODING_ENUM = [
      SHARED_SECRET_ENCODING_BASE32 = 'Base32'.freeze,
      SHARED_SECRET_ENCODING_BASE64 = 'Base64'.freeze,
      SHARED_SECRET_ENCODING_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Minimum length of the Personal Identification Number (PIN)
    #
    # **SCIM++ Properties:**
    #  - idcsMaxValue: 10
    #  - idcsMinValue: 6
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :min_pin_length

    # **[Required]** The maximum number of login failures that the system will allow before raising a warning and sending an alert via email
    #
    # **SCIM++ Properties:**
    #  - idcsMaxValue: 10
    #  - idcsMinValue: 0
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :max_failures_before_warning

    # **[Required]** The maximum number of times that a particular user can fail to login before the system locks that user out of the service
    #
    # **SCIM++ Properties:**
    #  - idcsMaxValue: 10
    #  - idcsMinValue: 5
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :max_failures_before_lockout

    # **[Required]** The period of time in seconds that the system will lock a user out of the service after that user exceeds the maximum number of login failures
    #
    # **SCIM++ Properties:**
    #  - idcsMaxValue: 86400
    #  - idcsMinValue: 30
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :initial_lockout_period_in_secs

    # **[Required]** The pattern of escalation that the system follows, in locking a particular user out of the service.
    #
    # **SCIM++ Properties:**
    #  - idcsCanonicalValueSourceFilter: attrName eq \"lockoutEscalationPattern\" and attrValues.value eq \"$(lockoutEscalationPattern)\"
    #  - idcsCanonicalValueSourceResourceType: AllowedValue
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :lockout_escalation_pattern

    # **[Required]** The maximum period of time that the system will lock a particular user out of the service regardless of what the configured pattern of escalation would otherwise dictate
    #
    # **SCIM++ Properties:**
    #  - idcsMaxValue: 86400
    #  - idcsMinValue: 30
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :max_lockout_interval_in_secs

    # **[Required]** Indicates which algorithm the system will use to sign requests
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :request_signing_algo

    # **[Required]** The period of time in days after which a client should refresh its policy by re-reading that policy from the server
    #
    # **SCIM++ Properties:**
    #  - idcsMaxValue: 999
    #  - idcsMinValue: 1
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :policy_update_freq_in_days

    # **[Required]** The size of the key that the system uses to generate the public-private key pair
    #
    # **SCIM++ Properties:**
    #  - idcsMaxValue: 4000
    #  - idcsMinValue: 32
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :key_pair_length

    # **[Required]** Indicates what protection policy that the system applies on a device. By default, the value is NONE, which indicates that the system applies no protection policy. A value of APP_PIN indicates that the system requires a Personal Identification Number (PIN). A value of DEVICE_BIOMETRIC_OR_APP_PIN indicates that either a PIN or a biometric authentication factor is required.
    #
    # **SCIM++ Properties:**
    #  - idcsCanonicalValueSourceFilter: attrName eq \"deviceProtectionPolicy\" and attrValues.value eq \"$(deviceProtectionPolicy)\"
    #  - idcsCanonicalValueSourceResourceType: AllowedValue
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :device_protection_policy

    # **[Required]** If true, indicates that the system should require the user to unlock the client app for each request. In order to unlock the App, the user must supply a Personal Identification Number (PIN) or a biometric authentication-factor.
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: boolean
    #  - uniqueness: none
    # @return [BOOLEAN]
    attr_accessor :unlock_app_for_each_request_enabled

    # **[Required]** If true, indicates that the system should require the user to unlock the client App whenever the App is started. In order to unlock the App, the user must supply a Personal Identification Number (PIN) or a biometric authentication-factor.
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: boolean
    #  - uniqueness: none
    # @return [BOOLEAN]
    attr_accessor :unlock_on_app_start_enabled

    # **[Required]** Specifies the period of time in seconds after which the client App should require the user to unlock the App. In order to unlock the App, the user must supply a Personal Identification Number (PIN) or a biometric authentication-factor. A value of zero means that it is disabled.
    #
    # **SCIM++ Properties:**
    #  - idcsMaxValue: 9999999
    #  - idcsMinValue: 0
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: integer
    #  - uniqueness: none
    # @return [Integer]
    attr_accessor :unlock_app_interval_in_secs

    # **[Required]** Indicates the type of encoding that the system should use to generate a shared secret
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :shared_secret_encoding

    # **[Required]** If true, indicates that the system should require the user to unlock the client App, when the client App comes to the foreground in the display of the device. In order to unlock the App, the user must supply a Personal Identification Number (PIN) or a biometric authentication-factor.
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: true
    #  - returned: default
    #  - type: boolean
    #  - uniqueness: none
    # @return [BOOLEAN]
    attr_accessor :unlock_on_app_foreground_enabled

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'min_pin_length': :'minPinLength',
        'max_failures_before_warning': :'maxFailuresBeforeWarning',
        'max_failures_before_lockout': :'maxFailuresBeforeLockout',
        'initial_lockout_period_in_secs': :'initialLockoutPeriodInSecs',
        'lockout_escalation_pattern': :'lockoutEscalationPattern',
        'max_lockout_interval_in_secs': :'maxLockoutIntervalInSecs',
        'request_signing_algo': :'requestSigningAlgo',
        'policy_update_freq_in_days': :'policyUpdateFreqInDays',
        'key_pair_length': :'keyPairLength',
        'device_protection_policy': :'deviceProtectionPolicy',
        'unlock_app_for_each_request_enabled': :'unlockAppForEachRequestEnabled',
        'unlock_on_app_start_enabled': :'unlockOnAppStartEnabled',
        'unlock_app_interval_in_secs': :'unlockAppIntervalInSecs',
        'shared_secret_encoding': :'sharedSecretEncoding',
        'unlock_on_app_foreground_enabled': :'unlockOnAppForegroundEnabled'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'min_pin_length': :'Integer',
        'max_failures_before_warning': :'Integer',
        'max_failures_before_lockout': :'Integer',
        'initial_lockout_period_in_secs': :'Integer',
        'lockout_escalation_pattern': :'String',
        'max_lockout_interval_in_secs': :'Integer',
        'request_signing_algo': :'String',
        'policy_update_freq_in_days': :'Integer',
        'key_pair_length': :'Integer',
        'device_protection_policy': :'String',
        'unlock_app_for_each_request_enabled': :'BOOLEAN',
        'unlock_on_app_start_enabled': :'BOOLEAN',
        'unlock_app_interval_in_secs': :'Integer',
        'shared_secret_encoding': :'String',
        'unlock_on_app_foreground_enabled': :'BOOLEAN'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [Integer] :min_pin_length The value to assign to the {#min_pin_length} property
    # @option attributes [Integer] :max_failures_before_warning The value to assign to the {#max_failures_before_warning} property
    # @option attributes [Integer] :max_failures_before_lockout The value to assign to the {#max_failures_before_lockout} property
    # @option attributes [Integer] :initial_lockout_period_in_secs The value to assign to the {#initial_lockout_period_in_secs} property
    # @option attributes [String] :lockout_escalation_pattern The value to assign to the {#lockout_escalation_pattern} property
    # @option attributes [Integer] :max_lockout_interval_in_secs The value to assign to the {#max_lockout_interval_in_secs} property
    # @option attributes [String] :request_signing_algo The value to assign to the {#request_signing_algo} property
    # @option attributes [Integer] :policy_update_freq_in_days The value to assign to the {#policy_update_freq_in_days} property
    # @option attributes [Integer] :key_pair_length The value to assign to the {#key_pair_length} property
    # @option attributes [String] :device_protection_policy The value to assign to the {#device_protection_policy} property
    # @option attributes [BOOLEAN] :unlock_app_for_each_request_enabled The value to assign to the {#unlock_app_for_each_request_enabled} property
    # @option attributes [BOOLEAN] :unlock_on_app_start_enabled The value to assign to the {#unlock_on_app_start_enabled} property
    # @option attributes [Integer] :unlock_app_interval_in_secs The value to assign to the {#unlock_app_interval_in_secs} property
    # @option attributes [String] :shared_secret_encoding The value to assign to the {#shared_secret_encoding} property
    # @option attributes [BOOLEAN] :unlock_on_app_foreground_enabled The value to assign to the {#unlock_on_app_foreground_enabled} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.min_pin_length = attributes[:'minPinLength'] if attributes[:'minPinLength']

      raise 'You cannot provide both :minPinLength and :min_pin_length' if attributes.key?(:'minPinLength') && attributes.key?(:'min_pin_length')

      self.min_pin_length = attributes[:'min_pin_length'] if attributes[:'min_pin_length']

      self.max_failures_before_warning = attributes[:'maxFailuresBeforeWarning'] if attributes[:'maxFailuresBeforeWarning']

      raise 'You cannot provide both :maxFailuresBeforeWarning and :max_failures_before_warning' if attributes.key?(:'maxFailuresBeforeWarning') && attributes.key?(:'max_failures_before_warning')

      self.max_failures_before_warning = attributes[:'max_failures_before_warning'] if attributes[:'max_failures_before_warning']

      self.max_failures_before_lockout = attributes[:'maxFailuresBeforeLockout'] if attributes[:'maxFailuresBeforeLockout']

      raise 'You cannot provide both :maxFailuresBeforeLockout and :max_failures_before_lockout' if attributes.key?(:'maxFailuresBeforeLockout') && attributes.key?(:'max_failures_before_lockout')

      self.max_failures_before_lockout = attributes[:'max_failures_before_lockout'] if attributes[:'max_failures_before_lockout']

      self.initial_lockout_period_in_secs = attributes[:'initialLockoutPeriodInSecs'] if attributes[:'initialLockoutPeriodInSecs']

      raise 'You cannot provide both :initialLockoutPeriodInSecs and :initial_lockout_period_in_secs' if attributes.key?(:'initialLockoutPeriodInSecs') && attributes.key?(:'initial_lockout_period_in_secs')

      self.initial_lockout_period_in_secs = attributes[:'initial_lockout_period_in_secs'] if attributes[:'initial_lockout_period_in_secs']

      self.lockout_escalation_pattern = attributes[:'lockoutEscalationPattern'] if attributes[:'lockoutEscalationPattern']

      raise 'You cannot provide both :lockoutEscalationPattern and :lockout_escalation_pattern' if attributes.key?(:'lockoutEscalationPattern') && attributes.key?(:'lockout_escalation_pattern')

      self.lockout_escalation_pattern = attributes[:'lockout_escalation_pattern'] if attributes[:'lockout_escalation_pattern']

      self.max_lockout_interval_in_secs = attributes[:'maxLockoutIntervalInSecs'] if attributes[:'maxLockoutIntervalInSecs']

      raise 'You cannot provide both :maxLockoutIntervalInSecs and :max_lockout_interval_in_secs' if attributes.key?(:'maxLockoutIntervalInSecs') && attributes.key?(:'max_lockout_interval_in_secs')

      self.max_lockout_interval_in_secs = attributes[:'max_lockout_interval_in_secs'] if attributes[:'max_lockout_interval_in_secs']

      self.request_signing_algo = attributes[:'requestSigningAlgo'] if attributes[:'requestSigningAlgo']

      raise 'You cannot provide both :requestSigningAlgo and :request_signing_algo' if attributes.key?(:'requestSigningAlgo') && attributes.key?(:'request_signing_algo')

      self.request_signing_algo = attributes[:'request_signing_algo'] if attributes[:'request_signing_algo']

      self.policy_update_freq_in_days = attributes[:'policyUpdateFreqInDays'] if attributes[:'policyUpdateFreqInDays']

      raise 'You cannot provide both :policyUpdateFreqInDays and :policy_update_freq_in_days' if attributes.key?(:'policyUpdateFreqInDays') && attributes.key?(:'policy_update_freq_in_days')

      self.policy_update_freq_in_days = attributes[:'policy_update_freq_in_days'] if attributes[:'policy_update_freq_in_days']

      self.key_pair_length = attributes[:'keyPairLength'] if attributes[:'keyPairLength']

      raise 'You cannot provide both :keyPairLength and :key_pair_length' if attributes.key?(:'keyPairLength') && attributes.key?(:'key_pair_length')

      self.key_pair_length = attributes[:'key_pair_length'] if attributes[:'key_pair_length']

      self.device_protection_policy = attributes[:'deviceProtectionPolicy'] if attributes[:'deviceProtectionPolicy']

      raise 'You cannot provide both :deviceProtectionPolicy and :device_protection_policy' if attributes.key?(:'deviceProtectionPolicy') && attributes.key?(:'device_protection_policy')

      self.device_protection_policy = attributes[:'device_protection_policy'] if attributes[:'device_protection_policy']

      self.unlock_app_for_each_request_enabled = attributes[:'unlockAppForEachRequestEnabled'] unless attributes[:'unlockAppForEachRequestEnabled'].nil?

      raise 'You cannot provide both :unlockAppForEachRequestEnabled and :unlock_app_for_each_request_enabled' if attributes.key?(:'unlockAppForEachRequestEnabled') && attributes.key?(:'unlock_app_for_each_request_enabled')

      self.unlock_app_for_each_request_enabled = attributes[:'unlock_app_for_each_request_enabled'] unless attributes[:'unlock_app_for_each_request_enabled'].nil?

      self.unlock_on_app_start_enabled = attributes[:'unlockOnAppStartEnabled'] unless attributes[:'unlockOnAppStartEnabled'].nil?

      raise 'You cannot provide both :unlockOnAppStartEnabled and :unlock_on_app_start_enabled' if attributes.key?(:'unlockOnAppStartEnabled') && attributes.key?(:'unlock_on_app_start_enabled')

      self.unlock_on_app_start_enabled = attributes[:'unlock_on_app_start_enabled'] unless attributes[:'unlock_on_app_start_enabled'].nil?

      self.unlock_app_interval_in_secs = attributes[:'unlockAppIntervalInSecs'] if attributes[:'unlockAppIntervalInSecs']

      raise 'You cannot provide both :unlockAppIntervalInSecs and :unlock_app_interval_in_secs' if attributes.key?(:'unlockAppIntervalInSecs') && attributes.key?(:'unlock_app_interval_in_secs')

      self.unlock_app_interval_in_secs = attributes[:'unlock_app_interval_in_secs'] if attributes[:'unlock_app_interval_in_secs']

      self.shared_secret_encoding = attributes[:'sharedSecretEncoding'] if attributes[:'sharedSecretEncoding']

      raise 'You cannot provide both :sharedSecretEncoding and :shared_secret_encoding' if attributes.key?(:'sharedSecretEncoding') && attributes.key?(:'shared_secret_encoding')

      self.shared_secret_encoding = attributes[:'shared_secret_encoding'] if attributes[:'shared_secret_encoding']

      self.unlock_on_app_foreground_enabled = attributes[:'unlockOnAppForegroundEnabled'] unless attributes[:'unlockOnAppForegroundEnabled'].nil?

      raise 'You cannot provide both :unlockOnAppForegroundEnabled and :unlock_on_app_foreground_enabled' if attributes.key?(:'unlockOnAppForegroundEnabled') && attributes.key?(:'unlock_on_app_foreground_enabled')

      self.unlock_on_app_foreground_enabled = attributes[:'unlock_on_app_foreground_enabled'] unless attributes[:'unlock_on_app_foreground_enabled'].nil?
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] request_signing_algo Object to be assigned
    def request_signing_algo=(request_signing_algo)
      # rubocop:disable Style/ConditionalAssignment
      if request_signing_algo && !REQUEST_SIGNING_ALGO_ENUM.include?(request_signing_algo)
        OCI.logger.debug("Unknown value for 'request_signing_algo' [" + request_signing_algo + "]. Mapping to 'REQUEST_SIGNING_ALGO_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @request_signing_algo = REQUEST_SIGNING_ALGO_UNKNOWN_ENUM_VALUE
      else
        @request_signing_algo = request_signing_algo
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] shared_secret_encoding Object to be assigned
    def shared_secret_encoding=(shared_secret_encoding)
      # rubocop:disable Style/ConditionalAssignment
      if shared_secret_encoding && !SHARED_SECRET_ENCODING_ENUM.include?(shared_secret_encoding)
        OCI.logger.debug("Unknown value for 'shared_secret_encoding' [" + shared_secret_encoding + "]. Mapping to 'SHARED_SECRET_ENCODING_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @shared_secret_encoding = SHARED_SECRET_ENCODING_UNKNOWN_ENUM_VALUE
      else
        @shared_secret_encoding = shared_secret_encoding
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        min_pin_length == other.min_pin_length &&
        max_failures_before_warning == other.max_failures_before_warning &&
        max_failures_before_lockout == other.max_failures_before_lockout &&
        initial_lockout_period_in_secs == other.initial_lockout_period_in_secs &&
        lockout_escalation_pattern == other.lockout_escalation_pattern &&
        max_lockout_interval_in_secs == other.max_lockout_interval_in_secs &&
        request_signing_algo == other.request_signing_algo &&
        policy_update_freq_in_days == other.policy_update_freq_in_days &&
        key_pair_length == other.key_pair_length &&
        device_protection_policy == other.device_protection_policy &&
        unlock_app_for_each_request_enabled == other.unlock_app_for_each_request_enabled &&
        unlock_on_app_start_enabled == other.unlock_on_app_start_enabled &&
        unlock_app_interval_in_secs == other.unlock_app_interval_in_secs &&
        shared_secret_encoding == other.shared_secret_encoding &&
        unlock_on_app_foreground_enabled == other.unlock_on_app_foreground_enabled
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
      [min_pin_length, max_failures_before_warning, max_failures_before_lockout, initial_lockout_period_in_secs, lockout_escalation_pattern, max_lockout_interval_in_secs, request_signing_algo, policy_update_freq_in_days, key_pair_length, device_protection_policy, unlock_app_for_each_request_enabled, unlock_on_app_start_enabled, unlock_app_interval_in_secs, shared_secret_encoding, unlock_on_app_foreground_enabled].hash
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
