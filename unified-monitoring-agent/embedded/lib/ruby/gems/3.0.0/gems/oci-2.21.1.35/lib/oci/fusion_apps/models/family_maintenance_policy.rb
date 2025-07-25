# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20211201
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The policy that specifies the maintenance and upgrade preferences for an environment. For more information about the options, see [Understanding Environment Maintenance](https://docs.cloud.oracle.com/iaas/Content/fusion-applications/plan-environment-family.htm#about-env-maintenance).
  class FusionApps::Models::FamilyMaintenancePolicy
    CONCURRENT_MAINTENANCE_ENUM = [
      CONCURRENT_MAINTENANCE_PROD = 'PROD'.freeze,
      CONCURRENT_MAINTENANCE_NON_PROD = 'NON_PROD'.freeze,
      CONCURRENT_MAINTENANCE_DISABLED = 'DISABLED'.freeze,
      CONCURRENT_MAINTENANCE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # The quarterly maintenance month group schedule of the Fusion environment family.
    # @return [String]
    attr_accessor :quarterly_upgrade_begin_times

    # When True, monthly patching is enabled for the environment family.
    # @return [BOOLEAN]
    attr_accessor :is_monthly_patching_enabled

    # Option to upgrade both production and non-production environments at the same time. When set to PROD both types of environnments are upgraded on the production schedule. When set to NON_PROD both types of environments are upgraded on the non-production schedule.
    # @return [String]
    attr_reader :concurrent_maintenance

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'quarterly_upgrade_begin_times': :'quarterlyUpgradeBeginTimes',
        'is_monthly_patching_enabled': :'isMonthlyPatchingEnabled',
        'concurrent_maintenance': :'concurrentMaintenance'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'quarterly_upgrade_begin_times': :'String',
        'is_monthly_patching_enabled': :'BOOLEAN',
        'concurrent_maintenance': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :quarterly_upgrade_begin_times The value to assign to the {#quarterly_upgrade_begin_times} property
    # @option attributes [BOOLEAN] :is_monthly_patching_enabled The value to assign to the {#is_monthly_patching_enabled} property
    # @option attributes [String] :concurrent_maintenance The value to assign to the {#concurrent_maintenance} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.quarterly_upgrade_begin_times = attributes[:'quarterlyUpgradeBeginTimes'] if attributes[:'quarterlyUpgradeBeginTimes']

      raise 'You cannot provide both :quarterlyUpgradeBeginTimes and :quarterly_upgrade_begin_times' if attributes.key?(:'quarterlyUpgradeBeginTimes') && attributes.key?(:'quarterly_upgrade_begin_times')

      self.quarterly_upgrade_begin_times = attributes[:'quarterly_upgrade_begin_times'] if attributes[:'quarterly_upgrade_begin_times']

      self.is_monthly_patching_enabled = attributes[:'isMonthlyPatchingEnabled'] unless attributes[:'isMonthlyPatchingEnabled'].nil?
      self.is_monthly_patching_enabled = false if is_monthly_patching_enabled.nil? && !attributes.key?(:'isMonthlyPatchingEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isMonthlyPatchingEnabled and :is_monthly_patching_enabled' if attributes.key?(:'isMonthlyPatchingEnabled') && attributes.key?(:'is_monthly_patching_enabled')

      self.is_monthly_patching_enabled = attributes[:'is_monthly_patching_enabled'] unless attributes[:'is_monthly_patching_enabled'].nil?
      self.is_monthly_patching_enabled = false if is_monthly_patching_enabled.nil? && !attributes.key?(:'isMonthlyPatchingEnabled') && !attributes.key?(:'is_monthly_patching_enabled') # rubocop:disable Style/StringLiterals

      self.concurrent_maintenance = attributes[:'concurrentMaintenance'] if attributes[:'concurrentMaintenance']
      self.concurrent_maintenance = "DISABLED" if concurrent_maintenance.nil? && !attributes.key?(:'concurrentMaintenance') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :concurrentMaintenance and :concurrent_maintenance' if attributes.key?(:'concurrentMaintenance') && attributes.key?(:'concurrent_maintenance')

      self.concurrent_maintenance = attributes[:'concurrent_maintenance'] if attributes[:'concurrent_maintenance']
      self.concurrent_maintenance = "DISABLED" if concurrent_maintenance.nil? && !attributes.key?(:'concurrentMaintenance') && !attributes.key?(:'concurrent_maintenance') # rubocop:disable Style/StringLiterals
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] concurrent_maintenance Object to be assigned
    def concurrent_maintenance=(concurrent_maintenance)
      # rubocop:disable Style/ConditionalAssignment
      if concurrent_maintenance && !CONCURRENT_MAINTENANCE_ENUM.include?(concurrent_maintenance)
        OCI.logger.debug("Unknown value for 'concurrent_maintenance' [" + concurrent_maintenance + "]. Mapping to 'CONCURRENT_MAINTENANCE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @concurrent_maintenance = CONCURRENT_MAINTENANCE_UNKNOWN_ENUM_VALUE
      else
        @concurrent_maintenance = concurrent_maintenance
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        quarterly_upgrade_begin_times == other.quarterly_upgrade_begin_times &&
        is_monthly_patching_enabled == other.is_monthly_patching_enabled &&
        concurrent_maintenance == other.concurrent_maintenance
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
      [quarterly_upgrade_begin_times, is_monthly_patching_enabled, concurrent_maintenance].hash
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
