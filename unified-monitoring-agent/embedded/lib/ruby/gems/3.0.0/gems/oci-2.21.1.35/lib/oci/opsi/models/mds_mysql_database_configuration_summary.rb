# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200630
require 'date'
require_relative 'database_configuration_summary'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Configuration Summary of a MDS MYSQL database.
  class Opsi::Models::MdsMysqlDatabaseConfigurationSummary < Opsi::Models::DatabaseConfigurationSummary
    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the database.
    # @return [String]
    attr_accessor :database_id

    # **[Required]** Specifies if MYSQL DB System has heatwave cluster attached.
    # @return [BOOLEAN]
    attr_accessor :is_heat_wave_cluster_attached

    # **[Required]** Specifies if MYSQL DB System is highly available.
    # @return [BOOLEAN]
    attr_accessor :is_highly_available

    # **[Required]** The shape of the primary instances of MYSQL DB system. The shape determines resources allocated to a DB System - CPU cores
    # and memory for VM shapes; CPU cores, memory and storage for non-VM shapes.
    #
    # @return [String]
    attr_accessor :shape_name

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'database_insight_id': :'databaseInsightId',
        'entity_source': :'entitySource',
        'compartment_id': :'compartmentId',
        'database_name': :'databaseName',
        'database_display_name': :'databaseDisplayName',
        'database_type': :'databaseType',
        'database_version': :'databaseVersion',
        'cdb_name': :'cdbName',
        'defined_tags': :'definedTags',
        'freeform_tags': :'freeformTags',
        'processor_count': :'processorCount',
        'database_id': :'databaseId',
        'is_heat_wave_cluster_attached': :'isHeatWaveClusterAttached',
        'is_highly_available': :'isHighlyAvailable',
        'shape_name': :'shapeName'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'database_insight_id': :'String',
        'entity_source': :'String',
        'compartment_id': :'String',
        'database_name': :'String',
        'database_display_name': :'String',
        'database_type': :'String',
        'database_version': :'String',
        'cdb_name': :'String',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'freeform_tags': :'Hash<String, String>',
        'processor_count': :'Integer',
        'database_id': :'String',
        'is_heat_wave_cluster_attached': :'BOOLEAN',
        'is_highly_available': :'BOOLEAN',
        'shape_name': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :database_insight_id The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#database_insight_id #database_insight_id} proprety
    # @option attributes [String] :compartment_id The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#compartment_id #compartment_id} proprety
    # @option attributes [String] :database_name The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#database_name #database_name} proprety
    # @option attributes [String] :database_display_name The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#database_display_name #database_display_name} proprety
    # @option attributes [String] :database_type The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#database_type #database_type} proprety
    # @option attributes [String] :database_version The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#database_version #database_version} proprety
    # @option attributes [String] :cdb_name The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#cdb_name #cdb_name} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#defined_tags #defined_tags} proprety
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#freeform_tags #freeform_tags} proprety
    # @option attributes [Integer] :processor_count The value to assign to the {OCI::Opsi::Models::DatabaseConfigurationSummary#processor_count #processor_count} proprety
    # @option attributes [String] :database_id The value to assign to the {#database_id} property
    # @option attributes [BOOLEAN] :is_heat_wave_cluster_attached The value to assign to the {#is_heat_wave_cluster_attached} property
    # @option attributes [BOOLEAN] :is_highly_available The value to assign to the {#is_highly_available} property
    # @option attributes [String] :shape_name The value to assign to the {#shape_name} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['entitySource'] = 'MDS_MYSQL_DATABASE_SYSTEM'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.database_id = attributes[:'databaseId'] if attributes[:'databaseId']

      raise 'You cannot provide both :databaseId and :database_id' if attributes.key?(:'databaseId') && attributes.key?(:'database_id')

      self.database_id = attributes[:'database_id'] if attributes[:'database_id']

      self.is_heat_wave_cluster_attached = attributes[:'isHeatWaveClusterAttached'] unless attributes[:'isHeatWaveClusterAttached'].nil?
      self.is_heat_wave_cluster_attached = false if is_heat_wave_cluster_attached.nil? && !attributes.key?(:'isHeatWaveClusterAttached') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isHeatWaveClusterAttached and :is_heat_wave_cluster_attached' if attributes.key?(:'isHeatWaveClusterAttached') && attributes.key?(:'is_heat_wave_cluster_attached')

      self.is_heat_wave_cluster_attached = attributes[:'is_heat_wave_cluster_attached'] unless attributes[:'is_heat_wave_cluster_attached'].nil?
      self.is_heat_wave_cluster_attached = false if is_heat_wave_cluster_attached.nil? && !attributes.key?(:'isHeatWaveClusterAttached') && !attributes.key?(:'is_heat_wave_cluster_attached') # rubocop:disable Style/StringLiterals

      self.is_highly_available = attributes[:'isHighlyAvailable'] unless attributes[:'isHighlyAvailable'].nil?
      self.is_highly_available = false if is_highly_available.nil? && !attributes.key?(:'isHighlyAvailable') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isHighlyAvailable and :is_highly_available' if attributes.key?(:'isHighlyAvailable') && attributes.key?(:'is_highly_available')

      self.is_highly_available = attributes[:'is_highly_available'] unless attributes[:'is_highly_available'].nil?
      self.is_highly_available = false if is_highly_available.nil? && !attributes.key?(:'isHighlyAvailable') && !attributes.key?(:'is_highly_available') # rubocop:disable Style/StringLiterals

      self.shape_name = attributes[:'shapeName'] if attributes[:'shapeName']

      raise 'You cannot provide both :shapeName and :shape_name' if attributes.key?(:'shapeName') && attributes.key?(:'shape_name')

      self.shape_name = attributes[:'shape_name'] if attributes[:'shape_name']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        database_insight_id == other.database_insight_id &&
        entity_source == other.entity_source &&
        compartment_id == other.compartment_id &&
        database_name == other.database_name &&
        database_display_name == other.database_display_name &&
        database_type == other.database_type &&
        database_version == other.database_version &&
        cdb_name == other.cdb_name &&
        defined_tags == other.defined_tags &&
        freeform_tags == other.freeform_tags &&
        processor_count == other.processor_count &&
        database_id == other.database_id &&
        is_heat_wave_cluster_attached == other.is_heat_wave_cluster_attached &&
        is_highly_available == other.is_highly_available &&
        shape_name == other.shape_name
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
      [database_insight_id, entity_source, compartment_id, database_name, database_display_name, database_type, database_version, cdb_name, defined_tags, freeform_tags, processor_count, database_id, is_heat_wave_cluster_attached, is_highly_available, shape_name].hash
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
