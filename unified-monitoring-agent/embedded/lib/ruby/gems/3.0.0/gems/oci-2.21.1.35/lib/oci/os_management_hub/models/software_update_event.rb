# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220901
require 'date'
require_relative 'event'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Provides information for a software update event.
  class OsManagementHub::Models::SoftwareUpdateEvent < OsManagementHub::Models::Event
    # This attribute is required.
    # @return [OCI::OsManagementHub::Models::SoftwareUpdateEventData]
    attr_accessor :data

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'type': :'type',
        'event_summary': :'eventSummary',
        'compartment_id': :'compartmentId',
        'event_details': :'eventDetails',
        'resource_id': :'resourceId',
        'system_details': :'systemDetails',
        'time_occurred': :'timeOccurred',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'lifecycle_state': :'lifecycleState',
        'lifecycle_details': :'lifecycleDetails',
        'is_managed_by_autonomous_linux': :'isManagedByAutonomousLinux',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags',
        'data': :'data'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'type': :'String',
        'event_summary': :'String',
        'compartment_id': :'String',
        'event_details': :'String',
        'resource_id': :'String',
        'system_details': :'OCI::OsManagementHub::Models::SystemDetails',
        'time_occurred': :'DateTime',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'lifecycle_state': :'String',
        'lifecycle_details': :'String',
        'is_managed_by_autonomous_linux': :'BOOLEAN',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>',
        'data': :'OCI::OsManagementHub::Models::SoftwareUpdateEventData'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {OCI::OsManagementHub::Models::Event#id #id} proprety
    # @option attributes [String] :event_summary The value to assign to the {OCI::OsManagementHub::Models::Event#event_summary #event_summary} proprety
    # @option attributes [String] :compartment_id The value to assign to the {OCI::OsManagementHub::Models::Event#compartment_id #compartment_id} proprety
    # @option attributes [String] :event_details The value to assign to the {OCI::OsManagementHub::Models::Event#event_details #event_details} proprety
    # @option attributes [String] :resource_id The value to assign to the {OCI::OsManagementHub::Models::Event#resource_id #resource_id} proprety
    # @option attributes [OCI::OsManagementHub::Models::SystemDetails] :system_details The value to assign to the {OCI::OsManagementHub::Models::Event#system_details #system_details} proprety
    # @option attributes [DateTime] :time_occurred The value to assign to the {OCI::OsManagementHub::Models::Event#time_occurred #time_occurred} proprety
    # @option attributes [DateTime] :time_created The value to assign to the {OCI::OsManagementHub::Models::Event#time_created #time_created} proprety
    # @option attributes [DateTime] :time_updated The value to assign to the {OCI::OsManagementHub::Models::Event#time_updated #time_updated} proprety
    # @option attributes [String] :lifecycle_state The value to assign to the {OCI::OsManagementHub::Models::Event#lifecycle_state #lifecycle_state} proprety
    # @option attributes [String] :lifecycle_details The value to assign to the {OCI::OsManagementHub::Models::Event#lifecycle_details #lifecycle_details} proprety
    # @option attributes [BOOLEAN] :is_managed_by_autonomous_linux The value to assign to the {OCI::OsManagementHub::Models::Event#is_managed_by_autonomous_linux #is_managed_by_autonomous_linux} proprety
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {OCI::OsManagementHub::Models::Event#freeform_tags #freeform_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {OCI::OsManagementHub::Models::Event#defined_tags #defined_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {OCI::OsManagementHub::Models::Event#system_tags #system_tags} proprety
    # @option attributes [OCI::OsManagementHub::Models::SoftwareUpdateEventData] :data The value to assign to the {#data} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['type'] = 'SOFTWARE_UPDATE'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.data = attributes[:'data'] if attributes[:'data']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        id == other.id &&
        type == other.type &&
        event_summary == other.event_summary &&
        compartment_id == other.compartment_id &&
        event_details == other.event_details &&
        resource_id == other.resource_id &&
        system_details == other.system_details &&
        time_occurred == other.time_occurred &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        lifecycle_state == other.lifecycle_state &&
        lifecycle_details == other.lifecycle_details &&
        is_managed_by_autonomous_linux == other.is_managed_by_autonomous_linux &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        system_tags == other.system_tags &&
        data == other.data
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
      [id, type, event_summary, compartment_id, event_details, resource_id, system_details, time_occurred, time_created, time_updated, lifecycle_state, lifecycle_details, is_managed_by_autonomous_linux, freeform_tags, defined_tags, system_tags, data].hash
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
