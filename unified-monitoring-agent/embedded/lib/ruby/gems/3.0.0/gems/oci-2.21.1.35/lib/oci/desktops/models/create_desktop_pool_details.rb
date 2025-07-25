# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220618
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Provides the configuration information used to create the desktop pool.
  class Desktops::Models::CreateDesktopPoolDetails
    # **[Required]** The OCID of the compartment which will contain the desktop pool.
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** A user friendly display name. Avoid entering confidential information.
    # @return [String]
    attr_accessor :display_name

    # A user friendly description providing additional information about the resource.
    # Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :description

    # **[Required]** The maximum number of desktops permitted in the desktop pool.
    # @return [Integer]
    attr_accessor :maximum_size

    # **[Required]** The maximum number of standby desktops available in the desktop pool.
    # @return [Integer]
    attr_accessor :standby_size

    # **[Required]** The shape of the desktop pool.
    # @return [String]
    attr_accessor :shape_name

    # **[Required]** Indicates whether storage is enabled for the desktop pool.
    # @return [BOOLEAN]
    attr_accessor :is_storage_enabled

    # **[Required]** The size in GBs of the storage for the desktop pool.
    # @return [Integer]
    attr_accessor :storage_size_in_gbs

    # **[Required]** The backup policy OCID of the storage.
    # @return [String]
    attr_accessor :storage_backup_policy_id

    # This attribute is required.
    # @return [OCI::Desktops::Models::DesktopDevicePolicy]
    attr_accessor :device_policy

    # This attribute is required.
    # @return [OCI::Desktops::Models::DesktopAvailabilityPolicy]
    attr_accessor :availability_policy

    # This attribute is required.
    # @return [OCI::Desktops::Models::DesktopImage]
    attr_accessor :image

    # This attribute is required.
    # @return [OCI::Desktops::Models::DesktopNetworkConfiguration]
    attr_accessor :network_configuration

    # The start time of the desktop pool.
    # @return [DateTime]
    attr_accessor :time_start_scheduled

    # The stop time of the desktop pool.
    # @return [DateTime]
    attr_accessor :time_stop_scheduled

    # **[Required]** Contact information of the desktop pool administrator.
    # Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :contact_details

    # **[Required]** Indicates whether desktop pool users have administrative privileges on their desktop.
    # @return [BOOLEAN]
    attr_accessor :are_privileged_users

    # **[Required]** The availability domain of the desktop pool.
    # @return [String]
    attr_accessor :availability_domain

    # Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # A list of network security groups for the desktop pool.
    # @return [Array<String>]
    attr_accessor :nsg_ids

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'compartment_id': :'compartmentId',
        'display_name': :'displayName',
        'description': :'description',
        'maximum_size': :'maximumSize',
        'standby_size': :'standbySize',
        'shape_name': :'shapeName',
        'is_storage_enabled': :'isStorageEnabled',
        'storage_size_in_gbs': :'storageSizeInGBs',
        'storage_backup_policy_id': :'storageBackupPolicyId',
        'device_policy': :'devicePolicy',
        'availability_policy': :'availabilityPolicy',
        'image': :'image',
        'network_configuration': :'networkConfiguration',
        'time_start_scheduled': :'timeStartScheduled',
        'time_stop_scheduled': :'timeStopScheduled',
        'contact_details': :'contactDetails',
        'are_privileged_users': :'arePrivilegedUsers',
        'availability_domain': :'availabilityDomain',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'nsg_ids': :'nsgIds'
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
        'maximum_size': :'Integer',
        'standby_size': :'Integer',
        'shape_name': :'String',
        'is_storage_enabled': :'BOOLEAN',
        'storage_size_in_gbs': :'Integer',
        'storage_backup_policy_id': :'String',
        'device_policy': :'OCI::Desktops::Models::DesktopDevicePolicy',
        'availability_policy': :'OCI::Desktops::Models::DesktopAvailabilityPolicy',
        'image': :'OCI::Desktops::Models::DesktopImage',
        'network_configuration': :'OCI::Desktops::Models::DesktopNetworkConfiguration',
        'time_start_scheduled': :'DateTime',
        'time_stop_scheduled': :'DateTime',
        'contact_details': :'String',
        'are_privileged_users': :'BOOLEAN',
        'availability_domain': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'nsg_ids': :'Array<String>'
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
    # @option attributes [Integer] :maximum_size The value to assign to the {#maximum_size} property
    # @option attributes [Integer] :standby_size The value to assign to the {#standby_size} property
    # @option attributes [String] :shape_name The value to assign to the {#shape_name} property
    # @option attributes [BOOLEAN] :is_storage_enabled The value to assign to the {#is_storage_enabled} property
    # @option attributes [Integer] :storage_size_in_gbs The value to assign to the {#storage_size_in_gbs} property
    # @option attributes [String] :storage_backup_policy_id The value to assign to the {#storage_backup_policy_id} property
    # @option attributes [OCI::Desktops::Models::DesktopDevicePolicy] :device_policy The value to assign to the {#device_policy} property
    # @option attributes [OCI::Desktops::Models::DesktopAvailabilityPolicy] :availability_policy The value to assign to the {#availability_policy} property
    # @option attributes [OCI::Desktops::Models::DesktopImage] :image The value to assign to the {#image} property
    # @option attributes [OCI::Desktops::Models::DesktopNetworkConfiguration] :network_configuration The value to assign to the {#network_configuration} property
    # @option attributes [DateTime] :time_start_scheduled The value to assign to the {#time_start_scheduled} property
    # @option attributes [DateTime] :time_stop_scheduled The value to assign to the {#time_stop_scheduled} property
    # @option attributes [String] :contact_details The value to assign to the {#contact_details} property
    # @option attributes [BOOLEAN] :are_privileged_users The value to assign to the {#are_privileged_users} property
    # @option attributes [String] :availability_domain The value to assign to the {#availability_domain} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Array<String>] :nsg_ids The value to assign to the {#nsg_ids} property
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

      self.maximum_size = attributes[:'maximumSize'] if attributes[:'maximumSize']

      raise 'You cannot provide both :maximumSize and :maximum_size' if attributes.key?(:'maximumSize') && attributes.key?(:'maximum_size')

      self.maximum_size = attributes[:'maximum_size'] if attributes[:'maximum_size']

      self.standby_size = attributes[:'standbySize'] if attributes[:'standbySize']

      raise 'You cannot provide both :standbySize and :standby_size' if attributes.key?(:'standbySize') && attributes.key?(:'standby_size')

      self.standby_size = attributes[:'standby_size'] if attributes[:'standby_size']

      self.shape_name = attributes[:'shapeName'] if attributes[:'shapeName']

      raise 'You cannot provide both :shapeName and :shape_name' if attributes.key?(:'shapeName') && attributes.key?(:'shape_name')

      self.shape_name = attributes[:'shape_name'] if attributes[:'shape_name']

      self.is_storage_enabled = attributes[:'isStorageEnabled'] unless attributes[:'isStorageEnabled'].nil?

      raise 'You cannot provide both :isStorageEnabled and :is_storage_enabled' if attributes.key?(:'isStorageEnabled') && attributes.key?(:'is_storage_enabled')

      self.is_storage_enabled = attributes[:'is_storage_enabled'] unless attributes[:'is_storage_enabled'].nil?

      self.storage_size_in_gbs = attributes[:'storageSizeInGBs'] if attributes[:'storageSizeInGBs']

      raise 'You cannot provide both :storageSizeInGBs and :storage_size_in_gbs' if attributes.key?(:'storageSizeInGBs') && attributes.key?(:'storage_size_in_gbs')

      self.storage_size_in_gbs = attributes[:'storage_size_in_gbs'] if attributes[:'storage_size_in_gbs']

      self.storage_backup_policy_id = attributes[:'storageBackupPolicyId'] if attributes[:'storageBackupPolicyId']

      raise 'You cannot provide both :storageBackupPolicyId and :storage_backup_policy_id' if attributes.key?(:'storageBackupPolicyId') && attributes.key?(:'storage_backup_policy_id')

      self.storage_backup_policy_id = attributes[:'storage_backup_policy_id'] if attributes[:'storage_backup_policy_id']

      self.device_policy = attributes[:'devicePolicy'] if attributes[:'devicePolicy']

      raise 'You cannot provide both :devicePolicy and :device_policy' if attributes.key?(:'devicePolicy') && attributes.key?(:'device_policy')

      self.device_policy = attributes[:'device_policy'] if attributes[:'device_policy']

      self.availability_policy = attributes[:'availabilityPolicy'] if attributes[:'availabilityPolicy']

      raise 'You cannot provide both :availabilityPolicy and :availability_policy' if attributes.key?(:'availabilityPolicy') && attributes.key?(:'availability_policy')

      self.availability_policy = attributes[:'availability_policy'] if attributes[:'availability_policy']

      self.image = attributes[:'image'] if attributes[:'image']

      self.network_configuration = attributes[:'networkConfiguration'] if attributes[:'networkConfiguration']

      raise 'You cannot provide both :networkConfiguration and :network_configuration' if attributes.key?(:'networkConfiguration') && attributes.key?(:'network_configuration')

      self.network_configuration = attributes[:'network_configuration'] if attributes[:'network_configuration']

      self.time_start_scheduled = attributes[:'timeStartScheduled'] if attributes[:'timeStartScheduled']

      raise 'You cannot provide both :timeStartScheduled and :time_start_scheduled' if attributes.key?(:'timeStartScheduled') && attributes.key?(:'time_start_scheduled')

      self.time_start_scheduled = attributes[:'time_start_scheduled'] if attributes[:'time_start_scheduled']

      self.time_stop_scheduled = attributes[:'timeStopScheduled'] if attributes[:'timeStopScheduled']

      raise 'You cannot provide both :timeStopScheduled and :time_stop_scheduled' if attributes.key?(:'timeStopScheduled') && attributes.key?(:'time_stop_scheduled')

      self.time_stop_scheduled = attributes[:'time_stop_scheduled'] if attributes[:'time_stop_scheduled']

      self.contact_details = attributes[:'contactDetails'] if attributes[:'contactDetails']

      raise 'You cannot provide both :contactDetails and :contact_details' if attributes.key?(:'contactDetails') && attributes.key?(:'contact_details')

      self.contact_details = attributes[:'contact_details'] if attributes[:'contact_details']

      self.are_privileged_users = attributes[:'arePrivilegedUsers'] unless attributes[:'arePrivilegedUsers'].nil?

      raise 'You cannot provide both :arePrivilegedUsers and :are_privileged_users' if attributes.key?(:'arePrivilegedUsers') && attributes.key?(:'are_privileged_users')

      self.are_privileged_users = attributes[:'are_privileged_users'] unless attributes[:'are_privileged_users'].nil?

      self.availability_domain = attributes[:'availabilityDomain'] if attributes[:'availabilityDomain']

      raise 'You cannot provide both :availabilityDomain and :availability_domain' if attributes.key?(:'availabilityDomain') && attributes.key?(:'availability_domain')

      self.availability_domain = attributes[:'availability_domain'] if attributes[:'availability_domain']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.nsg_ids = attributes[:'nsgIds'] if attributes[:'nsgIds']

      raise 'You cannot provide both :nsgIds and :nsg_ids' if attributes.key?(:'nsgIds') && attributes.key?(:'nsg_ids')

      self.nsg_ids = attributes[:'nsg_ids'] if attributes[:'nsg_ids']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        compartment_id == other.compartment_id &&
        display_name == other.display_name &&
        description == other.description &&
        maximum_size == other.maximum_size &&
        standby_size == other.standby_size &&
        shape_name == other.shape_name &&
        is_storage_enabled == other.is_storage_enabled &&
        storage_size_in_gbs == other.storage_size_in_gbs &&
        storage_backup_policy_id == other.storage_backup_policy_id &&
        device_policy == other.device_policy &&
        availability_policy == other.availability_policy &&
        image == other.image &&
        network_configuration == other.network_configuration &&
        time_start_scheduled == other.time_start_scheduled &&
        time_stop_scheduled == other.time_stop_scheduled &&
        contact_details == other.contact_details &&
        are_privileged_users == other.are_privileged_users &&
        availability_domain == other.availability_domain &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        nsg_ids == other.nsg_ids
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
      [compartment_id, display_name, description, maximum_size, standby_size, shape_name, is_storage_enabled, storage_size_in_gbs, storage_backup_policy_id, device_policy, availability_policy, image, network_configuration, time_start_scheduled, time_stop_scheduled, contact_details, are_privileged_users, availability_domain, freeform_tags, defined_tags, nsg_ids].hash
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
