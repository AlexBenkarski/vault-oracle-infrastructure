# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20201101
require 'date'
require_relative 'external_db_system_discovery_connector'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The details of an external DB system connector that uses the
  # [Management Agent Cloud Service (MACS)](https://docs.cloud.oracle.com/iaas/management-agents/index.html)
  # to connect to an external DB system component.
  #
  class DatabaseManagement::Models::ExternalDbSystemDiscoveryMacsConnector < DatabaseManagement::Models::ExternalDbSystemDiscoveryConnector
    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the management agent
    # used for the external DB system connector.
    #
    # @return [String]
    attr_accessor :agent_id

    # @return [OCI::DatabaseManagement::Models::ExternalDbSystemConnectionInfo]
    attr_accessor :connection_info

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'connector_type': :'connectorType',
        'display_name': :'displayName',
        'connection_status': :'connectionStatus',
        'connection_failure_message': :'connectionFailureMessage',
        'time_connection_status_last_updated': :'timeConnectionStatusLastUpdated',
        'agent_id': :'agentId',
        'connection_info': :'connectionInfo'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'connector_type': :'String',
        'display_name': :'String',
        'connection_status': :'String',
        'connection_failure_message': :'String',
        'time_connection_status_last_updated': :'DateTime',
        'agent_id': :'String',
        'connection_info': :'OCI::DatabaseManagement::Models::ExternalDbSystemConnectionInfo'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :display_name The value to assign to the {OCI::DatabaseManagement::Models::ExternalDbSystemDiscoveryConnector#display_name #display_name} proprety
    # @option attributes [String] :connection_status The value to assign to the {OCI::DatabaseManagement::Models::ExternalDbSystemDiscoveryConnector#connection_status #connection_status} proprety
    # @option attributes [String] :connection_failure_message The value to assign to the {OCI::DatabaseManagement::Models::ExternalDbSystemDiscoveryConnector#connection_failure_message #connection_failure_message} proprety
    # @option attributes [DateTime] :time_connection_status_last_updated The value to assign to the {OCI::DatabaseManagement::Models::ExternalDbSystemDiscoveryConnector#time_connection_status_last_updated #time_connection_status_last_updated} proprety
    # @option attributes [String] :agent_id The value to assign to the {#agent_id} property
    # @option attributes [OCI::DatabaseManagement::Models::ExternalDbSystemConnectionInfo] :connection_info The value to assign to the {#connection_info} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['connectorType'] = 'MACS'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.agent_id = attributes[:'agentId'] if attributes[:'agentId']

      raise 'You cannot provide both :agentId and :agent_id' if attributes.key?(:'agentId') && attributes.key?(:'agent_id')

      self.agent_id = attributes[:'agent_id'] if attributes[:'agent_id']

      self.connection_info = attributes[:'connectionInfo'] if attributes[:'connectionInfo']

      raise 'You cannot provide both :connectionInfo and :connection_info' if attributes.key?(:'connectionInfo') && attributes.key?(:'connection_info')

      self.connection_info = attributes[:'connection_info'] if attributes[:'connection_info']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        connector_type == other.connector_type &&
        display_name == other.display_name &&
        connection_status == other.connection_status &&
        connection_failure_message == other.connection_failure_message &&
        time_connection_status_last_updated == other.time_connection_status_last_updated &&
        agent_id == other.agent_id &&
        connection_info == other.connection_info
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
      [connector_type, display_name, connection_status, connection_failure_message, time_connection_status_last_updated, agent_id, connection_info].hash
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
