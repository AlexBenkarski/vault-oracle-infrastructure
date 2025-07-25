# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Backup destination details.
  class Database::Models::BackupDestination
    TYPE_ENUM = [
      TYPE_NFS = 'NFS'.freeze,
      TYPE_RECOVERY_APPLIANCE = 'RECOVERY_APPLIANCE'.freeze,
      TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    NFS_MOUNT_TYPE_ENUM = [
      NFS_MOUNT_TYPE_SELF_MOUNT = 'SELF_MOUNT'.freeze,
      NFS_MOUNT_TYPE_AUTOMATED_MOUNT = 'AUTOMATED_MOUNT'.freeze,
      NFS_MOUNT_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the backup destination.
    # @return [String]
    attr_accessor :id

    # The user-provided name of the backup destination.
    # @return [String]
    attr_accessor :display_name

    # The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the compartment.
    # @return [String]
    attr_accessor :compartment_id

    # Type of the backup destination.
    # @return [String]
    attr_reader :type

    # List of databases associated with the backup destination.
    # @return [Array<OCI::Database::Models::AssociatedDatabaseDetails>]
    attr_accessor :associated_databases

    # For a RECOVERY_APPLIANCE backup destination, the connection string for connecting to the Recovery Appliance.
    # @return [String]
    attr_accessor :connection_string

    # For a RECOVERY_APPLIANCE backup destination, the Virtual Private Catalog (VPC) users that are used to access the Recovery Appliance.
    # @return [Array<String>]
    attr_accessor :vpc_users

    # The local directory path on each VM cluster node where the NFS server location is mounted. The local directory path and the NFS server location must each be the same across all of the VM cluster nodes. Ensure that the NFS mount is maintained continuously on all of the VM cluster nodes.
    #
    # @return [String]
    attr_accessor :local_mount_point_path

    # NFS Mount type for backup destination.
    # @return [String]
    attr_reader :nfs_mount_type

    # Host names or IP addresses for NFS Auto mount.
    # @return [Array<String>]
    attr_accessor :nfs_server

    # Specifies the directory on which to mount the file system
    # @return [String]
    attr_accessor :nfs_server_export

    # The current lifecycle state of the backup destination.
    # @return [String]
    attr_reader :lifecycle_state

    # The date and time the backup destination was created.
    # @return [DateTime]
    attr_accessor :time_created

    # A descriptive text associated with the lifecycleState.
    # Typically contains additional displayable text
    #
    # @return [String]
    attr_accessor :lifecycle_details

    # Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'display_name': :'displayName',
        'compartment_id': :'compartmentId',
        'type': :'type',
        'associated_databases': :'associatedDatabases',
        'connection_string': :'connectionString',
        'vpc_users': :'vpcUsers',
        'local_mount_point_path': :'localMountPointPath',
        'nfs_mount_type': :'nfsMountType',
        'nfs_server': :'nfsServer',
        'nfs_server_export': :'nfsServerExport',
        'lifecycle_state': :'lifecycleState',
        'time_created': :'timeCreated',
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
        'compartment_id': :'String',
        'type': :'String',
        'associated_databases': :'Array<OCI::Database::Models::AssociatedDatabaseDetails>',
        'connection_string': :'String',
        'vpc_users': :'Array<String>',
        'local_mount_point_path': :'String',
        'nfs_mount_type': :'String',
        'nfs_server': :'Array<String>',
        'nfs_server_export': :'String',
        'lifecycle_state': :'String',
        'time_created': :'DateTime',
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
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :type The value to assign to the {#type} property
    # @option attributes [Array<OCI::Database::Models::AssociatedDatabaseDetails>] :associated_databases The value to assign to the {#associated_databases} property
    # @option attributes [String] :connection_string The value to assign to the {#connection_string} property
    # @option attributes [Array<String>] :vpc_users The value to assign to the {#vpc_users} property
    # @option attributes [String] :local_mount_point_path The value to assign to the {#local_mount_point_path} property
    # @option attributes [String] :nfs_mount_type The value to assign to the {#nfs_mount_type} property
    # @option attributes [Array<String>] :nfs_server The value to assign to the {#nfs_server} property
    # @option attributes [String] :nfs_server_export The value to assign to the {#nfs_server_export} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [String] :lifecycle_details The value to assign to the {#lifecycle_details} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      self.id = attributes[:'id'] if attributes[:'id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.type = attributes[:'type'] if attributes[:'type']

      self.associated_databases = attributes[:'associatedDatabases'] if attributes[:'associatedDatabases']

      raise 'You cannot provide both :associatedDatabases and :associated_databases' if attributes.key?(:'associatedDatabases') && attributes.key?(:'associated_databases')

      self.associated_databases = attributes[:'associated_databases'] if attributes[:'associated_databases']

      self.connection_string = attributes[:'connectionString'] if attributes[:'connectionString']

      raise 'You cannot provide both :connectionString and :connection_string' if attributes.key?(:'connectionString') && attributes.key?(:'connection_string')

      self.connection_string = attributes[:'connection_string'] if attributes[:'connection_string']

      self.vpc_users = attributes[:'vpcUsers'] if attributes[:'vpcUsers']

      raise 'You cannot provide both :vpcUsers and :vpc_users' if attributes.key?(:'vpcUsers') && attributes.key?(:'vpc_users')

      self.vpc_users = attributes[:'vpc_users'] if attributes[:'vpc_users']

      self.local_mount_point_path = attributes[:'localMountPointPath'] if attributes[:'localMountPointPath']

      raise 'You cannot provide both :localMountPointPath and :local_mount_point_path' if attributes.key?(:'localMountPointPath') && attributes.key?(:'local_mount_point_path')

      self.local_mount_point_path = attributes[:'local_mount_point_path'] if attributes[:'local_mount_point_path']

      self.nfs_mount_type = attributes[:'nfsMountType'] if attributes[:'nfsMountType']

      raise 'You cannot provide both :nfsMountType and :nfs_mount_type' if attributes.key?(:'nfsMountType') && attributes.key?(:'nfs_mount_type')

      self.nfs_mount_type = attributes[:'nfs_mount_type'] if attributes[:'nfs_mount_type']

      self.nfs_server = attributes[:'nfsServer'] if attributes[:'nfsServer']

      raise 'You cannot provide both :nfsServer and :nfs_server' if attributes.key?(:'nfsServer') && attributes.key?(:'nfs_server')

      self.nfs_server = attributes[:'nfs_server'] if attributes[:'nfs_server']

      self.nfs_server_export = attributes[:'nfsServerExport'] if attributes[:'nfsServerExport']

      raise 'You cannot provide both :nfsServerExport and :nfs_server_export' if attributes.key?(:'nfsServerExport') && attributes.key?(:'nfs_server_export')

      self.nfs_server_export = attributes[:'nfs_server_export'] if attributes[:'nfs_server_export']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

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

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] type Object to be assigned
    def type=(type)
      # rubocop:disable Style/ConditionalAssignment
      if type && !TYPE_ENUM.include?(type)
        OCI.logger.debug("Unknown value for 'type' [" + type + "]. Mapping to 'TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @type = TYPE_UNKNOWN_ENUM_VALUE
      else
        @type = type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] nfs_mount_type Object to be assigned
    def nfs_mount_type=(nfs_mount_type)
      # rubocop:disable Style/ConditionalAssignment
      if nfs_mount_type && !NFS_MOUNT_TYPE_ENUM.include?(nfs_mount_type)
        OCI.logger.debug("Unknown value for 'nfs_mount_type' [" + nfs_mount_type + "]. Mapping to 'NFS_MOUNT_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @nfs_mount_type = NFS_MOUNT_TYPE_UNKNOWN_ENUM_VALUE
      else
        @nfs_mount_type = nfs_mount_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

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

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        id == other.id &&
        display_name == other.display_name &&
        compartment_id == other.compartment_id &&
        type == other.type &&
        associated_databases == other.associated_databases &&
        connection_string == other.connection_string &&
        vpc_users == other.vpc_users &&
        local_mount_point_path == other.local_mount_point_path &&
        nfs_mount_type == other.nfs_mount_type &&
        nfs_server == other.nfs_server &&
        nfs_server_export == other.nfs_server_export &&
        lifecycle_state == other.lifecycle_state &&
        time_created == other.time_created &&
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
      [id, display_name, compartment_id, type, associated_databases, connection_string, vpc_users, local_mount_point_path, nfs_mount_type, nfs_server, nfs_server_export, lifecycle_state, time_created, lifecycle_details, freeform_tags, defined_tags].hash
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
