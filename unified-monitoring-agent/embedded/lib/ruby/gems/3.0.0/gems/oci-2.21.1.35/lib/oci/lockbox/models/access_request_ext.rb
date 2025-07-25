# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220126
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # An access request to a customer's resource that includes additional requestor metadata.
  # An access request is a subsidiary resource of the Lockbox entity.
  #
  class Lockbox::Models::AccessRequestExt
    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_IN_PROGRESS = 'IN_PROGRESS'.freeze,
      LIFECYCLE_STATE_WAITING = 'WAITING'.freeze,
      LIFECYCLE_STATE_SUCCEEDED = 'SUCCEEDED'.freeze,
      LIFECYCLE_STATE_CANCELING = 'CANCELING'.freeze,
      LIFECYCLE_STATE_CANCELED = 'CANCELED'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    LIFECYCLE_STATE_DETAILS_ENUM = [
      LIFECYCLE_STATE_DETAILS_PROCESSING = 'PROCESSING'.freeze,
      LIFECYCLE_STATE_DETAILS_WAITING_FOR_APPROVALS = 'WAITING_FOR_APPROVALS'.freeze,
      LIFECYCLE_STATE_DETAILS_APPROVED = 'APPROVED'.freeze,
      LIFECYCLE_STATE_DETAILS_AUTO_APPROVED = 'AUTO_APPROVED'.freeze,
      LIFECYCLE_STATE_DETAILS_CANCELLING_ACCESS = 'CANCELLING_ACCESS'.freeze,
      LIFECYCLE_STATE_DETAILS_EXPIRED = 'EXPIRED'.freeze,
      LIFECYCLE_STATE_DETAILS_REVOKED = 'REVOKED'.freeze,
      LIFECYCLE_STATE_DETAILS_DENIED = 'DENIED'.freeze,
      LIFECYCLE_STATE_DETAILS_ERROR = 'ERROR'.freeze,
      LIFECYCLE_STATE_DETAILS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The user name i.e. userId of the requestor.
    #
    # @return [String]
    attr_accessor :requestor_user_name

    # **[Required]** The unique identifier (OCID) of the access request, which can't be changed after creation.
    # @return [String]
    attr_accessor :id

    # **[Required]** The unique identifier (OCID) of the lockbox box that the access request is associated with, which can't be changed after creation.
    # @return [String]
    attr_accessor :lockbox_id

    # **[Required]** The name of the access request.
    # @return [String]
    attr_accessor :display_name

    # **[Required]** The rationale for requesting the access request and any other related details..
    # @return [String]
    attr_accessor :description

    # **[Required]** The unique identifier of the requestor.
    # @return [String]
    attr_accessor :requestor_id

    # **[Required]** Possible access request lifecycle states.
    # @return [String]
    attr_reader :lifecycle_state

    # **[Required]** Details of access request lifecycle state.
    # @return [String]
    attr_reader :lifecycle_state_details

    # **[Required]** The maximum amount of time operator has access to associated resources.
    # @return [String]
    attr_accessor :access_duration

    # The context object containing the access request specific details.
    # @return [Hash<String, String>]
    attr_accessor :context

    # **[Required]** The actions taken by different persona on the access request, e.g. approve/deny/revoke
    # @return [Array<OCI::Lockbox::Models::ActivityLog>]
    attr_accessor :activity_logs

    # **[Required]** The time the access request was created. Format is defined by [RFC3339](https://tools.ietf.org/html/rfc3339).
    # Example: `2020-01-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_created

    # **[Required]** The time the access request was last updated. Format is defined by [RFC3339](https://tools.ietf.org/html/rfc3339).
    # Example: `2020-01-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_updated

    # **[Required]** The time the access request expired. Format is defined by [RFC3339](https://tools.ietf.org/html/rfc3339).
    # Example: `2020-01-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_expired

    # **[Required]** The time the access request was last reminded. Format is defined by [RFC3339](https://tools.ietf.org/html/rfc3339).
    # Example: `2020-01-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_reminded

    # **[Required]** The count of times the access request was reminded.
    #
    # @return [Integer]
    attr_accessor :reminder_count

    # **[Required]** The location of the requestor. Format with be two letters indicatiog operator's country code defined by https://jira-sd.mc1.oracleiaas.com/browse/SSD-17880
    # Example: `US`
    #
    # @return [String]
    attr_accessor :requestor_location

    # The ticket number raised by external customers
    # Example: `3-37509643121`
    #
    # @return [String]
    attr_accessor :ticket_number

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'requestor_user_name': :'requestorUserName',
        'id': :'id',
        'lockbox_id': :'lockboxId',
        'display_name': :'displayName',
        'description': :'description',
        'requestor_id': :'requestorId',
        'lifecycle_state': :'lifecycleState',
        'lifecycle_state_details': :'lifecycleStateDetails',
        'access_duration': :'accessDuration',
        'context': :'context',
        'activity_logs': :'activityLogs',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'time_expired': :'timeExpired',
        'time_reminded': :'timeReminded',
        'reminder_count': :'reminderCount',
        'requestor_location': :'requestorLocation',
        'ticket_number': :'ticketNumber'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'requestor_user_name': :'String',
        'id': :'String',
        'lockbox_id': :'String',
        'display_name': :'String',
        'description': :'String',
        'requestor_id': :'String',
        'lifecycle_state': :'String',
        'lifecycle_state_details': :'String',
        'access_duration': :'String',
        'context': :'Hash<String, String>',
        'activity_logs': :'Array<OCI::Lockbox::Models::ActivityLog>',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'time_expired': :'DateTime',
        'time_reminded': :'DateTime',
        'reminder_count': :'Integer',
        'requestor_location': :'String',
        'ticket_number': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :requestor_user_name The value to assign to the {#requestor_user_name} property
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :lockbox_id The value to assign to the {#lockbox_id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :requestor_id The value to assign to the {#requestor_id} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :lifecycle_state_details The value to assign to the {#lifecycle_state_details} property
    # @option attributes [String] :access_duration The value to assign to the {#access_duration} property
    # @option attributes [Hash<String, String>] :context The value to assign to the {#context} property
    # @option attributes [Array<OCI::Lockbox::Models::ActivityLog>] :activity_logs The value to assign to the {#activity_logs} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [DateTime] :time_expired The value to assign to the {#time_expired} property
    # @option attributes [DateTime] :time_reminded The value to assign to the {#time_reminded} property
    # @option attributes [Integer] :reminder_count The value to assign to the {#reminder_count} property
    # @option attributes [String] :requestor_location The value to assign to the {#requestor_location} property
    # @option attributes [String] :ticket_number The value to assign to the {#ticket_number} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.requestor_user_name = attributes[:'requestorUserName'] if attributes[:'requestorUserName']

      raise 'You cannot provide both :requestorUserName and :requestor_user_name' if attributes.key?(:'requestorUserName') && attributes.key?(:'requestor_user_name')

      self.requestor_user_name = attributes[:'requestor_user_name'] if attributes[:'requestor_user_name']

      self.id = attributes[:'id'] if attributes[:'id']

      self.lockbox_id = attributes[:'lockboxId'] if attributes[:'lockboxId']

      raise 'You cannot provide both :lockboxId and :lockbox_id' if attributes.key?(:'lockboxId') && attributes.key?(:'lockbox_id')

      self.lockbox_id = attributes[:'lockbox_id'] if attributes[:'lockbox_id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.requestor_id = attributes[:'requestorId'] if attributes[:'requestorId']

      raise 'You cannot provide both :requestorId and :requestor_id' if attributes.key?(:'requestorId') && attributes.key?(:'requestor_id')

      self.requestor_id = attributes[:'requestor_id'] if attributes[:'requestor_id']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.lifecycle_state_details = attributes[:'lifecycleStateDetails'] if attributes[:'lifecycleStateDetails']

      raise 'You cannot provide both :lifecycleStateDetails and :lifecycle_state_details' if attributes.key?(:'lifecycleStateDetails') && attributes.key?(:'lifecycle_state_details')

      self.lifecycle_state_details = attributes[:'lifecycle_state_details'] if attributes[:'lifecycle_state_details']

      self.access_duration = attributes[:'accessDuration'] if attributes[:'accessDuration']

      raise 'You cannot provide both :accessDuration and :access_duration' if attributes.key?(:'accessDuration') && attributes.key?(:'access_duration')

      self.access_duration = attributes[:'access_duration'] if attributes[:'access_duration']

      self.context = attributes[:'context'] if attributes[:'context']

      self.activity_logs = attributes[:'activityLogs'] if attributes[:'activityLogs']

      raise 'You cannot provide both :activityLogs and :activity_logs' if attributes.key?(:'activityLogs') && attributes.key?(:'activity_logs')

      self.activity_logs = attributes[:'activity_logs'] if attributes[:'activity_logs']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.time_expired = attributes[:'timeExpired'] if attributes[:'timeExpired']

      raise 'You cannot provide both :timeExpired and :time_expired' if attributes.key?(:'timeExpired') && attributes.key?(:'time_expired')

      self.time_expired = attributes[:'time_expired'] if attributes[:'time_expired']

      self.time_reminded = attributes[:'timeReminded'] if attributes[:'timeReminded']

      raise 'You cannot provide both :timeReminded and :time_reminded' if attributes.key?(:'timeReminded') && attributes.key?(:'time_reminded')

      self.time_reminded = attributes[:'time_reminded'] if attributes[:'time_reminded']

      self.reminder_count = attributes[:'reminderCount'] if attributes[:'reminderCount']

      raise 'You cannot provide both :reminderCount and :reminder_count' if attributes.key?(:'reminderCount') && attributes.key?(:'reminder_count')

      self.reminder_count = attributes[:'reminder_count'] if attributes[:'reminder_count']

      self.requestor_location = attributes[:'requestorLocation'] if attributes[:'requestorLocation']

      raise 'You cannot provide both :requestorLocation and :requestor_location' if attributes.key?(:'requestorLocation') && attributes.key?(:'requestor_location')

      self.requestor_location = attributes[:'requestor_location'] if attributes[:'requestor_location']

      self.ticket_number = attributes[:'ticketNumber'] if attributes[:'ticketNumber']

      raise 'You cannot provide both :ticketNumber and :ticket_number' if attributes.key?(:'ticketNumber') && attributes.key?(:'ticket_number')

      self.ticket_number = attributes[:'ticket_number'] if attributes[:'ticket_number']
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
    # @param [Object] lifecycle_state_details Object to be assigned
    def lifecycle_state_details=(lifecycle_state_details)
      # rubocop:disable Style/ConditionalAssignment
      if lifecycle_state_details && !LIFECYCLE_STATE_DETAILS_ENUM.include?(lifecycle_state_details)
        OCI.logger.debug("Unknown value for 'lifecycle_state_details' [" + lifecycle_state_details + "]. Mapping to 'LIFECYCLE_STATE_DETAILS_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @lifecycle_state_details = LIFECYCLE_STATE_DETAILS_UNKNOWN_ENUM_VALUE
      else
        @lifecycle_state_details = lifecycle_state_details
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        requestor_user_name == other.requestor_user_name &&
        id == other.id &&
        lockbox_id == other.lockbox_id &&
        display_name == other.display_name &&
        description == other.description &&
        requestor_id == other.requestor_id &&
        lifecycle_state == other.lifecycle_state &&
        lifecycle_state_details == other.lifecycle_state_details &&
        access_duration == other.access_duration &&
        context == other.context &&
        activity_logs == other.activity_logs &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        time_expired == other.time_expired &&
        time_reminded == other.time_reminded &&
        reminder_count == other.reminder_count &&
        requestor_location == other.requestor_location &&
        ticket_number == other.ticket_number
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
      [requestor_user_name, id, lockbox_id, display_name, description, requestor_id, lifecycle_state, lifecycle_state_details, access_duration, context, activity_logs, time_created, time_updated, time_expired, time_reminded, reminder_count, requestor_location, ticket_number].hash
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
