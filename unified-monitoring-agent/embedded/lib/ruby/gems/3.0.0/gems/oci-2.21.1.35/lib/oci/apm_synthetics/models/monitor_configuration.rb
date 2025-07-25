# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200630
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details of monitor configuration.
  # This class has direct subclasses. If you are using this class as input to a service operations then you should favor using a subclass over the base class
  class ApmSynthetics::Models::MonitorConfiguration
    CONFIG_TYPE_ENUM = [
      CONFIG_TYPE_BROWSER_CONFIG = 'BROWSER_CONFIG'.freeze,
      CONFIG_TYPE_SCRIPTED_BROWSER_CONFIG = 'SCRIPTED_BROWSER_CONFIG'.freeze,
      CONFIG_TYPE_REST_CONFIG = 'REST_CONFIG'.freeze,
      CONFIG_TYPE_SCRIPTED_REST_CONFIG = 'SCRIPTED_REST_CONFIG'.freeze,
      CONFIG_TYPE_NETWORK_CONFIG = 'NETWORK_CONFIG'.freeze,
      CONFIG_TYPE_DNS_SERVER_CONFIG = 'DNS_SERVER_CONFIG'.freeze,
      CONFIG_TYPE_DNS_TRACE_CONFIG = 'DNS_TRACE_CONFIG'.freeze,
      CONFIG_TYPE_DNSSEC_CONFIG = 'DNSSEC_CONFIG'.freeze,
      CONFIG_TYPE_FTP_CONFIG = 'FTP_CONFIG'.freeze,
      CONFIG_TYPE_SQL_CONFIG = 'SQL_CONFIG'.freeze,
      CONFIG_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # Type of configuration.
    # @return [String]
    attr_reader :config_type

    # If isFailureRetried is enabled, then a failed call will be retried.
    # @return [BOOLEAN]
    attr_accessor :is_failure_retried

    # @return [OCI::ApmSynthetics::Models::DnsConfiguration]
    attr_accessor :dns_configuration

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'config_type': :'configType',
        'is_failure_retried': :'isFailureRetried',
        'dns_configuration': :'dnsConfiguration'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'config_type': :'String',
        'is_failure_retried': :'BOOLEAN',
        'dns_configuration': :'OCI::ApmSynthetics::Models::DnsConfiguration'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity, Metrics/AbcSize


    # Given the hash representation of a subtype of this class,
    # use the info in the hash to return the class of the subtype.
    def self.get_subtype(object_hash)
      type = object_hash[:'configType'] # rubocop:disable Style/SymbolLiteral

      return 'OCI::ApmSynthetics::Models::FtpMonitorConfiguration' if type == 'FTP_CONFIG'
      return 'OCI::ApmSynthetics::Models::DnsSecMonitorConfiguration' if type == 'DNSSEC_CONFIG'
      return 'OCI::ApmSynthetics::Models::DnsTraceMonitorConfiguration' if type == 'DNS_TRACE_CONFIG'
      return 'OCI::ApmSynthetics::Models::SqlMonitorConfiguration' if type == 'SQL_CONFIG'
      return 'OCI::ApmSynthetics::Models::ScriptedRestMonitorConfiguration' if type == 'SCRIPTED_REST_CONFIG'
      return 'OCI::ApmSynthetics::Models::DnsServerMonitorConfiguration' if type == 'DNS_SERVER_CONFIG'
      return 'OCI::ApmSynthetics::Models::ScriptedBrowserMonitorConfiguration' if type == 'SCRIPTED_BROWSER_CONFIG'
      return 'OCI::ApmSynthetics::Models::RestMonitorConfiguration' if type == 'REST_CONFIG'
      return 'OCI::ApmSynthetics::Models::BrowserMonitorConfiguration' if type == 'BROWSER_CONFIG'
      return 'OCI::ApmSynthetics::Models::NetworkMonitorConfiguration' if type == 'NETWORK_CONFIG'

      # TODO: Log a warning when the subtype is not found.
      'OCI::ApmSynthetics::Models::MonitorConfiguration'
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity, Metrics/AbcSize

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :config_type The value to assign to the {#config_type} property
    # @option attributes [BOOLEAN] :is_failure_retried The value to assign to the {#is_failure_retried} property
    # @option attributes [OCI::ApmSynthetics::Models::DnsConfiguration] :dns_configuration The value to assign to the {#dns_configuration} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.config_type = attributes[:'configType'] if attributes[:'configType']

      raise 'You cannot provide both :configType and :config_type' if attributes.key?(:'configType') && attributes.key?(:'config_type')

      self.config_type = attributes[:'config_type'] if attributes[:'config_type']

      self.is_failure_retried = attributes[:'isFailureRetried'] unless attributes[:'isFailureRetried'].nil?
      self.is_failure_retried = true if is_failure_retried.nil? && !attributes.key?(:'isFailureRetried') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isFailureRetried and :is_failure_retried' if attributes.key?(:'isFailureRetried') && attributes.key?(:'is_failure_retried')

      self.is_failure_retried = attributes[:'is_failure_retried'] unless attributes[:'is_failure_retried'].nil?
      self.is_failure_retried = true if is_failure_retried.nil? && !attributes.key?(:'isFailureRetried') && !attributes.key?(:'is_failure_retried') # rubocop:disable Style/StringLiterals

      self.dns_configuration = attributes[:'dnsConfiguration'] if attributes[:'dnsConfiguration']

      raise 'You cannot provide both :dnsConfiguration and :dns_configuration' if attributes.key?(:'dnsConfiguration') && attributes.key?(:'dns_configuration')

      self.dns_configuration = attributes[:'dns_configuration'] if attributes[:'dns_configuration']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] config_type Object to be assigned
    def config_type=(config_type)
      # rubocop:disable Style/ConditionalAssignment
      if config_type && !CONFIG_TYPE_ENUM.include?(config_type)
        OCI.logger.debug("Unknown value for 'config_type' [" + config_type + "]. Mapping to 'CONFIG_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @config_type = CONFIG_TYPE_UNKNOWN_ENUM_VALUE
      else
        @config_type = config_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        config_type == other.config_type &&
        is_failure_retried == other.is_failure_retried &&
        dns_configuration == other.dns_configuration
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
      [config_type, is_failure_retried, dns_configuration].hash
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
