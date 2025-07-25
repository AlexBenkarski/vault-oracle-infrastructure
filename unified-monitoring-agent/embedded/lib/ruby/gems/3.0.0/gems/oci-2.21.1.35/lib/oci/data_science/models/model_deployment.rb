# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20190101
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Model deployments are used by data scientists to perform predictions from the model hosted on an HTTP server.
  #
  class DataScience::Models::ModelDeployment
    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_CREATING = 'CREATING'.freeze,
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_DELETING = 'DELETING'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_INACTIVE = 'INACTIVE'.freeze,
      LIFECYCLE_STATE_UPDATING = 'UPDATING'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_NEEDS_ATTENTION = 'NEEDS_ATTENTION'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the model deployment.
    # @return [String]
    attr_accessor :id

    # **[Required]** The date and time the resource was created, in the timestamp format defined by [RFC3339](https://tools.ietf.org/html/rfc3339).
    # Example: 2019-08-25T21:10:29.41Z
    #
    # @return [DateTime]
    attr_accessor :time_created

    # **[Required]** A user-friendly display name for the resource. Does not have to be unique, and can be modified. Avoid entering confidential information.
    # Example: `My ModelDeployment`
    #
    # @return [String]
    attr_accessor :display_name

    # A short description of the model deployment.
    # @return [String]
    attr_accessor :description

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the project associated with the model deployment.
    # @return [String]
    attr_accessor :project_id

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the user who created the model deployment.
    # @return [String]
    attr_accessor :created_by

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the model deployment's compartment.
    # @return [String]
    attr_accessor :compartment_id

    # @return [OCI::DataScience::Models::ModelDeploymentConfigurationDetails]
    attr_accessor :model_deployment_configuration_details

    # @return [OCI::DataScience::Models::CategoryLogDetails]
    attr_accessor :category_log_details

    # **[Required]** The URL to interact with the model deployment.
    # @return [String]
    attr_accessor :model_deployment_url

    # @return [OCI::DataScience::Models::ModelDeploymentSystemData]
    attr_accessor :model_deployment_system_data

    # **[Required]** The state of the model deployment.
    # @return [String]
    attr_reader :lifecycle_state

    # Details about the state of the model deployment.
    # @return [String]
    attr_accessor :lifecycle_details

    # Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. See [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace. See [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'time_created': :'timeCreated',
        'display_name': :'displayName',
        'description': :'description',
        'project_id': :'projectId',
        'created_by': :'createdBy',
        'compartment_id': :'compartmentId',
        'model_deployment_configuration_details': :'modelDeploymentConfigurationDetails',
        'category_log_details': :'categoryLogDetails',
        'model_deployment_url': :'modelDeploymentUrl',
        'model_deployment_system_data': :'modelDeploymentSystemData',
        'lifecycle_state': :'lifecycleState',
        'lifecycle_details': :'lifecycleDetails',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'time_created': :'DateTime',
        'display_name': :'String',
        'description': :'String',
        'project_id': :'String',
        'created_by': :'String',
        'compartment_id': :'String',
        'model_deployment_configuration_details': :'OCI::DataScience::Models::ModelDeploymentConfigurationDetails',
        'category_log_details': :'OCI::DataScience::Models::CategoryLogDetails',
        'model_deployment_url': :'String',
        'model_deployment_system_data': :'OCI::DataScience::Models::ModelDeploymentSystemData',
        'lifecycle_state': :'String',
        'lifecycle_details': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :project_id The value to assign to the {#project_id} property
    # @option attributes [String] :created_by The value to assign to the {#created_by} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [OCI::DataScience::Models::ModelDeploymentConfigurationDetails] :model_deployment_configuration_details The value to assign to the {#model_deployment_configuration_details} property
    # @option attributes [OCI::DataScience::Models::CategoryLogDetails] :category_log_details The value to assign to the {#category_log_details} property
    # @option attributes [String] :model_deployment_url The value to assign to the {#model_deployment_url} property
    # @option attributes [OCI::DataScience::Models::ModelDeploymentSystemData] :model_deployment_system_data The value to assign to the {#model_deployment_system_data} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :lifecycle_details The value to assign to the {#lifecycle_details} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.project_id = attributes[:'projectId'] if attributes[:'projectId']

      raise 'You cannot provide both :projectId and :project_id' if attributes.key?(:'projectId') && attributes.key?(:'project_id')

      self.project_id = attributes[:'project_id'] if attributes[:'project_id']

      self.created_by = attributes[:'createdBy'] if attributes[:'createdBy']

      raise 'You cannot provide both :createdBy and :created_by' if attributes.key?(:'createdBy') && attributes.key?(:'created_by')

      self.created_by = attributes[:'created_by'] if attributes[:'created_by']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.model_deployment_configuration_details = attributes[:'modelDeploymentConfigurationDetails'] if attributes[:'modelDeploymentConfigurationDetails']

      raise 'You cannot provide both :modelDeploymentConfigurationDetails and :model_deployment_configuration_details' if attributes.key?(:'modelDeploymentConfigurationDetails') && attributes.key?(:'model_deployment_configuration_details')

      self.model_deployment_configuration_details = attributes[:'model_deployment_configuration_details'] if attributes[:'model_deployment_configuration_details']

      self.category_log_details = attributes[:'categoryLogDetails'] if attributes[:'categoryLogDetails']

      raise 'You cannot provide both :categoryLogDetails and :category_log_details' if attributes.key?(:'categoryLogDetails') && attributes.key?(:'category_log_details')

      self.category_log_details = attributes[:'category_log_details'] if attributes[:'category_log_details']

      self.model_deployment_url = attributes[:'modelDeploymentUrl'] if attributes[:'modelDeploymentUrl']

      raise 'You cannot provide both :modelDeploymentUrl and :model_deployment_url' if attributes.key?(:'modelDeploymentUrl') && attributes.key?(:'model_deployment_url')

      self.model_deployment_url = attributes[:'model_deployment_url'] if attributes[:'model_deployment_url']

      self.model_deployment_system_data = attributes[:'modelDeploymentSystemData'] if attributes[:'modelDeploymentSystemData']

      raise 'You cannot provide both :modelDeploymentSystemData and :model_deployment_system_data' if attributes.key?(:'modelDeploymentSystemData') && attributes.key?(:'model_deployment_system_data')

      self.model_deployment_system_data = attributes[:'model_deployment_system_data'] if attributes[:'model_deployment_system_data']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.lifecycle_details = attributes[:'lifecycleDetails'] if attributes[:'lifecycleDetails']

      raise 'You cannot provide both :lifecycleDetails and :lifecycle_details' if attributes.key?(:'lifecycleDetails') && attributes.key?(:'lifecycle_details')

      self.lifecycle_details = attributes[:'lifecycle_details'] if attributes[:'lifecycle_details']

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
        time_created == other.time_created &&
        display_name == other.display_name &&
        description == other.description &&
        project_id == other.project_id &&
        created_by == other.created_by &&
        compartment_id == other.compartment_id &&
        model_deployment_configuration_details == other.model_deployment_configuration_details &&
        category_log_details == other.category_log_details &&
        model_deployment_url == other.model_deployment_url &&
        model_deployment_system_data == other.model_deployment_system_data &&
        lifecycle_state == other.lifecycle_state &&
        lifecycle_details == other.lifecycle_details &&
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
      [id, time_created, display_name, description, project_id, created_by, compartment_id, model_deployment_configuration_details, category_log_details, model_deployment_url, model_deployment_system_data, lifecycle_state, lifecycle_details, freeform_tags, defined_tags].hash
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
