# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230801
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # While creating the Delegation Control, specify how Service Provider Actions are approved and the users who have the privilege of approving the Service Provider Actions associated with the Delegation Control.
  #
  # You must specify which Service Provider Actions must be pre-approved. The rest of the Service Provider Actions associated with the Delegation Control will require an explicit approval from the users selected either through the approver groups or individually.
  #
  # You must name your Delegation Control appropriately so it reflects the resources that will be governed by the Delegation Control. Neither the Delegation Controls nor their assignments to resources are visible to the support operators.
  #
  class DelegateAccessControl::Models::CreateDelegationControlDetails
    RESOURCE_TYPE_ENUM = [
      RESOURCE_TYPE_VMCLUSTER = 'VMCLUSTER'.freeze,
      RESOURCE_TYPE_CLOUDVMCLUSTER = 'CLOUDVMCLUSTER'.freeze
    ].freeze

    # **[Required]** The OCID of the compartment that contains this Delegation Control.
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** Name of the Delegation Control. The name does not need to be unique.
    # @return [String]
    attr_accessor :display_name

    # Description of the Delegation Control.
    # @return [String]
    attr_accessor :description

    # number of approvals required.
    # @return [Integer]
    attr_accessor :num_approvals_required

    # List of pre-approved Service Provider Action names. The list of pre-defined Service Provider Actions can be obtained from the ListServiceProviderActions API. Delegated Resource Access Requests associated with a resource governed by this Delegation Control will be
    # automatically approved if the Delegated Resource Access Request only contain Service Provider Actions in the pre-approved list.
    #
    # @return [Array<String>]
    attr_accessor :pre_approved_service_provider_action_names

    # **[Required]** List of Delegation Subscription OCID that are allowed for this Delegation Control. The allowed subscriptions will determine the available Service Provider Actions. Only support operators for the allowed subscriptions are allowed to create Delegated Resource Access Request.
    # @return [Array<String>]
    attr_accessor :delegation_subscription_ids

    # Set to true to allow all Delegated Resource Access Request to be approved automatically during maintenance.
    # @return [BOOLEAN]
    attr_accessor :is_auto_approve_during_maintenance

    # **[Required]** The OCID of the selected resources that this Delegation Control is applicable to.
    # @return [Array<String>]
    attr_accessor :resource_ids

    # **[Required]** Resource type for which the Delegation Control is applicable to.
    # @return [String]
    attr_reader :resource_type

    # **[Required]** The OCID of the OCI Notification topic to publish messages related to this Delegation Control.
    # @return [String]
    attr_accessor :notification_topic_id

    # **[Required]** The format of the OCI Notification messages for this Delegation Control.
    # @return [String]
    attr_accessor :notification_message_format

    # The OCID of the OCI Vault that will store the secrets containing the SSH keys to access the resource governed by this Delegation Control by Delegate Access Control Service. This property is required when resourceType is CLOUDVMCLUSTER. Delegate Access Control Service will generate the SSH keys and store them as secrets in the OCI Vault.
    # @return [String]
    attr_accessor :vault_id

    # The OCID of the Master Encryption Key in the OCI Vault specified by vaultId. This key will be used to encrypt the SSH keys to access the resource governed by this Delegation Control by Delegate Access Control Service. This property is required when resourceType is CLOUDVMCLUSTER.
    # @return [String]
    attr_accessor :vault_key_id

    # Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'compartment_id': :'compartmentId',
        'display_name': :'displayName',
        'description': :'description',
        'num_approvals_required': :'numApprovalsRequired',
        'pre_approved_service_provider_action_names': :'preApprovedServiceProviderActionNames',
        'delegation_subscription_ids': :'delegationSubscriptionIds',
        'is_auto_approve_during_maintenance': :'isAutoApproveDuringMaintenance',
        'resource_ids': :'resourceIds',
        'resource_type': :'resourceType',
        'notification_topic_id': :'notificationTopicId',
        'notification_message_format': :'notificationMessageFormat',
        'vault_id': :'vaultId',
        'vault_key_id': :'vaultKeyId',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'compartment_id': :'String',
        'display_name': :'String',
        'description': :'String',
        'num_approvals_required': :'Integer',
        'pre_approved_service_provider_action_names': :'Array<String>',
        'delegation_subscription_ids': :'Array<String>',
        'is_auto_approve_during_maintenance': :'BOOLEAN',
        'resource_ids': :'Array<String>',
        'resource_type': :'String',
        'notification_topic_id': :'String',
        'notification_message_format': :'String',
        'vault_id': :'String',
        'vault_key_id': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [Integer] :num_approvals_required The value to assign to the {#num_approvals_required} property
    # @option attributes [Array<String>] :pre_approved_service_provider_action_names The value to assign to the {#pre_approved_service_provider_action_names} property
    # @option attributes [Array<String>] :delegation_subscription_ids The value to assign to the {#delegation_subscription_ids} property
    # @option attributes [BOOLEAN] :is_auto_approve_during_maintenance The value to assign to the {#is_auto_approve_during_maintenance} property
    # @option attributes [Array<String>] :resource_ids The value to assign to the {#resource_ids} property
    # @option attributes [String] :resource_type The value to assign to the {#resource_type} property
    # @option attributes [String] :notification_topic_id The value to assign to the {#notification_topic_id} property
    # @option attributes [String] :notification_message_format The value to assign to the {#notification_message_format} property
    # @option attributes [String] :vault_id The value to assign to the {#vault_id} property
    # @option attributes [String] :vault_key_id The value to assign to the {#vault_key_id} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.num_approvals_required = attributes[:'numApprovalsRequired'] if attributes[:'numApprovalsRequired']

      raise 'You cannot provide both :numApprovalsRequired and :num_approvals_required' if attributes.key?(:'numApprovalsRequired') && attributes.key?(:'num_approvals_required')

      self.num_approvals_required = attributes[:'num_approvals_required'] if attributes[:'num_approvals_required']

      self.pre_approved_service_provider_action_names = attributes[:'preApprovedServiceProviderActionNames'] if attributes[:'preApprovedServiceProviderActionNames']

      raise 'You cannot provide both :preApprovedServiceProviderActionNames and :pre_approved_service_provider_action_names' if attributes.key?(:'preApprovedServiceProviderActionNames') && attributes.key?(:'pre_approved_service_provider_action_names')

      self.pre_approved_service_provider_action_names = attributes[:'pre_approved_service_provider_action_names'] if attributes[:'pre_approved_service_provider_action_names']

      self.delegation_subscription_ids = attributes[:'delegationSubscriptionIds'] if attributes[:'delegationSubscriptionIds']

      raise 'You cannot provide both :delegationSubscriptionIds and :delegation_subscription_ids' if attributes.key?(:'delegationSubscriptionIds') && attributes.key?(:'delegation_subscription_ids')

      self.delegation_subscription_ids = attributes[:'delegation_subscription_ids'] if attributes[:'delegation_subscription_ids']

      self.is_auto_approve_during_maintenance = attributes[:'isAutoApproveDuringMaintenance'] unless attributes[:'isAutoApproveDuringMaintenance'].nil?

      raise 'You cannot provide both :isAutoApproveDuringMaintenance and :is_auto_approve_during_maintenance' if attributes.key?(:'isAutoApproveDuringMaintenance') && attributes.key?(:'is_auto_approve_during_maintenance')

      self.is_auto_approve_during_maintenance = attributes[:'is_auto_approve_during_maintenance'] unless attributes[:'is_auto_approve_during_maintenance'].nil?

      self.resource_ids = attributes[:'resourceIds'] if attributes[:'resourceIds']

      raise 'You cannot provide both :resourceIds and :resource_ids' if attributes.key?(:'resourceIds') && attributes.key?(:'resource_ids')

      self.resource_ids = attributes[:'resource_ids'] if attributes[:'resource_ids']

      self.resource_type = attributes[:'resourceType'] if attributes[:'resourceType']

      raise 'You cannot provide both :resourceType and :resource_type' if attributes.key?(:'resourceType') && attributes.key?(:'resource_type')

      self.resource_type = attributes[:'resource_type'] if attributes[:'resource_type']

      self.notification_topic_id = attributes[:'notificationTopicId'] if attributes[:'notificationTopicId']

      raise 'You cannot provide both :notificationTopicId and :notification_topic_id' if attributes.key?(:'notificationTopicId') && attributes.key?(:'notification_topic_id')

      self.notification_topic_id = attributes[:'notification_topic_id'] if attributes[:'notification_topic_id']

      self.notification_message_format = attributes[:'notificationMessageFormat'] if attributes[:'notificationMessageFormat']

      raise 'You cannot provide both :notificationMessageFormat and :notification_message_format' if attributes.key?(:'notificationMessageFormat') && attributes.key?(:'notification_message_format')

      self.notification_message_format = attributes[:'notification_message_format'] if attributes[:'notification_message_format']

      self.vault_id = attributes[:'vaultId'] if attributes[:'vaultId']

      raise 'You cannot provide both :vaultId and :vault_id' if attributes.key?(:'vaultId') && attributes.key?(:'vault_id')

      self.vault_id = attributes[:'vault_id'] if attributes[:'vault_id']

      self.vault_key_id = attributes[:'vaultKeyId'] if attributes[:'vaultKeyId']

      raise 'You cannot provide both :vaultKeyId and :vault_key_id' if attributes.key?(:'vaultKeyId') && attributes.key?(:'vault_key_id')

      self.vault_key_id = attributes[:'vault_key_id'] if attributes[:'vault_key_id']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] resource_type Object to be assigned
    def resource_type=(resource_type)
      raise "Invalid value for 'resource_type': this must be one of the values in RESOURCE_TYPE_ENUM." if resource_type && !RESOURCE_TYPE_ENUM.include?(resource_type)

      @resource_type = resource_type
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        compartment_id == other.compartment_id &&
        display_name == other.display_name &&
        description == other.description &&
        num_approvals_required == other.num_approvals_required &&
        pre_approved_service_provider_action_names == other.pre_approved_service_provider_action_names &&
        delegation_subscription_ids == other.delegation_subscription_ids &&
        is_auto_approve_during_maintenance == other.is_auto_approve_during_maintenance &&
        resource_ids == other.resource_ids &&
        resource_type == other.resource_type &&
        notification_topic_id == other.notification_topic_id &&
        notification_message_format == other.notification_message_format &&
        vault_id == other.vault_id &&
        vault_key_id == other.vault_key_id &&
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
      [compartment_id, display_name, description, num_approvals_required, pre_approved_service_provider_action_names, delegation_subscription_ids, is_auto_approve_during_maintenance, resource_ids, resource_type, notification_topic_id, notification_message_format, vault_id, vault_key_id, freeform_tags, defined_tags].hash
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
