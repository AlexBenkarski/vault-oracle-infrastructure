# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230701
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A summary of the SDDC.
  class Ocvp::Models::SddcSummary
    HCX_MODE_ENUM = [
      HCX_MODE_DISABLED = 'DISABLED'.freeze,
      HCX_MODE_ADVANCED = 'ADVANCED'.freeze,
      HCX_MODE_ENTERPRISE = 'ENTERPRISE'.freeze,
      HCX_MODE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_CREATING = 'CREATING'.freeze,
      LIFECYCLE_STATE_UPDATING = 'UPDATING'.freeze,
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_DELETING = 'DELETING'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the compartment that
    # contains the SDDC.
    #
    # @return [String]
    attr_accessor :id

    # **[Required]** A descriptive name for the SDDC. It must be unique, start with a letter, and contain only letters, digits,
    # whitespaces, dashes and underscores.
    # Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :display_name

    # **[Required]** In general, this is a specific version of bundled VMware software supported by
    # Oracle Cloud VMware Solution (see
    # {#list_supported_vmware_software_versions list_supported_vmware_software_versions}).
    #
    # This attribute is not guaranteed to reflect the version of
    # software currently installed on the ESXi hosts in the SDDC. The purpose
    # of this attribute is to show the version of software that the Oracle
    # Cloud VMware Solution will install on any new ESXi hosts that you *add to this
    # SDDC in the future* with {#create_esxi_host create_esxi_host}.
    #
    # Therefore, if you upgrade the existing ESXi hosts in the SDDC to use a newer
    # version of bundled VMware software supported by the Oracle Cloud VMware Solution, you
    # should use {#update_sddc update_sddc} to update the SDDC's
    # `vmwareSoftwareVersion` with that new version.
    #
    # @return [String]
    attr_accessor :vmware_software_version

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the compartment that
    # contains the SDDC.
    #
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** The number of ESXi hosts in the SDDC.
    # @return [Integer]
    attr_accessor :clusters_count

    # HCX Fully Qualified Domain Name
    # @return [String]
    attr_accessor :hcx_fqdn

    # HCX configuration of the SDDC.
    #
    # @return [String]
    attr_reader :hcx_mode

    # FQDN for vCenter
    #
    # Example: `vcenter-my-sddc.sddc.us-phoenix-1.oraclecloud.com`
    #
    # @return [String]
    attr_accessor :vcenter_fqdn

    # FQDN for NSX Manager
    #
    # Example: `nsx-my-sddc.sddc.us-phoenix-1.oraclecloud.com`
    #
    # @return [String]
    attr_accessor :nsx_manager_fqdn

    # The date and time the SDDC was created, in the format defined by
    # [RFC3339](https://tools.ietf.org/html/rfc3339).
    #
    # Example: `2016-08-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_created

    # The date and time the SDDC was updated, in the format defined by
    # [RFC3339](https://tools.ietf.org/html/rfc3339).
    #
    # @return [DateTime]
    attr_accessor :time_updated

    # The current state of the SDDC.
    # @return [String]
    attr_reader :lifecycle_state

    # Indicates whether this SDDC is designated for only single ESXi host.
    # @return [BOOLEAN]
    attr_accessor :is_single_host_sddc

    # **[Required]** Free-form tags for this resource. Each tag is a simple key-value pair with no
    # predefined name, type, or namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # **[Required]** Defined tags for this resource. Each key is predefined and scoped to a
    # namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Usage of system tag keys. These predefined keys are scoped to namespaces.
    # Example: `{orcl-cloud: {free-tier-retain: true}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :system_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'display_name': :'displayName',
        'vmware_software_version': :'vmwareSoftwareVersion',
        'compartment_id': :'compartmentId',
        'clusters_count': :'clustersCount',
        'hcx_fqdn': :'hcxFqdn',
        'hcx_mode': :'hcxMode',
        'vcenter_fqdn': :'vcenterFqdn',
        'nsx_manager_fqdn': :'nsxManagerFqdn',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'lifecycle_state': :'lifecycleState',
        'is_single_host_sddc': :'isSingleHostSddc',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'display_name': :'String',
        'vmware_software_version': :'String',
        'compartment_id': :'String',
        'clusters_count': :'Integer',
        'hcx_fqdn': :'String',
        'hcx_mode': :'String',
        'vcenter_fqdn': :'String',
        'nsx_manager_fqdn': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'lifecycle_state': :'String',
        'is_single_host_sddc': :'BOOLEAN',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :vmware_software_version The value to assign to the {#vmware_software_version} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [Integer] :clusters_count The value to assign to the {#clusters_count} property
    # @option attributes [String] :hcx_fqdn The value to assign to the {#hcx_fqdn} property
    # @option attributes [String] :hcx_mode The value to assign to the {#hcx_mode} property
    # @option attributes [String] :vcenter_fqdn The value to assign to the {#vcenter_fqdn} property
    # @option attributes [String] :nsx_manager_fqdn The value to assign to the {#nsx_manager_fqdn} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [BOOLEAN] :is_single_host_sddc The value to assign to the {#is_single_host_sddc} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {#system_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.vmware_software_version = attributes[:'vmwareSoftwareVersion'] if attributes[:'vmwareSoftwareVersion']

      raise 'You cannot provide both :vmwareSoftwareVersion and :vmware_software_version' if attributes.key?(:'vmwareSoftwareVersion') && attributes.key?(:'vmware_software_version')

      self.vmware_software_version = attributes[:'vmware_software_version'] if attributes[:'vmware_software_version']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.clusters_count = attributes[:'clustersCount'] if attributes[:'clustersCount']

      raise 'You cannot provide both :clustersCount and :clusters_count' if attributes.key?(:'clustersCount') && attributes.key?(:'clusters_count')

      self.clusters_count = attributes[:'clusters_count'] if attributes[:'clusters_count']

      self.hcx_fqdn = attributes[:'hcxFqdn'] if attributes[:'hcxFqdn']

      raise 'You cannot provide both :hcxFqdn and :hcx_fqdn' if attributes.key?(:'hcxFqdn') && attributes.key?(:'hcx_fqdn')

      self.hcx_fqdn = attributes[:'hcx_fqdn'] if attributes[:'hcx_fqdn']

      self.hcx_mode = attributes[:'hcxMode'] if attributes[:'hcxMode']

      raise 'You cannot provide both :hcxMode and :hcx_mode' if attributes.key?(:'hcxMode') && attributes.key?(:'hcx_mode')

      self.hcx_mode = attributes[:'hcx_mode'] if attributes[:'hcx_mode']

      self.vcenter_fqdn = attributes[:'vcenterFqdn'] if attributes[:'vcenterFqdn']

      raise 'You cannot provide both :vcenterFqdn and :vcenter_fqdn' if attributes.key?(:'vcenterFqdn') && attributes.key?(:'vcenter_fqdn')

      self.vcenter_fqdn = attributes[:'vcenter_fqdn'] if attributes[:'vcenter_fqdn']

      self.nsx_manager_fqdn = attributes[:'nsxManagerFqdn'] if attributes[:'nsxManagerFqdn']

      raise 'You cannot provide both :nsxManagerFqdn and :nsx_manager_fqdn' if attributes.key?(:'nsxManagerFqdn') && attributes.key?(:'nsx_manager_fqdn')

      self.nsx_manager_fqdn = attributes[:'nsx_manager_fqdn'] if attributes[:'nsx_manager_fqdn']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.is_single_host_sddc = attributes[:'isSingleHostSddc'] unless attributes[:'isSingleHostSddc'].nil?
      self.is_single_host_sddc = false if is_single_host_sddc.nil? && !attributes.key?(:'isSingleHostSddc') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isSingleHostSddc and :is_single_host_sddc' if attributes.key?(:'isSingleHostSddc') && attributes.key?(:'is_single_host_sddc')

      self.is_single_host_sddc = attributes[:'is_single_host_sddc'] unless attributes[:'is_single_host_sddc'].nil?
      self.is_single_host_sddc = false if is_single_host_sddc.nil? && !attributes.key?(:'isSingleHostSddc') && !attributes.key?(:'is_single_host_sddc') # rubocop:disable Style/StringLiterals

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.system_tags = attributes[:'systemTags'] if attributes[:'systemTags']

      raise 'You cannot provide both :systemTags and :system_tags' if attributes.key?(:'systemTags') && attributes.key?(:'system_tags')

      self.system_tags = attributes[:'system_tags'] if attributes[:'system_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] hcx_mode Object to be assigned
    def hcx_mode=(hcx_mode)
      # rubocop:disable Style/ConditionalAssignment
      if hcx_mode && !HCX_MODE_ENUM.include?(hcx_mode)
        OCI.logger.debug("Unknown value for 'hcx_mode' [" + hcx_mode + "]. Mapping to 'HCX_MODE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @hcx_mode = HCX_MODE_UNKNOWN_ENUM_VALUE
      else
        @hcx_mode = hcx_mode
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] lifecycle_state Object to be assigned
    def lifecycle_state=(lifecycle_state)
      # rubocop:disable Style/ConditionalAssignment
      if lifecycle_state && !LIFECYCLE_STATE_ENUM.include?(lifecycle_state)
        OCI.logger.debug("Unknown value for 'lifecycle_state' [" + lifecycle_state + "]. Mapping to 'LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @lifecycle_state = LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE
      else
        @lifecycle_state = lifecycle_state
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        id == other.id &&
        display_name == other.display_name &&
        vmware_software_version == other.vmware_software_version &&
        compartment_id == other.compartment_id &&
        clusters_count == other.clusters_count &&
        hcx_fqdn == other.hcx_fqdn &&
        hcx_mode == other.hcx_mode &&
        vcenter_fqdn == other.vcenter_fqdn &&
        nsx_manager_fqdn == other.nsx_manager_fqdn &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        lifecycle_state == other.lifecycle_state &&
        is_single_host_sddc == other.is_single_host_sddc &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        system_tags == other.system_tags
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
      [id, display_name, vmware_software_version, compartment_id, clusters_count, hcx_fqdn, hcx_mode, vcenter_fqdn, nsx_manager_fqdn, time_created, time_updated, lifecycle_state, is_single_host_sddc, freeform_tags, defined_tags, system_tags].hash
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
