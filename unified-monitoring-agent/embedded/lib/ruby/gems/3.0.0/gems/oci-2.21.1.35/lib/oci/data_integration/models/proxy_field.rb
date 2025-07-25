# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200430
require 'date'
require_relative 'typed_object'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A proxy field.
  class DataIntegration::Models::ProxyField < DataIntegration::Models::TypedObject
    # Deprecated - Reference to a typed object. This can be either a key value to an object within the document, a shall referenced to a `TypedObject`, or a full `TypedObject` definition.
    # @return [Object]
    attr_accessor :scope

    # @return [OCI::DataIntegration::Models::ScopeReference]
    attr_accessor :scope_reference

    # @return [OCI::DataIntegration::Models::BaseType]
    attr_accessor :type

    # Labels are keywords or labels that you can add to data assets, dataflows and so on. You can define your own labels and use them to categorize content.
    # @return [Array<String>]
    attr_accessor :labels

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'model_type': :'modelType',
        'key': :'key',
        'model_version': :'modelVersion',
        'parent_ref': :'parentRef',
        'config_values': :'configValues',
        'object_status': :'objectStatus',
        'name': :'name',
        'description': :'description',
        'scope': :'scope',
        'scope_reference': :'scopeReference',
        'type': :'type',
        'labels': :'labels'
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
        'config_values': :'OCI::DataIntegration::Models::ConfigValues',
        'object_status': :'Integer',
        'name': :'String',
        'description': :'String',
        'scope': :'Object',
        'scope_reference': :'OCI::DataIntegration::Models::ScopeReference',
        'type': :'OCI::DataIntegration::Models::BaseType',
        'labels': :'Array<String>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :key The value to assign to the {OCI::DataIntegration::Models::TypedObject#key #key} proprety
    # @option attributes [String] :model_version The value to assign to the {OCI::DataIntegration::Models::TypedObject#model_version #model_version} proprety
    # @option attributes [OCI::DataIntegration::Models::ParentReference] :parent_ref The value to assign to the {OCI::DataIntegration::Models::TypedObject#parent_ref #parent_ref} proprety
    # @option attributes [OCI::DataIntegration::Models::ConfigValues] :config_values The value to assign to the {OCI::DataIntegration::Models::TypedObject#config_values #config_values} proprety
    # @option attributes [Integer] :object_status The value to assign to the {OCI::DataIntegration::Models::TypedObject#object_status #object_status} proprety
    # @option attributes [String] :name The value to assign to the {OCI::DataIntegration::Models::TypedObject#name #name} proprety
    # @option attributes [String] :description The value to assign to the {OCI::DataIntegration::Models::TypedObject#description #description} proprety
    # @option attributes [Object] :scope The value to assign to the {#scope} property
    # @option attributes [OCI::DataIntegration::Models::ScopeReference] :scope_reference The value to assign to the {#scope_reference} property
    # @option attributes [OCI::DataIntegration::Models::BaseType] :type The value to assign to the {#type} property
    # @option attributes [Array<String>] :labels The value to assign to the {#labels} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['modelType'] = 'PROXY_FIELD'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.scope = attributes[:'scope'] if attributes[:'scope']

      self.scope_reference = attributes[:'scopeReference'] if attributes[:'scopeReference']

      raise 'You cannot provide both :scopeReference and :scope_reference' if attributes.key?(:'scopeReference') && attributes.key?(:'scope_reference')

      self.scope_reference = attributes[:'scope_reference'] if attributes[:'scope_reference']

      self.type = attributes[:'type'] if attributes[:'type']

      self.labels = attributes[:'labels'] if attributes[:'labels']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

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
        config_values == other.config_values &&
        object_status == other.object_status &&
        name == other.name &&
        description == other.description &&
        scope == other.scope &&
        scope_reference == other.scope_reference &&
        type == other.type &&
        labels == other.labels
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
      [model_type, key, model_version, parent_ref, config_values, object_status, name, description, scope, scope_reference, type, labels].hash
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
