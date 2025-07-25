# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230518
require 'date'
require_relative 'update_oracle_data_transfer_medium_details'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # OCI Object Storage bucket will be used to store Data Pump dump files for the migration.
  class DatabaseMigration::Models::UpdateOracleNfsDataTransferMediumDetails < DatabaseMigration::Models::UpdateOracleDataTransferMediumDetails
    # @return [OCI::DatabaseMigration::Models::UpdateObjectStoreBucket]
    attr_accessor :object_storage_bucket

    # @return [OCI::DatabaseMigration::Models::HostDumpTransferDetails]
    attr_accessor :source

    # @return [OCI::DatabaseMigration::Models::HostDumpTransferDetails]
    attr_accessor :target

    # OCID of the shared storage mount target
    #
    # @return [String]
    attr_accessor :shared_storage_mount_target_id

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'type': :'type',
        'object_storage_bucket': :'objectStorageBucket',
        'source': :'source',
        'target': :'target',
        'shared_storage_mount_target_id': :'sharedStorageMountTargetId'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'type': :'String',
        'object_storage_bucket': :'OCI::DatabaseMigration::Models::UpdateObjectStoreBucket',
        'source': :'OCI::DatabaseMigration::Models::HostDumpTransferDetails',
        'target': :'OCI::DatabaseMigration::Models::HostDumpTransferDetails',
        'shared_storage_mount_target_id': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [OCI::DatabaseMigration::Models::UpdateObjectStoreBucket] :object_storage_bucket The value to assign to the {#object_storage_bucket} property
    # @option attributes [OCI::DatabaseMigration::Models::HostDumpTransferDetails] :source The value to assign to the {#source} property
    # @option attributes [OCI::DatabaseMigration::Models::HostDumpTransferDetails] :target The value to assign to the {#target} property
    # @option attributes [String] :shared_storage_mount_target_id The value to assign to the {#shared_storage_mount_target_id} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['type'] = 'NFS'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.object_storage_bucket = attributes[:'objectStorageBucket'] if attributes[:'objectStorageBucket']

      raise 'You cannot provide both :objectStorageBucket and :object_storage_bucket' if attributes.key?(:'objectStorageBucket') && attributes.key?(:'object_storage_bucket')

      self.object_storage_bucket = attributes[:'object_storage_bucket'] if attributes[:'object_storage_bucket']

      self.source = attributes[:'source'] if attributes[:'source']

      self.target = attributes[:'target'] if attributes[:'target']

      self.shared_storage_mount_target_id = attributes[:'sharedStorageMountTargetId'] if attributes[:'sharedStorageMountTargetId']

      raise 'You cannot provide both :sharedStorageMountTargetId and :shared_storage_mount_target_id' if attributes.key?(:'sharedStorageMountTargetId') && attributes.key?(:'shared_storage_mount_target_id')

      self.shared_storage_mount_target_id = attributes[:'shared_storage_mount_target_id'] if attributes[:'shared_storage_mount_target_id']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        type == other.type &&
        object_storage_bucket == other.object_storage_bucket &&
        source == other.source &&
        target == other.target &&
        shared_storage_mount_target_id == other.shared_storage_mount_target_id
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
      [type, object_storage_bucket, source, target, shared_storage_mount_target_id].hash
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
