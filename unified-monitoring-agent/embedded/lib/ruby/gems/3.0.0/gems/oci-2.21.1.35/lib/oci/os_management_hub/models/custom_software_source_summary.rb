# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220901
require 'date'
require_relative 'software_source_summary'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Indicates whether the service should create the software source from a list of packages provided by the user.
  class OsManagementHub::Models::CustomSoftwareSourceSummary < OsManagementHub::Models::SoftwareSourceSummary
    # **[Required]** List of vendor software sources that are used for the basis of the custom software source..
    # @return [Array<OCI::OsManagementHub::Models::Id>]
    attr_accessor :vendor_software_sources

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'compartment_id': :'compartmentId',
        'display_name': :'displayName',
        'repo_id': :'repoId',
        'url': :'url',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'description': :'description',
        'software_source_type': :'softwareSourceType',
        'availability': :'availability',
        'availability_at_oci': :'availabilityAtOci',
        'os_family': :'osFamily',
        'arch_type': :'archType',
        'package_count': :'packageCount',
        'lifecycle_state': :'lifecycleState',
        'size': :'size',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags',
        'vendor_software_sources': :'vendorSoftwareSources'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'compartment_id': :'String',
        'display_name': :'String',
        'repo_id': :'String',
        'url': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'description': :'String',
        'software_source_type': :'String',
        'availability': :'String',
        'availability_at_oci': :'String',
        'os_family': :'String',
        'arch_type': :'String',
        'package_count': :'Integer',
        'lifecycle_state': :'String',
        'size': :'Float',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>',
        'vendor_software_sources': :'Array<OCI::OsManagementHub::Models::Id>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#id #id} proprety
    # @option attributes [String] :compartment_id The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#compartment_id #compartment_id} proprety
    # @option attributes [String] :display_name The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#display_name #display_name} proprety
    # @option attributes [String] :repo_id The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#repo_id #repo_id} proprety
    # @option attributes [String] :url The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#url #url} proprety
    # @option attributes [DateTime] :time_created The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#time_created #time_created} proprety
    # @option attributes [DateTime] :time_updated The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#time_updated #time_updated} proprety
    # @option attributes [String] :description The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#description #description} proprety
    # @option attributes [String] :availability The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#availability #availability} proprety
    # @option attributes [String] :availability_at_oci The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#availability_at_oci #availability_at_oci} proprety
    # @option attributes [String] :os_family The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#os_family #os_family} proprety
    # @option attributes [String] :arch_type The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#arch_type #arch_type} proprety
    # @option attributes [Integer] :package_count The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#package_count #package_count} proprety
    # @option attributes [String] :lifecycle_state The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#lifecycle_state #lifecycle_state} proprety
    # @option attributes [Float] :size The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#size #size} proprety
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#freeform_tags #freeform_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#defined_tags #defined_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {OCI::OsManagementHub::Models::SoftwareSourceSummary#system_tags #system_tags} proprety
    # @option attributes [Array<OCI::OsManagementHub::Models::Id>] :vendor_software_sources The value to assign to the {#vendor_software_sources} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['softwareSourceType'] = 'CUSTOM'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.vendor_software_sources = attributes[:'vendorSoftwareSources'] if attributes[:'vendorSoftwareSources']

      raise 'You cannot provide both :vendorSoftwareSources and :vendor_software_sources' if attributes.key?(:'vendorSoftwareSources') && attributes.key?(:'vendor_software_sources')

      self.vendor_software_sources = attributes[:'vendor_software_sources'] if attributes[:'vendor_software_sources']
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
        compartment_id == other.compartment_id &&
        display_name == other.display_name &&
        repo_id == other.repo_id &&
        url == other.url &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        description == other.description &&
        software_source_type == other.software_source_type &&
        availability == other.availability &&
        availability_at_oci == other.availability_at_oci &&
        os_family == other.os_family &&
        arch_type == other.arch_type &&
        package_count == other.package_count &&
        lifecycle_state == other.lifecycle_state &&
        size == other.size &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        system_tags == other.system_tags &&
        vendor_software_sources == other.vendor_software_sources
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
      [id, compartment_id, display_name, repo_id, url, time_created, time_updated, description, software_source_type, availability, availability_at_oci, os_family, arch_type, package_count, lifecycle_state, size, freeform_tags, defined_tags, system_tags, vendor_software_sources].hash
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
