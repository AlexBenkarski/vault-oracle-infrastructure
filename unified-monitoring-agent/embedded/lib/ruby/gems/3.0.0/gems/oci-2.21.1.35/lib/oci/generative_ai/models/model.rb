# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20231130
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # You can create a custom model by using your dataset to fine-tune an out-of-the-box text generation base model. Have your dataset ready before you create a custom model. See [Training Data Requirements](https://docs.cloud.oracle.com/iaas/Content/generative-ai/training-data-requirements.htm).
  #
  # To use any of the API operations, you must be authorized in an IAM policy. If you're not authorized, talk to an administrator who gives OCI resource access to users. See
  # [Getting Started with Policies](https://docs.cloud.oracle.com/iaas/Content/Identity/policiesgs/get-started-with-policies.htm) and [Getting Access to Generative AI Resouces](https://docs.cloud.oracle.com/iaas/Content/generative-ai/iam-policies.htm).
  #
  class GenerativeAi::Models::Model
    CAPABILITIES_ENUM = [
      CAPABILITIES_TEXT_GENERATION = 'TEXT_GENERATION'.freeze,
      CAPABILITIES_TEXT_SUMMARIZATION = 'TEXT_SUMMARIZATION'.freeze,
      CAPABILITIES_TEXT_EMBEDDINGS = 'TEXT_EMBEDDINGS'.freeze,
      CAPABILITIES_FINE_TUNE = 'FINE_TUNE'.freeze,
      CAPABILITIES_CHAT = 'CHAT'.freeze,
      CAPABILITIES_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_CREATING = 'CREATING'.freeze,
      LIFECYCLE_STATE_DELETING = 'DELETING'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    TYPE_ENUM = [
      TYPE_BASE = 'BASE'.freeze,
      TYPE_CUSTOM = 'CUSTOM'.freeze,
      TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** An ID that uniquely identifies a pretrained or fine-tuned model.
    # @return [String]
    attr_accessor :id

    # An optional description of the model.
    # @return [String]
    attr_accessor :description

    # **[Required]** The compartment OCID for fine-tuned models. For pretrained models, this value is null.
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** Describes what this model can be used for.
    # @return [Array<String>]
    attr_reader :capabilities

    # **[Required]** The lifecycle state of the model.
    # @return [String]
    attr_reader :lifecycle_state

    # A message describing the current state of the model in more detail that can provide actionable information.
    # @return [String]
    attr_accessor :lifecycle_details

    # The provider of the base model.
    # @return [String]
    attr_accessor :vendor

    # The version of the model.
    # @return [String]
    attr_accessor :version

    # A user-friendly name.
    # @return [String]
    attr_accessor :display_name

    # **[Required]** The date and time that the model was created in the format of an RFC3339 datetime string.
    # @return [DateTime]
    attr_accessor :time_created

    # The date and time that the model was updated in the format of an RFC3339 datetime string.
    # @return [DateTime]
    attr_accessor :time_updated

    # The OCID of the base model that's used for fine-tuning. For pretrained models, the value is null.
    # @return [String]
    attr_accessor :base_model_id

    # **[Required]** The model type indicating whether this is a pretrained/base model or a custom/fine-tuned model.
    # @return [String]
    attr_reader :type

    # @return [OCI::GenerativeAi::Models::FineTuneDetails]
    attr_accessor :fine_tune_details

    # @return [OCI::GenerativeAi::Models::ModelMetrics]
    attr_accessor :model_metrics

    # Whether a model is supported long-term. Only applicable to base models.
    # @return [BOOLEAN]
    attr_accessor :is_long_term_supported

    # Corresponds to the time when the custom model and its associated foundation model will be deprecated.
    # @return [DateTime]
    attr_accessor :time_deprecated

    # @return [OCI::GenerativeAi::Models::Model]
    attr_accessor :previous_state

    # Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    #
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # System tags for this resource. Each key is predefined and scoped to a namespace.
    #
    # Example: `{\"orcl-cloud\": {\"free-tier-retained\": \"true\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :system_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'description': :'description',
        'compartment_id': :'compartmentId',
        'capabilities': :'capabilities',
        'lifecycle_state': :'lifecycleState',
        'lifecycle_details': :'lifecycleDetails',
        'vendor': :'vendor',
        'version': :'version',
        'display_name': :'displayName',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'base_model_id': :'baseModelId',
        'type': :'type',
        'fine_tune_details': :'fineTuneDetails',
        'model_metrics': :'modelMetrics',
        'is_long_term_supported': :'isLongTermSupported',
        'time_deprecated': :'timeDeprecated',
        'previous_state': :'previousState',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'description': :'String',
        'compartment_id': :'String',
        'capabilities': :'Array<String>',
        'lifecycle_state': :'String',
        'lifecycle_details': :'String',
        'vendor': :'String',
        'version': :'String',
        'display_name': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'base_model_id': :'String',
        'type': :'String',
        'fine_tune_details': :'OCI::GenerativeAi::Models::FineTuneDetails',
        'model_metrics': :'OCI::GenerativeAi::Models::ModelMetrics',
        'is_long_term_supported': :'BOOLEAN',
        'time_deprecated': :'DateTime',
        'previous_state': :'OCI::GenerativeAi::Models::Model',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [Array<String>] :capabilities The value to assign to the {#capabilities} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :lifecycle_details The value to assign to the {#lifecycle_details} property
    # @option attributes [String] :vendor The value to assign to the {#vendor} property
    # @option attributes [String] :version The value to assign to the {#version} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [String] :base_model_id The value to assign to the {#base_model_id} property
    # @option attributes [String] :type The value to assign to the {#type} property
    # @option attributes [OCI::GenerativeAi::Models::FineTuneDetails] :fine_tune_details The value to assign to the {#fine_tune_details} property
    # @option attributes [OCI::GenerativeAi::Models::ModelMetrics] :model_metrics The value to assign to the {#model_metrics} property
    # @option attributes [BOOLEAN] :is_long_term_supported The value to assign to the {#is_long_term_supported} property
    # @option attributes [DateTime] :time_deprecated The value to assign to the {#time_deprecated} property
    # @option attributes [OCI::GenerativeAi::Models::Model] :previous_state The value to assign to the {#previous_state} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {#system_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.description = attributes[:'description'] if attributes[:'description']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.capabilities = attributes[:'capabilities'] if attributes[:'capabilities']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.lifecycle_details = attributes[:'lifecycleDetails'] if attributes[:'lifecycleDetails']

      raise 'You cannot provide both :lifecycleDetails and :lifecycle_details' if attributes.key?(:'lifecycleDetails') && attributes.key?(:'lifecycle_details')

      self.lifecycle_details = attributes[:'lifecycle_details'] if attributes[:'lifecycle_details']

      self.vendor = attributes[:'vendor'] if attributes[:'vendor']

      self.version = attributes[:'version'] if attributes[:'version']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.base_model_id = attributes[:'baseModelId'] if attributes[:'baseModelId']

      raise 'You cannot provide both :baseModelId and :base_model_id' if attributes.key?(:'baseModelId') && attributes.key?(:'base_model_id')

      self.base_model_id = attributes[:'base_model_id'] if attributes[:'base_model_id']

      self.type = attributes[:'type'] if attributes[:'type']

      self.fine_tune_details = attributes[:'fineTuneDetails'] if attributes[:'fineTuneDetails']

      raise 'You cannot provide both :fineTuneDetails and :fine_tune_details' if attributes.key?(:'fineTuneDetails') && attributes.key?(:'fine_tune_details')

      self.fine_tune_details = attributes[:'fine_tune_details'] if attributes[:'fine_tune_details']

      self.model_metrics = attributes[:'modelMetrics'] if attributes[:'modelMetrics']

      raise 'You cannot provide both :modelMetrics and :model_metrics' if attributes.key?(:'modelMetrics') && attributes.key?(:'model_metrics')

      self.model_metrics = attributes[:'model_metrics'] if attributes[:'model_metrics']

      self.is_long_term_supported = attributes[:'isLongTermSupported'] unless attributes[:'isLongTermSupported'].nil?

      raise 'You cannot provide both :isLongTermSupported and :is_long_term_supported' if attributes.key?(:'isLongTermSupported') && attributes.key?(:'is_long_term_supported')

      self.is_long_term_supported = attributes[:'is_long_term_supported'] unless attributes[:'is_long_term_supported'].nil?

      self.time_deprecated = attributes[:'timeDeprecated'] if attributes[:'timeDeprecated']

      raise 'You cannot provide both :timeDeprecated and :time_deprecated' if attributes.key?(:'timeDeprecated') && attributes.key?(:'time_deprecated')

      self.time_deprecated = attributes[:'time_deprecated'] if attributes[:'time_deprecated']

      self.previous_state = attributes[:'previousState'] if attributes[:'previousState']

      raise 'You cannot provide both :previousState and :previous_state' if attributes.key?(:'previousState') && attributes.key?(:'previous_state')

      self.previous_state = attributes[:'previous_state'] if attributes[:'previous_state']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.system_tags = attributes[:'systemTags'] if attributes[:'systemTags']

      raise 'You cannot provide both :systemTags and :system_tags' if attributes.key?(:'systemTags') && attributes.key?(:'system_tags')

      self.system_tags = attributes[:'system_tags'] if attributes[:'system_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] capabilities Object to be assigned
    def capabilities=(capabilities)
      # rubocop:disable Style/ConditionalAssignment
      if capabilities.nil?
        @capabilities = nil
      else
        @capabilities =
          capabilities.collect do |item|
            if CAPABILITIES_ENUM.include?(item)
              item
            else
              OCI.logger.debug("Unknown value for 'capabilities' [#{item}]. Mapping to 'CAPABILITIES_UNKNOWN_ENUM_VALUE'") if OCI.logger
              CAPABILITIES_UNKNOWN_ENUM_VALUE
            end
          end
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

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] type Object to be assigned
    def type=(type)
      # rubocop:disable Style/ConditionalAssignment
      if type && !TYPE_ENUM.include?(type)
        OCI.logger.debug("Unknown value for 'type' [" + type + "]. Mapping to 'TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @type = TYPE_UNKNOWN_ENUM_VALUE
      else
        @type = type
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
        description == other.description &&
        compartment_id == other.compartment_id &&
        capabilities == other.capabilities &&
        lifecycle_state == other.lifecycle_state &&
        lifecycle_details == other.lifecycle_details &&
        vendor == other.vendor &&
        version == other.version &&
        display_name == other.display_name &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        base_model_id == other.base_model_id &&
        type == other.type &&
        fine_tune_details == other.fine_tune_details &&
        model_metrics == other.model_metrics &&
        is_long_term_supported == other.is_long_term_supported &&
        time_deprecated == other.time_deprecated &&
        previous_state == other.previous_state &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
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
      [id, description, compartment_id, capabilities, lifecycle_state, lifecycle_details, vendor, version, display_name, time_created, time_updated, base_model_id, type, fine_tune_details, model_metrics, is_long_term_supported, time_deprecated, previous_state, freeform_tags, defined_tags, system_tags].hash
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
