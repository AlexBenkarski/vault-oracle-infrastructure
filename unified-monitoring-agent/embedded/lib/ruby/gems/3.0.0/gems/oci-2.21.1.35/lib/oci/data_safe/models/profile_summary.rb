# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20181201
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The summary of information about the user profiles. It includes details such as profile name, failed login attempts,
  # sessions per user, inactive account time, password lock time, user created, target id, and the compartment id.
  #
  class DataSafe::Models::ProfileSummary
    # **[Required]** The OCID of the latest user assessment corresponding to the target under consideration. A compartment
    # type assessment can also be passed to profiles from all the targets from the corresponding compartment.
    #
    # @return [String]
    attr_accessor :user_assessment_id

    # **[Required]** The OCID of the compartment that contains the user assessment.
    # @return [String]
    attr_accessor :compartment_id

    # The OCID of the target database.
    # @return [String]
    attr_accessor :target_id

    # The name of the profile.
    # @return [String]
    attr_accessor :profile_name

    # The number of users having a given profile.
    # @return [Integer]
    attr_accessor :user_count

    # Maximum times the user is allowed to fail login before the user account is locked.
    # @return [String]
    attr_accessor :failed_login_attempts

    # PL/SQL that can be used for password verification.
    # @return [String]
    attr_accessor :password_verification_function

    # The maximum number of sessions a user is allowed to create.
    # @return [String]
    attr_accessor :sessions_per_user

    # The permitted periods of continuous inactive time during a session, expressed in minutes.
    # Long-running queries and other operations are not subjected to this limit.
    #
    # @return [String]
    attr_accessor :inactive_account_time

    # Number of days the user account remains locked after failed login
    # @return [String]
    attr_accessor :password_lock_time

    # Represents if the profile is created by user.
    # @return [BOOLEAN]
    attr_accessor :is_user_created

    # Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm)
    #
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm)
    #
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'user_assessment_id': :'userAssessmentId',
        'compartment_id': :'compartmentId',
        'target_id': :'targetId',
        'profile_name': :'profileName',
        'user_count': :'userCount',
        'failed_login_attempts': :'failedLoginAttempts',
        'password_verification_function': :'passwordVerificationFunction',
        'sessions_per_user': :'sessionsPerUser',
        'inactive_account_time': :'inactiveAccountTime',
        'password_lock_time': :'passwordLockTime',
        'is_user_created': :'isUserCreated',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'user_assessment_id': :'String',
        'compartment_id': :'String',
        'target_id': :'String',
        'profile_name': :'String',
        'user_count': :'Integer',
        'failed_login_attempts': :'String',
        'password_verification_function': :'String',
        'sessions_per_user': :'String',
        'inactive_account_time': :'String',
        'password_lock_time': :'String',
        'is_user_created': :'BOOLEAN',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :user_assessment_id The value to assign to the {#user_assessment_id} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :target_id The value to assign to the {#target_id} property
    # @option attributes [String] :profile_name The value to assign to the {#profile_name} property
    # @option attributes [Integer] :user_count The value to assign to the {#user_count} property
    # @option attributes [String] :failed_login_attempts The value to assign to the {#failed_login_attempts} property
    # @option attributes [String] :password_verification_function The value to assign to the {#password_verification_function} property
    # @option attributes [String] :sessions_per_user The value to assign to the {#sessions_per_user} property
    # @option attributes [String] :inactive_account_time The value to assign to the {#inactive_account_time} property
    # @option attributes [String] :password_lock_time The value to assign to the {#password_lock_time} property
    # @option attributes [BOOLEAN] :is_user_created The value to assign to the {#is_user_created} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.user_assessment_id = attributes[:'userAssessmentId'] if attributes[:'userAssessmentId']

      raise 'You cannot provide both :userAssessmentId and :user_assessment_id' if attributes.key?(:'userAssessmentId') && attributes.key?(:'user_assessment_id')

      self.user_assessment_id = attributes[:'user_assessment_id'] if attributes[:'user_assessment_id']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.target_id = attributes[:'targetId'] if attributes[:'targetId']

      raise 'You cannot provide both :targetId and :target_id' if attributes.key?(:'targetId') && attributes.key?(:'target_id')

      self.target_id = attributes[:'target_id'] if attributes[:'target_id']

      self.profile_name = attributes[:'profileName'] if attributes[:'profileName']

      raise 'You cannot provide both :profileName and :profile_name' if attributes.key?(:'profileName') && attributes.key?(:'profile_name')

      self.profile_name = attributes[:'profile_name'] if attributes[:'profile_name']

      self.user_count = attributes[:'userCount'] if attributes[:'userCount']

      raise 'You cannot provide both :userCount and :user_count' if attributes.key?(:'userCount') && attributes.key?(:'user_count')

      self.user_count = attributes[:'user_count'] if attributes[:'user_count']

      self.failed_login_attempts = attributes[:'failedLoginAttempts'] if attributes[:'failedLoginAttempts']

      raise 'You cannot provide both :failedLoginAttempts and :failed_login_attempts' if attributes.key?(:'failedLoginAttempts') && attributes.key?(:'failed_login_attempts')

      self.failed_login_attempts = attributes[:'failed_login_attempts'] if attributes[:'failed_login_attempts']

      self.password_verification_function = attributes[:'passwordVerificationFunction'] if attributes[:'passwordVerificationFunction']

      raise 'You cannot provide both :passwordVerificationFunction and :password_verification_function' if attributes.key?(:'passwordVerificationFunction') && attributes.key?(:'password_verification_function')

      self.password_verification_function = attributes[:'password_verification_function'] if attributes[:'password_verification_function']

      self.sessions_per_user = attributes[:'sessionsPerUser'] if attributes[:'sessionsPerUser']

      raise 'You cannot provide both :sessionsPerUser and :sessions_per_user' if attributes.key?(:'sessionsPerUser') && attributes.key?(:'sessions_per_user')

      self.sessions_per_user = attributes[:'sessions_per_user'] if attributes[:'sessions_per_user']

      self.inactive_account_time = attributes[:'inactiveAccountTime'] if attributes[:'inactiveAccountTime']

      raise 'You cannot provide both :inactiveAccountTime and :inactive_account_time' if attributes.key?(:'inactiveAccountTime') && attributes.key?(:'inactive_account_time')

      self.inactive_account_time = attributes[:'inactive_account_time'] if attributes[:'inactive_account_time']

      self.password_lock_time = attributes[:'passwordLockTime'] if attributes[:'passwordLockTime']

      raise 'You cannot provide both :passwordLockTime and :password_lock_time' if attributes.key?(:'passwordLockTime') && attributes.key?(:'password_lock_time')

      self.password_lock_time = attributes[:'password_lock_time'] if attributes[:'password_lock_time']

      self.is_user_created = attributes[:'isUserCreated'] unless attributes[:'isUserCreated'].nil?

      raise 'You cannot provide both :isUserCreated and :is_user_created' if attributes.key?(:'isUserCreated') && attributes.key?(:'is_user_created')

      self.is_user_created = attributes[:'is_user_created'] unless attributes[:'is_user_created'].nil?

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        user_assessment_id == other.user_assessment_id &&
        compartment_id == other.compartment_id &&
        target_id == other.target_id &&
        profile_name == other.profile_name &&
        user_count == other.user_count &&
        failed_login_attempts == other.failed_login_attempts &&
        password_verification_function == other.password_verification_function &&
        sessions_per_user == other.sessions_per_user &&
        inactive_account_time == other.inactive_account_time &&
        password_lock_time == other.password_lock_time &&
        is_user_created == other.is_user_created &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags
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
      [user_assessment_id, compartment_id, target_id, profile_name, user_count, failed_login_attempts, password_verification_function, sessions_per_user, inactive_account_time, password_lock_time, is_user_created, freeform_tags, defined_tags].hash
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
