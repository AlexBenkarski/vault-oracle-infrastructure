# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230301
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details required for creation of ATP-D based catalog.
  class GloballyDistributedDatabase::Models::CreateDedicatedCatalogDetail
    # @return [OCI::GloballyDistributedDatabase::Models::DedicatedShardOrCatalogEncryptionKeyDetails]
    attr_accessor :encryption_key_details

    # **[Required]** Admin password for the catalog database.
    # @return [String]
    attr_accessor :admin_password

    # **[Required]** The compute count for the catalog database. It has to be in multiple of 2.
    # @return [Float]
    attr_accessor :compute_count

    # **[Required]** The data disk group size to be allocated in GBs for the catalog database.
    # @return [Float]
    attr_accessor :data_storage_size_in_gbs

    # **[Required]** Determines the auto-scaling mode for the catalog database.
    # @return [BOOLEAN]
    attr_accessor :is_auto_scaling_enabled

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the cloud Autonomous Exadata VM Cluster.
    # @return [String]
    attr_accessor :cloud_autonomous_vm_cluster_id

    # The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the peer cloud Autonomous Exadata VM Cluster.
    # @return [String]
    attr_accessor :peer_cloud_autonomous_vm_cluster_id

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'encryption_key_details': :'encryptionKeyDetails',
        'admin_password': :'adminPassword',
        'compute_count': :'computeCount',
        'data_storage_size_in_gbs': :'dataStorageSizeInGbs',
        'is_auto_scaling_enabled': :'isAutoScalingEnabled',
        'cloud_autonomous_vm_cluster_id': :'cloudAutonomousVmClusterId',
        'peer_cloud_autonomous_vm_cluster_id': :'peerCloudAutonomousVmClusterId'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'encryption_key_details': :'OCI::GloballyDistributedDatabase::Models::DedicatedShardOrCatalogEncryptionKeyDetails',
        'admin_password': :'String',
        'compute_count': :'Float',
        'data_storage_size_in_gbs': :'Float',
        'is_auto_scaling_enabled': :'BOOLEAN',
        'cloud_autonomous_vm_cluster_id': :'String',
        'peer_cloud_autonomous_vm_cluster_id': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [OCI::GloballyDistributedDatabase::Models::DedicatedShardOrCatalogEncryptionKeyDetails] :encryption_key_details The value to assign to the {#encryption_key_details} property
    # @option attributes [String] :admin_password The value to assign to the {#admin_password} property
    # @option attributes [Float] :compute_count The value to assign to the {#compute_count} property
    # @option attributes [Float] :data_storage_size_in_gbs The value to assign to the {#data_storage_size_in_gbs} property
    # @option attributes [BOOLEAN] :is_auto_scaling_enabled The value to assign to the {#is_auto_scaling_enabled} property
    # @option attributes [String] :cloud_autonomous_vm_cluster_id The value to assign to the {#cloud_autonomous_vm_cluster_id} property
    # @option attributes [String] :peer_cloud_autonomous_vm_cluster_id The value to assign to the {#peer_cloud_autonomous_vm_cluster_id} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.encryption_key_details = attributes[:'encryptionKeyDetails'] if attributes[:'encryptionKeyDetails']

      raise 'You cannot provide both :encryptionKeyDetails and :encryption_key_details' if attributes.key?(:'encryptionKeyDetails') && attributes.key?(:'encryption_key_details')

      self.encryption_key_details = attributes[:'encryption_key_details'] if attributes[:'encryption_key_details']

      self.admin_password = attributes[:'adminPassword'] if attributes[:'adminPassword']

      raise 'You cannot provide both :adminPassword and :admin_password' if attributes.key?(:'adminPassword') && attributes.key?(:'admin_password')

      self.admin_password = attributes[:'admin_password'] if attributes[:'admin_password']

      self.compute_count = attributes[:'computeCount'] if attributes[:'computeCount']

      raise 'You cannot provide both :computeCount and :compute_count' if attributes.key?(:'computeCount') && attributes.key?(:'compute_count')

      self.compute_count = attributes[:'compute_count'] if attributes[:'compute_count']

      self.data_storage_size_in_gbs = attributes[:'dataStorageSizeInGbs'] if attributes[:'dataStorageSizeInGbs']

      raise 'You cannot provide both :dataStorageSizeInGbs and :data_storage_size_in_gbs' if attributes.key?(:'dataStorageSizeInGbs') && attributes.key?(:'data_storage_size_in_gbs')

      self.data_storage_size_in_gbs = attributes[:'data_storage_size_in_gbs'] if attributes[:'data_storage_size_in_gbs']

      self.is_auto_scaling_enabled = attributes[:'isAutoScalingEnabled'] unless attributes[:'isAutoScalingEnabled'].nil?

      raise 'You cannot provide both :isAutoScalingEnabled and :is_auto_scaling_enabled' if attributes.key?(:'isAutoScalingEnabled') && attributes.key?(:'is_auto_scaling_enabled')

      self.is_auto_scaling_enabled = attributes[:'is_auto_scaling_enabled'] unless attributes[:'is_auto_scaling_enabled'].nil?

      self.cloud_autonomous_vm_cluster_id = attributes[:'cloudAutonomousVmClusterId'] if attributes[:'cloudAutonomousVmClusterId']

      raise 'You cannot provide both :cloudAutonomousVmClusterId and :cloud_autonomous_vm_cluster_id' if attributes.key?(:'cloudAutonomousVmClusterId') && attributes.key?(:'cloud_autonomous_vm_cluster_id')

      self.cloud_autonomous_vm_cluster_id = attributes[:'cloud_autonomous_vm_cluster_id'] if attributes[:'cloud_autonomous_vm_cluster_id']

      self.peer_cloud_autonomous_vm_cluster_id = attributes[:'peerCloudAutonomousVmClusterId'] if attributes[:'peerCloudAutonomousVmClusterId']

      raise 'You cannot provide both :peerCloudAutonomousVmClusterId and :peer_cloud_autonomous_vm_cluster_id' if attributes.key?(:'peerCloudAutonomousVmClusterId') && attributes.key?(:'peer_cloud_autonomous_vm_cluster_id')

      self.peer_cloud_autonomous_vm_cluster_id = attributes[:'peer_cloud_autonomous_vm_cluster_id'] if attributes[:'peer_cloud_autonomous_vm_cluster_id']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        encryption_key_details == other.encryption_key_details &&
        admin_password == other.admin_password &&
        compute_count == other.compute_count &&
        data_storage_size_in_gbs == other.data_storage_size_in_gbs &&
        is_auto_scaling_enabled == other.is_auto_scaling_enabled &&
        cloud_autonomous_vm_cluster_id == other.cloud_autonomous_vm_cluster_id &&
        peer_cloud_autonomous_vm_cluster_id == other.peer_cloud_autonomous_vm_cluster_id
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
      [encryption_key_details, admin_password, compute_count, data_storage_size_in_gbs, is_auto_scaling_enabled, cloud_autonomous_vm_cluster_id, peer_cloud_autonomous_vm_cluster_id].hash
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
