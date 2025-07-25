# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details to create an application virtual IP (VIP) address on a cloud VM cluster.
  #
  class Database::Models::CreateApplicationVipDetails
    # **[Required]** The hostname of the application virtual IP (VIP) address.
    # @return [String]
    attr_accessor :hostname_label

    # The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the DB node associated with the application virtual IP (VIP) address.
    # @return [String]
    attr_accessor :db_node_id

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the cloud VM cluster associated with the application virtual IP (VIP) address.
    # @return [String]
    attr_accessor :cloud_vm_cluster_id

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the subnet associated with the application virtual IP (VIP) address.
    # @return [String]
    attr_accessor :subnet_id

    # The application virtual IP (VIP) address.
    # @return [String]
    attr_accessor :ip_address

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'hostname_label': :'hostnameLabel',
        'db_node_id': :'dbNodeId',
        'cloud_vm_cluster_id': :'cloudVmClusterId',
        'subnet_id': :'subnetId',
        'ip_address': :'ipAddress'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'hostname_label': :'String',
        'db_node_id': :'String',
        'cloud_vm_cluster_id': :'String',
        'subnet_id': :'String',
        'ip_address': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :hostname_label The value to assign to the {#hostname_label} property
    # @option attributes [String] :db_node_id The value to assign to the {#db_node_id} property
    # @option attributes [String] :cloud_vm_cluster_id The value to assign to the {#cloud_vm_cluster_id} property
    # @option attributes [String] :subnet_id The value to assign to the {#subnet_id} property
    # @option attributes [String] :ip_address The value to assign to the {#ip_address} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.hostname_label = attributes[:'hostnameLabel'] if attributes[:'hostnameLabel']

      raise 'You cannot provide both :hostnameLabel and :hostname_label' if attributes.key?(:'hostnameLabel') && attributes.key?(:'hostname_label')

      self.hostname_label = attributes[:'hostname_label'] if attributes[:'hostname_label']

      self.db_node_id = attributes[:'dbNodeId'] if attributes[:'dbNodeId']

      raise 'You cannot provide both :dbNodeId and :db_node_id' if attributes.key?(:'dbNodeId') && attributes.key?(:'db_node_id')

      self.db_node_id = attributes[:'db_node_id'] if attributes[:'db_node_id']

      self.cloud_vm_cluster_id = attributes[:'cloudVmClusterId'] if attributes[:'cloudVmClusterId']

      raise 'You cannot provide both :cloudVmClusterId and :cloud_vm_cluster_id' if attributes.key?(:'cloudVmClusterId') && attributes.key?(:'cloud_vm_cluster_id')

      self.cloud_vm_cluster_id = attributes[:'cloud_vm_cluster_id'] if attributes[:'cloud_vm_cluster_id']

      self.subnet_id = attributes[:'subnetId'] if attributes[:'subnetId']

      raise 'You cannot provide both :subnetId and :subnet_id' if attributes.key?(:'subnetId') && attributes.key?(:'subnet_id')

      self.subnet_id = attributes[:'subnet_id'] if attributes[:'subnet_id']

      self.ip_address = attributes[:'ipAddress'] if attributes[:'ipAddress']

      raise 'You cannot provide both :ipAddress and :ip_address' if attributes.key?(:'ipAddress') && attributes.key?(:'ip_address')

      self.ip_address = attributes[:'ip_address'] if attributes[:'ip_address']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        hostname_label == other.hostname_label &&
        db_node_id == other.db_node_id &&
        cloud_vm_cluster_id == other.cloud_vm_cluster_id &&
        subnet_id == other.subnet_id &&
        ip_address == other.ip_address
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
      [hostname_label, db_node_id, cloud_vm_cluster_id, subnet_id, ip_address].hash
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
