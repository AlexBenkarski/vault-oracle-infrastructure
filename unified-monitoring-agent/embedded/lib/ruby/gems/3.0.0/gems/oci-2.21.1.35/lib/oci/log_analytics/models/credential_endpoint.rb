# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200601
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The endpoint from where to fetch a credential, for example, the OAuth 2.0 token.
  class LogAnalytics::Models::CredentialEndpoint
    # **[Required]** The credential endpoint name.
    # @return [String]
    attr_accessor :name

    # The credential endpoint description.
    # @return [String]
    attr_accessor :description

    # The credential endpoint model.
    # @return [String]
    attr_accessor :model

    # The endpoint unique identifier.
    # @return [Integer]
    attr_accessor :endpoint_id

    # This attribute is required.
    # @return [OCI::LogAnalytics::Models::EndpointRequest]
    attr_accessor :request

    # @return [OCI::LogAnalytics::Models::EndpointResponse]
    attr_accessor :response

    # @return [OCI::LogAnalytics::Models::EndpointProxy]
    attr_accessor :proxy

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'name',
        'description': :'description',
        'model': :'model',
        'endpoint_id': :'endpointId',
        'request': :'request',
        'response': :'response',
        'proxy': :'proxy'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'String',
        'description': :'String',
        'model': :'String',
        'endpoint_id': :'Integer',
        'request': :'OCI::LogAnalytics::Models::EndpointRequest',
        'response': :'OCI::LogAnalytics::Models::EndpointResponse',
        'proxy': :'OCI::LogAnalytics::Models::EndpointProxy'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :model The value to assign to the {#model} property
    # @option attributes [Integer] :endpoint_id The value to assign to the {#endpoint_id} property
    # @option attributes [OCI::LogAnalytics::Models::EndpointRequest] :request The value to assign to the {#request} property
    # @option attributes [OCI::LogAnalytics::Models::EndpointResponse] :response The value to assign to the {#response} property
    # @option attributes [OCI::LogAnalytics::Models::EndpointProxy] :proxy The value to assign to the {#proxy} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.name = attributes[:'name'] if attributes[:'name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.model = attributes[:'model'] if attributes[:'model']

      self.endpoint_id = attributes[:'endpointId'] if attributes[:'endpointId']

      raise 'You cannot provide both :endpointId and :endpoint_id' if attributes.key?(:'endpointId') && attributes.key?(:'endpoint_id')

      self.endpoint_id = attributes[:'endpoint_id'] if attributes[:'endpoint_id']

      self.request = attributes[:'request'] if attributes[:'request']

      self.response = attributes[:'response'] if attributes[:'response']

      self.proxy = attributes[:'proxy'] if attributes[:'proxy']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        name == other.name &&
        description == other.description &&
        model == other.model &&
        endpoint_id == other.endpoint_id &&
        request == other.request &&
        response == other.response &&
        proxy == other.proxy
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
      [name, description, model, endpoint_id, request, response, proxy].hash
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
