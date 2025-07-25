# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: v1
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # This extension provides attributes for Form-Fill facet of App
  class IdentityDomains::Models::AppExtensionFormFillAppApp
    FORM_TYPE_ENUM = [
      FORM_TYPE_WEB_APPLICATION = 'WebApplication'.freeze,
      FORM_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    FORM_CRED_METHOD_ENUM = [
      FORM_CRED_METHOD_ADMIN_SETS_CREDENTIALS = 'ADMIN_SETS_CREDENTIALS'.freeze,
      FORM_CRED_METHOD_ADMIN_SETS_SHARED_CREDENTIALS = 'ADMIN_SETS_SHARED_CREDENTIALS'.freeze,
      FORM_CRED_METHOD_USER_SETS_PASSWORD_ONLY = 'USER_SETS_PASSWORD_ONLY'.freeze,
      FORM_CRED_METHOD_USER_SETS_CREDENTIALS = 'USER_SETS_CREDENTIALS'.freeze,
      FORM_CRED_METHOD_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # Type of the FormFill application like WebApplication, MainFrameApplication, WindowsApplication. Initially, we will support only WebApplication.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :form_type

    # Credential Sharing Group to which this form-fill application belongs.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :form_credential_sharing_group_id

    # If true, indicates that system is allowed to show the password in plain-text for this account after re-authentication.
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: boolean
    #  - uniqueness: none
    # @return [BOOLEAN]
    attr_accessor :reveal_password_on_form

    # Format for generating a username.  This value can be Username or Email Address; any other value will be treated as a custom expression.  A custom expression may combine 'concat' and 'substring' operations with literals and with any attribute of the Oracle Identity Cloud Service user.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsPii: true
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :user_name_form_template

    # Indicates the custom expression, which can combine concat and substring operations with literals and with any attribute of the Oracle Identity Cloud Service User
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :user_name_form_expression

    # Indicates how FormFill obtains the username and password of the account that FormFill will use to sign into the target App.
    #
    # **SCIM++ Properties:**
    #  - caseExact: false
    #  - idcsSearchable: true
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_reader :form_cred_method

    # FormFill Application Configuration CLOB which has to be maintained in Form-Fill APP for legacy code to do Form-Fill injection
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: string
    #  - uniqueness: none
    # @return [String]
    attr_accessor :configuration

    # If true, indicates that each of the Form-Fill-related attributes that can be inherited from the template actually will be inherited from the template. If false, indicates that the AppTemplate on which this App is based has disabled inheritance for these Form-Fill-related attributes.
    #
    # **Added In:** 17.4.2
    #
    # **SCIM++ Properties:**
    #  - idcsSearchable: false
    #  - multiValued: false
    #  - mutability: readOnly
    #  - required: false
    #  - returned: default
    #  - type: boolean
    #  - uniqueness: none
    # @return [BOOLEAN]
    attr_accessor :sync_from_template

    # A list of application-formURLs that FormFill should match against any formUrl that the user-specifies when signing in to the target service.  Each item in the list also indicates how FormFill should interpret that formUrl.
    #
    # **SCIM++ Properties:**
    #  - idcsCompositeKey: [formUrl]
    #  - multiValued: true
    #  - mutability: readWrite
    #  - required: false
    #  - returned: default
    #  - type: complex
    #  - uniqueness: none
    # @return [Array<OCI::IdentityDomains::Models::AppFormFillUrlMatch>]
    attr_accessor :form_fill_url_match

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'form_type': :'formType',
        'form_credential_sharing_group_id': :'formCredentialSharingGroupID',
        'reveal_password_on_form': :'revealPasswordOnForm',
        'user_name_form_template': :'userNameFormTemplate',
        'user_name_form_expression': :'userNameFormExpression',
        'form_cred_method': :'formCredMethod',
        'configuration': :'configuration',
        'sync_from_template': :'syncFromTemplate',
        'form_fill_url_match': :'formFillUrlMatch'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'form_type': :'String',
        'form_credential_sharing_group_id': :'String',
        'reveal_password_on_form': :'BOOLEAN',
        'user_name_form_template': :'String',
        'user_name_form_expression': :'String',
        'form_cred_method': :'String',
        'configuration': :'String',
        'sync_from_template': :'BOOLEAN',
        'form_fill_url_match': :'Array<OCI::IdentityDomains::Models::AppFormFillUrlMatch>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :form_type The value to assign to the {#form_type} property
    # @option attributes [String] :form_credential_sharing_group_id The value to assign to the {#form_credential_sharing_group_id} property
    # @option attributes [BOOLEAN] :reveal_password_on_form The value to assign to the {#reveal_password_on_form} property
    # @option attributes [String] :user_name_form_template The value to assign to the {#user_name_form_template} property
    # @option attributes [String] :user_name_form_expression The value to assign to the {#user_name_form_expression} property
    # @option attributes [String] :form_cred_method The value to assign to the {#form_cred_method} property
    # @option attributes [String] :configuration The value to assign to the {#configuration} property
    # @option attributes [BOOLEAN] :sync_from_template The value to assign to the {#sync_from_template} property
    # @option attributes [Array<OCI::IdentityDomains::Models::AppFormFillUrlMatch>] :form_fill_url_match The value to assign to the {#form_fill_url_match} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.form_type = attributes[:'formType'] if attributes[:'formType']

      raise 'You cannot provide both :formType and :form_type' if attributes.key?(:'formType') && attributes.key?(:'form_type')

      self.form_type = attributes[:'form_type'] if attributes[:'form_type']

      self.form_credential_sharing_group_id = attributes[:'formCredentialSharingGroupID'] if attributes[:'formCredentialSharingGroupID']

      raise 'You cannot provide both :formCredentialSharingGroupID and :form_credential_sharing_group_id' if attributes.key?(:'formCredentialSharingGroupID') && attributes.key?(:'form_credential_sharing_group_id')

      self.form_credential_sharing_group_id = attributes[:'form_credential_sharing_group_id'] if attributes[:'form_credential_sharing_group_id']

      self.reveal_password_on_form = attributes[:'revealPasswordOnForm'] unless attributes[:'revealPasswordOnForm'].nil?

      raise 'You cannot provide both :revealPasswordOnForm and :reveal_password_on_form' if attributes.key?(:'revealPasswordOnForm') && attributes.key?(:'reveal_password_on_form')

      self.reveal_password_on_form = attributes[:'reveal_password_on_form'] unless attributes[:'reveal_password_on_form'].nil?

      self.user_name_form_template = attributes[:'userNameFormTemplate'] if attributes[:'userNameFormTemplate']

      raise 'You cannot provide both :userNameFormTemplate and :user_name_form_template' if attributes.key?(:'userNameFormTemplate') && attributes.key?(:'user_name_form_template')

      self.user_name_form_template = attributes[:'user_name_form_template'] if attributes[:'user_name_form_template']

      self.user_name_form_expression = attributes[:'userNameFormExpression'] if attributes[:'userNameFormExpression']

      raise 'You cannot provide both :userNameFormExpression and :user_name_form_expression' if attributes.key?(:'userNameFormExpression') && attributes.key?(:'user_name_form_expression')

      self.user_name_form_expression = attributes[:'user_name_form_expression'] if attributes[:'user_name_form_expression']

      self.form_cred_method = attributes[:'formCredMethod'] if attributes[:'formCredMethod']

      raise 'You cannot provide both :formCredMethod and :form_cred_method' if attributes.key?(:'formCredMethod') && attributes.key?(:'form_cred_method')

      self.form_cred_method = attributes[:'form_cred_method'] if attributes[:'form_cred_method']

      self.configuration = attributes[:'configuration'] if attributes[:'configuration']

      self.sync_from_template = attributes[:'syncFromTemplate'] unless attributes[:'syncFromTemplate'].nil?

      raise 'You cannot provide both :syncFromTemplate and :sync_from_template' if attributes.key?(:'syncFromTemplate') && attributes.key?(:'sync_from_template')

      self.sync_from_template = attributes[:'sync_from_template'] unless attributes[:'sync_from_template'].nil?

      self.form_fill_url_match = attributes[:'formFillUrlMatch'] if attributes[:'formFillUrlMatch']

      raise 'You cannot provide both :formFillUrlMatch and :form_fill_url_match' if attributes.key?(:'formFillUrlMatch') && attributes.key?(:'form_fill_url_match')

      self.form_fill_url_match = attributes[:'form_fill_url_match'] if attributes[:'form_fill_url_match']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] form_type Object to be assigned
    def form_type=(form_type)
      # rubocop:disable Style/ConditionalAssignment
      if form_type && !FORM_TYPE_ENUM.include?(form_type)
        OCI.logger.debug("Unknown value for 'form_type' [" + form_type + "]. Mapping to 'FORM_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @form_type = FORM_TYPE_UNKNOWN_ENUM_VALUE
      else
        @form_type = form_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] form_cred_method Object to be assigned
    def form_cred_method=(form_cred_method)
      # rubocop:disable Style/ConditionalAssignment
      if form_cred_method && !FORM_CRED_METHOD_ENUM.include?(form_cred_method)
        OCI.logger.debug("Unknown value for 'form_cred_method' [" + form_cred_method + "]. Mapping to 'FORM_CRED_METHOD_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @form_cred_method = FORM_CRED_METHOD_UNKNOWN_ENUM_VALUE
      else
        @form_cred_method = form_cred_method
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        form_type == other.form_type &&
        form_credential_sharing_group_id == other.form_credential_sharing_group_id &&
        reveal_password_on_form == other.reveal_password_on_form &&
        user_name_form_template == other.user_name_form_template &&
        user_name_form_expression == other.user_name_form_expression &&
        form_cred_method == other.form_cred_method &&
        configuration == other.configuration &&
        sync_from_template == other.sync_from_template &&
        form_fill_url_match == other.form_fill_url_match
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
      [form_type, form_credential_sharing_group_id, reveal_password_on_form, user_name_form_template, user_name_form_expression, form_cred_method, configuration, sync_from_template, form_fill_url_match].hash
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
