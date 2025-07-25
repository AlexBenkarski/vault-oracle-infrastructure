# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230831
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The information about new Fleet.
  class FleetAppsManagement::Models::CreateFleetDetails
    # A user-friendly name. Does not have to be unique, and it's changeable.
    # Avoid entering confidential information.
    #
    # Example: `My new resource`
    #
    # @return [String]
    attr_accessor :display_name

    # A user-friendly description. To provide some insight about the resource.
    # Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :description

    # **[Required]** Tenancy OCID
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** Type of the Fleet
    # @return [String]
    attr_accessor :fleet_type

    # Products associated with the Fleet
    # @return [Array<String>]
    attr_accessor :products

    # Application Type associated with the Fleet.Applicable for Environment fleet types.
    # @return [String]
    attr_accessor :application_type

    # Environment Type associated with the Fleet.Applicable for Environment fleet types.
    # @return [String]
    attr_accessor :environment_type

    # Group Type associated with Group Fleet.Applicable for Group fleet types.
    # @return [String]
    attr_accessor :group_type

    # Type of resource selection in a fleet
    # @return [String]
    attr_accessor :resource_selection_type

    # @return [OCI::FleetAppsManagement::Models::SelectionCriteria]
    attr_accessor :rule_selection_criteria

    # @return [OCI::FleetAppsManagement::Models::NotificationPreferences]
    attr_accessor :notification_preferences

    # Resources to be added during fleet creation when Resource selection type is Manual.
    # @return [Array<OCI::FleetAppsManagement::Models::AssociatedFleetResourceDetails>]
    attr_accessor :resources

    # A value which represents if auto confirming of the targets can be enabled
    # @return [BOOLEAN]
    attr_accessor :is_target_auto_confirm

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
        'description': :'description',
        'compartment_id': :'compartmentId',
        'fleet_type': :'fleetType',
        'products': :'products',
        'application_type': :'applicationType',
        'environment_type': :'environmentType',
        'group_type': :'groupType',
        'resource_selection_type': :'resourceSelectionType',
        'rule_selection_criteria': :'ruleSelectionCriteria',
        'notification_preferences': :'notificationPreferences',
        'resources': :'resources',
        'is_target_auto_confirm': :'isTargetAutoConfirm',
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
        'description': :'String',
        'compartment_id': :'String',
        'fleet_type': :'String',
        'products': :'Array<String>',
        'application_type': :'String',
        'environment_type': :'String',
        'group_type': :'String',
        'resource_selection_type': :'String',
        'rule_selection_criteria': :'OCI::FleetAppsManagement::Models::SelectionCriteria',
        'notification_preferences': :'OCI::FleetAppsManagement::Models::NotificationPreferences',
        'resources': :'Array<OCI::FleetAppsManagement::Models::AssociatedFleetResourceDetails>',
        'is_target_auto_confirm': :'BOOLEAN',
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
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :fleet_type The value to assign to the {#fleet_type} property
    # @option attributes [Array<String>] :products The value to assign to the {#products} property
    # @option attributes [String] :application_type The value to assign to the {#application_type} property
    # @option attributes [String] :environment_type The value to assign to the {#environment_type} property
    # @option attributes [String] :group_type The value to assign to the {#group_type} property
    # @option attributes [String] :resource_selection_type The value to assign to the {#resource_selection_type} property
    # @option attributes [OCI::FleetAppsManagement::Models::SelectionCriteria] :rule_selection_criteria The value to assign to the {#rule_selection_criteria} property
    # @option attributes [OCI::FleetAppsManagement::Models::NotificationPreferences] :notification_preferences The value to assign to the {#notification_preferences} property
    # @option attributes [Array<OCI::FleetAppsManagement::Models::AssociatedFleetResourceDetails>] :resources The value to assign to the {#resources} property
    # @option attributes [BOOLEAN] :is_target_auto_confirm The value to assign to the {#is_target_auto_confirm} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.fleet_type = attributes[:'fleetType'] if attributes[:'fleetType']

      raise 'You cannot provide both :fleetType and :fleet_type' if attributes.key?(:'fleetType') && attributes.key?(:'fleet_type')

      self.fleet_type = attributes[:'fleet_type'] if attributes[:'fleet_type']

      self.products = attributes[:'products'] if attributes[:'products']

      self.application_type = attributes[:'applicationType'] if attributes[:'applicationType']

      raise 'You cannot provide both :applicationType and :application_type' if attributes.key?(:'applicationType') && attributes.key?(:'application_type')

      self.application_type = attributes[:'application_type'] if attributes[:'application_type']

      self.environment_type = attributes[:'environmentType'] if attributes[:'environmentType']

      raise 'You cannot provide both :environmentType and :environment_type' if attributes.key?(:'environmentType') && attributes.key?(:'environment_type')

      self.environment_type = attributes[:'environment_type'] if attributes[:'environment_type']

      self.group_type = attributes[:'groupType'] if attributes[:'groupType']

      raise 'You cannot provide both :groupType and :group_type' if attributes.key?(:'groupType') && attributes.key?(:'group_type')

      self.group_type = attributes[:'group_type'] if attributes[:'group_type']

      self.resource_selection_type = attributes[:'resourceSelectionType'] if attributes[:'resourceSelectionType']

      raise 'You cannot provide both :resourceSelectionType and :resource_selection_type' if attributes.key?(:'resourceSelectionType') && attributes.key?(:'resource_selection_type')

      self.resource_selection_type = attributes[:'resource_selection_type'] if attributes[:'resource_selection_type']

      self.rule_selection_criteria = attributes[:'ruleSelectionCriteria'] if attributes[:'ruleSelectionCriteria']

      raise 'You cannot provide both :ruleSelectionCriteria and :rule_selection_criteria' if attributes.key?(:'ruleSelectionCriteria') && attributes.key?(:'rule_selection_criteria')

      self.rule_selection_criteria = attributes[:'rule_selection_criteria'] if attributes[:'rule_selection_criteria']

      self.notification_preferences = attributes[:'notificationPreferences'] if attributes[:'notificationPreferences']

      raise 'You cannot provide both :notificationPreferences and :notification_preferences' if attributes.key?(:'notificationPreferences') && attributes.key?(:'notification_preferences')

      self.notification_preferences = attributes[:'notification_preferences'] if attributes[:'notification_preferences']

      self.resources = attributes[:'resources'] if attributes[:'resources']

      self.is_target_auto_confirm = attributes[:'isTargetAutoConfirm'] unless attributes[:'isTargetAutoConfirm'].nil?
      self.is_target_auto_confirm = false if is_target_auto_confirm.nil? && !attributes.key?(:'isTargetAutoConfirm') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isTargetAutoConfirm and :is_target_auto_confirm' if attributes.key?(:'isTargetAutoConfirm') && attributes.key?(:'is_target_auto_confirm')

      self.is_target_auto_confirm = attributes[:'is_target_auto_confirm'] unless attributes[:'is_target_auto_confirm'].nil?
      self.is_target_auto_confirm = false if is_target_auto_confirm.nil? && !attributes.key?(:'isTargetAutoConfirm') && !attributes.key?(:'is_target_auto_confirm') # rubocop:disable Style/StringLiterals

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
        description == other.description &&
        compartment_id == other.compartment_id &&
        fleet_type == other.fleet_type &&
        products == other.products &&
        application_type == other.application_type &&
        environment_type == other.environment_type &&
        group_type == other.group_type &&
        resource_selection_type == other.resource_selection_type &&
        rule_selection_criteria == other.rule_selection_criteria &&
        notification_preferences == other.notification_preferences &&
        resources == other.resources &&
        is_target_auto_confirm == other.is_target_auto_confirm &&
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
      [display_name, description, compartment_id, fleet_type, products, application_type, environment_type, group_type, resource_selection_type, rule_selection_criteria, notification_preferences, resources, is_target_auto_confirm, freeform_tags, defined_tags].hash
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
