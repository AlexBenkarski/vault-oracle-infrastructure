# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A virtual cloud network (VCN). For more information, see
  # [Overview of the Networking Service](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm).
  #
  # To use any of the API operations, you must be authorized in an IAM policy. If you're not authorized,
  # talk to an administrator. If you're an administrator who needs to write policies to give users access, see
  # [Getting Started with Policies](https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/policygetstarted.htm).
  #
  class VnMonitoring::Models::Vcn
    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_PROVISIONING = 'PROVISIONING'.freeze,
      LIFECYCLE_STATE_AVAILABLE = 'AVAILABLE'.freeze,
      LIFECYCLE_STATE_TERMINATING = 'TERMINATING'.freeze,
      LIFECYCLE_STATE_TERMINATED = 'TERMINATED'.freeze,
      LIFECYCLE_STATE_UPDATING = 'UPDATING'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # The list of BYOIPv6 CIDR blocks required to create a VCN that uses BYOIPv6 ranges.
    #
    # @return [Array<String>]
    attr_accessor :byoipv6_cidr_blocks

    # For an IPv6-enabled VCN, this is the list of Private IPv6 CIDR blocks for the VCN's IP address space.
    #
    # @return [Array<String>]
    attr_accessor :ipv6_private_cidr_blocks

    # **[Required]** Deprecated. The first CIDR IP address from cidrBlocks.
    #
    # Example: `172.16.0.0/16`
    #
    # @return [String]
    attr_accessor :cidr_block

    # **[Required]** The list of IPv4 CIDR blocks the VCN will use.
    #
    # @return [Array<String>]
    attr_accessor :cidr_blocks

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the compartment containing the VCN.
    # @return [String]
    attr_accessor :compartment_id

    # The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) for the VCN's default set of DHCP options.
    #
    # @return [String]
    attr_accessor :default_dhcp_options_id

    # The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) for the VCN's default route table.
    # @return [String]
    attr_accessor :default_route_table_id

    # The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) for the VCN's default security list.
    # @return [String]
    attr_accessor :default_security_list_id

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # Example: `{\"foo-namespace\": {\"bar-key\": \"value\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # A user-friendly name. Does not have to be unique, and it's changeable.
    # Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :display_name

    # A DNS label for the VCN, used in conjunction with the VNIC's hostname and
    # subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC
    # within this subnet (for example, `bminstance1.subnet123.vcn1.oraclevcn.com`).
    # Must be an alphanumeric string that begins with a letter.
    # The value cannot be changed.
    #
    # The absence of this parameter means the Internet and VCN Resolver will
    # not work for this VCN.
    #
    # For more information, see
    # [DNS in Your Virtual Cloud Network](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/dns.htm).
    #
    # Example: `vcn1`
    #
    # @return [String]
    attr_accessor :dns_label

    # Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only.
    # Example: `{\"bar-key\": \"value\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # **[Required]** The VCN's Oracle ID ([OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm)).
    # @return [String]
    attr_accessor :id

    # For an IPv6-enabled VCN, this is the list of IPv6 CIDR blocks for the VCN's IP address space.
    # The CIDRs are provided by Oracle and the sizes are always /56.
    #
    # @return [Array<String>]
    attr_accessor :ipv6_cidr_blocks

    # **[Required]** The VCN's current state.
    # @return [String]
    attr_reader :lifecycle_state

    # The date and time the VCN was created, in the format defined by [RFC3339](https://tools.ietf.org/html/rfc3339).
    #
    # Example: `2016-08-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_created

    # The VCN's domain name, which consists of the VCN's DNS label, and the
    # `oraclevcn.com` domain.
    #
    # For more information, see
    # [DNS in Your Virtual Cloud Network](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/dns.htm).
    #
    # Example: `vcn1.oraclevcn.com`
    #
    # @return [String]
    attr_accessor :vcn_domain_name

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'byoipv6_cidr_blocks': :'byoipv6CidrBlocks',
        'ipv6_private_cidr_blocks': :'ipv6PrivateCidrBlocks',
        'cidr_block': :'cidrBlock',
        'cidr_blocks': :'cidrBlocks',
        'compartment_id': :'compartmentId',
        'default_dhcp_options_id': :'defaultDhcpOptionsId',
        'default_route_table_id': :'defaultRouteTableId',
        'default_security_list_id': :'defaultSecurityListId',
        'defined_tags': :'definedTags',
        'display_name': :'displayName',
        'dns_label': :'dnsLabel',
        'freeform_tags': :'freeformTags',
        'id': :'id',
        'ipv6_cidr_blocks': :'ipv6CidrBlocks',
        'lifecycle_state': :'lifecycleState',
        'time_created': :'timeCreated',
        'vcn_domain_name': :'vcnDomainName'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'byoipv6_cidr_blocks': :'Array<String>',
        'ipv6_private_cidr_blocks': :'Array<String>',
        'cidr_block': :'String',
        'cidr_blocks': :'Array<String>',
        'compartment_id': :'String',
        'default_dhcp_options_id': :'String',
        'default_route_table_id': :'String',
        'default_security_list_id': :'String',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'display_name': :'String',
        'dns_label': :'String',
        'freeform_tags': :'Hash<String, String>',
        'id': :'String',
        'ipv6_cidr_blocks': :'Array<String>',
        'lifecycle_state': :'String',
        'time_created': :'DateTime',
        'vcn_domain_name': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [Array<String>] :byoipv6_cidr_blocks The value to assign to the {#byoipv6_cidr_blocks} property
    # @option attributes [Array<String>] :ipv6_private_cidr_blocks The value to assign to the {#ipv6_private_cidr_blocks} property
    # @option attributes [String] :cidr_block The value to assign to the {#cidr_block} property
    # @option attributes [Array<String>] :cidr_blocks The value to assign to the {#cidr_blocks} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :default_dhcp_options_id The value to assign to the {#default_dhcp_options_id} property
    # @option attributes [String] :default_route_table_id The value to assign to the {#default_route_table_id} property
    # @option attributes [String] :default_security_list_id The value to assign to the {#default_security_list_id} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :dns_label The value to assign to the {#dns_label} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [Array<String>] :ipv6_cidr_blocks The value to assign to the {#ipv6_cidr_blocks} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [String] :vcn_domain_name The value to assign to the {#vcn_domain_name} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.byoipv6_cidr_blocks = attributes[:'byoipv6CidrBlocks'] if attributes[:'byoipv6CidrBlocks']

      raise 'You cannot provide both :byoipv6CidrBlocks and :byoipv6_cidr_blocks' if attributes.key?(:'byoipv6CidrBlocks') && attributes.key?(:'byoipv6_cidr_blocks')

      self.byoipv6_cidr_blocks = attributes[:'byoipv6_cidr_blocks'] if attributes[:'byoipv6_cidr_blocks']

      self.ipv6_private_cidr_blocks = attributes[:'ipv6PrivateCidrBlocks'] if attributes[:'ipv6PrivateCidrBlocks']

      raise 'You cannot provide both :ipv6PrivateCidrBlocks and :ipv6_private_cidr_blocks' if attributes.key?(:'ipv6PrivateCidrBlocks') && attributes.key?(:'ipv6_private_cidr_blocks')

      self.ipv6_private_cidr_blocks = attributes[:'ipv6_private_cidr_blocks'] if attributes[:'ipv6_private_cidr_blocks']

      self.cidr_block = attributes[:'cidrBlock'] if attributes[:'cidrBlock']

      raise 'You cannot provide both :cidrBlock and :cidr_block' if attributes.key?(:'cidrBlock') && attributes.key?(:'cidr_block')

      self.cidr_block = attributes[:'cidr_block'] if attributes[:'cidr_block']

      self.cidr_blocks = attributes[:'cidrBlocks'] if attributes[:'cidrBlocks']

      raise 'You cannot provide both :cidrBlocks and :cidr_blocks' if attributes.key?(:'cidrBlocks') && attributes.key?(:'cidr_blocks')

      self.cidr_blocks = attributes[:'cidr_blocks'] if attributes[:'cidr_blocks']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.default_dhcp_options_id = attributes[:'defaultDhcpOptionsId'] if attributes[:'defaultDhcpOptionsId']

      raise 'You cannot provide both :defaultDhcpOptionsId and :default_dhcp_options_id' if attributes.key?(:'defaultDhcpOptionsId') && attributes.key?(:'default_dhcp_options_id')

      self.default_dhcp_options_id = attributes[:'default_dhcp_options_id'] if attributes[:'default_dhcp_options_id']

      self.default_route_table_id = attributes[:'defaultRouteTableId'] if attributes[:'defaultRouteTableId']

      raise 'You cannot provide both :defaultRouteTableId and :default_route_table_id' if attributes.key?(:'defaultRouteTableId') && attributes.key?(:'default_route_table_id')

      self.default_route_table_id = attributes[:'default_route_table_id'] if attributes[:'default_route_table_id']

      self.default_security_list_id = attributes[:'defaultSecurityListId'] if attributes[:'defaultSecurityListId']

      raise 'You cannot provide both :defaultSecurityListId and :default_security_list_id' if attributes.key?(:'defaultSecurityListId') && attributes.key?(:'default_security_list_id')

      self.default_security_list_id = attributes[:'default_security_list_id'] if attributes[:'default_security_list_id']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.dns_label = attributes[:'dnsLabel'] if attributes[:'dnsLabel']

      raise 'You cannot provide both :dnsLabel and :dns_label' if attributes.key?(:'dnsLabel') && attributes.key?(:'dns_label')

      self.dns_label = attributes[:'dns_label'] if attributes[:'dns_label']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.id = attributes[:'id'] if attributes[:'id']

      self.ipv6_cidr_blocks = attributes[:'ipv6CidrBlocks'] if attributes[:'ipv6CidrBlocks']

      raise 'You cannot provide both :ipv6CidrBlocks and :ipv6_cidr_blocks' if attributes.key?(:'ipv6CidrBlocks') && attributes.key?(:'ipv6_cidr_blocks')

      self.ipv6_cidr_blocks = attributes[:'ipv6_cidr_blocks'] if attributes[:'ipv6_cidr_blocks']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.vcn_domain_name = attributes[:'vcnDomainName'] if attributes[:'vcnDomainName']

      raise 'You cannot provide both :vcnDomainName and :vcn_domain_name' if attributes.key?(:'vcnDomainName') && attributes.key?(:'vcn_domain_name')

      self.vcn_domain_name = attributes[:'vcn_domain_name'] if attributes[:'vcn_domain_name']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

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
        byoipv6_cidr_blocks == other.byoipv6_cidr_blocks &&
        ipv6_private_cidr_blocks == other.ipv6_private_cidr_blocks &&
        cidr_block == other.cidr_block &&
        cidr_blocks == other.cidr_blocks &&
        compartment_id == other.compartment_id &&
        default_dhcp_options_id == other.default_dhcp_options_id &&
        default_route_table_id == other.default_route_table_id &&
        default_security_list_id == other.default_security_list_id &&
        defined_tags == other.defined_tags &&
        display_name == other.display_name &&
        dns_label == other.dns_label &&
        freeform_tags == other.freeform_tags &&
        id == other.id &&
        ipv6_cidr_blocks == other.ipv6_cidr_blocks &&
        lifecycle_state == other.lifecycle_state &&
        time_created == other.time_created &&
        vcn_domain_name == other.vcn_domain_name
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
      [byoipv6_cidr_blocks, ipv6_private_cidr_blocks, cidr_block, cidr_blocks, compartment_id, default_dhcp_options_id, default_route_table_id, default_security_list_id, defined_tags, display_name, dns_label, freeform_tags, id, ipv6_cidr_blocks, lifecycle_state, time_created, vcn_domain_name].hash
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
