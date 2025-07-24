# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A ContinuousQuery that can be used to save and share a given search result.
  #
  class HydraControlplaneClient::Models::ContinuousQuery
    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_CREATING = 'CREATING'.freeze,
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_UPDATING = 'UPDATING'.freeze,
      LIFECYCLE_STATE_INACTIVE = 'INACTIVE'.freeze,
      LIFECYCLE_STATE_DELETING = 'DELETING'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    SEVERITY_ENUM = [
      SEVERITY_CRITICAL = 'CRITICAL'.freeze,
      SEVERITY_HIGH = 'HIGH'.freeze,
      SEVERITY_MEDIUM = 'MEDIUM'.freeze,
      SEVERITY_LOW = 'LOW'.freeze,
      SEVERITY_MINOR = 'MINOR'.freeze,
      SEVERITY_INFORMATIONAL = 'INFORMATIONAL'.freeze,
      SEVERITY_NONE = 'NONE'.freeze,
      SEVERITY_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    OPERATOR_ENUM = [
      OPERATOR_EQUAL = 'EQUAL'.freeze,
      OPERATOR_GREATER = 'GREATER'.freeze,
      OPERATOR_GREATERTHANEQUALTO = 'GREATERTHANEQUALTO'.freeze,
      OPERATOR_LESS = 'LESS'.freeze,
      OPERATOR_LESSTHANEQUALTO = 'LESSTHANEQUALTO'.freeze,
      OPERATOR_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The OCID of the resource.
    # @return [String]
    attr_accessor :id

    # **[Required]** The continuous query expression that is run periodically.
    # For example,
    # search \"loggroup-id\" subject IN (INPUTLOOKUP 'objectstorage://bmc-logging-test/lookups/subjects.json' subject)
    # summarize count() as eventsCount by type as LogType, source, subject sort by eventsCount
    #
    # @return [String]
    attr_accessor :query

    # **[Required]** The OCID of the compartment that the resource belongs to.
    # @return [String]
    attr_accessor :compartment_id

    # Time the resource was created.
    # @return [DateTime]
    attr_accessor :time_created

    # Time the resource was last modified.
    # @return [DateTime]
    attr_accessor :time_updated

    # This attribute is required.
    # @return [OCI::HydraControlplaneClient::Models::ContinuousQueryStartPolicy]
    attr_accessor :query_start_time

    # **[Required]** Interval in minutes that query is run periodically.
    # @return [Integer]
    attr_accessor :interval_in_minutes

    # **[Required]** The integer value that must be exceeded, fall below or equal to (depending on the operator), the query result to trigger an event.
    # @return [Integer]
    attr_accessor :threshold

    # **[Required]** The user-friendly query name. This must be unique within the enclosing resource,
    # and it's changeable. Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :display_name

    # **[Required]** The OCID of the custom log for continuous query.
    # @return [String]
    attr_accessor :custom_log_id

    # Defined tags for this resource. Each key is predefined and scoped to a
    # namespace. For more information, see [Resource Tags]({{DOC_SERVER_URL}}/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Free-form tags for this resource. Each tag is a simple key-value pair with no
    # predefined name, type, or namespace. For more information, see [Resource Tags]({{DOC_SERVER_URL}}/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Recommendations to act in case of a notification produced by the query.
    # For example,
    # when this event happens,
    # . check the logs under <dir> and search for event.
    # . If you find any occurrences of X open a security event in the queue https://queue
    #
    # @return [String]
    attr_accessor :recommendation_text

    # Description for this resource.
    # @return [String]
    attr_accessor :description

    # Whether or not this resource is currently enabled.
    # @return [BOOLEAN]
    attr_accessor :is_enabled

    # The state of the ContinuousQueryLifecycleState
    #   1. CREATING
    #   2. ACTIVE   ContinuousQuery is active and can be used by other users
    #   3. UPDATING
    #   4. INACTIVE
    #   5. DELETING
    #   6. FAILED
    #
    # @return [String]
    attr_reader :lifecycle_state

    # **[Required]** The state of the ContinuousQuerySeverity
    #
    # @return [String]
    attr_reader :severity

    # **[Required]** operator used in continuous query
    #   1. EQUAL
    #   2. GREATER
    #   3. GREATERTHANEQUALTO
    #   4. LESS
    #   5. LESSTHANEQUALTO
    #
    # @return [String]
    attr_reader :operator

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'query': :'query',
        'compartment_id': :'compartmentId',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'query_start_time': :'queryStartTime',
        'interval_in_minutes': :'intervalInMinutes',
        'threshold': :'threshold',
        'display_name': :'displayName',
        'custom_log_id': :'customLogId',
        'defined_tags': :'definedTags',
        'freeform_tags': :'freeformTags',
        'recommendation_text': :'recommendationText',
        'description': :'description',
        'is_enabled': :'isEnabled',
        'lifecycle_state': :'lifecycleState',
        'severity': :'severity',
        'operator': :'operator'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'query': :'String',
        'compartment_id': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'query_start_time': :'OCI::HydraControlplaneClient::Models::ContinuousQueryStartPolicy',
        'interval_in_minutes': :'Integer',
        'threshold': :'Integer',
        'display_name': :'String',
        'custom_log_id': :'String',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'freeform_tags': :'Hash<String, String>',
        'recommendation_text': :'String',
        'description': :'String',
        'is_enabled': :'BOOLEAN',
        'lifecycle_state': :'String',
        'severity': :'String',
        'operator': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :query The value to assign to the {#query} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [OCI::HydraControlplaneClient::Models::ContinuousQueryStartPolicy] :query_start_time The value to assign to the {#query_start_time} property
    # @option attributes [Integer] :interval_in_minutes The value to assign to the {#interval_in_minutes} property
    # @option attributes [Integer] :threshold The value to assign to the {#threshold} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :custom_log_id The value to assign to the {#custom_log_id} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [String] :recommendation_text The value to assign to the {#recommendation_text} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [BOOLEAN] :is_enabled The value to assign to the {#is_enabled} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :severity The value to assign to the {#severity} property
    # @option attributes [String] :operator The value to assign to the {#operator} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.query = attributes[:'query'] if attributes[:'query']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.query_start_time = attributes[:'queryStartTime'] if attributes[:'queryStartTime']

      raise 'You cannot provide both :queryStartTime and :query_start_time' if attributes.key?(:'queryStartTime') && attributes.key?(:'query_start_time')

      self.query_start_time = attributes[:'query_start_time'] if attributes[:'query_start_time']

      self.interval_in_minutes = attributes[:'intervalInMinutes'] if attributes[:'intervalInMinutes']

      raise 'You cannot provide both :intervalInMinutes and :interval_in_minutes' if attributes.key?(:'intervalInMinutes') && attributes.key?(:'interval_in_minutes')

      self.interval_in_minutes = attributes[:'interval_in_minutes'] if attributes[:'interval_in_minutes']

      self.threshold = attributes[:'threshold'] if attributes[:'threshold']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.custom_log_id = attributes[:'customLogId'] if attributes[:'customLogId']

      raise 'You cannot provide both :customLogId and :custom_log_id' if attributes.key?(:'customLogId') && attributes.key?(:'custom_log_id')

      self.custom_log_id = attributes[:'custom_log_id'] if attributes[:'custom_log_id']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.recommendation_text = attributes[:'recommendationText'] if attributes[:'recommendationText']

      raise 'You cannot provide both :recommendationText and :recommendation_text' if attributes.key?(:'recommendationText') && attributes.key?(:'recommendation_text')

      self.recommendation_text = attributes[:'recommendation_text'] if attributes[:'recommendation_text']

      self.description = attributes[:'description'] if attributes[:'description']

      self.is_enabled = attributes[:'isEnabled'] unless attributes[:'isEnabled'].nil?
      self.is_enabled = true if is_enabled.nil? && !attributes.key?(:'isEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isEnabled and :is_enabled' if attributes.key?(:'isEnabled') && attributes.key?(:'is_enabled')

      self.is_enabled = attributes[:'is_enabled'] unless attributes[:'is_enabled'].nil?
      self.is_enabled = true if is_enabled.nil? && !attributes.key?(:'isEnabled') && !attributes.key?(:'is_enabled') # rubocop:disable Style/StringLiterals

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.severity = attributes[:'severity'] if attributes[:'severity']

      self.operator = attributes[:'operator'] if attributes[:'operator']
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

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] severity Object to be assigned
    def severity=(severity)
      # rubocop:disable Style/ConditionalAssignment
      if severity && !SEVERITY_ENUM.include?(severity)
        OCI.logger.debug("Unknown value for 'severity' [" + severity + "]. Mapping to 'SEVERITY_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @severity = SEVERITY_UNKNOWN_ENUM_VALUE
      else
        @severity = severity
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] operator Object to be assigned
    def operator=(operator)
      # rubocop:disable Style/ConditionalAssignment
      if operator && !OPERATOR_ENUM.include?(operator)
        OCI.logger.debug("Unknown value for 'operator' [" + operator + "]. Mapping to 'OPERATOR_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @operator = OPERATOR_UNKNOWN_ENUM_VALUE
      else
        @operator = operator
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
        query == other.query &&
        compartment_id == other.compartment_id &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        query_start_time == other.query_start_time &&
        interval_in_minutes == other.interval_in_minutes &&
        threshold == other.threshold &&
        display_name == other.display_name &&
        custom_log_id == other.custom_log_id &&
        defined_tags == other.defined_tags &&
        freeform_tags == other.freeform_tags &&
        recommendation_text == other.recommendation_text &&
        description == other.description &&
        is_enabled == other.is_enabled &&
        lifecycle_state == other.lifecycle_state &&
        severity == other.severity &&
        operator == other.operator
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
      [id, query, compartment_id, time_created, time_updated, query_start_time, interval_in_minutes, threshold, display_name, custom_log_id, defined_tags, freeform_tags, recommendation_text, description, is_enabled, lifecycle_state, severity, operator].hash
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
