# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20201101
require 'date'
require_relative 'database_feature_details'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The details required to enable the Diagnostics and Management feature.
  class DatabaseManagement::Models::DatabaseDiagnosticsAndManagementFeatureDetails < DatabaseManagement::Models::DatabaseFeatureDetails
    MANAGEMENT_TYPE_ENUM = [
      MANAGEMENT_TYPE_BASIC = 'BASIC'.freeze,
      MANAGEMENT_TYPE_ADVANCED = 'ADVANCED'.freeze
    ].freeze

    # **[Required]** The management type for the database.
    # @return [String]
    attr_reader :management_type

    # Indicates whether the pluggable database can be enabled automatically.
    # @return [BOOLEAN]
    attr_accessor :is_auto_enable_pluggable_database

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'feature': :'feature',
        'database_connection_details': :'databaseConnectionDetails',
        'connector_details': :'connectorDetails',
        'management_type': :'managementType',
        'is_auto_enable_pluggable_database': :'isAutoEnablePluggableDatabase'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'feature': :'String',
        'database_connection_details': :'OCI::DatabaseManagement::Models::DatabaseConnectionDetails',
        'connector_details': :'OCI::DatabaseManagement::Models::ConnectorDetails',
        'management_type': :'String',
        'is_auto_enable_pluggable_database': :'BOOLEAN'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [OCI::DatabaseManagement::Models::DatabaseConnectionDetails] :database_connection_details The value to assign to the {OCI::DatabaseManagement::Models::DatabaseFeatureDetails#database_connection_details #database_connection_details} proprety
    # @option attributes [OCI::DatabaseManagement::Models::ConnectorDetails] :connector_details The value to assign to the {OCI::DatabaseManagement::Models::DatabaseFeatureDetails#connector_details #connector_details} proprety
    # @option attributes [String] :management_type The value to assign to the {#management_type} property
    # @option attributes [BOOLEAN] :is_auto_enable_pluggable_database The value to assign to the {#is_auto_enable_pluggable_database} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['feature'] = 'DIAGNOSTICS_AND_MANAGEMENT'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.management_type = attributes[:'managementType'] if attributes[:'managementType']

      raise 'You cannot provide both :managementType and :management_type' if attributes.key?(:'managementType') && attributes.key?(:'management_type')

      self.management_type = attributes[:'management_type'] if attributes[:'management_type']

      self.is_auto_enable_pluggable_database = attributes[:'isAutoEnablePluggableDatabase'] unless attributes[:'isAutoEnablePluggableDatabase'].nil?

      raise 'You cannot provide both :isAutoEnablePluggableDatabase and :is_auto_enable_pluggable_database' if attributes.key?(:'isAutoEnablePluggableDatabase') && attributes.key?(:'is_auto_enable_pluggable_database')

      self.is_auto_enable_pluggable_database = attributes[:'is_auto_enable_pluggable_database'] unless attributes[:'is_auto_enable_pluggable_database'].nil?
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] management_type Object to be assigned
    def management_type=(management_type)
      raise "Invalid value for 'management_type': this must be one of the values in MANAGEMENT_TYPE_ENUM." if management_type && !MANAGEMENT_TYPE_ENUM.include?(management_type)

      @management_type = management_type
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        feature == other.feature &&
        database_connection_details == other.database_connection_details &&
        connector_details == other.connector_details &&
        management_type == other.management_type &&
        is_auto_enable_pluggable_database == other.is_auto_enable_pluggable_database
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
      [feature, database_connection_details, connector_details, management_type, is_auto_enable_pluggable_database].hash
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
