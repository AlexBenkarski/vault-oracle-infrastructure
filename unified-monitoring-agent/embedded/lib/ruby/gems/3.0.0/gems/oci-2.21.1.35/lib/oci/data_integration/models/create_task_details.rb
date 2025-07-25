# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200430
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Properties used in task create operations.
  # This class has direct subclasses. If you are using this class as input to a service operations then you should favor using a subclass over the base class
  class DataIntegration::Models::CreateTaskDetails
    MODEL_TYPE_ENUM = [
      MODEL_TYPE_INTEGRATION_TASK = 'INTEGRATION_TASK'.freeze,
      MODEL_TYPE_DATA_LOADER_TASK = 'DATA_LOADER_TASK'.freeze,
      MODEL_TYPE_PIPELINE_TASK = 'PIPELINE_TASK'.freeze,
      MODEL_TYPE_SQL_TASK = 'SQL_TASK'.freeze,
      MODEL_TYPE_OCI_DATAFLOW_TASK = 'OCI_DATAFLOW_TASK'.freeze,
      MODEL_TYPE_REST_TASK = 'REST_TASK'.freeze
    ].freeze

    # **[Required]** The type of the task.
    # @return [String]
    attr_reader :model_type

    # Generated key that can be used in API calls to identify task. On scenarios where reference to the task is needed, a value can be passed in create.
    # @return [String]
    attr_accessor :key

    # The object's model version.
    # @return [String]
    attr_accessor :model_version

    # @return [OCI::DataIntegration::Models::ParentReference]
    attr_accessor :parent_ref

    # **[Required]** Free form text without any restriction on permitted characters. Name can have letters, numbers, and special characters. The value is editable and is restricted to 1000 characters.
    # @return [String]
    attr_accessor :name

    # Detailed description for the object.
    # @return [String]
    attr_accessor :description

    # The status of an object that can be set to value 1 for shallow references across objects, other values reserved.
    # @return [Integer]
    attr_accessor :object_status

    # **[Required]** Value can only contain upper case letters, underscore, and numbers. It should begin with upper case letter or underscore. The value can be modified.
    # @return [String]
    attr_accessor :identifier

    # An array of input ports.
    # @return [Array<OCI::DataIntegration::Models::InputPort>]
    attr_accessor :input_ports

    # An array of output ports.
    # @return [Array<OCI::DataIntegration::Models::OutputPort>]
    attr_accessor :output_ports

    # An array of parameters.
    # @return [Array<OCI::DataIntegration::Models::Parameter>]
    attr_accessor :parameters

    # @return [OCI::DataIntegration::Models::ConfigValues]
    attr_accessor :op_config_values

    # @return [OCI::DataIntegration::Models::CreateConfigProvider]
    attr_accessor :config_provider_delegate

    # Whether the same task can be executed concurrently.
    # @return [BOOLEAN]
    attr_accessor :is_concurrent_allowed

    # This attribute is required.
    # @return [OCI::DataIntegration::Models::RegistryMetadata]
    attr_accessor :registry_metadata

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
        'object_status': :'objectStatus',
        'identifier': :'identifier',
        'input_ports': :'inputPorts',
        'output_ports': :'outputPorts',
        'parameters': :'parameters',
        'op_config_values': :'opConfigValues',
        'config_provider_delegate': :'configProviderDelegate',
        'is_concurrent_allowed': :'isConcurrentAllowed',
        'registry_metadata': :'registryMetadata'
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
        'object_status': :'Integer',
        'identifier': :'String',
        'input_ports': :'Array<OCI::DataIntegration::Models::InputPort>',
        'output_ports': :'Array<OCI::DataIntegration::Models::OutputPort>',
        'parameters': :'Array<OCI::DataIntegration::Models::Parameter>',
        'op_config_values': :'OCI::DataIntegration::Models::ConfigValues',
        'config_provider_delegate': :'OCI::DataIntegration::Models::CreateConfigProvider',
        'is_concurrent_allowed': :'BOOLEAN',
        'registry_metadata': :'OCI::DataIntegration::Models::RegistryMetadata'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity, Metrics/AbcSize


    # Given the hash representation of a subtype of this class,
    # use the info in the hash to return the class of the subtype.
    def self.get_subtype(object_hash)
      type = object_hash[:'modelType'] # rubocop:disable Style/SymbolLiteral

      return 'OCI::DataIntegration::Models::CreateTaskFromIntegrationTask' if type == 'INTEGRATION_TASK'
      return 'OCI::DataIntegration::Models::CreateTaskFromDataLoaderTask' if type == 'DATA_LOADER_TASK'
      return 'OCI::DataIntegration::Models::CreateTaskFromPipelineTask' if type == 'PIPELINE_TASK'
      return 'OCI::DataIntegration::Models::CreateTaskFromOCIDataflowTask' if type == 'OCI_DATAFLOW_TASK'
      return 'OCI::DataIntegration::Models::CreateTaskFromSQLTask' if type == 'SQL_TASK'
      return 'OCI::DataIntegration::Models::CreateTaskFromRestTask' if type == 'REST_TASK'

      # TODO: Log a warning when the subtype is not found.
      'OCI::DataIntegration::Models::CreateTaskDetails'
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity, Metrics/AbcSize

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :model_type The value to assign to the {#model_type} property
    # @option attributes [String] :key The value to assign to the {#key} property
    # @option attributes [String] :model_version The value to assign to the {#model_version} property
    # @option attributes [OCI::DataIntegration::Models::ParentReference] :parent_ref The value to assign to the {#parent_ref} property
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [Integer] :object_status The value to assign to the {#object_status} property
    # @option attributes [String] :identifier The value to assign to the {#identifier} property
    # @option attributes [Array<OCI::DataIntegration::Models::InputPort>] :input_ports The value to assign to the {#input_ports} property
    # @option attributes [Array<OCI::DataIntegration::Models::OutputPort>] :output_ports The value to assign to the {#output_ports} property
    # @option attributes [Array<OCI::DataIntegration::Models::Parameter>] :parameters The value to assign to the {#parameters} property
    # @option attributes [OCI::DataIntegration::Models::ConfigValues] :op_config_values The value to assign to the {#op_config_values} property
    # @option attributes [OCI::DataIntegration::Models::CreateConfigProvider] :config_provider_delegate The value to assign to the {#config_provider_delegate} property
    # @option attributes [BOOLEAN] :is_concurrent_allowed The value to assign to the {#is_concurrent_allowed} property
    # @option attributes [OCI::DataIntegration::Models::RegistryMetadata] :registry_metadata The value to assign to the {#registry_metadata} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.model_type = attributes[:'modelType'] if attributes[:'modelType']

      raise 'You cannot provide both :modelType and :model_type' if attributes.key?(:'modelType') && attributes.key?(:'model_type')

      self.model_type = attributes[:'model_type'] if attributes[:'model_type']

      self.key = attributes[:'key'] if attributes[:'key']

      self.model_version = attributes[:'modelVersion'] if attributes[:'modelVersion']

      raise 'You cannot provide both :modelVersion and :model_version' if attributes.key?(:'modelVersion') && attributes.key?(:'model_version')

      self.model_version = attributes[:'model_version'] if attributes[:'model_version']

      self.parent_ref = attributes[:'parentRef'] if attributes[:'parentRef']

      raise 'You cannot provide both :parentRef and :parent_ref' if attributes.key?(:'parentRef') && attributes.key?(:'parent_ref')

      self.parent_ref = attributes[:'parent_ref'] if attributes[:'parent_ref']

      self.name = attributes[:'name'] if attributes[:'name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.object_status = attributes[:'objectStatus'] if attributes[:'objectStatus']

      raise 'You cannot provide both :objectStatus and :object_status' if attributes.key?(:'objectStatus') && attributes.key?(:'object_status')

      self.object_status = attributes[:'object_status'] if attributes[:'object_status']

      self.identifier = attributes[:'identifier'] if attributes[:'identifier']

      self.input_ports = attributes[:'inputPorts'] if attributes[:'inputPorts']

      raise 'You cannot provide both :inputPorts and :input_ports' if attributes.key?(:'inputPorts') && attributes.key?(:'input_ports')

      self.input_ports = attributes[:'input_ports'] if attributes[:'input_ports']

      self.output_ports = attributes[:'outputPorts'] if attributes[:'outputPorts']

      raise 'You cannot provide both :outputPorts and :output_ports' if attributes.key?(:'outputPorts') && attributes.key?(:'output_ports')

      self.output_ports = attributes[:'output_ports'] if attributes[:'output_ports']

      self.parameters = attributes[:'parameters'] if attributes[:'parameters']

      self.op_config_values = attributes[:'opConfigValues'] if attributes[:'opConfigValues']

      raise 'You cannot provide both :opConfigValues and :op_config_values' if attributes.key?(:'opConfigValues') && attributes.key?(:'op_config_values')

      self.op_config_values = attributes[:'op_config_values'] if attributes[:'op_config_values']

      self.config_provider_delegate = attributes[:'configProviderDelegate'] if attributes[:'configProviderDelegate']

      raise 'You cannot provide both :configProviderDelegate and :config_provider_delegate' if attributes.key?(:'configProviderDelegate') && attributes.key?(:'config_provider_delegate')

      self.config_provider_delegate = attributes[:'config_provider_delegate'] if attributes[:'config_provider_delegate']

      self.is_concurrent_allowed = attributes[:'isConcurrentAllowed'] unless attributes[:'isConcurrentAllowed'].nil?
      self.is_concurrent_allowed = true if is_concurrent_allowed.nil? && !attributes.key?(:'isConcurrentAllowed') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isConcurrentAllowed and :is_concurrent_allowed' if attributes.key?(:'isConcurrentAllowed') && attributes.key?(:'is_concurrent_allowed')

      self.is_concurrent_allowed = attributes[:'is_concurrent_allowed'] unless attributes[:'is_concurrent_allowed'].nil?
      self.is_concurrent_allowed = true if is_concurrent_allowed.nil? && !attributes.key?(:'isConcurrentAllowed') && !attributes.key?(:'is_concurrent_allowed') # rubocop:disable Style/StringLiterals

      self.registry_metadata = attributes[:'registryMetadata'] if attributes[:'registryMetadata']

      raise 'You cannot provide both :registryMetadata and :registry_metadata' if attributes.key?(:'registryMetadata') && attributes.key?(:'registry_metadata')

      self.registry_metadata = attributes[:'registry_metadata'] if attributes[:'registry_metadata']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] model_type Object to be assigned
    def model_type=(model_type)
      raise "Invalid value for 'model_type': this must be one of the values in MODEL_TYPE_ENUM." if model_type && !MODEL_TYPE_ENUM.include?(model_type)

      @model_type = model_type
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
        object_status == other.object_status &&
        identifier == other.identifier &&
        input_ports == other.input_ports &&
        output_ports == other.output_ports &&
        parameters == other.parameters &&
        op_config_values == other.op_config_values &&
        config_provider_delegate == other.config_provider_delegate &&
        is_concurrent_allowed == other.is_concurrent_allowed &&
        registry_metadata == other.registry_metadata
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
      [model_type, key, model_version, parent_ref, name, description, object_status, identifier, input_ports, output_ports, parameters, op_config_values, config_provider_delegate, is_concurrent_allowed, registry_metadata].hash
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
