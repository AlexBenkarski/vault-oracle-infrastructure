# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details of unallocated resources of the Cloud Exadata infrastructure. Applies to Cloud Exadata infrastructure instances only.
  #
  class Database::Models::CloudExadataInfrastructureUnallocatedResources
    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the Cloud Exadata infrastructure.
    # @return [String]
    attr_accessor :cloud_exadata_infrastructure_id

    # **[Required]** The user-friendly name for the Cloud Exadata infrastructure. The name does not need to be unique.
    # @return [String]
    attr_accessor :cloud_exadata_infrastructure_display_name

    # The minimum amount of unallocated storage available across all nodes in the infrastructure.
    # @return [Integer]
    attr_accessor :local_storage_in_gbs

    # The minimum amount of unallocated ocpus available across all nodes in the infrastructure.
    # @return [Integer]
    attr_accessor :ocpus

    # The minimum amount of unallocated memory available across all nodes in the infrastructure.
    # @return [Integer]
    attr_accessor :memory_in_gbs

    # Total unallocated exadata storage in the infrastructure in TBs.
    # @return [Float]
    attr_accessor :exadata_storage_in_tbs

    # The list of Cloud Autonomous VM Clusters on the Infrastructure and their associated unallocated resources details.
    # @return [Array<OCI::Database::Models::CloudAutonomousVmClusterResourceDetails>]
    attr_accessor :cloud_autonomous_vm_clusters

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'cloud_exadata_infrastructure_id': :'cloudExadataInfrastructureId',
        'cloud_exadata_infrastructure_display_name': :'cloudExadataInfrastructureDisplayName',
        'local_storage_in_gbs': :'localStorageInGbs',
        'ocpus': :'ocpus',
        'memory_in_gbs': :'memoryInGBs',
        'exadata_storage_in_tbs': :'exadataStorageInTBs',
        'cloud_autonomous_vm_clusters': :'cloudAutonomousVmClusters'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'cloud_exadata_infrastructure_id': :'String',
        'cloud_exadata_infrastructure_display_name': :'String',
        'local_storage_in_gbs': :'Integer',
        'ocpus': :'Integer',
        'memory_in_gbs': :'Integer',
        'exadata_storage_in_tbs': :'Float',
        'cloud_autonomous_vm_clusters': :'Array<OCI::Database::Models::CloudAutonomousVmClusterResourceDetails>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :cloud_exadata_infrastructure_id The value to assign to the {#cloud_exadata_infrastructure_id} property
    # @option attributes [String] :cloud_exadata_infrastructure_display_name The value to assign to the {#cloud_exadata_infrastructure_display_name} property
    # @option attributes [Integer] :local_storage_in_gbs The value to assign to the {#local_storage_in_gbs} property
    # @option attributes [Integer] :ocpus The value to assign to the {#ocpus} property
    # @option attributes [Integer] :memory_in_gbs The value to assign to the {#memory_in_gbs} property
    # @option attributes [Float] :exadata_storage_in_tbs The value to assign to the {#exadata_storage_in_tbs} property
    # @option attributes [Array<OCI::Database::Models::CloudAutonomousVmClusterResourceDetails>] :cloud_autonomous_vm_clusters The value to assign to the {#cloud_autonomous_vm_clusters} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.cloud_exadata_infrastructure_id = attributes[:'cloudExadataInfrastructureId'] if attributes[:'cloudExadataInfrastructureId']

      raise 'You cannot provide both :cloudExadataInfrastructureId and :cloud_exadata_infrastructure_id' if attributes.key?(:'cloudExadataInfrastructureId') && attributes.key?(:'cloud_exadata_infrastructure_id')

      self.cloud_exadata_infrastructure_id = attributes[:'cloud_exadata_infrastructure_id'] if attributes[:'cloud_exadata_infrastructure_id']

      self.cloud_exadata_infrastructure_display_name = attributes[:'cloudExadataInfrastructureDisplayName'] if attributes[:'cloudExadataInfrastructureDisplayName']

      raise 'You cannot provide both :cloudExadataInfrastructureDisplayName and :cloud_exadata_infrastructure_display_name' if attributes.key?(:'cloudExadataInfrastructureDisplayName') && attributes.key?(:'cloud_exadata_infrastructure_display_name')

      self.cloud_exadata_infrastructure_display_name = attributes[:'cloud_exadata_infrastructure_display_name'] if attributes[:'cloud_exadata_infrastructure_display_name']

      self.local_storage_in_gbs = attributes[:'localStorageInGbs'] if attributes[:'localStorageInGbs']

      raise 'You cannot provide both :localStorageInGbs and :local_storage_in_gbs' if attributes.key?(:'localStorageInGbs') && attributes.key?(:'local_storage_in_gbs')

      self.local_storage_in_gbs = attributes[:'local_storage_in_gbs'] if attributes[:'local_storage_in_gbs']

      self.ocpus = attributes[:'ocpus'] if attributes[:'ocpus']

      self.memory_in_gbs = attributes[:'memoryInGBs'] if attributes[:'memoryInGBs']

      raise 'You cannot provide both :memoryInGBs and :memory_in_gbs' if attributes.key?(:'memoryInGBs') && attributes.key?(:'memory_in_gbs')

      self.memory_in_gbs = attributes[:'memory_in_gbs'] if attributes[:'memory_in_gbs']

      self.exadata_storage_in_tbs = attributes[:'exadataStorageInTBs'] if attributes[:'exadataStorageInTBs']

      raise 'You cannot provide both :exadataStorageInTBs and :exadata_storage_in_tbs' if attributes.key?(:'exadataStorageInTBs') && attributes.key?(:'exadata_storage_in_tbs')

      self.exadata_storage_in_tbs = attributes[:'exadata_storage_in_tbs'] if attributes[:'exadata_storage_in_tbs']

      self.cloud_autonomous_vm_clusters = attributes[:'cloudAutonomousVmClusters'] if attributes[:'cloudAutonomousVmClusters']

      raise 'You cannot provide both :cloudAutonomousVmClusters and :cloud_autonomous_vm_clusters' if attributes.key?(:'cloudAutonomousVmClusters') && attributes.key?(:'cloud_autonomous_vm_clusters')

      self.cloud_autonomous_vm_clusters = attributes[:'cloud_autonomous_vm_clusters'] if attributes[:'cloud_autonomous_vm_clusters']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        cloud_exadata_infrastructure_id == other.cloud_exadata_infrastructure_id &&
        cloud_exadata_infrastructure_display_name == other.cloud_exadata_infrastructure_display_name &&
        local_storage_in_gbs == other.local_storage_in_gbs &&
        ocpus == other.ocpus &&
        memory_in_gbs == other.memory_in_gbs &&
        exadata_storage_in_tbs == other.exadata_storage_in_tbs &&
        cloud_autonomous_vm_clusters == other.cloud_autonomous_vm_clusters
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
      [cloud_exadata_infrastructure_id, cloud_exadata_infrastructure_display_name, local_storage_in_gbs, ocpus, memory_in_gbs, exadata_storage_in_tbs, cloud_autonomous_vm_clusters].hash
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
