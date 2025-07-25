# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Configurations of a Disaster Recovery.
  class Database::Models::DisasterRecoveryConfiguration
    DISASTER_RECOVERY_TYPE_ENUM = [
      DISASTER_RECOVERY_TYPE_ADG = 'ADG'.freeze,
      DISASTER_RECOVERY_TYPE_BACKUP_BASED = 'BACKUP_BASED'.freeze,
      DISASTER_RECOVERY_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # Indicates the disaster recovery (DR) type of the Autonomous Database Serverless instance.
    # Autonomous Data Guard (ADG) DR type provides business critical DR with a faster recovery time objective (RTO) during failover or switchover.
    # Backup-based DR type provides lower cost DR with a slower RTO during failover or switchover.
    #
    # @return [String]
    attr_reader :disaster_recovery_type

    # Time and date stored as an RFC 3339 formatted timestamp string. For example, 2022-01-01T12:00:00.000Z would set a limit for the snapshot standby to be converted back to a cross-region standby database.
    # @return [DateTime]
    attr_accessor :time_snapshot_standby_enabled_till

    # Indicates if user wants to convert to a snapshot standby. For example, true would set a standby database to snapshot standby database. False would set a snapshot standby database back to regular standby database.
    #
    # @return [BOOLEAN]
    attr_accessor :is_snapshot_standby

    # If true, 7 days worth of backups are replicated across regions for Cross-Region ADB or Backup-Based DR between Primary and Standby. If false, the backups taken on the Primary are not replicated to the Standby database.
    # @return [BOOLEAN]
    attr_accessor :is_replicate_automatic_backups

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'disaster_recovery_type': :'disasterRecoveryType',
        'time_snapshot_standby_enabled_till': :'timeSnapshotStandbyEnabledTill',
        'is_snapshot_standby': :'isSnapshotStandby',
        'is_replicate_automatic_backups': :'isReplicateAutomaticBackups'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'disaster_recovery_type': :'String',
        'time_snapshot_standby_enabled_till': :'DateTime',
        'is_snapshot_standby': :'BOOLEAN',
        'is_replicate_automatic_backups': :'BOOLEAN'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :disaster_recovery_type The value to assign to the {#disaster_recovery_type} property
    # @option attributes [DateTime] :time_snapshot_standby_enabled_till The value to assign to the {#time_snapshot_standby_enabled_till} property
    # @option attributes [BOOLEAN] :is_snapshot_standby The value to assign to the {#is_snapshot_standby} property
    # @option attributes [BOOLEAN] :is_replicate_automatic_backups The value to assign to the {#is_replicate_automatic_backups} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.disaster_recovery_type = attributes[:'disasterRecoveryType'] if attributes[:'disasterRecoveryType']

      raise 'You cannot provide both :disasterRecoveryType and :disaster_recovery_type' if attributes.key?(:'disasterRecoveryType') && attributes.key?(:'disaster_recovery_type')

      self.disaster_recovery_type = attributes[:'disaster_recovery_type'] if attributes[:'disaster_recovery_type']

      self.time_snapshot_standby_enabled_till = attributes[:'timeSnapshotStandbyEnabledTill'] if attributes[:'timeSnapshotStandbyEnabledTill']

      raise 'You cannot provide both :timeSnapshotStandbyEnabledTill and :time_snapshot_standby_enabled_till' if attributes.key?(:'timeSnapshotStandbyEnabledTill') && attributes.key?(:'time_snapshot_standby_enabled_till')

      self.time_snapshot_standby_enabled_till = attributes[:'time_snapshot_standby_enabled_till'] if attributes[:'time_snapshot_standby_enabled_till']

      self.is_snapshot_standby = attributes[:'isSnapshotStandby'] unless attributes[:'isSnapshotStandby'].nil?

      raise 'You cannot provide both :isSnapshotStandby and :is_snapshot_standby' if attributes.key?(:'isSnapshotStandby') && attributes.key?(:'is_snapshot_standby')

      self.is_snapshot_standby = attributes[:'is_snapshot_standby'] unless attributes[:'is_snapshot_standby'].nil?

      self.is_replicate_automatic_backups = attributes[:'isReplicateAutomaticBackups'] unless attributes[:'isReplicateAutomaticBackups'].nil?

      raise 'You cannot provide both :isReplicateAutomaticBackups and :is_replicate_automatic_backups' if attributes.key?(:'isReplicateAutomaticBackups') && attributes.key?(:'is_replicate_automatic_backups')

      self.is_replicate_automatic_backups = attributes[:'is_replicate_automatic_backups'] unless attributes[:'is_replicate_automatic_backups'].nil?
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] disaster_recovery_type Object to be assigned
    def disaster_recovery_type=(disaster_recovery_type)
      # rubocop:disable Style/ConditionalAssignment
      if disaster_recovery_type && !DISASTER_RECOVERY_TYPE_ENUM.include?(disaster_recovery_type)
        OCI.logger.debug("Unknown value for 'disaster_recovery_type' [" + disaster_recovery_type + "]. Mapping to 'DISASTER_RECOVERY_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @disaster_recovery_type = DISASTER_RECOVERY_TYPE_UNKNOWN_ENUM_VALUE
      else
        @disaster_recovery_type = disaster_recovery_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        disaster_recovery_type == other.disaster_recovery_type &&
        time_snapshot_standby_enabled_till == other.time_snapshot_standby_enabled_till &&
        is_snapshot_standby == other.is_snapshot_standby &&
        is_replicate_automatic_backups == other.is_replicate_automatic_backups
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
      [disaster_recovery_type, time_snapshot_standby_enabled_till, is_snapshot_standby, is_replicate_automatic_backups].hash
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
