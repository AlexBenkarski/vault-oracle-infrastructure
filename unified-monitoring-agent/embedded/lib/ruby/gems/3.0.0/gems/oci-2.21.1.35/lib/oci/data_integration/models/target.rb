# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200430
require 'date'
require 'logger'
require_relative 'operator'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The information about the target operator. The target operator lets you specify the data entity to store the transformed data.
  class DataIntegration::Models::Target < DataIntegration::Models::Operator
    DATA_PROPERTY_ENUM = [
      DATA_PROPERTY_TRUNCATE = 'TRUNCATE'.freeze,
      DATA_PROPERTY_MERGE = 'MERGE'.freeze,
      DATA_PROPERTY_BACKUP = 'BACKUP'.freeze,
      DATA_PROPERTY_OVERWRITE = 'OVERWRITE'.freeze,
      DATA_PROPERTY_APPEND = 'APPEND'.freeze,
      DATA_PROPERTY_IGNORE = 'IGNORE'.freeze,
      DATA_PROPERTY_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # @return [OCI::DataIntegration::Models::DataEntity]
    attr_accessor :entity

    # Specifies the read access.
    # @return [BOOLEAN]
    attr_accessor :is_read_access

    # Specifies the copy fields.
    # @return [BOOLEAN]
    attr_accessor :is_copy_fields

    # Specifies if this uses a predefined shape.
    # @return [BOOLEAN]
    attr_accessor :is_predefined_shape

    # Specifies if entity name is the same as source.
    # @return [BOOLEAN]
    attr_accessor :is_use_same_source_name

    # Prefix for the entity Name.
    # @return [String]
    attr_accessor :target_entity_name_prefix

    # Suffix for the entity Name.
    # @return [String]
    attr_accessor :target_entity_name_suffix

    # Specifies the data property.
    # @return [String]
    attr_reader :data_property

    # @return [OCI::DataIntegration::Models::SchemaDriftConfig]
    attr_accessor :schema_drift_config

    # @return [OCI::DataIntegration::Models::Shape]
    attr_accessor :fixed_data_shape

    # @return [OCI::DataIntegration::Models::WriteOperationConfig]
    attr_accessor :write_operation_config

    # A numeric loading order number for the target.
    # @return [Integer]
    attr_accessor :load_order

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'model_type': :'modelType',
        'key': :'key',
        'model_version': :'modelVersion',
        'parent_ref': :'parentRef',
        'name': :'name',
        'description': :'description',
        'object_version': :'objectVersion',
        'input_ports': :'inputPorts',
        'output_ports': :'outputPorts',
        'object_status': :'objectStatus',
        'identifier': :'identifier',
        'parameters': :'parameters',
        'op_config_values': :'opConfigValues',
        'entity': :'entity',
        'is_read_access': :'isReadAccess',
        'is_copy_fields': :'isCopyFields',
        'is_predefined_shape': :'isPredefinedShape',
        'is_use_same_source_name': :'isUseSameSourceName',
        'target_entity_name_prefix': :'targetEntityNamePrefix',
        'target_entity_name_suffix': :'targetEntityNameSuffix',
        'data_property': :'dataProperty',
        'schema_drift_config': :'schemaDriftConfig',
        'fixed_data_shape': :'fixedDataShape',
        'write_operation_config': :'writeOperationConfig',
        'load_order': :'loadOrder'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'model_type': :'String',
        'key': :'String',
        'model_version': :'String',
        'parent_ref': :'OCI::DataIntegration::Models::ParentReference',
        'name': :'String',
        'description': :'String',
        'object_version': :'Integer',
        'input_ports': :'Array<OCI::DataIntegration::Models::InputPort>',
        'output_ports': :'Array<OCI::DataIntegration::Models::TypedObject>',
        'object_status': :'Integer',
        'identifier': :'String',
        'parameters': :'Array<OCI::DataIntegration::Models::Parameter>',
        'op_config_values': :'OCI::DataIntegration::Models::ConfigValues',
        'entity': :'OCI::DataIntegration::Models::DataEntity',
        'is_read_access': :'BOOLEAN',
        'is_copy_fields': :'BOOLEAN',
        'is_predefined_shape': :'BOOLEAN',
        'is_use_same_source_name': :'BOOLEAN',
        'target_entity_name_prefix': :'String',
        'target_entity_name_suffix': :'String',
        'data_property': :'String',
        'schema_drift_config': :'OCI::DataIntegration::Models::SchemaDriftConfig',
        'fixed_data_shape': :'OCI::DataIntegration::Models::Shape',
        'write_operation_config': :'OCI::DataIntegration::Models::WriteOperationConfig',
        'load_order': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :key The value to assign to the {OCI::DataIntegration::Models::Operator#key #key} proprety
    # @option attributes [String] :model_version The value to assign to the {OCI::DataIntegration::Models::Operator#model_version #model_version} proprety
    # @option attributes [OCI::DataIntegration::Models::ParentReference] :parent_ref The value to assign to the {OCI::DataIntegration::Models::Operator#parent_ref #parent_ref} proprety
    # @option attributes [String] :name The value to assign to the {OCI::DataIntegration::Models::Operator#name #name} proprety
    # @option attributes [String] :description The value to assign to the {OCI::DataIntegration::Models::Operator#description #description} proprety
    # @option attributes [Integer] :object_version The value to assign to the {OCI::DataIntegration::Models::Operator#object_version #object_version} proprety
    # @option attributes [Array<OCI::DataIntegration::Models::InputPort>] :input_ports The value to assign to the {OCI::DataIntegration::Models::Operator#input_ports #input_ports} proprety
    # @option attributes [Array<OCI::DataIntegration::Models::TypedObject>] :output_ports The value to assign to the {OCI::DataIntegration::Models::Operator#output_ports #output_ports} proprety
    # @option attributes [Integer] :object_status The value to assign to the {OCI::DataIntegration::Models::Operator#object_status #object_status} proprety
    # @option attributes [String] :identifier The value to assign to the {OCI::DataIntegration::Models::Operator#identifier #identifier} proprety
    # @option attributes [Array<OCI::DataIntegration::Models::Parameter>] :parameters The value to assign to the {OCI::DataIntegration::Models::Operator#parameters #parameters} proprety
    # @option attributes [OCI::DataIntegration::Models::ConfigValues] :op_config_values The value to assign to the {OCI::DataIntegration::Models::Operator#op_config_values #op_config_values} proprety
    # @option attributes [OCI::DataIntegration::Models::DataEntity] :entity The value to assign to the {#entity} property
    # @option attributes [BOOLEAN] :is_read_access The value to assign to the {#is_read_access} property
    # @option attributes [BOOLEAN] :is_copy_fields The value to assign to the {#is_copy_fields} property
    # @option attributes [BOOLEAN] :is_predefined_shape The value to assign to the {#is_predefined_shape} property
    # @option attributes [BOOLEAN] :is_use_same_source_name The value to assign to the {#is_use_same_source_name} property
    # @option attributes [String] :target_entity_name_prefix The value to assign to the {#target_entity_name_prefix} property
    # @option attributes [String] :target_entity_name_suffix The value to assign to the {#target_entity_name_suffix} property
    # @option attributes [String] :data_property The value to assign to the {#data_property} property
    # @option attributes [OCI::DataIntegration::Models::SchemaDriftConfig] :schema_drift_config The value to assign to the {#schema_drift_config} property
    # @option attributes [OCI::DataIntegration::Models::Shape] :fixed_data_shape The value to assign to the {#fixed_data_shape} property
    # @option attributes [OCI::DataIntegration::Models::WriteOperationConfig] :write_operation_config The value to assign to the {#write_operation_config} property
    # @option attributes [Integer] :load_order The value to assign to the {#load_order} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['modelType'] = 'TARGET_OPERATOR'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.entity = attributes[:'entity'] if attributes[:'entity']

      self.is_read_access = attributes[:'isReadAccess'] unless attributes[:'isReadAccess'].nil?

      raise 'You cannot provide both :isReadAccess and :is_read_access' if attributes.key?(:'isReadAccess') && attributes.key?(:'is_read_access')

      self.is_read_access = attributes[:'is_read_access'] unless attributes[:'is_read_access'].nil?

      self.is_copy_fields = attributes[:'isCopyFields'] unless attributes[:'isCopyFields'].nil?

      raise 'You cannot provide both :isCopyFields and :is_copy_fields' if attributes.key?(:'isCopyFields') && attributes.key?(:'is_copy_fields')

      self.is_copy_fields = attributes[:'is_copy_fields'] unless attributes[:'is_copy_fields'].nil?

      self.is_predefined_shape = attributes[:'isPredefinedShape'] unless attributes[:'isPredefinedShape'].nil?

      raise 'You cannot provide both :isPredefinedShape and :is_predefined_shape' if attributes.key?(:'isPredefinedShape') && attributes.key?(:'is_predefined_shape')

      self.is_predefined_shape = attributes[:'is_predefined_shape'] unless attributes[:'is_predefined_shape'].nil?

      self.is_use_same_source_name = attributes[:'isUseSameSourceName'] unless attributes[:'isUseSameSourceName'].nil?
      self.is_use_same_source_name = true if is_use_same_source_name.nil? && !attributes.key?(:'isUseSameSourceName') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isUseSameSourceName and :is_use_same_source_name' if attributes.key?(:'isUseSameSourceName') && attributes.key?(:'is_use_same_source_name')

      self.is_use_same_source_name = attributes[:'is_use_same_source_name'] unless attributes[:'is_use_same_source_name'].nil?
      self.is_use_same_source_name = true if is_use_same_source_name.nil? && !attributes.key?(:'isUseSameSourceName') && !attributes.key?(:'is_use_same_source_name') # rubocop:disable Style/StringLiterals

      self.target_entity_name_prefix = attributes[:'targetEntityNamePrefix'] if attributes[:'targetEntityNamePrefix']
      self.target_entity_name_prefix = "null" if target_entity_name_prefix.nil? && !attributes.key?(:'targetEntityNamePrefix') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :targetEntityNamePrefix and :target_entity_name_prefix' if attributes.key?(:'targetEntityNamePrefix') && attributes.key?(:'target_entity_name_prefix')

      self.target_entity_name_prefix = attributes[:'target_entity_name_prefix'] if attributes[:'target_entity_name_prefix']
      self.target_entity_name_prefix = "null" if target_entity_name_prefix.nil? && !attributes.key?(:'targetEntityNamePrefix') && !attributes.key?(:'target_entity_name_prefix') # rubocop:disable Style/StringLiterals

      self.target_entity_name_suffix = attributes[:'targetEntityNameSuffix'] if attributes[:'targetEntityNameSuffix']
      self.target_entity_name_suffix = "null" if target_entity_name_suffix.nil? && !attributes.key?(:'targetEntityNameSuffix') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :targetEntityNameSuffix and :target_entity_name_suffix' if attributes.key?(:'targetEntityNameSuffix') && attributes.key?(:'target_entity_name_suffix')

      self.target_entity_name_suffix = attributes[:'target_entity_name_suffix'] if attributes[:'target_entity_name_suffix']
      self.target_entity_name_suffix = "null" if target_entity_name_suffix.nil? && !attributes.key?(:'targetEntityNameSuffix') && !attributes.key?(:'target_entity_name_suffix') # rubocop:disable Style/StringLiterals

      self.data_property = attributes[:'dataProperty'] if attributes[:'dataProperty']

      raise 'You cannot provide both :dataProperty and :data_property' if attributes.key?(:'dataProperty') && attributes.key?(:'data_property')

      self.data_property = attributes[:'data_property'] if attributes[:'data_property']

      self.schema_drift_config = attributes[:'schemaDriftConfig'] if attributes[:'schemaDriftConfig']

      raise 'You cannot provide both :schemaDriftConfig and :schema_drift_config' if attributes.key?(:'schemaDriftConfig') && attributes.key?(:'schema_drift_config')

      self.schema_drift_config = attributes[:'schema_drift_config'] if attributes[:'schema_drift_config']

      self.fixed_data_shape = attributes[:'fixedDataShape'] if attributes[:'fixedDataShape']

      raise 'You cannot provide both :fixedDataShape and :fixed_data_shape' if attributes.key?(:'fixedDataShape') && attributes.key?(:'fixed_data_shape')

      self.fixed_data_shape = attributes[:'fixed_data_shape'] if attributes[:'fixed_data_shape']

      self.write_operation_config = attributes[:'writeOperationConfig'] if attributes[:'writeOperationConfig']

      raise 'You cannot provide both :writeOperationConfig and :write_operation_config' if attributes.key?(:'writeOperationConfig') && attributes.key?(:'write_operation_config')

      self.write_operation_config = attributes[:'write_operation_config'] if attributes[:'write_operation_config']

      self.load_order = attributes[:'loadOrder'] if attributes[:'loadOrder']

      raise 'You cannot provide both :loadOrder and :load_order' if attributes.key?(:'loadOrder') && attributes.key?(:'load_order')

      self.load_order = attributes[:'load_order'] if attributes[:'load_order']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] data_property Object to be assigned
    def data_property=(data_property)
      # rubocop:disable Style/ConditionalAssignment
      if data_property && !DATA_PROPERTY_ENUM.include?(data_property)
        OCI.logger.debug("Unknown value for 'data_property' [" + data_property + "]. Mapping to 'DATA_PROPERTY_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @data_property = DATA_PROPERTY_UNKNOWN_ENUM_VALUE
      else
        @data_property = data_property
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        model_type == other.model_type &&
        key == other.key &&
        model_version == other.model_version &&
        parent_ref == other.parent_ref &&
        name == other.name &&
        description == other.description &&
        object_version == other.object_version &&
        input_ports == other.input_ports &&
        output_ports == other.output_ports &&
        object_status == other.object_status &&
        identifier == other.identifier &&
        parameters == other.parameters &&
        op_config_values == other.op_config_values &&
        entity == other.entity &&
        is_read_access == other.is_read_access &&
        is_copy_fields == other.is_copy_fields &&
        is_predefined_shape == other.is_predefined_shape &&
        is_use_same_source_name == other.is_use_same_source_name &&
        target_entity_name_prefix == other.target_entity_name_prefix &&
        target_entity_name_suffix == other.target_entity_name_suffix &&
        data_property == other.data_property &&
        schema_drift_config == other.schema_drift_config &&
        fixed_data_shape == other.fixed_data_shape &&
        write_operation_config == other.write_operation_config &&
        load_order == other.load_order
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
      [model_type, key, model_version, parent_ref, name, description, object_version, input_ports, output_ports, object_status, identifier, parameters, op_config_values, entity, is_read_access, is_copy_fields, is_predefined_shape, is_use_same_source_name, target_entity_name_prefix, target_entity_name_suffix, data_property, schema_drift_config, fixed_data_shape, write_operation_config, load_order].hash
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
