# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20180828
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details about a cluster backup event.
  class Opensearch::Models::BackupEventDetails
    BACKUP_STATE_ENUM = [
      BACKUP_STATE_DELETED = 'DELETED'.freeze,
      BACKUP_STATE_SUCCESS = 'SUCCESS'.freeze,
      BACKUP_STATE_FAILED = 'FAILED'.freeze
    ].freeze

    # **[Required]** The OCID of the OpenSearch cluster for the cluster backup.
    # @return [String]
    attr_accessor :cluster_id

    # **[Required]** The result of the cluster backup operation.
    # @return [String]
    attr_reader :backup_state

    # The name of the cluster backup.
    # @return [String]
    attr_accessor :snapshot_name

    # **[Required]** The date and time the cluster backup event started. Format defined by [RFC3339](https://tools.ietf.org/html/rfc3339).
    # @return [DateTime]
    attr_accessor :time_started

    # **[Required]** The date and time the cluster backup event started. Format defined by [RFC3339](https://tools.ietf.org/html/rfc3339).
    # @return [DateTime]
    attr_accessor :time_ended

    # The cluster backup size in GB.
    # @return [Float]
    attr_accessor :backup_size

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'cluster_id': :'clusterId',
        'backup_state': :'backupState',
        'snapshot_name': :'snapshotName',
        'time_started': :'timeStarted',
        'time_ended': :'timeEnded',
        'backup_size': :'backupSize'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'cluster_id': :'String',
        'backup_state': :'String',
        'snapshot_name': :'String',
        'time_started': :'DateTime',
        'time_ended': :'DateTime',
        'backup_size': :'Float'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :cluster_id The value to assign to the {#cluster_id} property
    # @option attributes [String] :backup_state The value to assign to the {#backup_state} property
    # @option attributes [String] :snapshot_name The value to assign to the {#snapshot_name} property
    # @option attributes [DateTime] :time_started The value to assign to the {#time_started} property
    # @option attributes [DateTime] :time_ended The value to assign to the {#time_ended} property
    # @option attributes [Float] :backup_size The value to assign to the {#backup_size} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.cluster_id = attributes[:'clusterId'] if attributes[:'clusterId']

      raise 'You cannot provide both :clusterId and :cluster_id' if attributes.key?(:'clusterId') && attributes.key?(:'cluster_id')

      self.cluster_id = attributes[:'cluster_id'] if attributes[:'cluster_id']

      self.backup_state = attributes[:'backupState'] if attributes[:'backupState']

      raise 'You cannot provide both :backupState and :backup_state' if attributes.key?(:'backupState') && attributes.key?(:'backup_state')

      self.backup_state = attributes[:'backup_state'] if attributes[:'backup_state']

      self.snapshot_name = attributes[:'snapshotName'] if attributes[:'snapshotName']

      raise 'You cannot provide both :snapshotName and :snapshot_name' if attributes.key?(:'snapshotName') && attributes.key?(:'snapshot_name')

      self.snapshot_name = attributes[:'snapshot_name'] if attributes[:'snapshot_name']

      self.time_started = attributes[:'timeStarted'] if attributes[:'timeStarted']

      raise 'You cannot provide both :timeStarted and :time_started' if attributes.key?(:'timeStarted') && attributes.key?(:'time_started')

      self.time_started = attributes[:'time_started'] if attributes[:'time_started']

      self.time_ended = attributes[:'timeEnded'] if attributes[:'timeEnded']

      raise 'You cannot provide both :timeEnded and :time_ended' if attributes.key?(:'timeEnded') && attributes.key?(:'time_ended')

      self.time_ended = attributes[:'time_ended'] if attributes[:'time_ended']

      self.backup_size = attributes[:'backupSize'] if attributes[:'backupSize']

      raise 'You cannot provide both :backupSize and :backup_size' if attributes.key?(:'backupSize') && attributes.key?(:'backup_size')

      self.backup_size = attributes[:'backup_size'] if attributes[:'backup_size']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] backup_state Object to be assigned
    def backup_state=(backup_state)
      raise "Invalid value for 'backup_state': this must be one of the values in BACKUP_STATE_ENUM." if backup_state && !BACKUP_STATE_ENUM.include?(backup_state)

      @backup_state = backup_state
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        cluster_id == other.cluster_id &&
        backup_state == other.backup_state &&
        snapshot_name == other.snapshot_name &&
        time_started == other.time_started &&
        time_ended == other.time_ended &&
        backup_size == other.backup_size
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
      [cluster_id, backup_state, snapshot_name, time_started, time_ended, backup_size].hash
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
