# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20180917
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The properties that define a configuration source provider.
  # For more information, see
  # [Managing Configuration Source Providers](https://docs.cloud.oracle.com/iaas/Content/ResourceManager/Tasks/managingconfigurationsourceproviders.htm).
  #
  # This class has direct subclasses. If you are using this class as input to a service operations then you should favor using a subclass over the base class
  class ResourceManager::Models::ConfigurationSourceProvider
    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    CONFIG_SOURCE_PROVIDER_TYPE_ENUM = [
      CONFIG_SOURCE_PROVIDER_TYPE_BITBUCKET_CLOUD_USERNAME_APPPASSWORD = 'BITBUCKET_CLOUD_USERNAME_APPPASSWORD'.freeze,
      CONFIG_SOURCE_PROVIDER_TYPE_BITBUCKET_SERVER_ACCESS_TOKEN = 'BITBUCKET_SERVER_ACCESS_TOKEN'.freeze,
      CONFIG_SOURCE_PROVIDER_TYPE_GITLAB_ACCESS_TOKEN = 'GITLAB_ACCESS_TOKEN'.freeze,
      CONFIG_SOURCE_PROVIDER_TYPE_GITHUB_ACCESS_TOKEN = 'GITHUB_ACCESS_TOKEN'.freeze,
      CONFIG_SOURCE_PROVIDER_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the configuration source provider.
    # @return [String]
    attr_accessor :id

    # The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the compartment where the configuration source provider is located.
    # @return [String]
    attr_accessor :compartment_id

    # Human-readable display name for the configuration source provider.
    # @return [String]
    attr_accessor :display_name

    # Description of the configuration source provider.
    # @return [String]
    attr_accessor :description

    # The date and time when the configuration source provider was created.
    # Format is defined by RFC3339.
    # Example: `2020-01-25T21:10:29.600Z`
    #
    # @return [DateTime]
    attr_accessor :time_created

    # The current lifecycle state of the configuration source provider.
    # For more information about configuration source provider lifecycle states in Resource Manager, see
    # [Key Concepts](https://docs.cloud.oracle.com/iaas/Content/ResourceManager/Concepts/resourcemanager.htm#concepts__CSPStates).
    #
    # @return [String]
    attr_reader :lifecycle_state

    # **[Required]** The type of configuration source provider.
    # The `BITBUCKET_CLOUD_USERNAME_APPPASSWORD` type corresponds to Bitbucket Cloud.
    # The `BITBUCKET_SERVER_ACCESS_TOKEN` type corresponds to Bitbucket Server.
    # The `GITLAB_ACCESS_TOKEN` type corresponds to GitLab.
    # The `GITHUB_ACCESS_TOKEN` type corresponds to GitHub.
    #
    # @return [String]
    attr_reader :config_source_provider_type

    # @return [OCI::ResourceManager::Models::PrivateServerConfigDetails]
    attr_accessor :private_server_config_details

    # Username which is used to authorize the user.
    # @return [String]
    attr_accessor :username

    # Secret ocid which is used to authorize the user.
    # @return [String]
    attr_accessor :secret_id

    # Free-form tags associated with this resource. Each tag is a key-value pair with no predefined name, type, or namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'compartment_id': :'compartmentId',
        'display_name': :'displayName',
        'description': :'description',
        'time_created': :'timeCreated',
        'lifecycle_state': :'lifecycleState',
        'config_source_provider_type': :'configSourceProviderType',
        'private_server_config_details': :'privateServerConfigDetails',
        'username': :'username',
        'secret_id': :'secretId',
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
        'compartment_id': :'String',
        'display_name': :'String',
        'description': :'String',
        'time_created': :'DateTime',
        'lifecycle_state': :'String',
        'config_source_provider_type': :'String',
        'private_server_config_details': :'OCI::ResourceManager::Models::PrivateServerConfigDetails',
        'username': :'String',
        'secret_id': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity, Metrics/AbcSize


    # Given the hash representation of a subtype of this class,
    # use the info in the hash to return the class of the subtype.
    def self.get_subtype(object_hash)
      type = object_hash[:'configSourceProviderType'] # rubocop:disable Style/SymbolLiteral

      return 'OCI::ResourceManager::Models::GithubAccessTokenConfigurationSourceProvider' if type == 'GITHUB_ACCESS_TOKEN'
      return 'OCI::ResourceManager::Models::GitlabAccessTokenConfigurationSourceProvider' if type == 'GITLAB_ACCESS_TOKEN'
      return 'OCI::ResourceManager::Models::BitbucketServerAccessTokenConfigurationSourceProvider' if type == 'BITBUCKET_SERVER_ACCESS_TOKEN'
      return 'OCI::ResourceManager::Models::BitbucketCloudUsernameAppPasswordConfigurationSourceProvider' if type == 'BITBUCKET_CLOUD_USERNAME_APPPASSWORD'

      # TODO: Log a warning when the subtype is not found.
      'OCI::ResourceManager::Models::ConfigurationSourceProvider'
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity, Metrics/AbcSize

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :config_source_provider_type The value to assign to the {#config_source_provider_type} property
    # @option attributes [OCI::ResourceManager::Models::PrivateServerConfigDetails] :private_server_config_details The value to assign to the {#private_server_config_details} property
    # @option attributes [String] :username The value to assign to the {#username} property
    # @option attributes [String] :secret_id The value to assign to the {#secret_id} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.config_source_provider_type = attributes[:'configSourceProviderType'] if attributes[:'configSourceProviderType']

      raise 'You cannot provide both :configSourceProviderType and :config_source_provider_type' if attributes.key?(:'configSourceProviderType') && attributes.key?(:'config_source_provider_type')

      self.config_source_provider_type = attributes[:'config_source_provider_type'] if attributes[:'config_source_provider_type']

      self.private_server_config_details = attributes[:'privateServerConfigDetails'] if attributes[:'privateServerConfigDetails']

      raise 'You cannot provide both :privateServerConfigDetails and :private_server_config_details' if attributes.key?(:'privateServerConfigDetails') && attributes.key?(:'private_server_config_details')

      self.private_server_config_details = attributes[:'private_server_config_details'] if attributes[:'private_server_config_details']

      self.username = attributes[:'username'] if attributes[:'username']

      self.secret_id = attributes[:'secretId'] if attributes[:'secretId']

      raise 'You cannot provide both :secretId and :secret_id' if attributes.key?(:'secretId') && attributes.key?(:'secret_id')

      self.secret_id = attributes[:'secret_id'] if attributes[:'secret_id']

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

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] config_source_provider_type Object to be assigned
    def config_source_provider_type=(config_source_provider_type)
      # rubocop:disable Style/ConditionalAssignment
      if config_source_provider_type && !CONFIG_SOURCE_PROVIDER_TYPE_ENUM.include?(config_source_provider_type)
        OCI.logger.debug("Unknown value for 'config_source_provider_type' [" + config_source_provider_type + "]. Mapping to 'CONFIG_SOURCE_PROVIDER_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @config_source_provider_type = CONFIG_SOURCE_PROVIDER_TYPE_UNKNOWN_ENUM_VALUE
      else
        @config_source_provider_type = config_source_provider_type
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
        compartment_id == other.compartment_id &&
        display_name == other.display_name &&
        description == other.description &&
        time_created == other.time_created &&
        lifecycle_state == other.lifecycle_state &&
        config_source_provider_type == other.config_source_provider_type &&
        private_server_config_details == other.private_server_config_details &&
        username == other.username &&
        secret_id == other.secret_id &&
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
      [id, compartment_id, display_name, description, time_created, lifecycle_state, config_source_provider_type, private_server_config_details, username, secret_id, freeform_tags, defined_tags].hash
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
