# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A service registry entity to register partner service.
  #
  class HydraControlplaneClient::Models::ServiceRegistrySummary
    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_INACTIVE = 'INACTIVE'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The OCID of the resource.
    # @return [String]
    attr_accessor :id

    # **[Required]** the service lifecycle state.
    # @return [String]
    attr_reader :lifecycle_state

    # **[Required]** The OCID of the tenancy.
    # @return [String]
    attr_accessor :tenancy_id

    # **[Required]** The OCID of the compartment that the resource belongs to.
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** service principal of the partner service.
    # @return [String]
    attr_accessor :service_principal_name

    # **[Required]** The user-friendly display name. This must be unique within the enclosing resource,
    # and it's changeable. Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :display_name

    # **[Required]** Internal name of the partner service, to be registered for oracle cloud infrastructure logging.
    # @return [String]
    attr_accessor :name

    # **[Required]** namespace
    # @return [String]
    attr_accessor :namespace

    # **[Required]** email of distribution list for partner service team.
    # @return [String]
    attr_accessor :email

    # **[Required]** JIRA queue of the partner service team.
    # @return [String]
    attr_accessor :jira_queue

    # List of the tenancies allowed for ingesting service logs.
    # @return [Array<String>]
    attr_accessor :ingestion_allowed_tenancies

    # **[Required]** Flag to hide in registry list or not.
    # @return [BOOLEAN]
    attr_accessor :is_hidden_in_registry_list

    # **[Required]** Flag to notify log reclamation.
    # @return [BOOLEAN]
    attr_accessor :is_notifying_log_reclamation

    # **[Required]** Flag to check if the partner service implements get logging api.
    # @return [BOOLEAN]
    attr_accessor :is_implementing_get_logging

    # **[Required]** Enum to specify service type.
    # @return [String]
    attr_accessor :service_type

    # **[Required]** Enum to specify service stage.
    # @return [String]
    attr_accessor :service_stage

    # Time the resource was created.
    # @return [DateTime]
    attr_accessor :time_created

    # Time the resource was last modified.
    # @return [DateTime]
    attr_accessor :time_last_modified

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'lifecycle_state': :'lifecycleState',
        'tenancy_id': :'tenancyId',
        'compartment_id': :'compartmentId',
        'service_principal_name': :'servicePrincipalName',
        'display_name': :'displayName',
        'name': :'name',
        'namespace': :'namespace',
        'email': :'email',
        'jira_queue': :'jiraQueue',
        'ingestion_allowed_tenancies': :'ingestionAllowedTenancies',
        'is_hidden_in_registry_list': :'isHiddenInRegistryList',
        'is_notifying_log_reclamation': :'isNotifyingLogReclamation',
        'is_implementing_get_logging': :'isImplementingGetLogging',
        'service_type': :'serviceType',
        'service_stage': :'serviceStage',
        'time_created': :'timeCreated',
        'time_last_modified': :'timeLastModified'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'lifecycle_state': :'String',
        'tenancy_id': :'String',
        'compartment_id': :'String',
        'service_principal_name': :'String',
        'display_name': :'String',
        'name': :'String',
        'namespace': :'String',
        'email': :'String',
        'jira_queue': :'String',
        'ingestion_allowed_tenancies': :'Array<String>',
        'is_hidden_in_registry_list': :'BOOLEAN',
        'is_notifying_log_reclamation': :'BOOLEAN',
        'is_implementing_get_logging': :'BOOLEAN',
        'service_type': :'String',
        'service_stage': :'String',
        'time_created': :'DateTime',
        'time_last_modified': :'DateTime'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :tenancy_id The value to assign to the {#tenancy_id} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :service_principal_name The value to assign to the {#service_principal_name} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :namespace The value to assign to the {#namespace} property
    # @option attributes [String] :email The value to assign to the {#email} property
    # @option attributes [String] :jira_queue The value to assign to the {#jira_queue} property
    # @option attributes [Array<String>] :ingestion_allowed_tenancies The value to assign to the {#ingestion_allowed_tenancies} property
    # @option attributes [BOOLEAN] :is_hidden_in_registry_list The value to assign to the {#is_hidden_in_registry_list} property
    # @option attributes [BOOLEAN] :is_notifying_log_reclamation The value to assign to the {#is_notifying_log_reclamation} property
    # @option attributes [BOOLEAN] :is_implementing_get_logging The value to assign to the {#is_implementing_get_logging} property
    # @option attributes [String] :service_type The value to assign to the {#service_type} property
    # @option attributes [String] :service_stage The value to assign to the {#service_stage} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_last_modified The value to assign to the {#time_last_modified} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.tenancy_id = attributes[:'tenancyId'] if attributes[:'tenancyId']

      raise 'You cannot provide both :tenancyId and :tenancy_id' if attributes.key?(:'tenancyId') && attributes.key?(:'tenancy_id')

      self.tenancy_id = attributes[:'tenancy_id'] if attributes[:'tenancy_id']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.service_principal_name = attributes[:'servicePrincipalName'] if attributes[:'servicePrincipalName']

      raise 'You cannot provide both :servicePrincipalName and :service_principal_name' if attributes.key?(:'servicePrincipalName') && attributes.key?(:'service_principal_name')

      self.service_principal_name = attributes[:'service_principal_name'] if attributes[:'service_principal_name']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.name = attributes[:'name'] if attributes[:'name']

      self.namespace = attributes[:'namespace'] if attributes[:'namespace']

      self.email = attributes[:'email'] if attributes[:'email']

      self.jira_queue = attributes[:'jiraQueue'] if attributes[:'jiraQueue']

      raise 'You cannot provide both :jiraQueue and :jira_queue' if attributes.key?(:'jiraQueue') && attributes.key?(:'jira_queue')

      self.jira_queue = attributes[:'jira_queue'] if attributes[:'jira_queue']

      self.ingestion_allowed_tenancies = attributes[:'ingestionAllowedTenancies'] if attributes[:'ingestionAllowedTenancies']

      raise 'You cannot provide both :ingestionAllowedTenancies and :ingestion_allowed_tenancies' if attributes.key?(:'ingestionAllowedTenancies') && attributes.key?(:'ingestion_allowed_tenancies')

      self.ingestion_allowed_tenancies = attributes[:'ingestion_allowed_tenancies'] if attributes[:'ingestion_allowed_tenancies']

      self.is_hidden_in_registry_list = attributes[:'isHiddenInRegistryList'] unless attributes[:'isHiddenInRegistryList'].nil?

      raise 'You cannot provide both :isHiddenInRegistryList and :is_hidden_in_registry_list' if attributes.key?(:'isHiddenInRegistryList') && attributes.key?(:'is_hidden_in_registry_list')

      self.is_hidden_in_registry_list = attributes[:'is_hidden_in_registry_list'] unless attributes[:'is_hidden_in_registry_list'].nil?

      self.is_notifying_log_reclamation = attributes[:'isNotifyingLogReclamation'] unless attributes[:'isNotifyingLogReclamation'].nil?

      raise 'You cannot provide both :isNotifyingLogReclamation and :is_notifying_log_reclamation' if attributes.key?(:'isNotifyingLogReclamation') && attributes.key?(:'is_notifying_log_reclamation')

      self.is_notifying_log_reclamation = attributes[:'is_notifying_log_reclamation'] unless attributes[:'is_notifying_log_reclamation'].nil?

      self.is_implementing_get_logging = attributes[:'isImplementingGetLogging'] unless attributes[:'isImplementingGetLogging'].nil?

      raise 'You cannot provide both :isImplementingGetLogging and :is_implementing_get_logging' if attributes.key?(:'isImplementingGetLogging') && attributes.key?(:'is_implementing_get_logging')

      self.is_implementing_get_logging = attributes[:'is_implementing_get_logging'] unless attributes[:'is_implementing_get_logging'].nil?

      self.service_type = attributes[:'serviceType'] if attributes[:'serviceType']

      raise 'You cannot provide both :serviceType and :service_type' if attributes.key?(:'serviceType') && attributes.key?(:'service_type')

      self.service_type = attributes[:'service_type'] if attributes[:'service_type']

      self.service_stage = attributes[:'serviceStage'] if attributes[:'serviceStage']

      raise 'You cannot provide both :serviceStage and :service_stage' if attributes.key?(:'serviceStage') && attributes.key?(:'service_stage')

      self.service_stage = attributes[:'service_stage'] if attributes[:'service_stage']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_last_modified = attributes[:'timeLastModified'] if attributes[:'timeLastModified']

      raise 'You cannot provide both :timeLastModified and :time_last_modified' if attributes.key?(:'timeLastModified') && attributes.key?(:'time_last_modified')

      self.time_last_modified = attributes[:'time_last_modified'] if attributes[:'time_last_modified']
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

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        id == other.id &&
        lifecycle_state == other.lifecycle_state &&
        tenancy_id == other.tenancy_id &&
        compartment_id == other.compartment_id &&
        service_principal_name == other.service_principal_name &&
        display_name == other.display_name &&
        name == other.name &&
        namespace == other.namespace &&
        email == other.email &&
        jira_queue == other.jira_queue &&
        ingestion_allowed_tenancies == other.ingestion_allowed_tenancies &&
        is_hidden_in_registry_list == other.is_hidden_in_registry_list &&
        is_notifying_log_reclamation == other.is_notifying_log_reclamation &&
        is_implementing_get_logging == other.is_implementing_get_logging &&
        service_type == other.service_type &&
        service_stage == other.service_stage &&
        time_created == other.time_created &&
        time_last_modified == other.time_last_modified
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
      [id, lifecycle_state, tenancy_id, compartment_id, service_principal_name, display_name, name, namespace, email, jira_queue, ingestion_allowed_tenancies, is_hidden_in_registry_list, is_notifying_log_reclamation, is_implementing_get_logging, service_type, service_stage, time_created, time_last_modified].hash
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
