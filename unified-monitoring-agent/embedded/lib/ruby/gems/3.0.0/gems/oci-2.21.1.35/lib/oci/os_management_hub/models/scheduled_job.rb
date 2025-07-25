# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220901
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The object that defines a scheduled job. For more information about jobs, see [Managing Jobs](https://docs.cloud.oracle.com/iaas/osmh/doc/jobs.htm).
  class OsManagementHub::Models::ScheduledJob
    SCHEDULE_TYPE_ENUM = [
      SCHEDULE_TYPE_ONETIME = 'ONETIME'.freeze,
      SCHEDULE_TYPE_RECURRING = 'RECURRING'.freeze,
      SCHEDULE_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_CREATING = 'CREATING'.freeze,
      LIFECYCLE_STATE_UPDATING = 'UPDATING'.freeze,
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_INACTIVE = 'INACTIVE'.freeze,
      LIFECYCLE_STATE_DELETING = 'DELETING'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the scheduled job.
    # @return [String]
    attr_accessor :id

    # **[Required]** User-friendly name for the scheduled job.
    # @return [String]
    attr_accessor :display_name

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the compartment that contains the scheduled job.
    # @return [String]
    attr_accessor :compartment_id

    # User-specified description for the scheduled job.
    # @return [String]
    attr_accessor :description

    # **[Required]** The type of scheduling frequency for the job.
    # @return [String]
    attr_reader :schedule_type

    # The list of locations this scheduled job should operate on for a job targeting on compartments. (Empty list means apply to all locations). This can only be set when managedCompartmentIds is not empty.
    # @return [Array<OCI::OsManagementHub::Models::ManagedInstanceLocation>]
    attr_accessor :locations

    # **[Required]** The time of the next execution of this scheduled job (in [RFC 3339](https://tools.ietf.org/rfc/rfc3339) format).
    # @return [DateTime]
    attr_accessor :time_next_execution

    # The time of the last execution of this scheduled job (in [RFC 3339](https://tools.ietf.org/rfc/rfc3339) format).
    # @return [DateTime]
    attr_accessor :time_last_execution

    # The frequency schedule for a recurring scheduled job.
    # @return [String]
    attr_accessor :recurring_rule

    # The managed instance [OCIDs](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) that this scheduled job operates on.
    # A scheduled job can only operate on one type of target, therefore this parameter is mutually exclusive with
    # managedInstanceGroupIds, managedCompartmentIds, and lifecycleStageIds.
    #
    # @return [Array<String>]
    attr_accessor :managed_instance_ids

    # The managed instance group [OCIDs](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) that this scheduled job operates on. A scheduled job can only operate on one type of target, therefore this parameter is mutually exclusive with managedInstanceIds, managedCompartmentIds, and lifecycleStageIds.
    # @return [Array<String>]
    attr_accessor :managed_instance_group_ids

    # The compartment [OCIDs](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) that this scheduled job operates on. A scheduled job can only operate on one type of target, therefore this parameter is mutually exclusive with managedInstanceIds, managedInstanceGroupIds, and lifecycleStageIds.
    # @return [Array<String>]
    attr_accessor :managed_compartment_ids

    # The lifecycle stage [OCIDs](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) that this scheduled job operates on.
    # A scheduled job can only operate on one type of target, therefore this parameter is mutually exclusive with
    # managedInstanceIds, managedInstanceGroupIds, and managedCompartmentIds.
    #
    # @return [Array<String>]
    attr_accessor :lifecycle_stage_ids

    # Indicates whether to apply the scheduled job to all compartments in the tenancy when managedCompartmentIds specifies the tenancy [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) (root compartment).
    #
    # @return [BOOLEAN]
    attr_accessor :is_subcompartment_included

    # **[Required]** The list of operations this scheduled job needs to perform.
    # A scheduled job supports only one operation type, unless it is one of the following:
    # * UPDATE_PACKAGES
    # * UPDATE_ALL
    # * UPDATE_SECURITY
    # * UPDATE_BUGFIX
    # * UPDATE_ENHANCEMENT
    # * UPDATE_OTHER
    # * UPDATE_KSPLICE_USERSPACE
    # * UPDATE_KSPLICE_KERNEL
    #
    # @return [Array<OCI::OsManagementHub::Models::ScheduledJobOperation>]
    attr_accessor :operations

    # The list of work request [OCIDs](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) associated with this scheduled job.
    # @return [Array<String>]
    attr_accessor :work_request_ids

    # **[Required]** The time this scheduled job was created (in [RFC 3339](https://tools.ietf.org/rfc/rfc3339) format).
    # @return [DateTime]
    attr_accessor :time_created

    # **[Required]** The time this scheduled job was updated (in [RFC 3339](https://tools.ietf.org/rfc/rfc3339) format).
    # @return [DateTime]
    attr_accessor :time_updated

    # **[Required]** The current state of the scheduled job.
    # @return [String]
    attr_reader :lifecycle_state

    # Indicates whether this scheduled job is managed by the Autonomous Linux service.
    # @return [BOOLEAN]
    attr_accessor :is_managed_by_autonomous_linux

    # **[Required]** Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # **[Required]** Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # System tags for this resource. Each key is predefined and scoped to a namespace.
    # Example: `{\"orcl-cloud\": {\"free-tier-retained\": \"true\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :system_tags

    # Indicates if the schedule job has restricted update and deletion capabilities. For restricted scheduled jobs,
    # you can update only the timeNextExecution, recurringRule, and tags.
    #
    # @return [BOOLEAN]
    attr_accessor :is_restricted

    # The amount of time in minutes to wait until retrying the scheduled job. If set, the service will automatically retry
    # a failed scheduled job after the interval. For example, you could set the interval to [2,5,10]. If the initial
    # execution of the job fails, the service waits 2 minutes and then retries. If that fails, the service waits 5 minutes
    # and then retries. If that fails, the service waits 10 minutes and then retries.
    #
    # @return [Array<Integer>]
    attr_accessor :retry_intervals

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'display_name': :'displayName',
        'compartment_id': :'compartmentId',
        'description': :'description',
        'schedule_type': :'scheduleType',
        'locations': :'locations',
        'time_next_execution': :'timeNextExecution',
        'time_last_execution': :'timeLastExecution',
        'recurring_rule': :'recurringRule',
        'managed_instance_ids': :'managedInstanceIds',
        'managed_instance_group_ids': :'managedInstanceGroupIds',
        'managed_compartment_ids': :'managedCompartmentIds',
        'lifecycle_stage_ids': :'lifecycleStageIds',
        'is_subcompartment_included': :'isSubcompartmentIncluded',
        'operations': :'operations',
        'work_request_ids': :'workRequestIds',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'lifecycle_state': :'lifecycleState',
        'is_managed_by_autonomous_linux': :'isManagedByAutonomousLinux',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags',
        'is_restricted': :'isRestricted',
        'retry_intervals': :'retryIntervals'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'display_name': :'String',
        'compartment_id': :'String',
        'description': :'String',
        'schedule_type': :'String',
        'locations': :'Array<OCI::OsManagementHub::Models::ManagedInstanceLocation>',
        'time_next_execution': :'DateTime',
        'time_last_execution': :'DateTime',
        'recurring_rule': :'String',
        'managed_instance_ids': :'Array<String>',
        'managed_instance_group_ids': :'Array<String>',
        'managed_compartment_ids': :'Array<String>',
        'lifecycle_stage_ids': :'Array<String>',
        'is_subcompartment_included': :'BOOLEAN',
        'operations': :'Array<OCI::OsManagementHub::Models::ScheduledJobOperation>',
        'work_request_ids': :'Array<String>',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'lifecycle_state': :'String',
        'is_managed_by_autonomous_linux': :'BOOLEAN',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>',
        'is_restricted': :'BOOLEAN',
        'retry_intervals': :'Array<Integer>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :schedule_type The value to assign to the {#schedule_type} property
    # @option attributes [Array<OCI::OsManagementHub::Models::ManagedInstanceLocation>] :locations The value to assign to the {#locations} property
    # @option attributes [DateTime] :time_next_execution The value to assign to the {#time_next_execution} property
    # @option attributes [DateTime] :time_last_execution The value to assign to the {#time_last_execution} property
    # @option attributes [String] :recurring_rule The value to assign to the {#recurring_rule} property
    # @option attributes [Array<String>] :managed_instance_ids The value to assign to the {#managed_instance_ids} property
    # @option attributes [Array<String>] :managed_instance_group_ids The value to assign to the {#managed_instance_group_ids} property
    # @option attributes [Array<String>] :managed_compartment_ids The value to assign to the {#managed_compartment_ids} property
    # @option attributes [Array<String>] :lifecycle_stage_ids The value to assign to the {#lifecycle_stage_ids} property
    # @option attributes [BOOLEAN] :is_subcompartment_included The value to assign to the {#is_subcompartment_included} property
    # @option attributes [Array<OCI::OsManagementHub::Models::ScheduledJobOperation>] :operations The value to assign to the {#operations} property
    # @option attributes [Array<String>] :work_request_ids The value to assign to the {#work_request_ids} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [BOOLEAN] :is_managed_by_autonomous_linux The value to assign to the {#is_managed_by_autonomous_linux} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {#system_tags} property
    # @option attributes [BOOLEAN] :is_restricted The value to assign to the {#is_restricted} property
    # @option attributes [Array<Integer>] :retry_intervals The value to assign to the {#retry_intervals} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.description = attributes[:'description'] if attributes[:'description']

      self.schedule_type = attributes[:'scheduleType'] if attributes[:'scheduleType']

      raise 'You cannot provide both :scheduleType and :schedule_type' if attributes.key?(:'scheduleType') && attributes.key?(:'schedule_type')

      self.schedule_type = attributes[:'schedule_type'] if attributes[:'schedule_type']

      self.locations = attributes[:'locations'] if attributes[:'locations']

      self.time_next_execution = attributes[:'timeNextExecution'] if attributes[:'timeNextExecution']

      raise 'You cannot provide both :timeNextExecution and :time_next_execution' if attributes.key?(:'timeNextExecution') && attributes.key?(:'time_next_execution')

      self.time_next_execution = attributes[:'time_next_execution'] if attributes[:'time_next_execution']

      self.time_last_execution = attributes[:'timeLastExecution'] if attributes[:'timeLastExecution']

      raise 'You cannot provide both :timeLastExecution and :time_last_execution' if attributes.key?(:'timeLastExecution') && attributes.key?(:'time_last_execution')

      self.time_last_execution = attributes[:'time_last_execution'] if attributes[:'time_last_execution']

      self.recurring_rule = attributes[:'recurringRule'] if attributes[:'recurringRule']

      raise 'You cannot provide both :recurringRule and :recurring_rule' if attributes.key?(:'recurringRule') && attributes.key?(:'recurring_rule')

      self.recurring_rule = attributes[:'recurring_rule'] if attributes[:'recurring_rule']

      self.managed_instance_ids = attributes[:'managedInstanceIds'] if attributes[:'managedInstanceIds']

      raise 'You cannot provide both :managedInstanceIds and :managed_instance_ids' if attributes.key?(:'managedInstanceIds') && attributes.key?(:'managed_instance_ids')

      self.managed_instance_ids = attributes[:'managed_instance_ids'] if attributes[:'managed_instance_ids']

      self.managed_instance_group_ids = attributes[:'managedInstanceGroupIds'] if attributes[:'managedInstanceGroupIds']

      raise 'You cannot provide both :managedInstanceGroupIds and :managed_instance_group_ids' if attributes.key?(:'managedInstanceGroupIds') && attributes.key?(:'managed_instance_group_ids')

      self.managed_instance_group_ids = attributes[:'managed_instance_group_ids'] if attributes[:'managed_instance_group_ids']

      self.managed_compartment_ids = attributes[:'managedCompartmentIds'] if attributes[:'managedCompartmentIds']

      raise 'You cannot provide both :managedCompartmentIds and :managed_compartment_ids' if attributes.key?(:'managedCompartmentIds') && attributes.key?(:'managed_compartment_ids')

      self.managed_compartment_ids = attributes[:'managed_compartment_ids'] if attributes[:'managed_compartment_ids']

      self.lifecycle_stage_ids = attributes[:'lifecycleStageIds'] if attributes[:'lifecycleStageIds']

      raise 'You cannot provide both :lifecycleStageIds and :lifecycle_stage_ids' if attributes.key?(:'lifecycleStageIds') && attributes.key?(:'lifecycle_stage_ids')

      self.lifecycle_stage_ids = attributes[:'lifecycle_stage_ids'] if attributes[:'lifecycle_stage_ids']

      self.is_subcompartment_included = attributes[:'isSubcompartmentIncluded'] unless attributes[:'isSubcompartmentIncluded'].nil?
      self.is_subcompartment_included = false if is_subcompartment_included.nil? && !attributes.key?(:'isSubcompartmentIncluded') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isSubcompartmentIncluded and :is_subcompartment_included' if attributes.key?(:'isSubcompartmentIncluded') && attributes.key?(:'is_subcompartment_included')

      self.is_subcompartment_included = attributes[:'is_subcompartment_included'] unless attributes[:'is_subcompartment_included'].nil?
      self.is_subcompartment_included = false if is_subcompartment_included.nil? && !attributes.key?(:'isSubcompartmentIncluded') && !attributes.key?(:'is_subcompartment_included') # rubocop:disable Style/StringLiterals

      self.operations = attributes[:'operations'] if attributes[:'operations']

      self.work_request_ids = attributes[:'workRequestIds'] if attributes[:'workRequestIds']

      raise 'You cannot provide both :workRequestIds and :work_request_ids' if attributes.key?(:'workRequestIds') && attributes.key?(:'work_request_ids')

      self.work_request_ids = attributes[:'work_request_ids'] if attributes[:'work_request_ids']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.is_managed_by_autonomous_linux = attributes[:'isManagedByAutonomousLinux'] unless attributes[:'isManagedByAutonomousLinux'].nil?

      raise 'You cannot provide both :isManagedByAutonomousLinux and :is_managed_by_autonomous_linux' if attributes.key?(:'isManagedByAutonomousLinux') && attributes.key?(:'is_managed_by_autonomous_linux')

      self.is_managed_by_autonomous_linux = attributes[:'is_managed_by_autonomous_linux'] unless attributes[:'is_managed_by_autonomous_linux'].nil?

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.system_tags = attributes[:'systemTags'] if attributes[:'systemTags']

      raise 'You cannot provide both :systemTags and :system_tags' if attributes.key?(:'systemTags') && attributes.key?(:'system_tags')

      self.system_tags = attributes[:'system_tags'] if attributes[:'system_tags']

      self.is_restricted = attributes[:'isRestricted'] unless attributes[:'isRestricted'].nil?

      raise 'You cannot provide both :isRestricted and :is_restricted' if attributes.key?(:'isRestricted') && attributes.key?(:'is_restricted')

      self.is_restricted = attributes[:'is_restricted'] unless attributes[:'is_restricted'].nil?

      self.retry_intervals = attributes[:'retryIntervals'] if attributes[:'retryIntervals']

      raise 'You cannot provide both :retryIntervals and :retry_intervals' if attributes.key?(:'retryIntervals') && attributes.key?(:'retry_intervals')

      self.retry_intervals = attributes[:'retry_intervals'] if attributes[:'retry_intervals']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] schedule_type Object to be assigned
    def schedule_type=(schedule_type)
      # rubocop:disable Style/ConditionalAssignment
      if schedule_type && !SCHEDULE_TYPE_ENUM.include?(schedule_type)
        OCI.logger.debug("Unknown value for 'schedule_type' [" + schedule_type + "]. Mapping to 'SCHEDULE_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @schedule_type = SCHEDULE_TYPE_UNKNOWN_ENUM_VALUE
      else
        @schedule_type = schedule_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

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
        id == other.id &&
        display_name == other.display_name &&
        compartment_id == other.compartment_id &&
        description == other.description &&
        schedule_type == other.schedule_type &&
        locations == other.locations &&
        time_next_execution == other.time_next_execution &&
        time_last_execution == other.time_last_execution &&
        recurring_rule == other.recurring_rule &&
        managed_instance_ids == other.managed_instance_ids &&
        managed_instance_group_ids == other.managed_instance_group_ids &&
        managed_compartment_ids == other.managed_compartment_ids &&
        lifecycle_stage_ids == other.lifecycle_stage_ids &&
        is_subcompartment_included == other.is_subcompartment_included &&
        operations == other.operations &&
        work_request_ids == other.work_request_ids &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        lifecycle_state == other.lifecycle_state &&
        is_managed_by_autonomous_linux == other.is_managed_by_autonomous_linux &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        system_tags == other.system_tags &&
        is_restricted == other.is_restricted &&
        retry_intervals == other.retry_intervals
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
      [id, display_name, compartment_id, description, schedule_type, locations, time_next_execution, time_last_execution, recurring_rule, managed_instance_ids, managed_instance_group_ids, managed_compartment_ids, lifecycle_stage_ids, is_subcompartment_included, operations, work_request_ids, time_created, time_updated, lifecycle_state, is_managed_by_autonomous_linux, freeform_tags, defined_tags, system_tags, is_restricted, retry_intervals].hash
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
