# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230518
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Database objects to include or exclude from migration
  class DatabaseMigration::Models::OracleDatabaseObject
    # **[Required]** Owner of the object (regular expression is allowed)
    # @return [String]
    attr_accessor :owner

    # **[Required]** Name of the object (regular expression is allowed)
    # @return [String]
    attr_accessor :object_name

    # Type of object to exclude.
    # If not specified, matching owners and object names of type TABLE would be excluded.
    #
    # @return [String]
    attr_accessor :type

    # Whether an excluded table should be omitted from replication. Only valid for database objects
    # that have are of type TABLE and object status EXCLUDE.
    #
    # @return [BOOLEAN]
    attr_accessor :is_omit_excluded_table_from_replication

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'owner': :'owner',
        'object_name': :'objectName',
        'type': :'type',
        'is_omit_excluded_table_from_replication': :'isOmitExcludedTableFromReplication'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'owner': :'String',
        'object_name': :'String',
        'type': :'String',
        'is_omit_excluded_table_from_replication': :'BOOLEAN'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :owner The value to assign to the {#owner} property
    # @option attributes [String] :object_name The value to assign to the {#object_name} property
    # @option attributes [String] :type The value to assign to the {#type} property
    # @option attributes [BOOLEAN] :is_omit_excluded_table_from_replication The value to assign to the {#is_omit_excluded_table_from_replication} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.owner = attributes[:'owner'] if attributes[:'owner']

      self.object_name = attributes[:'objectName'] if attributes[:'objectName']

      raise 'You cannot provide both :objectName and :object_name' if attributes.key?(:'objectName') && attributes.key?(:'object_name')

      self.object_name = attributes[:'object_name'] if attributes[:'object_name']

      self.type = attributes[:'type'] if attributes[:'type']

      self.is_omit_excluded_table_from_replication = attributes[:'isOmitExcludedTableFromReplication'] unless attributes[:'isOmitExcludedTableFromReplication'].nil?
      self.is_omit_excluded_table_from_replication = false if is_omit_excluded_table_from_replication.nil? && !attributes.key?(:'isOmitExcludedTableFromReplication') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isOmitExcludedTableFromReplication and :is_omit_excluded_table_from_replication' if attributes.key?(:'isOmitExcludedTableFromReplication') && attributes.key?(:'is_omit_excluded_table_from_replication')

      self.is_omit_excluded_table_from_replication = attributes[:'is_omit_excluded_table_from_replication'] unless attributes[:'is_omit_excluded_table_from_replication'].nil?
      self.is_omit_excluded_table_from_replication = false if is_omit_excluded_table_from_replication.nil? && !attributes.key?(:'isOmitExcludedTableFromReplication') && !attributes.key?(:'is_omit_excluded_table_from_replication') # rubocop:disable Style/StringLiterals
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        owner == other.owner &&
        object_name == other.object_name &&
        type == other.type &&
        is_omit_excluded_table_from_replication == other.is_omit_excluded_table_from_replication
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
      [owner, object_name, type, is_omit_excluded_table_from_replication].hash
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
