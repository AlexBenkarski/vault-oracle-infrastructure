# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A rule for allowing inbound IP packets.
  class VnMonitoring::Models::IngressSecurityRule
    SOURCE_TYPE_ENUM = [
      SOURCE_TYPE_CIDR_BLOCK = 'CIDR_BLOCK'.freeze,
      SOURCE_TYPE_SERVICE_CIDR_BLOCK = 'SERVICE_CIDR_BLOCK'.freeze,
      SOURCE_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # @return [OCI::VnMonitoring::Models::IcmpOptions]
    attr_accessor :icmp_options

    # A stateless rule allows traffic in one direction. Remember to add a corresponding
    # stateless rule in the other direction if you need to support bidirectional traffic. For
    # example, if ingress traffic allows TCP destination port 80, there should be an egress
    # rule to allow TCP source port 80. Defaults to false, which means the rule is stateful
    # and a corresponding rule is not necessary for bidirectional traffic.
    #
    # @return [BOOLEAN]
    attr_accessor :is_stateless

    # **[Required]** The transport protocol. Specify either `all` or an IPv4 protocol number as
    # defined in
    # [Protocol Numbers](http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
    # Options are supported only for ICMP (\"1\"), TCP (\"6\"), UDP (\"17\"), and ICMPv6 (\"58\").
    #
    # @return [String]
    attr_accessor :protocol

    # **[Required]** Conceptually, this is the range of IP addresses that a packet coming into the instance
    # can come from.
    #
    # Allowed values:
    #
    #   * IP address range in CIDR notation. For example: `192.168.1.0/24` or `2001:0db8:0123:45::/56`.
    #     IPv6 addressing is supported for all commercial and government regions. See
    #     [IPv6 Addresses](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/ipv6.htm).
    #
    #   * The `cidrBlock` value for a {Service}, if you're
    #     setting up a security list rule for traffic coming from a particular `Service` through
    #     a service gateway. For example: `oci-phx-objectstorage`.
    #
    # @return [String]
    attr_accessor :source

    # Type of source for the rule. The default is `CIDR_BLOCK`.
    #
    #   * `CIDR_BLOCK`: If the rule's `source` is an IP address range in CIDR notation.
    #
    #   * `SERVICE_CIDR_BLOCK`: If the rule's `source` is the `cidrBlock` value for a
    #     {Service} (the rule is for traffic coming from a
    #     particular `Service` through a service gateway).
    #
    # @return [String]
    attr_reader :source_type

    # @return [OCI::VnMonitoring::Models::TcpOptions]
    attr_accessor :tcp_options

    # @return [OCI::VnMonitoring::Models::UdpOptions]
    attr_accessor :udp_options

    # An optional description of your choice for the rule.
    #
    # @return [String]
    attr_accessor :description

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'icmp_options': :'icmpOptions',
        'is_stateless': :'isStateless',
        'protocol': :'protocol',
        'source': :'source',
        'source_type': :'sourceType',
        'tcp_options': :'tcpOptions',
        'udp_options': :'udpOptions',
        'description': :'description'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'icmp_options': :'OCI::VnMonitoring::Models::IcmpOptions',
        'is_stateless': :'BOOLEAN',
        'protocol': :'String',
        'source': :'String',
        'source_type': :'String',
        'tcp_options': :'OCI::VnMonitoring::Models::TcpOptions',
        'udp_options': :'OCI::VnMonitoring::Models::UdpOptions',
        'description': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [OCI::VnMonitoring::Models::IcmpOptions] :icmp_options The value to assign to the {#icmp_options} property
    # @option attributes [BOOLEAN] :is_stateless The value to assign to the {#is_stateless} property
    # @option attributes [String] :protocol The value to assign to the {#protocol} property
    # @option attributes [String] :source The value to assign to the {#source} property
    # @option attributes [String] :source_type The value to assign to the {#source_type} property
    # @option attributes [OCI::VnMonitoring::Models::TcpOptions] :tcp_options The value to assign to the {#tcp_options} property
    # @option attributes [OCI::VnMonitoring::Models::UdpOptions] :udp_options The value to assign to the {#udp_options} property
    # @option attributes [String] :description The value to assign to the {#description} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.icmp_options = attributes[:'icmpOptions'] if attributes[:'icmpOptions']

      raise 'You cannot provide both :icmpOptions and :icmp_options' if attributes.key?(:'icmpOptions') && attributes.key?(:'icmp_options')

      self.icmp_options = attributes[:'icmp_options'] if attributes[:'icmp_options']

      self.is_stateless = attributes[:'isStateless'] unless attributes[:'isStateless'].nil?

      raise 'You cannot provide both :isStateless and :is_stateless' if attributes.key?(:'isStateless') && attributes.key?(:'is_stateless')

      self.is_stateless = attributes[:'is_stateless'] unless attributes[:'is_stateless'].nil?

      self.protocol = attributes[:'protocol'] if attributes[:'protocol']

      self.source = attributes[:'source'] if attributes[:'source']

      self.source_type = attributes[:'sourceType'] if attributes[:'sourceType']
      self.source_type = "CIDR_BLOCK" if source_type.nil? && !attributes.key?(:'sourceType') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :sourceType and :source_type' if attributes.key?(:'sourceType') && attributes.key?(:'source_type')

      self.source_type = attributes[:'source_type'] if attributes[:'source_type']
      self.source_type = "CIDR_BLOCK" if source_type.nil? && !attributes.key?(:'sourceType') && !attributes.key?(:'source_type') # rubocop:disable Style/StringLiterals

      self.tcp_options = attributes[:'tcpOptions'] if attributes[:'tcpOptions']

      raise 'You cannot provide both :tcpOptions and :tcp_options' if attributes.key?(:'tcpOptions') && attributes.key?(:'tcp_options')

      self.tcp_options = attributes[:'tcp_options'] if attributes[:'tcp_options']

      self.udp_options = attributes[:'udpOptions'] if attributes[:'udpOptions']

      raise 'You cannot provide both :udpOptions and :udp_options' if attributes.key?(:'udpOptions') && attributes.key?(:'udp_options')

      self.udp_options = attributes[:'udp_options'] if attributes[:'udp_options']

      self.description = attributes[:'description'] if attributes[:'description']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] source_type Object to be assigned
    def source_type=(source_type)
      # rubocop:disable Style/ConditionalAssignment
      if source_type && !SOURCE_TYPE_ENUM.include?(source_type)
        OCI.logger.debug("Unknown value for 'source_type' [" + source_type + "]. Mapping to 'SOURCE_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @source_type = SOURCE_TYPE_UNKNOWN_ENUM_VALUE
      else
        @source_type = source_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        icmp_options == other.icmp_options &&
        is_stateless == other.is_stateless &&
        protocol == other.protocol &&
        source == other.source &&
        source_type == other.source_type &&
        tcp_options == other.tcp_options &&
        udp_options == other.udp_options &&
        description == other.description
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
      [icmp_options, is_stateless, protocol, source, source_type, tcp_options, udp_options, description].hash
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
