# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20211201
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Summary of the internal FA Environment.
  class FusionApps::Models::FusionEnvironmentSummary
    # **[Required]** Unique identifier that is immutable on creation
    # @return [String]
    attr_accessor :id

    # **[Required]** FusionEnvironment Identifier, can be renamed
    # @return [String]
    attr_accessor :display_name

    # The next maintenance for this environment
    # @return [DateTime]
    attr_accessor :time_upcoming_maintenance

    # @return [OCI::FusionApps::Models::GetMaintenancePolicyDetails]
    attr_accessor :maintenance_policy

    # **[Required]** Compartment Identifier
    # @return [String]
    attr_accessor :compartment_id

    # FusionEnvironmentFamily Identifier
    # @return [String]
    attr_accessor :fusion_environment_family_id

    # List of subscription IDs.
    # @return [Array<String>]
    attr_accessor :subscription_ids

    # Patch bundle names
    # @return [Array<String>]
    attr_accessor :applied_patch_bundles

    # **[Required]** Type of the FusionEnvironment.
    # @return [String]
    attr_accessor :fusion_environment_type

    # Version of Fusion Apps used by this environment
    # @return [String]
    attr_accessor :version

    # Public URL
    # @return [String]
    attr_accessor :public_url

    # DNS prefix
    # @return [String]
    attr_accessor :dns_prefix

    # Language packs
    # @return [Array<String>]
    attr_accessor :additional_language_packs

    # The lockbox Id of this fusion environment. If there's no lockbox id, this field will be null
    # @return [String]
    attr_accessor :lockbox_id

    # If it's true, then the Break Glass feature is enabled
    # @return [BOOLEAN]
    attr_accessor :is_break_glass_enabled

    # The time the the FusionEnvironment was created. An RFC3339 formatted datetime string
    # @return [DateTime]
    attr_accessor :time_created

    # The time the FusionEnvironment was updated. An RFC3339 formatted datetime string
    # @return [DateTime]
    attr_accessor :time_updated

    # **[Required]** The current state of the FusionEnvironment.
    # @return [String]
    attr_accessor :lifecycle_state

    # A message describing the current state in more detail. For example, can be used to provide actionable information for a resource in Failed state.
    # @return [String]
    attr_accessor :lifecycle_details

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
        'id': :'id',
        'display_name': :'displayName',
        'time_upcoming_maintenance': :'timeUpcomingMaintenance',
        'maintenance_policy': :'maintenancePolicy',
        'compartment_id': :'compartmentId',
        'fusion_environment_family_id': :'fusionEnvironmentFamilyId',
        'subscription_ids': :'subscriptionIds',
        'applied_patch_bundles': :'appliedPatchBundles',
        'fusion_environment_type': :'fusionEnvironmentType',
        'version': :'version',
        'public_url': :'publicUrl',
        'dns_prefix': :'dnsPrefix',
        'additional_language_packs': :'additionalLanguagePacks',
        'lockbox_id': :'lockboxId',
        'is_break_glass_enabled': :'isBreakGlassEnabled',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'lifecycle_state': :'lifecycleState',
        'lifecycle_details': :'lifecycleDetails',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'display_name': :'String',
        'time_upcoming_maintenance': :'DateTime',
        'maintenance_policy': :'OCI::FusionApps::Models::GetMaintenancePolicyDetails',
        'compartment_id': :'String',
        'fusion_environment_family_id': :'String',
        'subscription_ids': :'Array<String>',
        'applied_patch_bundles': :'Array<String>',
        'fusion_environment_type': :'String',
        'version': :'String',
        'public_url': :'String',
        'dns_prefix': :'String',
        'additional_language_packs': :'Array<String>',
        'lockbox_id': :'String',
        'is_break_glass_enabled': :'BOOLEAN',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'lifecycle_state': :'String',
        'lifecycle_details': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [DateTime] :time_upcoming_maintenance The value to assign to the {#time_upcoming_maintenance} property
    # @option attributes [OCI::FusionApps::Models::GetMaintenancePolicyDetails] :maintenance_policy The value to assign to the {#maintenance_policy} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :fusion_environment_family_id The value to assign to the {#fusion_environment_family_id} property
    # @option attributes [Array<String>] :subscription_ids The value to assign to the {#subscription_ids} property
    # @option attributes [Array<String>] :applied_patch_bundles The value to assign to the {#applied_patch_bundles} property
    # @option attributes [String] :fusion_environment_type The value to assign to the {#fusion_environment_type} property
    # @option attributes [String] :version The value to assign to the {#version} property
    # @option attributes [String] :public_url The value to assign to the {#public_url} property
    # @option attributes [String] :dns_prefix The value to assign to the {#dns_prefix} property
    # @option attributes [Array<String>] :additional_language_packs The value to assign to the {#additional_language_packs} property
    # @option attributes [String] :lockbox_id The value to assign to the {#lockbox_id} property
    # @option attributes [BOOLEAN] :is_break_glass_enabled The value to assign to the {#is_break_glass_enabled} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :lifecycle_details The value to assign to the {#lifecycle_details} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.time_upcoming_maintenance = attributes[:'timeUpcomingMaintenance'] if attributes[:'timeUpcomingMaintenance']

      raise 'You cannot provide both :timeUpcomingMaintenance and :time_upcoming_maintenance' if attributes.key?(:'timeUpcomingMaintenance') && attributes.key?(:'time_upcoming_maintenance')

      self.time_upcoming_maintenance = attributes[:'time_upcoming_maintenance'] if attributes[:'time_upcoming_maintenance']

      self.maintenance_policy = attributes[:'maintenancePolicy'] if attributes[:'maintenancePolicy']

      raise 'You cannot provide both :maintenancePolicy and :maintenance_policy' if attributes.key?(:'maintenancePolicy') && attributes.key?(:'maintenance_policy')

      self.maintenance_policy = attributes[:'maintenance_policy'] if attributes[:'maintenance_policy']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.fusion_environment_family_id = attributes[:'fusionEnvironmentFamilyId'] if attributes[:'fusionEnvironmentFamilyId']

      raise 'You cannot provide both :fusionEnvironmentFamilyId and :fusion_environment_family_id' if attributes.key?(:'fusionEnvironmentFamilyId') && attributes.key?(:'fusion_environment_family_id')

      self.fusion_environment_family_id = attributes[:'fusion_environment_family_id'] if attributes[:'fusion_environment_family_id']

      self.subscription_ids = attributes[:'subscriptionIds'] if attributes[:'subscriptionIds']

      raise 'You cannot provide both :subscriptionIds and :subscription_ids' if attributes.key?(:'subscriptionIds') && attributes.key?(:'subscription_ids')

      self.subscription_ids = attributes[:'subscription_ids'] if attributes[:'subscription_ids']

      self.applied_patch_bundles = attributes[:'appliedPatchBundles'] if attributes[:'appliedPatchBundles']

      raise 'You cannot provide both :appliedPatchBundles and :applied_patch_bundles' if attributes.key?(:'appliedPatchBundles') && attributes.key?(:'applied_patch_bundles')

      self.applied_patch_bundles = attributes[:'applied_patch_bundles'] if attributes[:'applied_patch_bundles']

      self.fusion_environment_type = attributes[:'fusionEnvironmentType'] if attributes[:'fusionEnvironmentType']

      raise 'You cannot provide both :fusionEnvironmentType and :fusion_environment_type' if attributes.key?(:'fusionEnvironmentType') && attributes.key?(:'fusion_environment_type')

      self.fusion_environment_type = attributes[:'fusion_environment_type'] if attributes[:'fusion_environment_type']

      self.version = attributes[:'version'] if attributes[:'version']

      self.public_url = attributes[:'publicUrl'] if attributes[:'publicUrl']

      raise 'You cannot provide both :publicUrl and :public_url' if attributes.key?(:'publicUrl') && attributes.key?(:'public_url')

      self.public_url = attributes[:'public_url'] if attributes[:'public_url']

      self.dns_prefix = attributes[:'dnsPrefix'] if attributes[:'dnsPrefix']

      raise 'You cannot provide both :dnsPrefix and :dns_prefix' if attributes.key?(:'dnsPrefix') && attributes.key?(:'dns_prefix')

      self.dns_prefix = attributes[:'dns_prefix'] if attributes[:'dns_prefix']

      self.additional_language_packs = attributes[:'additionalLanguagePacks'] if attributes[:'additionalLanguagePacks']

      raise 'You cannot provide both :additionalLanguagePacks and :additional_language_packs' if attributes.key?(:'additionalLanguagePacks') && attributes.key?(:'additional_language_packs')

      self.additional_language_packs = attributes[:'additional_language_packs'] if attributes[:'additional_language_packs']

      self.lockbox_id = attributes[:'lockboxId'] if attributes[:'lockboxId']

      raise 'You cannot provide both :lockboxId and :lockbox_id' if attributes.key?(:'lockboxId') && attributes.key?(:'lockbox_id')

      self.lockbox_id = attributes[:'lockbox_id'] if attributes[:'lockbox_id']

      self.is_break_glass_enabled = attributes[:'isBreakGlassEnabled'] unless attributes[:'isBreakGlassEnabled'].nil?
      self.is_break_glass_enabled = false if is_break_glass_enabled.nil? && !attributes.key?(:'isBreakGlassEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isBreakGlassEnabled and :is_break_glass_enabled' if attributes.key?(:'isBreakGlassEnabled') && attributes.key?(:'is_break_glass_enabled')

      self.is_break_glass_enabled = attributes[:'is_break_glass_enabled'] unless attributes[:'is_break_glass_enabled'].nil?
      self.is_break_glass_enabled = false if is_break_glass_enabled.nil? && !attributes.key?(:'isBreakGlassEnabled') && !attributes.key?(:'is_break_glass_enabled') # rubocop:disable Style/StringLiterals

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.lifecycle_details = attributes[:'lifecycleDetails'] if attributes[:'lifecycleDetails']

      raise 'You cannot provide both :lifecycleDetails and :lifecycle_details' if attributes.key?(:'lifecycleDetails') && attributes.key?(:'lifecycle_details')

      self.lifecycle_details = attributes[:'lifecycle_details'] if attributes[:'lifecycle_details']

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
        id == other.id &&
        display_name == other.display_name &&
        time_upcoming_maintenance == other.time_upcoming_maintenance &&
        maintenance_policy == other.maintenance_policy &&
        compartment_id == other.compartment_id &&
        fusion_environment_family_id == other.fusion_environment_family_id &&
        subscription_ids == other.subscription_ids &&
        applied_patch_bundles == other.applied_patch_bundles &&
        fusion_environment_type == other.fusion_environment_type &&
        version == other.version &&
        public_url == other.public_url &&
        dns_prefix == other.dns_prefix &&
        additional_language_packs == other.additional_language_packs &&
        lockbox_id == other.lockbox_id &&
        is_break_glass_enabled == other.is_break_glass_enabled &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        lifecycle_state == other.lifecycle_state &&
        lifecycle_details == other.lifecycle_details &&
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
      [id, display_name, time_upcoming_maintenance, maintenance_policy, compartment_id, fusion_environment_family_id, subscription_ids, applied_patch_bundles, fusion_environment_type, version, public_url, dns_prefix, additional_language_packs, lockbox_id, is_break_glass_enabled, time_created, time_updated, lifecycle_state, lifecycle_details, freeform_tags, defined_tags].hash
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
