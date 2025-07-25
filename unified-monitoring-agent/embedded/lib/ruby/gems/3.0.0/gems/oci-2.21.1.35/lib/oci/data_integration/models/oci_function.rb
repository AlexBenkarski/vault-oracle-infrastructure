# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200430
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The information about the OCI Function.
  class DataIntegration::Models::OciFunction
    MODEL_TYPE_ENUM = [
      MODEL_TYPE_OCI_FUNCTION = 'OCI_FUNCTION'.freeze,
      MODEL_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    PAYLOAD_FORMAT_ENUM = [
      PAYLOAD_FORMAT_JSON = 'JSON'.freeze,
      PAYLOAD_FORMAT_AVRO = 'AVRO'.freeze,
      PAYLOAD_FORMAT_JSONBYTES = 'JSONBYTES'.freeze,
      PAYLOAD_FORMAT_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # Ocid of the OCI Function.
    # @return [String]
    attr_accessor :function_id

    # Region where the OCI Function is deployed.
    # @return [String]
    attr_accessor :region_id

    # @return [OCI::DataIntegration::Models::ConfigDefinition]
    attr_accessor :fn_config_definition

    # @return [OCI::DataIntegration::Models::Shape]
    attr_accessor :input_shape

    # @return [OCI::DataIntegration::Models::Shape]
    attr_accessor :output_shape

    # The type of the OCI Function object.
    # @return [String]
    attr_reader :model_type

    # The key identifying the OCI Function operator object, use this to identiy this instance within the dataflow.
    # @return [String]
    attr_accessor :key

    # @return [OCI::DataIntegration::Models::ParentReference]
    attr_accessor :parent_ref

    # The model version of an object.
    # @return [String]
    attr_accessor :model_version

    # The version of the object that is used to track changes in the object instance.
    # @return [Integer]
    attr_accessor :object_version

    # The OCI Function payload format.
    # @return [String]
    attr_reader :payload_format

    # @return [OCI::DataIntegration::Models::FunctionConfigurationDefinition]
    attr_accessor :fn_config_def

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'function_id': :'functionId',
        'region_id': :'regionId',
        'fn_config_definition': :'fnConfigDefinition',
        'input_shape': :'inputShape',
        'output_shape': :'outputShape',
        'model_type': :'modelType',
        'key': :'key',
        'parent_ref': :'parentRef',
        'model_version': :'modelVersion',
        'object_version': :'objectVersion',
        'payload_format': :'payloadFormat',
        'fn_config_def': :'fnConfigDef'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'function_id': :'String',
        'region_id': :'String',
        'fn_config_definition': :'OCI::DataIntegration::Models::ConfigDefinition',
        'input_shape': :'OCI::DataIntegration::Models::Shape',
        'output_shape': :'OCI::DataIntegration::Models::Shape',
        'model_type': :'String',
        'key': :'String',
        'parent_ref': :'OCI::DataIntegration::Models::ParentReference',
        'model_version': :'String',
        'object_version': :'Integer',
        'payload_format': :'String',
        'fn_config_def': :'OCI::DataIntegration::Models::FunctionConfigurationDefinition'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :function_id The value to assign to the {#function_id} property
    # @option attributes [String] :region_id The value to assign to the {#region_id} property
    # @option attributes [OCI::DataIntegration::Models::ConfigDefinition] :fn_config_definition The value to assign to the {#fn_config_definition} property
    # @option attributes [OCI::DataIntegration::Models::Shape] :input_shape The value to assign to the {#input_shape} property
    # @option attributes [OCI::DataIntegration::Models::Shape] :output_shape The value to assign to the {#output_shape} property
    # @option attributes [String] :model_type The value to assign to the {#model_type} property
    # @option attributes [String] :key The value to assign to the {#key} property
    # @option attributes [OCI::DataIntegration::Models::ParentReference] :parent_ref The value to assign to the {#parent_ref} property
    # @option attributes [String] :model_version The value to assign to the {#model_version} property
    # @option attributes [Integer] :object_version The value to assign to the {#object_version} property
    # @option attributes [String] :payload_format The value to assign to the {#payload_format} property
    # @option attributes [OCI::DataIntegration::Models::FunctionConfigurationDefinition] :fn_config_def The value to assign to the {#fn_config_def} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.function_id = attributes[:'functionId'] if attributes[:'functionId']

      raise 'You cannot provide both :functionId and :function_id' if attributes.key?(:'functionId') && attributes.key?(:'function_id')

      self.function_id = attributes[:'function_id'] if attributes[:'function_id']

      self.region_id = attributes[:'regionId'] if attributes[:'regionId']

      raise 'You cannot provide both :regionId and :region_id' if attributes.key?(:'regionId') && attributes.key?(:'region_id')

      self.region_id = attributes[:'region_id'] if attributes[:'region_id']

      self.fn_config_definition = attributes[:'fnConfigDefinition'] if attributes[:'fnConfigDefinition']

      raise 'You cannot provide both :fnConfigDefinition and :fn_config_definition' if attributes.key?(:'fnConfigDefinition') && attributes.key?(:'fn_config_definition')

      self.fn_config_definition = attributes[:'fn_config_definition'] if attributes[:'fn_config_definition']

      self.input_shape = attributes[:'inputShape'] if attributes[:'inputShape']

      raise 'You cannot provide both :inputShape and :input_shape' if attributes.key?(:'inputShape') && attributes.key?(:'input_shape')

      self.input_shape = attributes[:'input_shape'] if attributes[:'input_shape']

      self.output_shape = attributes[:'outputShape'] if attributes[:'outputShape']

      raise 'You cannot provide both :outputShape and :output_shape' if attributes.key?(:'outputShape') && attributes.key?(:'output_shape')

      self.output_shape = attributes[:'output_shape'] if attributes[:'output_shape']

      self.model_type = attributes[:'modelType'] if attributes[:'modelType']
      self.model_type = "OCI_FUNCTION" if model_type.nil? && !attributes.key?(:'modelType') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :modelType and :model_type' if attributes.key?(:'modelType') && attributes.key?(:'model_type')

      self.model_type = attributes[:'model_type'] if attributes[:'model_type']
      self.model_type = "OCI_FUNCTION" if model_type.nil? && !attributes.key?(:'modelType') && !attributes.key?(:'model_type') # rubocop:disable Style/StringLiterals

      self.key = attributes[:'key'] if attributes[:'key']

      self.parent_ref = attributes[:'parentRef'] if attributes[:'parentRef']

      raise 'You cannot provide both :parentRef and :parent_ref' if attributes.key?(:'parentRef') && attributes.key?(:'parent_ref')

      self.parent_ref = attributes[:'parent_ref'] if attributes[:'parent_ref']

      self.model_version = attributes[:'modelVersion'] if attributes[:'modelVersion']

      raise 'You cannot provide both :modelVersion and :model_version' if attributes.key?(:'modelVersion') && attributes.key?(:'model_version')

      self.model_version = attributes[:'model_version'] if attributes[:'model_version']

      self.object_version = attributes[:'objectVersion'] if attributes[:'objectVersion']

      raise 'You cannot provide both :objectVersion and :object_version' if attributes.key?(:'objectVersion') && attributes.key?(:'object_version')

      self.object_version = attributes[:'object_version'] if attributes[:'object_version']

      self.payload_format = attributes[:'payloadFormat'] if attributes[:'payloadFormat']
      self.payload_format = "JSON" if payload_format.nil? && !attributes.key?(:'payloadFormat') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :payloadFormat and :payload_format' if attributes.key?(:'payloadFormat') && attributes.key?(:'payload_format')

      self.payload_format = attributes[:'payload_format'] if attributes[:'payload_format']
      self.payload_format = "JSON" if payload_format.nil? && !attributes.key?(:'payloadFormat') && !attributes.key?(:'payload_format') # rubocop:disable Style/StringLiterals

      self.fn_config_def = attributes[:'fnConfigDef'] if attributes[:'fnConfigDef']

      raise 'You cannot provide both :fnConfigDef and :fn_config_def' if attributes.key?(:'fnConfigDef') && attributes.key?(:'fn_config_def')

      self.fn_config_def = attributes[:'fn_config_def'] if attributes[:'fn_config_def']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] model_type Object to be assigned
    def model_type=(model_type)
      # rubocop:disable Style/ConditionalAssignment
      if model_type && !MODEL_TYPE_ENUM.include?(model_type)
        OCI.logger.debug("Unknown value for 'model_type' [" + model_type + "]. Mapping to 'MODEL_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @model_type = MODEL_TYPE_UNKNOWN_ENUM_VALUE
      else
        @model_type = model_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] payload_format Object to be assigned
    def payload_format=(payload_format)
      # rubocop:disable Style/ConditionalAssignment
      if payload_format && !PAYLOAD_FORMAT_ENUM.include?(payload_format)
        OCI.logger.debug("Unknown value for 'payload_format' [" + payload_format + "]. Mapping to 'PAYLOAD_FORMAT_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @payload_format = PAYLOAD_FORMAT_UNKNOWN_ENUM_VALUE
      else
        @payload_format = payload_format
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        function_id == other.function_id &&
        region_id == other.region_id &&
        fn_config_definition == other.fn_config_definition &&
        input_shape == other.input_shape &&
        output_shape == other.output_shape &&
        model_type == other.model_type &&
        key == other.key &&
        parent_ref == other.parent_ref &&
        model_version == other.model_version &&
        object_version == other.object_version &&
        payload_format == other.payload_format &&
        fn_config_def == other.fn_config_def
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
      [function_id, region_id, fn_config_definition, input_shape, output_shape, model_type, key, parent_ref, model_version, object_version, payload_format, fn_config_def].hash
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
