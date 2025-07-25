# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220915
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Information about a database system.
  class Psql::Models::DbSystem
    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_CREATING = 'CREATING'.freeze,
      LIFECYCLE_STATE_UPDATING = 'UPDATING'.freeze,
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_INACTIVE = 'INACTIVE'.freeze,
      LIFECYCLE_STATE_DELETING = 'DELETING'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_NEEDS_ATTENTION = 'NEEDS_ATTENTION'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    SYSTEM_TYPE_ENUM = [
      SYSTEM_TYPE_OCI_OPTIMIZED_STORAGE = 'OCI_OPTIMIZED_STORAGE'.freeze,
      SYSTEM_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** A unique identifier for the database system. Immutable on creation.
    # @return [String]
    attr_accessor :id

    # **[Required]** A user-friendly display name for the database system. Avoid entering confidential information.
    # @return [String]
    attr_accessor :display_name

    # A description of the database system.
    # @return [String]
    attr_accessor :description

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the compartment that contains the database system.
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** The date and time that the database system was created, expressed in
    # [RFC 3339](https://tools.ietf.org/rfc/rfc3339) timestamp format.
    #
    # Example: `2016-08-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_created

    # The date and time that the database system was updated, expressed in
    # [RFC 3339](https://tools.ietf.org/rfc/rfc3339) timestamp format.
    #
    # Example: `2016-08-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_updated

    # **[Required]** The current state of the database system.
    # @return [String]
    attr_reader :lifecycle_state

    # A message describing the current state in more detail. For example, can be used to provide actionable information for a resource in Failed state.
    # @return [String]
    attr_accessor :lifecycle_details

    # The database system administrator username.
    # @return [String]
    attr_accessor :admin_username

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

    # System tags for this resource. Each key is predefined and scoped to a namespace.
    # Example: `{\"orcl-cloud\": {\"free-tier-retained\": \"true\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :system_tags

    # **[Required]** Type of the database system.
    # @return [String]
    attr_reader :system_type

    # **[Required]** The major and minor versions of the database system software.
    # @return [String]
    attr_accessor :db_version

    # The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the configuration associated with the database system.
    # @return [String]
    attr_accessor :config_id

    # **[Required]** The name of the shape for the database instance.
    # Example: `VM.Standard.E4.Flex`
    #
    # @return [String]
    attr_accessor :shape

    # **[Required]** The total number of OCPUs available to each database instance node.
    # @return [Integer]
    attr_accessor :instance_ocpu_count

    # **[Required]** The total amount of memory available to each database instance node, in gigabytes.
    # @return [Integer]
    attr_accessor :instance_memory_size_in_gbs

    # Count of instances, or nodes, in the database system.
    # @return [Integer]
    attr_accessor :instance_count

    # The list of instances, or nodes, in the database system.
    # @return [Array<OCI::Psql::Models::DbInstance>]
    attr_accessor :instances

    # This attribute is required.
    # @return [OCI::Psql::Models::StorageDetails]
    attr_accessor :storage_details

    # This attribute is required.
    # @return [OCI::Psql::Models::NetworkDetails]
    attr_accessor :network_details

    # This attribute is required.
    # @return [OCI::Psql::Models::ManagementPolicy]
    attr_accessor :management_policy

    # @return [OCI::Psql::Models::SourceDetails]
    attr_accessor :source

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'display_name': :'displayName',
        'description': :'description',
        'compartment_id': :'compartmentId',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'lifecycle_state': :'lifecycleState',
        'lifecycle_details': :'lifecycleDetails',
        'admin_username': :'adminUsername',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags',
        'system_type': :'systemType',
        'db_version': :'dbVersion',
        'config_id': :'configId',
        'shape': :'shape',
        'instance_ocpu_count': :'instanceOcpuCount',
        'instance_memory_size_in_gbs': :'instanceMemorySizeInGBs',
        'instance_count': :'instanceCount',
        'instances': :'instances',
        'storage_details': :'storageDetails',
        'network_details': :'networkDetails',
        'management_policy': :'managementPolicy',
        'source': :'source'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'display_name': :'String',
        'description': :'String',
        'compartment_id': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'lifecycle_state': :'String',
        'lifecycle_details': :'String',
        'admin_username': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>',
        'system_type': :'String',
        'db_version': :'String',
        'config_id': :'String',
        'shape': :'String',
        'instance_ocpu_count': :'Integer',
        'instance_memory_size_in_gbs': :'Integer',
        'instance_count': :'Integer',
        'instances': :'Array<OCI::Psql::Models::DbInstance>',
        'storage_details': :'OCI::Psql::Models::StorageDetails',
        'network_details': :'OCI::Psql::Models::NetworkDetails',
        'management_policy': :'OCI::Psql::Models::ManagementPolicy',
        'source': :'OCI::Psql::Models::SourceDetails'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :lifecycle_details The value to assign to the {#lifecycle_details} property
    # @option attributes [String] :admin_username The value to assign to the {#admin_username} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {#system_tags} property
    # @option attributes [String] :system_type The value to assign to the {#system_type} property
    # @option attributes [String] :db_version The value to assign to the {#db_version} property
    # @option attributes [String] :config_id The value to assign to the {#config_id} property
    # @option attributes [String] :shape The value to assign to the {#shape} property
    # @option attributes [Integer] :instance_ocpu_count The value to assign to the {#instance_ocpu_count} property
    # @option attributes [Integer] :instance_memory_size_in_gbs The value to assign to the {#instance_memory_size_in_gbs} property
    # @option attributes [Integer] :instance_count The value to assign to the {#instance_count} property
    # @option attributes [Array<OCI::Psql::Models::DbInstance>] :instances The value to assign to the {#instances} property
    # @option attributes [OCI::Psql::Models::StorageDetails] :storage_details The value to assign to the {#storage_details} property
    # @option attributes [OCI::Psql::Models::NetworkDetails] :network_details The value to assign to the {#network_details} property
    # @option attributes [OCI::Psql::Models::ManagementPolicy] :management_policy The value to assign to the {#management_policy} property
    # @option attributes [OCI::Psql::Models::SourceDetails] :source The value to assign to the {#source} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

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

      self.admin_username = attributes[:'adminUsername'] if attributes[:'adminUsername']

      raise 'You cannot provide both :adminUsername and :admin_username' if attributes.key?(:'adminUsername') && attributes.key?(:'admin_username')

      self.admin_username = attributes[:'admin_username'] if attributes[:'admin_username']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.system_tags = attributes[:'systemTags'] if attributes[:'systemTags']

      raise 'You cannot provide both :systemTags and :system_tags' if attributes.key?(:'systemTags') && attributes.key?(:'system_tags')

      self.system_tags = attributes[:'system_tags'] if attributes[:'system_tags']

      self.system_type = attributes[:'systemType'] if attributes[:'systemType']

      raise 'You cannot provide both :systemType and :system_type' if attributes.key?(:'systemType') && attributes.key?(:'system_type')

      self.system_type = attributes[:'system_type'] if attributes[:'system_type']

      self.db_version = attributes[:'dbVersion'] if attributes[:'dbVersion']

      raise 'You cannot provide both :dbVersion and :db_version' if attributes.key?(:'dbVersion') && attributes.key?(:'db_version')

      self.db_version = attributes[:'db_version'] if attributes[:'db_version']

      self.config_id = attributes[:'configId'] if attributes[:'configId']

      raise 'You cannot provide both :configId and :config_id' if attributes.key?(:'configId') && attributes.key?(:'config_id')

      self.config_id = attributes[:'config_id'] if attributes[:'config_id']

      self.shape = attributes[:'shape'] if attributes[:'shape']

      self.instance_ocpu_count = attributes[:'instanceOcpuCount'] if attributes[:'instanceOcpuCount']

      raise 'You cannot provide both :instanceOcpuCount and :instance_ocpu_count' if attributes.key?(:'instanceOcpuCount') && attributes.key?(:'instance_ocpu_count')

      self.instance_ocpu_count = attributes[:'instance_ocpu_count'] if attributes[:'instance_ocpu_count']

      self.instance_memory_size_in_gbs = attributes[:'instanceMemorySizeInGBs'] if attributes[:'instanceMemorySizeInGBs']

      raise 'You cannot provide both :instanceMemorySizeInGBs and :instance_memory_size_in_gbs' if attributes.key?(:'instanceMemorySizeInGBs') && attributes.key?(:'instance_memory_size_in_gbs')

      self.instance_memory_size_in_gbs = attributes[:'instance_memory_size_in_gbs'] if attributes[:'instance_memory_size_in_gbs']

      self.instance_count = attributes[:'instanceCount'] if attributes[:'instanceCount']

      raise 'You cannot provide both :instanceCount and :instance_count' if attributes.key?(:'instanceCount') && attributes.key?(:'instance_count')

      self.instance_count = attributes[:'instance_count'] if attributes[:'instance_count']

      self.instances = attributes[:'instances'] if attributes[:'instances']

      self.storage_details = attributes[:'storageDetails'] if attributes[:'storageDetails']

      raise 'You cannot provide both :storageDetails and :storage_details' if attributes.key?(:'storageDetails') && attributes.key?(:'storage_details')

      self.storage_details = attributes[:'storage_details'] if attributes[:'storage_details']

      self.network_details = attributes[:'networkDetails'] if attributes[:'networkDetails']

      raise 'You cannot provide both :networkDetails and :network_details' if attributes.key?(:'networkDetails') && attributes.key?(:'network_details')

      self.network_details = attributes[:'network_details'] if attributes[:'network_details']

      self.management_policy = attributes[:'managementPolicy'] if attributes[:'managementPolicy']

      raise 'You cannot provide both :managementPolicy and :management_policy' if attributes.key?(:'managementPolicy') && attributes.key?(:'management_policy')

      self.management_policy = attributes[:'management_policy'] if attributes[:'management_policy']

      self.source = attributes[:'source'] if attributes[:'source']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] lifecycle_state Object to be assigned
    def lifecycle_state=(lifecycle_state)
      # rubocop:disable Style/ConditionalAssignment
      if lifecycle_state && !LIFECYCLE_STATE_ENUM.include?(lifecycle_state)
        OCI.logger.debug("Unknown value for 'lifecycle_state' [" + lifecycle_state + "]. Mapping to 'LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @lifecycle_state = LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE
      else
        @lifecycle_state = lifecycle_state
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] system_type Object to be assigned
    def system_type=(system_type)
      # rubocop:disable Style/ConditionalAssignment
      if system_type && !SYSTEM_TYPE_ENUM.include?(system_type)
        OCI.logger.debug("Unknown value for 'system_type' [" + system_type + "]. Mapping to 'SYSTEM_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @system_type = SYSTEM_TYPE_UNKNOWN_ENUM_VALUE
      else
        @system_type = system_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        id == other.id &&
        display_name == other.display_name &&
        description == other.description &&
        compartment_id == other.compartment_id &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        lifecycle_state == other.lifecycle_state &&
        lifecycle_details == other.lifecycle_details &&
        admin_username == other.admin_username &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        system_tags == other.system_tags &&
        system_type == other.system_type &&
        db_version == other.db_version &&
        config_id == other.config_id &&
        shape == other.shape &&
        instance_ocpu_count == other.instance_ocpu_count &&
        instance_memory_size_in_gbs == other.instance_memory_size_in_gbs &&
        instance_count == other.instance_count &&
        instances == other.instances &&
        storage_details == other.storage_details &&
        network_details == other.network_details &&
        management_policy == other.management_policy &&
        source == other.source
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
      [id, display_name, description, compartment_id, time_created, time_updated, lifecycle_state, lifecycle_details, admin_username, freeform_tags, defined_tags, system_tags, system_type, db_version, config_id, shape, instance_ocpu_count, instance_memory_size_in_gbs, instance_count, instances, storage_details, network_details, management_policy, source].hash
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
