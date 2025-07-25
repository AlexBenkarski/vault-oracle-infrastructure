# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230831
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Task Execution associated with the Job.
  class FleetAppsManagement::Models::Execution
    STATUS_ENUM = [
      STATUS_ACCEPTED = 'ACCEPTED'.freeze,
      STATUS_WAITING = 'WAITING'.freeze,
      STATUS_IN_PROGRESS = 'IN_PROGRESS'.freeze,
      STATUS_FAILED = 'FAILED'.freeze,
      STATUS_SUCCEEDED = 'SUCCEEDED'.freeze,
      STATUS_CANCELED = 'CANCELED'.freeze,
      STATUS_SKIPPED = 'SKIPPED'.freeze,
      STATUS_IGNORED = 'IGNORED'.freeze,
      STATUS_NOT_APPLICABLE = 'NOT_APPLICABLE'.freeze,
      STATUS_ABORTED = 'ABORTED'.freeze,
      STATUS_TIMED_OUT = 'TIMED_OUT'.freeze,
      STATUS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Unique Id assocaited with the Task Execution
    # @return [String]
    attr_accessor :id

    # The OCID of taskRecord
    # @return [String]
    attr_accessor :task_record_id

    # Name of the step
    # @return [String]
    attr_accessor :step_name

    # Unique process reference identifier returned by the execution client
    # @return [String]
    attr_accessor :process_reference_id

    # The sequence of the task
    # @return [String]
    attr_accessor :sequence

    # Subjects which are tied to the task
    # @return [Array<String>]
    attr_accessor :subjects

    # **[Required]** Status of the Task
    # @return [String]
    attr_reader :status

    # @return [OCI::FleetAppsManagement::Models::Outcome]
    attr_accessor :outcome

    # Target associated with the execution
    # @return [String]
    attr_accessor :target_id

    # The time the task started. An RFC3339 formatted datetime string
    # @return [DateTime]
    attr_accessor :time_started

    # The time the task ended. An RFC3339 formatted datetime string
    # @return [DateTime]
    attr_accessor :time_ended

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
        'task_record_id': :'taskRecordId',
        'step_name': :'stepName',
        'process_reference_id': :'processReferenceId',
        'sequence': :'sequence',
        'subjects': :'subjects',
        'status': :'status',
        'outcome': :'outcome',
        'target_id': :'targetId',
        'time_started': :'timeStarted',
        'time_ended': :'timeEnded',
        'system_tags': :'systemTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'task_record_id': :'String',
        'step_name': :'String',
        'process_reference_id': :'String',
        'sequence': :'String',
        'subjects': :'Array<String>',
        'status': :'String',
        'outcome': :'OCI::FleetAppsManagement::Models::Outcome',
        'target_id': :'String',
        'time_started': :'DateTime',
        'time_ended': :'DateTime',
        'system_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :task_record_id The value to assign to the {#task_record_id} property
    # @option attributes [String] :step_name The value to assign to the {#step_name} property
    # @option attributes [String] :process_reference_id The value to assign to the {#process_reference_id} property
    # @option attributes [String] :sequence The value to assign to the {#sequence} property
    # @option attributes [Array<String>] :subjects The value to assign to the {#subjects} property
    # @option attributes [String] :status The value to assign to the {#status} property
    # @option attributes [OCI::FleetAppsManagement::Models::Outcome] :outcome The value to assign to the {#outcome} property
    # @option attributes [String] :target_id The value to assign to the {#target_id} property
    # @option attributes [DateTime] :time_started The value to assign to the {#time_started} property
    # @option attributes [DateTime] :time_ended The value to assign to the {#time_ended} property
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {#system_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.task_record_id = attributes[:'taskRecordId'] if attributes[:'taskRecordId']

      raise 'You cannot provide both :taskRecordId and :task_record_id' if attributes.key?(:'taskRecordId') && attributes.key?(:'task_record_id')

      self.task_record_id = attributes[:'task_record_id'] if attributes[:'task_record_id']

      self.step_name = attributes[:'stepName'] if attributes[:'stepName']

      raise 'You cannot provide both :stepName and :step_name' if attributes.key?(:'stepName') && attributes.key?(:'step_name')

      self.step_name = attributes[:'step_name'] if attributes[:'step_name']

      self.process_reference_id = attributes[:'processReferenceId'] if attributes[:'processReferenceId']

      raise 'You cannot provide both :processReferenceId and :process_reference_id' if attributes.key?(:'processReferenceId') && attributes.key?(:'process_reference_id')

      self.process_reference_id = attributes[:'process_reference_id'] if attributes[:'process_reference_id']

      self.sequence = attributes[:'sequence'] if attributes[:'sequence']

      self.subjects = attributes[:'subjects'] if attributes[:'subjects']

      self.status = attributes[:'status'] if attributes[:'status']

      self.outcome = attributes[:'outcome'] if attributes[:'outcome']

      self.target_id = attributes[:'targetId'] if attributes[:'targetId']

      raise 'You cannot provide both :targetId and :target_id' if attributes.key?(:'targetId') && attributes.key?(:'target_id')

      self.target_id = attributes[:'target_id'] if attributes[:'target_id']

      self.time_started = attributes[:'timeStarted'] if attributes[:'timeStarted']

      raise 'You cannot provide both :timeStarted and :time_started' if attributes.key?(:'timeStarted') && attributes.key?(:'time_started')

      self.time_started = attributes[:'time_started'] if attributes[:'time_started']

      self.time_ended = attributes[:'timeEnded'] if attributes[:'timeEnded']

      raise 'You cannot provide both :timeEnded and :time_ended' if attributes.key?(:'timeEnded') && attributes.key?(:'time_ended')

      self.time_ended = attributes[:'time_ended'] if attributes[:'time_ended']

      self.system_tags = attributes[:'systemTags'] if attributes[:'systemTags']

      raise 'You cannot provide both :systemTags and :system_tags' if attributes.key?(:'systemTags') && attributes.key?(:'system_tags')

      self.system_tags = attributes[:'system_tags'] if attributes[:'system_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] status Object to be assigned
    def status=(status)
      # rubocop:disable Style/ConditionalAssignment
      if status && !STATUS_ENUM.include?(status)
        OCI.logger.debug("Unknown value for 'status' [" + status + "]. Mapping to 'STATUS_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @status = STATUS_UNKNOWN_ENUM_VALUE
      else
        @status = status
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
        task_record_id == other.task_record_id &&
        step_name == other.step_name &&
        process_reference_id == other.process_reference_id &&
        sequence == other.sequence &&
        subjects == other.subjects &&
        status == other.status &&
        outcome == other.outcome &&
        target_id == other.target_id &&
        time_started == other.time_started &&
        time_ended == other.time_ended &&
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
      [id, task_record_id, step_name, process_reference_id, sequence, subjects, status, outcome, target_id, time_started, time_ended, system_tags].hash
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
