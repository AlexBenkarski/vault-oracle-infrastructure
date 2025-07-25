# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20240430
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # This is the data to create a schedule.
  class ResourceScheduler::Models::CreateScheduleDetails
    ACTION_ENUM = [
      ACTION_START_RESOURCE = 'START_RESOURCE'.freeze,
      ACTION_STOP_RESOURCE = 'STOP_RESOURCE'.freeze
    ].freeze

    RECURRENCE_TYPE_ENUM = [
      RECURRENCE_TYPE_CRON = 'CRON'.freeze,
      RECURRENCE_TYPE_ICAL = 'ICAL'.freeze
    ].freeze

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the compartment in which the schedule is created
    # @return [String]
    attr_accessor :compartment_id

    # This is a user-friendly name for the schedule. It does not have to be unique, and it's changeable.
    # @return [String]
    attr_accessor :display_name

    # This is the description of the schedule.
    # @return [String]
    attr_accessor :description

    # **[Required]** This is the action that will be executed by the schedule.
    # @return [String]
    attr_reader :action

    # **[Required]** This is the frequency of recurrence of a schedule. The frequency field can either conform to RFC-5545 formatting
    # or UNIX cron formatting for recurrences, based on the value specified by the recurrenceType field.
    #
    # @return [String]
    attr_accessor :recurrence_details

    # **[Required]** Type of recurrence of a schedule
    # @return [String]
    attr_reader :recurrence_type

    # This is a list of resources filters.  The schedule will be applied to resources matching all of them.
    # @return [Array<OCI::ResourceScheduler::Models::ResourceFilter>]
    attr_accessor :resource_filters

    # This is the list of resources to which the scheduled operation is applied.
    # @return [Array<OCI::ResourceScheduler::Models::Resource>]
    attr_accessor :resources

    # This is the date and time the schedule starts, in the format defined by [RFC 3339](https://tools.ietf.org/html/rfc3339)
    #
    # Example: `2016-08-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_starts

    # This is the date and time the schedule ends, in the format defined by [RFC 3339](https://tools.ietf.org/html/rfc3339)
    #
    # Example: `2016-08-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_ends

    # These are free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # These are defined tags for this resource. Each key is predefined and scoped to a namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'compartment_id': :'compartmentId',
        'display_name': :'displayName',
        'description': :'description',
        'action': :'action',
        'recurrence_details': :'recurrenceDetails',
        'recurrence_type': :'recurrenceType',
        'resource_filters': :'resourceFilters',
        'resources': :'resources',
        'time_starts': :'timeStarts',
        'time_ends': :'timeEnds',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'compartment_id': :'String',
        'display_name': :'String',
        'description': :'String',
        'action': :'String',
        'recurrence_details': :'String',
        'recurrence_type': :'String',
        'resource_filters': :'Array<OCI::ResourceScheduler::Models::ResourceFilter>',
        'resources': :'Array<OCI::ResourceScheduler::Models::Resource>',
        'time_starts': :'DateTime',
        'time_ends': :'DateTime',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :action The value to assign to the {#action} property
    # @option attributes [String] :recurrence_details The value to assign to the {#recurrence_details} property
    # @option attributes [String] :recurrence_type The value to assign to the {#recurrence_type} property
    # @option attributes [Array<OCI::ResourceScheduler::Models::ResourceFilter>] :resource_filters The value to assign to the {#resource_filters} property
    # @option attributes [Array<OCI::ResourceScheduler::Models::Resource>] :resources The value to assign to the {#resources} property
    # @option attributes [DateTime] :time_starts The value to assign to the {#time_starts} property
    # @option attributes [DateTime] :time_ends The value to assign to the {#time_ends} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.action = attributes[:'action'] if attributes[:'action']

      self.recurrence_details = attributes[:'recurrenceDetails'] if attributes[:'recurrenceDetails']

      raise 'You cannot provide both :recurrenceDetails and :recurrence_details' if attributes.key?(:'recurrenceDetails') && attributes.key?(:'recurrence_details')

      self.recurrence_details = attributes[:'recurrence_details'] if attributes[:'recurrence_details']

      self.recurrence_type = attributes[:'recurrenceType'] if attributes[:'recurrenceType']

      raise 'You cannot provide both :recurrenceType and :recurrence_type' if attributes.key?(:'recurrenceType') && attributes.key?(:'recurrence_type')

      self.recurrence_type = attributes[:'recurrence_type'] if attributes[:'recurrence_type']

      self.resource_filters = attributes[:'resourceFilters'] if attributes[:'resourceFilters']

      raise 'You cannot provide both :resourceFilters and :resource_filters' if attributes.key?(:'resourceFilters') && attributes.key?(:'resource_filters')

      self.resource_filters = attributes[:'resource_filters'] if attributes[:'resource_filters']

      self.resources = attributes[:'resources'] if attributes[:'resources']

      self.time_starts = attributes[:'timeStarts'] if attributes[:'timeStarts']

      raise 'You cannot provide both :timeStarts and :time_starts' if attributes.key?(:'timeStarts') && attributes.key?(:'time_starts')

      self.time_starts = attributes[:'time_starts'] if attributes[:'time_starts']

      self.time_ends = attributes[:'timeEnds'] if attributes[:'timeEnds']

      raise 'You cannot provide both :timeEnds and :time_ends' if attributes.key?(:'timeEnds') && attributes.key?(:'time_ends')

      self.time_ends = attributes[:'time_ends'] if attributes[:'time_ends']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] action Object to be assigned
    def action=(action)
      raise "Invalid value for 'action': this must be one of the values in ACTION_ENUM." if action && !ACTION_ENUM.include?(action)

      @action = action
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] recurrence_type Object to be assigned
    def recurrence_type=(recurrence_type)
      raise "Invalid value for 'recurrence_type': this must be one of the values in RECURRENCE_TYPE_ENUM." if recurrence_type && !RECURRENCE_TYPE_ENUM.include?(recurrence_type)

      @recurrence_type = recurrence_type
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        compartment_id == other.compartment_id &&
        display_name == other.display_name &&
        description == other.description &&
        action == other.action &&
        recurrence_details == other.recurrence_details &&
        recurrence_type == other.recurrence_type &&
        resource_filters == other.resource_filters &&
        resources == other.resources &&
        time_starts == other.time_starts &&
        time_ends == other.time_ends &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags
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
      [compartment_id, display_name, description, action, recurrence_details, recurrence_type, resource_filters, resources, time_starts, time_ends, freeform_tags, defined_tags].hash
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
