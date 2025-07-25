# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220901
require 'date'
require_relative 'create_profile_details'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Provides the information used to create the management station profile.
  class OsManagementHub::Models::CreateStationProfileDetails < OsManagementHub::Models::CreateProfileDetails
    VENDOR_NAME_ENUM = [
      VENDOR_NAME_ORACLE = 'ORACLE'.freeze,
      VENDOR_NAME_MICROSOFT = 'MICROSOFT'.freeze
    ].freeze

    OS_FAMILY_ENUM = [
      OS_FAMILY_ORACLE_LINUX_9 = 'ORACLE_LINUX_9'.freeze,
      OS_FAMILY_ORACLE_LINUX_8 = 'ORACLE_LINUX_8'.freeze,
      OS_FAMILY_ORACLE_LINUX_7 = 'ORACLE_LINUX_7'.freeze,
      OS_FAMILY_ORACLE_LINUX_6 = 'ORACLE_LINUX_6'.freeze,
      OS_FAMILY_WINDOWS_SERVER_2016 = 'WINDOWS_SERVER_2016'.freeze,
      OS_FAMILY_WINDOWS_SERVER_2019 = 'WINDOWS_SERVER_2019'.freeze,
      OS_FAMILY_WINDOWS_SERVER_2022 = 'WINDOWS_SERVER_2022'.freeze,
      OS_FAMILY_ALL = 'ALL'.freeze
    ].freeze

    ARCH_TYPE_ENUM = [
      ARCH_TYPE_X86_64 = 'X86_64'.freeze,
      ARCH_TYPE_AARCH64 = 'AARCH64'.freeze,
      ARCH_TYPE_I686 = 'I686'.freeze,
      ARCH_TYPE_NOARCH = 'NOARCH'.freeze,
      ARCH_TYPE_SRC = 'SRC'.freeze
    ].freeze

    # The vendor of the operating system for the instance.
    # @return [String]
    attr_reader :vendor_name

    # The operating system family.
    # @return [String]
    attr_reader :os_family

    # The architecture type.
    # @return [String]
    attr_reader :arch_type

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'displayName',
        'compartment_id': :'compartmentId',
        'description': :'description',
        'management_station_id': :'managementStationId',
        'profile_type': :'profileType',
        'registration_type': :'registrationType',
        'is_default_profile': :'isDefaultProfile',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'vendor_name': :'vendorName',
        'os_family': :'osFamily',
        'arch_type': :'archType'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'String',
        'compartment_id': :'String',
        'description': :'String',
        'management_station_id': :'String',
        'profile_type': :'String',
        'registration_type': :'String',
        'is_default_profile': :'BOOLEAN',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'vendor_name': :'String',
        'os_family': :'String',
        'arch_type': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :display_name The value to assign to the {OCI::OsManagementHub::Models::CreateProfileDetails#display_name #display_name} proprety
    # @option attributes [String] :compartment_id The value to assign to the {OCI::OsManagementHub::Models::CreateProfileDetails#compartment_id #compartment_id} proprety
    # @option attributes [String] :description The value to assign to the {OCI::OsManagementHub::Models::CreateProfileDetails#description #description} proprety
    # @option attributes [String] :management_station_id The value to assign to the {OCI::OsManagementHub::Models::CreateProfileDetails#management_station_id #management_station_id} proprety
    # @option attributes [String] :registration_type The value to assign to the {OCI::OsManagementHub::Models::CreateProfileDetails#registration_type #registration_type} proprety
    # @option attributes [BOOLEAN] :is_default_profile The value to assign to the {OCI::OsManagementHub::Models::CreateProfileDetails#is_default_profile #is_default_profile} proprety
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {OCI::OsManagementHub::Models::CreateProfileDetails#freeform_tags #freeform_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {OCI::OsManagementHub::Models::CreateProfileDetails#defined_tags #defined_tags} proprety
    # @option attributes [String] :vendor_name The value to assign to the {#vendor_name} property
    # @option attributes [String] :os_family The value to assign to the {#os_family} property
    # @option attributes [String] :arch_type The value to assign to the {#arch_type} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['profileType'] = 'STATION'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.vendor_name = attributes[:'vendorName'] if attributes[:'vendorName']

      raise 'You cannot provide both :vendorName and :vendor_name' if attributes.key?(:'vendorName') && attributes.key?(:'vendor_name')

      self.vendor_name = attributes[:'vendor_name'] if attributes[:'vendor_name']

      self.os_family = attributes[:'osFamily'] if attributes[:'osFamily']

      raise 'You cannot provide both :osFamily and :os_family' if attributes.key?(:'osFamily') && attributes.key?(:'os_family')

      self.os_family = attributes[:'os_family'] if attributes[:'os_family']

      self.arch_type = attributes[:'archType'] if attributes[:'archType']

      raise 'You cannot provide both :archType and :arch_type' if attributes.key?(:'archType') && attributes.key?(:'arch_type')

      self.arch_type = attributes[:'arch_type'] if attributes[:'arch_type']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] vendor_name Object to be assigned
    def vendor_name=(vendor_name)
      raise "Invalid value for 'vendor_name': this must be one of the values in VENDOR_NAME_ENUM." if vendor_name && !VENDOR_NAME_ENUM.include?(vendor_name)

      @vendor_name = vendor_name
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] os_family Object to be assigned
    def os_family=(os_family)
      raise "Invalid value for 'os_family': this must be one of the values in OS_FAMILY_ENUM." if os_family && !OS_FAMILY_ENUM.include?(os_family)

      @os_family = os_family
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] arch_type Object to be assigned
    def arch_type=(arch_type)
      raise "Invalid value for 'arch_type': this must be one of the values in ARCH_TYPE_ENUM." if arch_type && !ARCH_TYPE_ENUM.include?(arch_type)

      @arch_type = arch_type
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        display_name == other.display_name &&
        compartment_id == other.compartment_id &&
        description == other.description &&
        management_station_id == other.management_station_id &&
        profile_type == other.profile_type &&
        registration_type == other.registration_type &&
        is_default_profile == other.is_default_profile &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        vendor_name == other.vendor_name &&
        os_family == other.os_family &&
        arch_type == other.arch_type
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
      [display_name, compartment_id, description, management_station_id, profile_type, registration_type, is_default_profile, freeform_tags, defined_tags, vendor_name, os_family, arch_type].hash
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
