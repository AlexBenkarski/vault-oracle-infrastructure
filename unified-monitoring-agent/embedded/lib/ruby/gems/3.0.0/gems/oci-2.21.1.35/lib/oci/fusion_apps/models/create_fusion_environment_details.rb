# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20211201
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The configuration details of the FusionEnvironment. For more information about these fields, see [Managing Environments](https://docs.cloud.oracle.com/iaas/Content/fusion-applications/manage-environment.htm).
  class FusionApps::Models::CreateFusionEnvironmentDetails
    # **[Required]** FusionEnvironment Identifier can be renamed.
    # @return [String]
    attr_accessor :display_name

    # @return [OCI::FusionApps::Models::MaintenancePolicy]
    attr_accessor :maintenance_policy

    # **[Required]** The unique identifier (OCID) of the compartment where the Fusion Environment is located.
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** The unique identifier (OCID) of the Fusion Environment Family that the Fusion Environment belongs to.
    # @return [String]
    attr_accessor :fusion_environment_family_id

    # **[Required]** The type of environment. Valid values are Production, Test, or Development.
    # @return [String]
    attr_accessor :fusion_environment_type

    # byok kms keyId
    # @return [String]
    attr_accessor :kms_key_id

    # DNS prefix.
    # @return [String]
    attr_accessor :dns_prefix

    # Language packs.
    # @return [Array<String>]
    attr_accessor :additional_language_packs

    # Rules.
    # @return [Array<OCI::FusionApps::Models::Rule>]
    attr_accessor :rules

    # This attribute is required.
    # @return [OCI::FusionApps::Models::CreateFusionEnvironmentAdminUserDetails]
    attr_accessor :create_fusion_environment_admin_user_details

    # Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only.
    # Example: `{\"bar-key\": \"value\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # Example: `{\"foo-namespace\": {\"bar-key\": \"value\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'displayName',
        'maintenance_policy': :'maintenancePolicy',
        'compartment_id': :'compartmentId',
        'fusion_environment_family_id': :'fusionEnvironmentFamilyId',
        'fusion_environment_type': :'fusionEnvironmentType',
        'kms_key_id': :'kmsKeyId',
        'dns_prefix': :'dnsPrefix',
        'additional_language_packs': :'additionalLanguagePacks',
        'rules': :'rules',
        'create_fusion_environment_admin_user_details': :'createFusionEnvironmentAdminUserDetails',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'String',
        'maintenance_policy': :'OCI::FusionApps::Models::MaintenancePolicy',
        'compartment_id': :'String',
        'fusion_environment_family_id': :'String',
        'fusion_environment_type': :'String',
        'kms_key_id': :'String',
        'dns_prefix': :'String',
        'additional_language_packs': :'Array<String>',
        'rules': :'Array<OCI::FusionApps::Models::Rule>',
        'create_fusion_environment_admin_user_details': :'OCI::FusionApps::Models::CreateFusionEnvironmentAdminUserDetails',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [OCI::FusionApps::Models::MaintenancePolicy] :maintenance_policy The value to assign to the {#maintenance_policy} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :fusion_environment_family_id The value to assign to the {#fusion_environment_family_id} property
    # @option attributes [String] :fusion_environment_type The value to assign to the {#fusion_environment_type} property
    # @option attributes [String] :kms_key_id The value to assign to the {#kms_key_id} property
    # @option attributes [String] :dns_prefix The value to assign to the {#dns_prefix} property
    # @option attributes [Array<String>] :additional_language_packs The value to assign to the {#additional_language_packs} property
    # @option attributes [Array<OCI::FusionApps::Models::Rule>] :rules The value to assign to the {#rules} property
    # @option attributes [OCI::FusionApps::Models::CreateFusionEnvironmentAdminUserDetails] :create_fusion_environment_admin_user_details The value to assign to the {#create_fusion_environment_admin_user_details} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.maintenance_policy = attributes[:'maintenancePolicy'] if attributes[:'maintenancePolicy']

      raise 'You cannot provide both :maintenancePolicy and :maintenance_policy' if attributes.key?(:'maintenancePolicy') && attributes.key?(:'maintenance_policy')

      self.maintenance_policy = attributes[:'maintenance_policy'] if attributes[:'maintenance_policy']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.fusion_environment_family_id = attributes[:'fusionEnvironmentFamilyId'] if attributes[:'fusionEnvironmentFamilyId']

      raise 'You cannot provide both :fusionEnvironmentFamilyId and :fusion_environment_family_id' if attributes.key?(:'fusionEnvironmentFamilyId') && attributes.key?(:'fusion_environment_family_id')

      self.fusion_environment_family_id = attributes[:'fusion_environment_family_id'] if attributes[:'fusion_environment_family_id']

      self.fusion_environment_type = attributes[:'fusionEnvironmentType'] if attributes[:'fusionEnvironmentType']

      raise 'You cannot provide both :fusionEnvironmentType and :fusion_environment_type' if attributes.key?(:'fusionEnvironmentType') && attributes.key?(:'fusion_environment_type')

      self.fusion_environment_type = attributes[:'fusion_environment_type'] if attributes[:'fusion_environment_type']

      self.kms_key_id = attributes[:'kmsKeyId'] if attributes[:'kmsKeyId']

      raise 'You cannot provide both :kmsKeyId and :kms_key_id' if attributes.key?(:'kmsKeyId') && attributes.key?(:'kms_key_id')

      self.kms_key_id = attributes[:'kms_key_id'] if attributes[:'kms_key_id']

      self.dns_prefix = attributes[:'dnsPrefix'] if attributes[:'dnsPrefix']

      raise 'You cannot provide both :dnsPrefix and :dns_prefix' if attributes.key?(:'dnsPrefix') && attributes.key?(:'dns_prefix')

      self.dns_prefix = attributes[:'dns_prefix'] if attributes[:'dns_prefix']

      self.additional_language_packs = attributes[:'additionalLanguagePacks'] if attributes[:'additionalLanguagePacks']

      raise 'You cannot provide both :additionalLanguagePacks and :additional_language_packs' if attributes.key?(:'additionalLanguagePacks') && attributes.key?(:'additional_language_packs')

      self.additional_language_packs = attributes[:'additional_language_packs'] if attributes[:'additional_language_packs']

      self.rules = attributes[:'rules'] if attributes[:'rules']

      self.create_fusion_environment_admin_user_details = attributes[:'createFusionEnvironmentAdminUserDetails'] if attributes[:'createFusionEnvironmentAdminUserDetails']

      raise 'You cannot provide both :createFusionEnvironmentAdminUserDetails and :create_fusion_environment_admin_user_details' if attributes.key?(:'createFusionEnvironmentAdminUserDetails') && attributes.key?(:'create_fusion_environment_admin_user_details')

      self.create_fusion_environment_admin_user_details = attributes[:'create_fusion_environment_admin_user_details'] if attributes[:'create_fusion_environment_admin_user_details']

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
        display_name == other.display_name &&
        maintenance_policy == other.maintenance_policy &&
        compartment_id == other.compartment_id &&
        fusion_environment_family_id == other.fusion_environment_family_id &&
        fusion_environment_type == other.fusion_environment_type &&
        kms_key_id == other.kms_key_id &&
        dns_prefix == other.dns_prefix &&
        additional_language_packs == other.additional_language_packs &&
        rules == other.rules &&
        create_fusion_environment_admin_user_details == other.create_fusion_environment_admin_user_details &&
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
      [display_name, maintenance_policy, compartment_id, fusion_environment_family_id, fusion_environment_type, kms_key_id, dns_prefix, additional_language_packs, rules, create_fusion_environment_admin_user_details, freeform_tags, defined_tags].hash
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
