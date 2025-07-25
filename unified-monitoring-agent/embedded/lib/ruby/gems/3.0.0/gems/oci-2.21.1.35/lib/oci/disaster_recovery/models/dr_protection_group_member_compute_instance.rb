# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220125
require 'date'
require_relative 'dr_protection_group_member'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Deprecated. Properties for a compute instance member of a DR protection group.
  class DisasterRecovery::Models::DrProtectionGroupMemberComputeInstance < DisasterRecovery::Models::DrProtectionGroupMember
    # A flag indicating if the compute instance should be moved during DR operations.
    #
    # Example: `false`
    #
    # @return [BOOLEAN]
    attr_accessor :is_movable

    # A list of compute instance VNIC mappings.
    #
    # @return [Array<OCI::DisasterRecovery::Models::ComputeInstanceVnicMapping>]
    attr_accessor :vnic_mapping

    # The OCID of a compartment in the destination region in which the compute instance
    # should be launched.
    #
    # Example: `ocid1.compartment.oc1..uniqueID`
    #
    # @return [String]
    attr_accessor :destination_compartment_id

    # The OCID of a dedicated VM host in the destination region where the compute instance
    # should be launched.
    #
    # Example: `ocid1.dedicatedvmhost.oc1..uniqueID`
    #
    # @return [String]
    attr_accessor :destination_dedicated_vm_host_id

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'member_id': :'memberId',
        'member_type': :'memberType',
        'is_movable': :'isMovable',
        'vnic_mapping': :'vnicMapping',
        'destination_compartment_id': :'destinationCompartmentId',
        'destination_dedicated_vm_host_id': :'destinationDedicatedVmHostId'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'member_id': :'String',
        'member_type': :'String',
        'is_movable': :'BOOLEAN',
        'vnic_mapping': :'Array<OCI::DisasterRecovery::Models::ComputeInstanceVnicMapping>',
        'destination_compartment_id': :'String',
        'destination_dedicated_vm_host_id': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :member_id The value to assign to the {OCI::DisasterRecovery::Models::DrProtectionGroupMember#member_id #member_id} proprety
    # @option attributes [BOOLEAN] :is_movable The value to assign to the {#is_movable} property
    # @option attributes [Array<OCI::DisasterRecovery::Models::ComputeInstanceVnicMapping>] :vnic_mapping The value to assign to the {#vnic_mapping} property
    # @option attributes [String] :destination_compartment_id The value to assign to the {#destination_compartment_id} property
    # @option attributes [String] :destination_dedicated_vm_host_id The value to assign to the {#destination_dedicated_vm_host_id} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['memberType'] = 'COMPUTE_INSTANCE'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.is_movable = attributes[:'isMovable'] unless attributes[:'isMovable'].nil?
      self.is_movable = true if is_movable.nil? && !attributes.key?(:'isMovable') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isMovable and :is_movable' if attributes.key?(:'isMovable') && attributes.key?(:'is_movable')

      self.is_movable = attributes[:'is_movable'] unless attributes[:'is_movable'].nil?
      self.is_movable = true if is_movable.nil? && !attributes.key?(:'isMovable') && !attributes.key?(:'is_movable') # rubocop:disable Style/StringLiterals

      self.vnic_mapping = attributes[:'vnicMapping'] if attributes[:'vnicMapping']

      raise 'You cannot provide both :vnicMapping and :vnic_mapping' if attributes.key?(:'vnicMapping') && attributes.key?(:'vnic_mapping')

      self.vnic_mapping = attributes[:'vnic_mapping'] if attributes[:'vnic_mapping']

      self.destination_compartment_id = attributes[:'destinationCompartmentId'] if attributes[:'destinationCompartmentId']

      raise 'You cannot provide both :destinationCompartmentId and :destination_compartment_id' if attributes.key?(:'destinationCompartmentId') && attributes.key?(:'destination_compartment_id')

      self.destination_compartment_id = attributes[:'destination_compartment_id'] if attributes[:'destination_compartment_id']

      self.destination_dedicated_vm_host_id = attributes[:'destinationDedicatedVmHostId'] if attributes[:'destinationDedicatedVmHostId']

      raise 'You cannot provide both :destinationDedicatedVmHostId and :destination_dedicated_vm_host_id' if attributes.key?(:'destinationDedicatedVmHostId') && attributes.key?(:'destination_dedicated_vm_host_id')

      self.destination_dedicated_vm_host_id = attributes[:'destination_dedicated_vm_host_id'] if attributes[:'destination_dedicated_vm_host_id']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        member_id == other.member_id &&
        member_type == other.member_type &&
        is_movable == other.is_movable &&
        vnic_mapping == other.vnic_mapping &&
        destination_compartment_id == other.destination_compartment_id &&
        destination_dedicated_vm_host_id == other.destination_dedicated_vm_host_id
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
      [member_id, member_type, is_movable, vnic_mapping, destination_compartment_id, destination_dedicated_vm_host_id].hash
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
