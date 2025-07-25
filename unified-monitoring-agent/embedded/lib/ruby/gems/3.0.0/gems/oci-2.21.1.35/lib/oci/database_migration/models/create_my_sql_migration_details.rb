# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230518
require 'date'
require_relative 'create_migration_details'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Create Migration resource parameters.
  class DatabaseMigration::Models::CreateMySqlMigrationDetails < DatabaseMigration::Models::CreateMigrationDetails
    # @return [OCI::DatabaseMigration::Models::CreateMySqlDataTransferMediumDetails]
    attr_accessor :data_transfer_medium_details

    # @return [OCI::DatabaseMigration::Models::CreateMySqlInitialLoadSettings]
    attr_accessor :initial_load_settings

    # @return [OCI::DatabaseMigration::Models::CreateMySqlAdvisorSettings]
    attr_accessor :advisor_settings

    # Database objects to exclude from migration, cannot be specified alongside 'includeObjects'
    # @return [Array<OCI::DatabaseMigration::Models::MySqlDatabaseObject>]
    attr_accessor :exclude_objects

    # Database objects to include from migration, cannot be specified alongside 'excludeObjects'
    # @return [Array<OCI::DatabaseMigration::Models::MySqlDatabaseObject>]
    attr_accessor :include_objects

    # Specifies the database objects to be excluded from the migration in bulk.
    # The definition accepts input in a CSV format, newline separated for each entry.
    # More details can be found in the documentation.
    #
    # @return [String]
    attr_accessor :bulk_include_exclude_data

    # @return [OCI::DatabaseMigration::Models::CreateGoldenGateHubDetails]
    attr_accessor :hub_details

    # @return [OCI::DatabaseMigration::Models::CreateMySqlGgsDeploymentDetails]
    attr_accessor :ggs_details

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'description': :'description',
        'compartment_id': :'compartmentId',
        'database_combination': :'databaseCombination',
        'type': :'type',
        'display_name': :'displayName',
        'source_database_connection_id': :'sourceDatabaseConnectionId',
        'target_database_connection_id': :'targetDatabaseConnectionId',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'data_transfer_medium_details': :'dataTransferMediumDetails',
        'initial_load_settings': :'initialLoadSettings',
        'advisor_settings': :'advisorSettings',
        'exclude_objects': :'excludeObjects',
        'include_objects': :'includeObjects',
        'bulk_include_exclude_data': :'bulkIncludeExcludeData',
        'hub_details': :'hubDetails',
        'ggs_details': :'ggsDetails'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'description': :'String',
        'compartment_id': :'String',
        'database_combination': :'String',
        'type': :'String',
        'display_name': :'String',
        'source_database_connection_id': :'String',
        'target_database_connection_id': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'data_transfer_medium_details': :'OCI::DatabaseMigration::Models::CreateMySqlDataTransferMediumDetails',
        'initial_load_settings': :'OCI::DatabaseMigration::Models::CreateMySqlInitialLoadSettings',
        'advisor_settings': :'OCI::DatabaseMigration::Models::CreateMySqlAdvisorSettings',
        'exclude_objects': :'Array<OCI::DatabaseMigration::Models::MySqlDatabaseObject>',
        'include_objects': :'Array<OCI::DatabaseMigration::Models::MySqlDatabaseObject>',
        'bulk_include_exclude_data': :'String',
        'hub_details': :'OCI::DatabaseMigration::Models::CreateGoldenGateHubDetails',
        'ggs_details': :'OCI::DatabaseMigration::Models::CreateMySqlGgsDeploymentDetails'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :description The value to assign to the {OCI::DatabaseMigration::Models::CreateMigrationDetails#description #description} proprety
    # @option attributes [String] :compartment_id The value to assign to the {OCI::DatabaseMigration::Models::CreateMigrationDetails#compartment_id #compartment_id} proprety
    # @option attributes [String] :type The value to assign to the {OCI::DatabaseMigration::Models::CreateMigrationDetails#type #type} proprety
    # @option attributes [String] :display_name The value to assign to the {OCI::DatabaseMigration::Models::CreateMigrationDetails#display_name #display_name} proprety
    # @option attributes [String] :source_database_connection_id The value to assign to the {OCI::DatabaseMigration::Models::CreateMigrationDetails#source_database_connection_id #source_database_connection_id} proprety
    # @option attributes [String] :target_database_connection_id The value to assign to the {OCI::DatabaseMigration::Models::CreateMigrationDetails#target_database_connection_id #target_database_connection_id} proprety
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {OCI::DatabaseMigration::Models::CreateMigrationDetails#freeform_tags #freeform_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {OCI::DatabaseMigration::Models::CreateMigrationDetails#defined_tags #defined_tags} proprety
    # @option attributes [OCI::DatabaseMigration::Models::CreateMySqlDataTransferMediumDetails] :data_transfer_medium_details The value to assign to the {#data_transfer_medium_details} property
    # @option attributes [OCI::DatabaseMigration::Models::CreateMySqlInitialLoadSettings] :initial_load_settings The value to assign to the {#initial_load_settings} property
    # @option attributes [OCI::DatabaseMigration::Models::CreateMySqlAdvisorSettings] :advisor_settings The value to assign to the {#advisor_settings} property
    # @option attributes [Array<OCI::DatabaseMigration::Models::MySqlDatabaseObject>] :exclude_objects The value to assign to the {#exclude_objects} property
    # @option attributes [Array<OCI::DatabaseMigration::Models::MySqlDatabaseObject>] :include_objects The value to assign to the {#include_objects} property
    # @option attributes [String] :bulk_include_exclude_data The value to assign to the {#bulk_include_exclude_data} property
    # @option attributes [OCI::DatabaseMigration::Models::CreateGoldenGateHubDetails] :hub_details The value to assign to the {#hub_details} property
    # @option attributes [OCI::DatabaseMigration::Models::CreateMySqlGgsDeploymentDetails] :ggs_details The value to assign to the {#ggs_details} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['databaseCombination'] = 'MYSQL'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.data_transfer_medium_details = attributes[:'dataTransferMediumDetails'] if attributes[:'dataTransferMediumDetails']

      raise 'You cannot provide both :dataTransferMediumDetails and :data_transfer_medium_details' if attributes.key?(:'dataTransferMediumDetails') && attributes.key?(:'data_transfer_medium_details')

      self.data_transfer_medium_details = attributes[:'data_transfer_medium_details'] if attributes[:'data_transfer_medium_details']

      self.initial_load_settings = attributes[:'initialLoadSettings'] if attributes[:'initialLoadSettings']

      raise 'You cannot provide both :initialLoadSettings and :initial_load_settings' if attributes.key?(:'initialLoadSettings') && attributes.key?(:'initial_load_settings')

      self.initial_load_settings = attributes[:'initial_load_settings'] if attributes[:'initial_load_settings']

      self.advisor_settings = attributes[:'advisorSettings'] if attributes[:'advisorSettings']

      raise 'You cannot provide both :advisorSettings and :advisor_settings' if attributes.key?(:'advisorSettings') && attributes.key?(:'advisor_settings')

      self.advisor_settings = attributes[:'advisor_settings'] if attributes[:'advisor_settings']

      self.exclude_objects = attributes[:'excludeObjects'] if attributes[:'excludeObjects']

      raise 'You cannot provide both :excludeObjects and :exclude_objects' if attributes.key?(:'excludeObjects') && attributes.key?(:'exclude_objects')

      self.exclude_objects = attributes[:'exclude_objects'] if attributes[:'exclude_objects']

      self.include_objects = attributes[:'includeObjects'] if attributes[:'includeObjects']

      raise 'You cannot provide both :includeObjects and :include_objects' if attributes.key?(:'includeObjects') && attributes.key?(:'include_objects')

      self.include_objects = attributes[:'include_objects'] if attributes[:'include_objects']

      self.bulk_include_exclude_data = attributes[:'bulkIncludeExcludeData'] if attributes[:'bulkIncludeExcludeData']

      raise 'You cannot provide both :bulkIncludeExcludeData and :bulk_include_exclude_data' if attributes.key?(:'bulkIncludeExcludeData') && attributes.key?(:'bulk_include_exclude_data')

      self.bulk_include_exclude_data = attributes[:'bulk_include_exclude_data'] if attributes[:'bulk_include_exclude_data']

      self.hub_details = attributes[:'hubDetails'] if attributes[:'hubDetails']

      raise 'You cannot provide both :hubDetails and :hub_details' if attributes.key?(:'hubDetails') && attributes.key?(:'hub_details')

      self.hub_details = attributes[:'hub_details'] if attributes[:'hub_details']

      self.ggs_details = attributes[:'ggsDetails'] if attributes[:'ggsDetails']

      raise 'You cannot provide both :ggsDetails and :ggs_details' if attributes.key?(:'ggsDetails') && attributes.key?(:'ggs_details')

      self.ggs_details = attributes[:'ggs_details'] if attributes[:'ggs_details']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        description == other.description &&
        compartment_id == other.compartment_id &&
        database_combination == other.database_combination &&
        type == other.type &&
        display_name == other.display_name &&
        source_database_connection_id == other.source_database_connection_id &&
        target_database_connection_id == other.target_database_connection_id &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        data_transfer_medium_details == other.data_transfer_medium_details &&
        initial_load_settings == other.initial_load_settings &&
        advisor_settings == other.advisor_settings &&
        exclude_objects == other.exclude_objects &&
        include_objects == other.include_objects &&
        bulk_include_exclude_data == other.bulk_include_exclude_data &&
        hub_details == other.hub_details &&
        ggs_details == other.ggs_details
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
      [description, compartment_id, database_combination, type, display_name, source_database_connection_id, target_database_connection_id, freeform_tags, defined_tags, data_transfer_medium_details, initial_load_settings, advisor_settings, exclude_objects, include_objects, bulk_include_exclude_data, hub_details, ggs_details].hash
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
