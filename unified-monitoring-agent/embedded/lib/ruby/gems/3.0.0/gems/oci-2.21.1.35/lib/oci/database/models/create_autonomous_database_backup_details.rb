# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details to create an Oracle Autonomous Database backup.
  #
  # **Warning:** Oracle recommends that you avoid using any confidential information when you supply string values using the API.
  #
  class Database::Models::CreateAutonomousDatabaseBackupDetails
    # The user-friendly name for the backup. The name does not have to be unique.
    # @return [String]
    attr_accessor :display_name

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the Autonomous Database backup.
    # @return [String]
    attr_accessor :autonomous_database_id

    # Retention period, in days, for long-term backups
    # @return [Integer]
    attr_accessor :retention_period_in_days

    # Indicates whether the backup is long-term
    # @return [BOOLEAN]
    attr_accessor :is_long_term_backup

    # @return [OCI::Database::Models::BackupDestinationDetails]
    attr_accessor :backup_destination_details

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'displayName',
        'autonomous_database_id': :'autonomousDatabaseId',
        'retention_period_in_days': :'retentionPeriodInDays',
        'is_long_term_backup': :'isLongTermBackup',
        'backup_destination_details': :'backupDestinationDetails'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'String',
        'autonomous_database_id': :'String',
        'retention_period_in_days': :'Integer',
        'is_long_term_backup': :'BOOLEAN',
        'backup_destination_details': :'OCI::Database::Models::BackupDestinationDetails'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :autonomous_database_id The value to assign to the {#autonomous_database_id} property
    # @option attributes [Integer] :retention_period_in_days The value to assign to the {#retention_period_in_days} property
    # @option attributes [BOOLEAN] :is_long_term_backup The value to assign to the {#is_long_term_backup} property
    # @option attributes [OCI::Database::Models::BackupDestinationDetails] :backup_destination_details The value to assign to the {#backup_destination_details} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.autonomous_database_id = attributes[:'autonomousDatabaseId'] if attributes[:'autonomousDatabaseId']

      raise 'You cannot provide both :autonomousDatabaseId and :autonomous_database_id' if attributes.key?(:'autonomousDatabaseId') && attributes.key?(:'autonomous_database_id')

      self.autonomous_database_id = attributes[:'autonomous_database_id'] if attributes[:'autonomous_database_id']

      self.retention_period_in_days = attributes[:'retentionPeriodInDays'] if attributes[:'retentionPeriodInDays']

      raise 'You cannot provide both :retentionPeriodInDays and :retention_period_in_days' if attributes.key?(:'retentionPeriodInDays') && attributes.key?(:'retention_period_in_days')

      self.retention_period_in_days = attributes[:'retention_period_in_days'] if attributes[:'retention_period_in_days']

      self.is_long_term_backup = attributes[:'isLongTermBackup'] unless attributes[:'isLongTermBackup'].nil?

      raise 'You cannot provide both :isLongTermBackup and :is_long_term_backup' if attributes.key?(:'isLongTermBackup') && attributes.key?(:'is_long_term_backup')

      self.is_long_term_backup = attributes[:'is_long_term_backup'] unless attributes[:'is_long_term_backup'].nil?

      self.backup_destination_details = attributes[:'backupDestinationDetails'] if attributes[:'backupDestinationDetails']

      raise 'You cannot provide both :backupDestinationDetails and :backup_destination_details' if attributes.key?(:'backupDestinationDetails') && attributes.key?(:'backup_destination_details')

      self.backup_destination_details = attributes[:'backup_destination_details'] if attributes[:'backup_destination_details']
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
        autonomous_database_id == other.autonomous_database_id &&
        retention_period_in_days == other.retention_period_in_days &&
        is_long_term_backup == other.is_long_term_backup &&
        backup_destination_details == other.backup_destination_details
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
      [display_name, autonomous_database_id, retention_period_in_days, is_long_term_backup, backup_destination_details].hash
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
