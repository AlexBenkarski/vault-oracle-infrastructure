# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220901
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Provides summary information for a managed instance.
  class OsManagementHub::Models::ManagedInstanceSummary
    LOCATION_ENUM = [
      LOCATION_ON_PREMISE = 'ON_PREMISE'.freeze,
      LOCATION_OCI_COMPUTE = 'OCI_COMPUTE'.freeze,
      LOCATION_AZURE = 'AZURE'.freeze,
      LOCATION_EC2 = 'EC2'.freeze,
      LOCATION_GCP = 'GCP'.freeze,
      LOCATION_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    ARCHITECTURE_ENUM = [
      ARCHITECTURE_X86_64 = 'X86_64'.freeze,
      ARCHITECTURE_AARCH64 = 'AARCH64'.freeze,
      ARCHITECTURE_I686 = 'I686'.freeze,
      ARCHITECTURE_NOARCH = 'NOARCH'.freeze,
      ARCHITECTURE_SRC = 'SRC'.freeze,
      ARCHITECTURE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    OS_FAMILY_ENUM = [
      OS_FAMILY_ORACLE_LINUX_9 = 'ORACLE_LINUX_9'.freeze,
      OS_FAMILY_ORACLE_LINUX_8 = 'ORACLE_LINUX_8'.freeze,
      OS_FAMILY_ORACLE_LINUX_7 = 'ORACLE_LINUX_7'.freeze,
      OS_FAMILY_ORACLE_LINUX_6 = 'ORACLE_LINUX_6'.freeze,
      OS_FAMILY_WINDOWS_SERVER_2016 = 'WINDOWS_SERVER_2016'.freeze,
      OS_FAMILY_WINDOWS_SERVER_2019 = 'WINDOWS_SERVER_2019'.freeze,
      OS_FAMILY_WINDOWS_SERVER_2022 = 'WINDOWS_SERVER_2022'.freeze,
      OS_FAMILY_ALL = 'ALL'.freeze,
      OS_FAMILY_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    STATUS_ENUM = [
      STATUS_NORMAL = 'NORMAL'.freeze,
      STATUS_UNREACHABLE = 'UNREACHABLE'.freeze,
      STATUS_ERROR = 'ERROR'.freeze,
      STATUS_WARNING = 'WARNING'.freeze,
      STATUS_REGISTRATION_ERROR = 'REGISTRATION_ERROR'.freeze,
      STATUS_DELETING = 'DELETING'.freeze,
      STATUS_ONBOARDING = 'ONBOARDING'.freeze,
      STATUS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the managed instance.
    #
    # @return [String]
    attr_accessor :id

    # **[Required]** User-friendly name for the managed instance.
    # @return [String]
    attr_accessor :display_name

    # User-specified description of the managed instance.
    # @return [String]
    attr_accessor :description

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the tenancy this managed instance resides in.
    #
    # @return [String]
    attr_accessor :tenancy_id

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the compartment that contains the managed instance.
    #
    # @return [String]
    attr_accessor :compartment_id

    # The location of the managed instance.
    # @return [String]
    attr_reader :location

    # The CPU architecture type of the managed instance.
    # @return [String]
    attr_reader :architecture

    # The operating system type of the managed instance.
    # @return [String]
    attr_reader :os_family

    # **[Required]** Current status of the managed instance.
    # @return [String]
    attr_reader :status

    # @return [OCI::OsManagementHub::Models::Id]
    attr_accessor :managed_instance_group

    # @return [OCI::OsManagementHub::Models::Id]
    attr_accessor :lifecycle_environment

    # @return [OCI::OsManagementHub::Models::Id]
    attr_accessor :lifecycle_stage

    # Indicates whether a reboot is required to complete installation of updates.
    # @return [BOOLEAN]
    attr_accessor :is_reboot_required

    # Number of updates available for installation.
    # @return [Integer]
    attr_accessor :updates_available

    # Whether this managed instance is acting as an on-premises management station.
    # @return [BOOLEAN]
    attr_accessor :is_management_station

    # The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) for the Oracle Notifications service (ONS) topic. ONS is the channel used to send notifications to the customer.
    #
    # @return [String]
    attr_accessor :notification_topic_id

    # @return [OCI::OsManagementHub::Models::AutonomousSettings]
    attr_accessor :autonomous_settings

    # Indicates whether Autonomous Linux manages this instance.
    # @return [BOOLEAN]
    attr_accessor :is_managed_by_autonomous_linux

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'display_name': :'displayName',
        'description': :'description',
        'tenancy_id': :'tenancyId',
        'compartment_id': :'compartmentId',
        'location': :'location',
        'architecture': :'architecture',
        'os_family': :'osFamily',
        'status': :'status',
        'managed_instance_group': :'managedInstanceGroup',
        'lifecycle_environment': :'lifecycleEnvironment',
        'lifecycle_stage': :'lifecycleStage',
        'is_reboot_required': :'isRebootRequired',
        'updates_available': :'updatesAvailable',
        'is_management_station': :'isManagementStation',
        'notification_topic_id': :'notificationTopicId',
        'autonomous_settings': :'autonomousSettings',
        'is_managed_by_autonomous_linux': :'isManagedByAutonomousLinux'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'display_name': :'String',
        'description': :'String',
        'tenancy_id': :'String',
        'compartment_id': :'String',
        'location': :'String',
        'architecture': :'String',
        'os_family': :'String',
        'status': :'String',
        'managed_instance_group': :'OCI::OsManagementHub::Models::Id',
        'lifecycle_environment': :'OCI::OsManagementHub::Models::Id',
        'lifecycle_stage': :'OCI::OsManagementHub::Models::Id',
        'is_reboot_required': :'BOOLEAN',
        'updates_available': :'Integer',
        'is_management_station': :'BOOLEAN',
        'notification_topic_id': :'String',
        'autonomous_settings': :'OCI::OsManagementHub::Models::AutonomousSettings',
        'is_managed_by_autonomous_linux': :'BOOLEAN'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :tenancy_id The value to assign to the {#tenancy_id} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :location The value to assign to the {#location} property
    # @option attributes [String] :architecture The value to assign to the {#architecture} property
    # @option attributes [String] :os_family The value to assign to the {#os_family} property
    # @option attributes [String] :status The value to assign to the {#status} property
    # @option attributes [OCI::OsManagementHub::Models::Id] :managed_instance_group The value to assign to the {#managed_instance_group} property
    # @option attributes [OCI::OsManagementHub::Models::Id] :lifecycle_environment The value to assign to the {#lifecycle_environment} property
    # @option attributes [OCI::OsManagementHub::Models::Id] :lifecycle_stage The value to assign to the {#lifecycle_stage} property
    # @option attributes [BOOLEAN] :is_reboot_required The value to assign to the {#is_reboot_required} property
    # @option attributes [Integer] :updates_available The value to assign to the {#updates_available} property
    # @option attributes [BOOLEAN] :is_management_station The value to assign to the {#is_management_station} property
    # @option attributes [String] :notification_topic_id The value to assign to the {#notification_topic_id} property
    # @option attributes [OCI::OsManagementHub::Models::AutonomousSettings] :autonomous_settings The value to assign to the {#autonomous_settings} property
    # @option attributes [BOOLEAN] :is_managed_by_autonomous_linux The value to assign to the {#is_managed_by_autonomous_linux} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.tenancy_id = attributes[:'tenancyId'] if attributes[:'tenancyId']

      raise 'You cannot provide both :tenancyId and :tenancy_id' if attributes.key?(:'tenancyId') && attributes.key?(:'tenancy_id')

      self.tenancy_id = attributes[:'tenancy_id'] if attributes[:'tenancy_id']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.location = attributes[:'location'] if attributes[:'location']

      self.architecture = attributes[:'architecture'] if attributes[:'architecture']

      self.os_family = attributes[:'osFamily'] if attributes[:'osFamily']

      raise 'You cannot provide both :osFamily and :os_family' if attributes.key?(:'osFamily') && attributes.key?(:'os_family')

      self.os_family = attributes[:'os_family'] if attributes[:'os_family']

      self.status = attributes[:'status'] if attributes[:'status']

      self.managed_instance_group = attributes[:'managedInstanceGroup'] if attributes[:'managedInstanceGroup']

      raise 'You cannot provide both :managedInstanceGroup and :managed_instance_group' if attributes.key?(:'managedInstanceGroup') && attributes.key?(:'managed_instance_group')

      self.managed_instance_group = attributes[:'managed_instance_group'] if attributes[:'managed_instance_group']

      self.lifecycle_environment = attributes[:'lifecycleEnvironment'] if attributes[:'lifecycleEnvironment']

      raise 'You cannot provide both :lifecycleEnvironment and :lifecycle_environment' if attributes.key?(:'lifecycleEnvironment') && attributes.key?(:'lifecycle_environment')

      self.lifecycle_environment = attributes[:'lifecycle_environment'] if attributes[:'lifecycle_environment']

      self.lifecycle_stage = attributes[:'lifecycleStage'] if attributes[:'lifecycleStage']

      raise 'You cannot provide both :lifecycleStage and :lifecycle_stage' if attributes.key?(:'lifecycleStage') && attributes.key?(:'lifecycle_stage')

      self.lifecycle_stage = attributes[:'lifecycle_stage'] if attributes[:'lifecycle_stage']

      self.is_reboot_required = attributes[:'isRebootRequired'] unless attributes[:'isRebootRequired'].nil?

      raise 'You cannot provide both :isRebootRequired and :is_reboot_required' if attributes.key?(:'isRebootRequired') && attributes.key?(:'is_reboot_required')

      self.is_reboot_required = attributes[:'is_reboot_required'] unless attributes[:'is_reboot_required'].nil?

      self.updates_available = attributes[:'updatesAvailable'] if attributes[:'updatesAvailable']

      raise 'You cannot provide both :updatesAvailable and :updates_available' if attributes.key?(:'updatesAvailable') && attributes.key?(:'updates_available')

      self.updates_available = attributes[:'updates_available'] if attributes[:'updates_available']

      self.is_management_station = attributes[:'isManagementStation'] unless attributes[:'isManagementStation'].nil?

      raise 'You cannot provide both :isManagementStation and :is_management_station' if attributes.key?(:'isManagementStation') && attributes.key?(:'is_management_station')

      self.is_management_station = attributes[:'is_management_station'] unless attributes[:'is_management_station'].nil?

      self.notification_topic_id = attributes[:'notificationTopicId'] if attributes[:'notificationTopicId']

      raise 'You cannot provide both :notificationTopicId and :notification_topic_id' if attributes.key?(:'notificationTopicId') && attributes.key?(:'notification_topic_id')

      self.notification_topic_id = attributes[:'notification_topic_id'] if attributes[:'notification_topic_id']

      self.autonomous_settings = attributes[:'autonomousSettings'] if attributes[:'autonomousSettings']

      raise 'You cannot provide both :autonomousSettings and :autonomous_settings' if attributes.key?(:'autonomousSettings') && attributes.key?(:'autonomous_settings')

      self.autonomous_settings = attributes[:'autonomous_settings'] if attributes[:'autonomous_settings']

      self.is_managed_by_autonomous_linux = attributes[:'isManagedByAutonomousLinux'] unless attributes[:'isManagedByAutonomousLinux'].nil?

      raise 'You cannot provide both :isManagedByAutonomousLinux and :is_managed_by_autonomous_linux' if attributes.key?(:'isManagedByAutonomousLinux') && attributes.key?(:'is_managed_by_autonomous_linux')

      self.is_managed_by_autonomous_linux = attributes[:'is_managed_by_autonomous_linux'] unless attributes[:'is_managed_by_autonomous_linux'].nil?
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] location Object to be assigned
    def location=(location)
      # rubocop:disable Style/ConditionalAssignment
      if location && !LOCATION_ENUM.include?(location)
        OCI.logger.debug("Unknown value for 'location' [" + location + "]. Mapping to 'LOCATION_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @location = LOCATION_UNKNOWN_ENUM_VALUE
      else
        @location = location
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] architecture Object to be assigned
    def architecture=(architecture)
      # rubocop:disable Style/ConditionalAssignment
      if architecture && !ARCHITECTURE_ENUM.include?(architecture)
        OCI.logger.debug("Unknown value for 'architecture' [" + architecture + "]. Mapping to 'ARCHITECTURE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @architecture = ARCHITECTURE_UNKNOWN_ENUM_VALUE
      else
        @architecture = architecture
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] os_family Object to be assigned
    def os_family=(os_family)
      # rubocop:disable Style/ConditionalAssignment
      if os_family && !OS_FAMILY_ENUM.include?(os_family)
        OCI.logger.debug("Unknown value for 'os_family' [" + os_family + "]. Mapping to 'OS_FAMILY_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @os_family = OS_FAMILY_UNKNOWN_ENUM_VALUE
      else
        @os_family = os_family
      end
      # rubocop:enable Style/ConditionalAssignment
    end

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
        display_name == other.display_name &&
        description == other.description &&
        tenancy_id == other.tenancy_id &&
        compartment_id == other.compartment_id &&
        location == other.location &&
        architecture == other.architecture &&
        os_family == other.os_family &&
        status == other.status &&
        managed_instance_group == other.managed_instance_group &&
        lifecycle_environment == other.lifecycle_environment &&
        lifecycle_stage == other.lifecycle_stage &&
        is_reboot_required == other.is_reboot_required &&
        updates_available == other.updates_available &&
        is_management_station == other.is_management_station &&
        notification_topic_id == other.notification_topic_id &&
        autonomous_settings == other.autonomous_settings &&
        is_managed_by_autonomous_linux == other.is_managed_by_autonomous_linux
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
      [id, display_name, description, tenancy_id, compartment_id, location, architecture, os_family, status, managed_instance_group, lifecycle_environment, lifecycle_stage, is_reboot_required, updates_available, is_management_station, notification_topic_id, autonomous_settings, is_managed_by_autonomous_linux].hash
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
