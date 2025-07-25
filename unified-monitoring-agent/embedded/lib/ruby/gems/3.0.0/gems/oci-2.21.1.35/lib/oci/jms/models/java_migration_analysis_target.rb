# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20210610
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The target describes the input data for Java migration analysis.
  # A target contains a managed instance, application Installation Key, sourceJdkVersion, targetJdkVersion and optional excludePackagePrefixes.
  #
  class Jms::Models::JavaMigrationAnalysisTarget
    # **[Required]** The OCID of the managed instance that hosts the application for which the Java migration analysis was performed.
    # @return [String]
    attr_accessor :managed_instance_id

    # **[Required]** The unique key that identifies the application's installation path that is to be used for the Java migration analysis.
    # @return [String]
    attr_accessor :application_installation_key

    # **[Required]** The JDK version the application is currently running on.
    # @return [String]
    attr_accessor :source_jdk_version

    # **[Required]** The JDK version against which the migration analysis was performed to identify effort required to move from source JDK.
    # @return [String]
    attr_accessor :target_jdk_version

    # Excludes the packages that starts with the prefix from the migration analysis result.
    # @return [Array<String>]
    attr_accessor :exclude_package_prefixes

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'managed_instance_id': :'managedInstanceId',
        'application_installation_key': :'applicationInstallationKey',
        'source_jdk_version': :'sourceJdkVersion',
        'target_jdk_version': :'targetJdkVersion',
        'exclude_package_prefixes': :'excludePackagePrefixes'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'managed_instance_id': :'String',
        'application_installation_key': :'String',
        'source_jdk_version': :'String',
        'target_jdk_version': :'String',
        'exclude_package_prefixes': :'Array<String>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :managed_instance_id The value to assign to the {#managed_instance_id} property
    # @option attributes [String] :application_installation_key The value to assign to the {#application_installation_key} property
    # @option attributes [String] :source_jdk_version The value to assign to the {#source_jdk_version} property
    # @option attributes [String] :target_jdk_version The value to assign to the {#target_jdk_version} property
    # @option attributes [Array<String>] :exclude_package_prefixes The value to assign to the {#exclude_package_prefixes} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.managed_instance_id = attributes[:'managedInstanceId'] if attributes[:'managedInstanceId']

      raise 'You cannot provide both :managedInstanceId and :managed_instance_id' if attributes.key?(:'managedInstanceId') && attributes.key?(:'managed_instance_id')

      self.managed_instance_id = attributes[:'managed_instance_id'] if attributes[:'managed_instance_id']

      self.application_installation_key = attributes[:'applicationInstallationKey'] if attributes[:'applicationInstallationKey']

      raise 'You cannot provide both :applicationInstallationKey and :application_installation_key' if attributes.key?(:'applicationInstallationKey') && attributes.key?(:'application_installation_key')

      self.application_installation_key = attributes[:'application_installation_key'] if attributes[:'application_installation_key']

      self.source_jdk_version = attributes[:'sourceJdkVersion'] if attributes[:'sourceJdkVersion']

      raise 'You cannot provide both :sourceJdkVersion and :source_jdk_version' if attributes.key?(:'sourceJdkVersion') && attributes.key?(:'source_jdk_version')

      self.source_jdk_version = attributes[:'source_jdk_version'] if attributes[:'source_jdk_version']

      self.target_jdk_version = attributes[:'targetJdkVersion'] if attributes[:'targetJdkVersion']

      raise 'You cannot provide both :targetJdkVersion and :target_jdk_version' if attributes.key?(:'targetJdkVersion') && attributes.key?(:'target_jdk_version')

      self.target_jdk_version = attributes[:'target_jdk_version'] if attributes[:'target_jdk_version']

      self.exclude_package_prefixes = attributes[:'excludePackagePrefixes'] if attributes[:'excludePackagePrefixes']

      raise 'You cannot provide both :excludePackagePrefixes and :exclude_package_prefixes' if attributes.key?(:'excludePackagePrefixes') && attributes.key?(:'exclude_package_prefixes')

      self.exclude_package_prefixes = attributes[:'exclude_package_prefixes'] if attributes[:'exclude_package_prefixes']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        managed_instance_id == other.managed_instance_id &&
        application_installation_key == other.application_installation_key &&
        source_jdk_version == other.source_jdk_version &&
        target_jdk_version == other.target_jdk_version &&
        exclude_package_prefixes == other.exclude_package_prefixes
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
      [managed_instance_id, application_installation_key, source_jdk_version, target_jdk_version, exclude_package_prefixes].hash
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
