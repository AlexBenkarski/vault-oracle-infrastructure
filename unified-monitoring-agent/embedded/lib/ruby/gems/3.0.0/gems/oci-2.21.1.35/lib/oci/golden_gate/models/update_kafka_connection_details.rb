# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200407
require 'date'
require_relative 'update_connection_details'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The information to update a Kafka Connection.
  #
  class GoldenGate::Models::UpdateKafkaConnectionDetails < GoldenGate::Models::UpdateConnectionDetails
    # The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the stream pool being referenced.
    #
    # @return [String]
    attr_accessor :stream_pool_id

    # Kafka bootstrap. Equivalent of bootstrap.servers configuration property in Kafka:
    # list of KafkaBootstrapServer objects specified by host/port.
    # Used for establishing the initial connection to the Kafka cluster.
    # Example: `\"server1.example.com:9092,server2.example.com:9092\"`
    #
    # @return [Array<OCI::GoldenGate::Models::KafkaBootstrapServer>]
    attr_accessor :bootstrap_servers

    # Security Type for Kafka.
    #
    # @return [String]
    attr_accessor :security_protocol

    # The username Oracle GoldenGate uses to connect the associated system of the given technology.
    # This username must already exist and be available by the system/application to be connected to
    # and must conform to the case sensitivty requirments defined in it.
    #
    # @return [String]
    attr_accessor :username

    # The password Oracle GoldenGate uses to connect the associated system of the given technology.
    # It must conform to the specific security requirements including length, case sensitivity, and so on.
    #
    # @return [String]
    attr_accessor :password

    # The base64 encoded content of the TrustStore file.
    #
    # @return [String]
    attr_accessor :trust_store

    # The TrustStore password.
    #
    # @return [String]
    attr_accessor :trust_store_password

    # The base64 encoded content of the KeyStore file.
    #
    # @return [String]
    attr_accessor :key_store

    # The KeyStore password.
    #
    # @return [String]
    attr_accessor :key_store_password

    # The password for the cert inside of the KeyStore.
    # In case it differs from the KeyStore password, it should be provided.
    #
    # @return [String]
    attr_accessor :ssl_key_password

    # The base64 encoded content of the consumer.properties file.
    #
    # @return [String]
    attr_accessor :consumer_properties

    # The base64 encoded content of the producer.properties file.
    #
    # @return [String]
    attr_accessor :producer_properties

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'connection_type': :'connectionType',
        'display_name': :'displayName',
        'description': :'description',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'vault_id': :'vaultId',
        'key_id': :'keyId',
        'nsg_ids': :'nsgIds',
        'subnet_id': :'subnetId',
        'routing_method': :'routingMethod',
        'stream_pool_id': :'streamPoolId',
        'bootstrap_servers': :'bootstrapServers',
        'security_protocol': :'securityProtocol',
        'username': :'username',
        'password': :'password',
        'trust_store': :'trustStore',
        'trust_store_password': :'trustStorePassword',
        'key_store': :'keyStore',
        'key_store_password': :'keyStorePassword',
        'ssl_key_password': :'sslKeyPassword',
        'consumer_properties': :'consumerProperties',
        'producer_properties': :'producerProperties'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'connection_type': :'String',
        'display_name': :'String',
        'description': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'vault_id': :'String',
        'key_id': :'String',
        'nsg_ids': :'Array<String>',
        'subnet_id': :'String',
        'routing_method': :'String',
        'stream_pool_id': :'String',
        'bootstrap_servers': :'Array<OCI::GoldenGate::Models::KafkaBootstrapServer>',
        'security_protocol': :'String',
        'username': :'String',
        'password': :'String',
        'trust_store': :'String',
        'trust_store_password': :'String',
        'key_store': :'String',
        'key_store_password': :'String',
        'ssl_key_password': :'String',
        'consumer_properties': :'String',
        'producer_properties': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :display_name The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#display_name #display_name} proprety
    # @option attributes [String] :description The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#description #description} proprety
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#freeform_tags #freeform_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#defined_tags #defined_tags} proprety
    # @option attributes [String] :vault_id The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#vault_id #vault_id} proprety
    # @option attributes [String] :key_id The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#key_id #key_id} proprety
    # @option attributes [Array<String>] :nsg_ids The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#nsg_ids #nsg_ids} proprety
    # @option attributes [String] :subnet_id The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#subnet_id #subnet_id} proprety
    # @option attributes [String] :routing_method The value to assign to the {OCI::GoldenGate::Models::UpdateConnectionDetails#routing_method #routing_method} proprety
    # @option attributes [String] :stream_pool_id The value to assign to the {#stream_pool_id} property
    # @option attributes [Array<OCI::GoldenGate::Models::KafkaBootstrapServer>] :bootstrap_servers The value to assign to the {#bootstrap_servers} property
    # @option attributes [String] :security_protocol The value to assign to the {#security_protocol} property
    # @option attributes [String] :username The value to assign to the {#username} property
    # @option attributes [String] :password The value to assign to the {#password} property
    # @option attributes [String] :trust_store The value to assign to the {#trust_store} property
    # @option attributes [String] :trust_store_password The value to assign to the {#trust_store_password} property
    # @option attributes [String] :key_store The value to assign to the {#key_store} property
    # @option attributes [String] :key_store_password The value to assign to the {#key_store_password} property
    # @option attributes [String] :ssl_key_password The value to assign to the {#ssl_key_password} property
    # @option attributes [String] :consumer_properties The value to assign to the {#consumer_properties} property
    # @option attributes [String] :producer_properties The value to assign to the {#producer_properties} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['connectionType'] = 'KAFKA'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.stream_pool_id = attributes[:'streamPoolId'] if attributes[:'streamPoolId']

      raise 'You cannot provide both :streamPoolId and :stream_pool_id' if attributes.key?(:'streamPoolId') && attributes.key?(:'stream_pool_id')

      self.stream_pool_id = attributes[:'stream_pool_id'] if attributes[:'stream_pool_id']

      self.bootstrap_servers = attributes[:'bootstrapServers'] if attributes[:'bootstrapServers']

      raise 'You cannot provide both :bootstrapServers and :bootstrap_servers' if attributes.key?(:'bootstrapServers') && attributes.key?(:'bootstrap_servers')

      self.bootstrap_servers = attributes[:'bootstrap_servers'] if attributes[:'bootstrap_servers']

      self.security_protocol = attributes[:'securityProtocol'] if attributes[:'securityProtocol']

      raise 'You cannot provide both :securityProtocol and :security_protocol' if attributes.key?(:'securityProtocol') && attributes.key?(:'security_protocol')

      self.security_protocol = attributes[:'security_protocol'] if attributes[:'security_protocol']

      self.username = attributes[:'username'] if attributes[:'username']

      self.password = attributes[:'password'] if attributes[:'password']

      self.trust_store = attributes[:'trustStore'] if attributes[:'trustStore']

      raise 'You cannot provide both :trustStore and :trust_store' if attributes.key?(:'trustStore') && attributes.key?(:'trust_store')

      self.trust_store = attributes[:'trust_store'] if attributes[:'trust_store']

      self.trust_store_password = attributes[:'trustStorePassword'] if attributes[:'trustStorePassword']

      raise 'You cannot provide both :trustStorePassword and :trust_store_password' if attributes.key?(:'trustStorePassword') && attributes.key?(:'trust_store_password')

      self.trust_store_password = attributes[:'trust_store_password'] if attributes[:'trust_store_password']

      self.key_store = attributes[:'keyStore'] if attributes[:'keyStore']

      raise 'You cannot provide both :keyStore and :key_store' if attributes.key?(:'keyStore') && attributes.key?(:'key_store')

      self.key_store = attributes[:'key_store'] if attributes[:'key_store']

      self.key_store_password = attributes[:'keyStorePassword'] if attributes[:'keyStorePassword']

      raise 'You cannot provide both :keyStorePassword and :key_store_password' if attributes.key?(:'keyStorePassword') && attributes.key?(:'key_store_password')

      self.key_store_password = attributes[:'key_store_password'] if attributes[:'key_store_password']

      self.ssl_key_password = attributes[:'sslKeyPassword'] if attributes[:'sslKeyPassword']

      raise 'You cannot provide both :sslKeyPassword and :ssl_key_password' if attributes.key?(:'sslKeyPassword') && attributes.key?(:'ssl_key_password')

      self.ssl_key_password = attributes[:'ssl_key_password'] if attributes[:'ssl_key_password']

      self.consumer_properties = attributes[:'consumerProperties'] if attributes[:'consumerProperties']

      raise 'You cannot provide both :consumerProperties and :consumer_properties' if attributes.key?(:'consumerProperties') && attributes.key?(:'consumer_properties')

      self.consumer_properties = attributes[:'consumer_properties'] if attributes[:'consumer_properties']

      self.producer_properties = attributes[:'producerProperties'] if attributes[:'producerProperties']

      raise 'You cannot provide both :producerProperties and :producer_properties' if attributes.key?(:'producerProperties') && attributes.key?(:'producer_properties')

      self.producer_properties = attributes[:'producer_properties'] if attributes[:'producer_properties']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        connection_type == other.connection_type &&
        display_name == other.display_name &&
        description == other.description &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        vault_id == other.vault_id &&
        key_id == other.key_id &&
        nsg_ids == other.nsg_ids &&
        subnet_id == other.subnet_id &&
        routing_method == other.routing_method &&
        stream_pool_id == other.stream_pool_id &&
        bootstrap_servers == other.bootstrap_servers &&
        security_protocol == other.security_protocol &&
        username == other.username &&
        password == other.password &&
        trust_store == other.trust_store &&
        trust_store_password == other.trust_store_password &&
        key_store == other.key_store &&
        key_store_password == other.key_store_password &&
        ssl_key_password == other.ssl_key_password &&
        consumer_properties == other.consumer_properties &&
        producer_properties == other.producer_properties
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
      [connection_type, display_name, description, freeform_tags, defined_tags, vault_id, key_id, nsg_ids, subnet_id, routing_method, stream_pool_id, bootstrap_servers, security_protocol, username, password, trust_store, trust_store_password, key_store, key_store_password, ssl_key_password, consumer_properties, producer_properties].hash
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
