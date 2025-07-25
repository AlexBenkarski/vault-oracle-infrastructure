# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230831
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Summary of Fleet part of the Schedule.
  class FleetAppsManagement::Models::ScheduledFleetSummary
    ACTION_GROUP_TYPES_ENUM = [
      ACTION_GROUP_TYPES_PRODUCT = 'PRODUCT'.freeze,
      ACTION_GROUP_TYPES_ENVIRONMENT = 'ENVIRONMENT'.freeze,
      ACTION_GROUP_TYPES_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The OCID of the resource.
    # @return [String]
    attr_accessor :id

    # OCID of the tenancy to which the resource belongs to.
    # @return [String]
    attr_accessor :tenancy_id

    # **[Required]** A user-friendly name. Does not have to be unique, and it's changeable.
    # Avoid entering confidential information.
    #
    # Example: `My new resource`
    #
    # @return [String]
    attr_accessor :display_name

    # Count of Resources affected by the Schedule
    # @return [Integer]
    attr_accessor :count_of_affected_resources

    # Count of Targets affected by the Schedule
    # @return [Integer]
    attr_accessor :count_of_affected_targets

    # All ActionGroup Types part of the schedule.
    # @return [Array<String>]
    attr_reader :action_group_types

    # All application types part of the schedule.
    # @return [Array<String>]
    attr_accessor :application_types

    # System tags for this resource. Each key is predefined and scoped to a namespace.
    # Example: `{\"orcl-cloud\": {\"free-tier-retained\": \"true\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :system_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'tenancy_id': :'tenancyId',
        'display_name': :'displayName',
        'count_of_affected_resources': :'countOfAffectedResources',
        'count_of_affected_targets': :'countOfAffectedTargets',
        'action_group_types': :'actionGroupTypes',
        'application_types': :'applicationTypes',
        'system_tags': :'systemTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'tenancy_id': :'String',
        'display_name': :'String',
        'count_of_affected_resources': :'Integer',
        'count_of_affected_targets': :'Integer',
        'action_group_types': :'Array<String>',
        'application_types': :'Array<String>',
        'system_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :tenancy_id The value to assign to the {#tenancy_id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [Integer] :count_of_affected_resources The value to assign to the {#count_of_affected_resources} property
    # @option attributes [Integer] :count_of_affected_targets The value to assign to the {#count_of_affected_targets} property
    # @option attributes [Array<String>] :action_group_types The value to assign to the {#action_group_types} property
    # @option attributes [Array<String>] :application_types The value to assign to the {#application_types} property
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {#system_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.tenancy_id = attributes[:'tenancyId'] if attributes[:'tenancyId']

      raise 'You cannot provide both :tenancyId and :tenancy_id' if attributes.key?(:'tenancyId') && attributes.key?(:'tenancy_id')

      self.tenancy_id = attributes[:'tenancy_id'] if attributes[:'tenancy_id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.count_of_affected_resources = attributes[:'countOfAffectedResources'] if attributes[:'countOfAffectedResources']

      raise 'You cannot provide both :countOfAffectedResources and :count_of_affected_resources' if attributes.key?(:'countOfAffectedResources') && attributes.key?(:'count_of_affected_resources')

      self.count_of_affected_resources = attributes[:'count_of_affected_resources'] if attributes[:'count_of_affected_resources']

      self.count_of_affected_targets = attributes[:'countOfAffectedTargets'] if attributes[:'countOfAffectedTargets']

      raise 'You cannot provide both :countOfAffectedTargets and :count_of_affected_targets' if attributes.key?(:'countOfAffectedTargets') && attributes.key?(:'count_of_affected_targets')

      self.count_of_affected_targets = attributes[:'count_of_affected_targets'] if attributes[:'count_of_affected_targets']

      self.action_group_types = attributes[:'actionGroupTypes'] if attributes[:'actionGroupTypes']

      raise 'You cannot provide both :actionGroupTypes and :action_group_types' if attributes.key?(:'actionGroupTypes') && attributes.key?(:'action_group_types')

      self.action_group_types = attributes[:'action_group_types'] if attributes[:'action_group_types']

      self.application_types = attributes[:'applicationTypes'] if attributes[:'applicationTypes']

      raise 'You cannot provide both :applicationTypes and :application_types' if attributes.key?(:'applicationTypes') && attributes.key?(:'application_types')

      self.application_types = attributes[:'application_types'] if attributes[:'application_types']

      self.system_tags = attributes[:'systemTags'] if attributes[:'systemTags']

      raise 'You cannot provide both :systemTags and :system_tags' if attributes.key?(:'systemTags') && attributes.key?(:'system_tags')

      self.system_tags = attributes[:'system_tags'] if attributes[:'system_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] action_group_types Object to be assigned
    def action_group_types=(action_group_types)
      # rubocop:disable Style/ConditionalAssignment
      if action_group_types.nil?
        @action_group_types = nil
      else
        @action_group_types =
          action_group_types.collect do |item|
            if ACTION_GROUP_TYPES_ENUM.include?(item)
              item
            else
              OCI.logger.debug("Unknown value for 'action_group_types' [#{item}]. Mapping to 'ACTION_GROUP_TYPES_UNKNOWN_ENUM_VALUE'") if OCI.logger
              ACTION_GROUP_TYPES_UNKNOWN_ENUM_VALUE
            end
          end
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
        tenancy_id == other.tenancy_id &&
        display_name == other.display_name &&
        count_of_affected_resources == other.count_of_affected_resources &&
        count_of_affected_targets == other.count_of_affected_targets &&
        action_group_types == other.action_group_types &&
        application_types == other.application_types &&
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
      [id, tenancy_id, display_name, count_of_affected_resources, count_of_affected_targets, action_group_types, application_types, system_tags].hash
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
