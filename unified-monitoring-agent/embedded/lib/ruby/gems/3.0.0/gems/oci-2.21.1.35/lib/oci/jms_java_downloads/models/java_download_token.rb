# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230601
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A JavaDownloadToken is a primary resource for the script friendly URLs. The value of this token serves as the authorization token for the download.
  class JmsJavaDownloads::Models::JavaDownloadToken
    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_CREATING = 'CREATING'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_DELETING = 'DELETING'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_NEEDS_ATTENTION = 'NEEDS_ATTENTION'.freeze,
      LIFECYCLE_STATE_UPDATING = 'UPDATING'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    LIFECYCLE_DETAILS_ENUM = [
      LIFECYCLE_DETAILS_EXPIRED = 'EXPIRED'.freeze,
      LIFECYCLE_DETAILS_REVOKING = 'REVOKING'.freeze,
      LIFECYCLE_DETAILS_REVOKED = 'REVOKED'.freeze,
      LIFECYCLE_DETAILS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the JavaDownloadToken.
    #
    # @return [String]
    attr_accessor :id

    # **[Required]** User provided display name of the JavaDownloadToken.
    # @return [String]
    attr_accessor :display_name

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of the tenancy scoped to the JavaDownloadToken.
    #
    # @return [String]
    attr_accessor :compartment_id

    # This attribute is required.
    # @return [OCI::JmsJavaDownloads::Models::Principal]
    attr_accessor :created_by

    # @return [OCI::JmsJavaDownloads::Models::Principal]
    attr_accessor :last_updated_by

    # **[Required]** User provided description of the JavaDownloadToken.
    # @return [String]
    attr_accessor :description

    # **[Required]** Uniquely generated value for the JavaDownloadToken.
    # @return [String]
    attr_accessor :value

    # **[Required]** The time the JavaDownloadToken was created, displayed as an [RFC3339](https://datatracker.ietf.org/doc/html/rfc3339) formatted datetime string.
    # @return [DateTime]
    attr_accessor :time_created

    # The time the JavaDownloadToken was updated, displayed as an [RFC3339](https://datatracker.ietf.org/doc/html/rfc3339) formatted datetime string.
    # @return [DateTime]
    attr_accessor :time_updated

    # The time the JavaDownloadToken was last used for download, displayed as an [RFC3339](https://datatracker.ietf.org/doc/html/rfc3339) formatted datetime string.
    # @return [DateTime]
    attr_accessor :time_last_used

    # **[Required]** The expiry time of the JavaDownloadToken, displayed as an [RFC3339](https://datatracker.ietf.org/doc/html/rfc3339) formatted datetime string.
    # @return [DateTime]
    attr_accessor :time_expires

    # **[Required]** The associated Java version of the JavaDownloadToken.
    # @return [String]
    attr_accessor :java_version

    # The license type(s) associated with the JavaDownloadToken.
    # @return [Array<OCI::JmsJavaDownloads::Models::LicenseType>]
    attr_accessor :license_type

    # A flag to indicate if the token is default.
    # @return [BOOLEAN]
    attr_accessor :is_default

    # **[Required]** The current state of the JavaDownloadToken.
    # @return [String]
    attr_reader :lifecycle_state

    # Possible lifecycle substates.
    # @return [String]
    attr_reader :lifecycle_details

    # Simple key-value pair that is applied without any predefined name, type, or scope. Exists for cross-compatibility only.
    # Example: `{\"bar-key\": \"value\"}`. (See [Managing Tags and Tag Namespaces](https://docs.cloud.oracle.com/Content/Tagging/Concepts/understandingfreeformtags.htm).)
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # Example: `{\"foo-namespace\": {\"bar-key\": \"value\"}}`. (See [Understanding Free-form Tags](https://docs.cloud.oracle.com/Content/Tagging/Tasks/managingtagsandtagnamespaces.htm)).
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # System tags for this resource. Each key is predefined and scoped to a namespace.
    # For more information, see [Resource Tags](https://docs.cloud.oracle.com/Content/General/Concepts/resourcetags.htm).
    # System tags can be viewed by users, but can only be created by the system.
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
        'display_name': :'displayName',
        'compartment_id': :'compartmentId',
        'created_by': :'createdBy',
        'last_updated_by': :'lastUpdatedBy',
        'description': :'description',
        'value': :'value',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'time_last_used': :'timeLastUsed',
        'time_expires': :'timeExpires',
        'java_version': :'javaVersion',
        'license_type': :'licenseType',
        'is_default': :'isDefault',
        'lifecycle_state': :'lifecycleState',
        'lifecycle_details': :'lifecycleDetails',
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
        'display_name': :'String',
        'compartment_id': :'String',
        'created_by': :'OCI::JmsJavaDownloads::Models::Principal',
        'last_updated_by': :'OCI::JmsJavaDownloads::Models::Principal',
        'description': :'String',
        'value': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'time_last_used': :'DateTime',
        'time_expires': :'DateTime',
        'java_version': :'String',
        'license_type': :'Array<OCI::JmsJavaDownloads::Models::LicenseType>',
        'is_default': :'BOOLEAN',
        'lifecycle_state': :'String',
        'lifecycle_details': :'String',
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
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [OCI::JmsJavaDownloads::Models::Principal] :created_by The value to assign to the {#created_by} property
    # @option attributes [OCI::JmsJavaDownloads::Models::Principal] :last_updated_by The value to assign to the {#last_updated_by} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :value The value to assign to the {#value} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [DateTime] :time_last_used The value to assign to the {#time_last_used} property
    # @option attributes [DateTime] :time_expires The value to assign to the {#time_expires} property
    # @option attributes [String] :java_version The value to assign to the {#java_version} property
    # @option attributes [Array<OCI::JmsJavaDownloads::Models::LicenseType>] :license_type The value to assign to the {#license_type} property
    # @option attributes [BOOLEAN] :is_default The value to assign to the {#is_default} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :lifecycle_details The value to assign to the {#lifecycle_details} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {#system_tags} property
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

      self.created_by = attributes[:'createdBy'] if attributes[:'createdBy']

      raise 'You cannot provide both :createdBy and :created_by' if attributes.key?(:'createdBy') && attributes.key?(:'created_by')

      self.created_by = attributes[:'created_by'] if attributes[:'created_by']

      self.last_updated_by = attributes[:'lastUpdatedBy'] if attributes[:'lastUpdatedBy']

      raise 'You cannot provide both :lastUpdatedBy and :last_updated_by' if attributes.key?(:'lastUpdatedBy') && attributes.key?(:'last_updated_by')

      self.last_updated_by = attributes[:'last_updated_by'] if attributes[:'last_updated_by']

      self.description = attributes[:'description'] if attributes[:'description']

      self.value = attributes[:'value'] if attributes[:'value']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.time_last_used = attributes[:'timeLastUsed'] if attributes[:'timeLastUsed']

      raise 'You cannot provide both :timeLastUsed and :time_last_used' if attributes.key?(:'timeLastUsed') && attributes.key?(:'time_last_used')

      self.time_last_used = attributes[:'time_last_used'] if attributes[:'time_last_used']

      self.time_expires = attributes[:'timeExpires'] if attributes[:'timeExpires']

      raise 'You cannot provide both :timeExpires and :time_expires' if attributes.key?(:'timeExpires') && attributes.key?(:'time_expires')

      self.time_expires = attributes[:'time_expires'] if attributes[:'time_expires']

      self.java_version = attributes[:'javaVersion'] if attributes[:'javaVersion']

      raise 'You cannot provide both :javaVersion and :java_version' if attributes.key?(:'javaVersion') && attributes.key?(:'java_version')

      self.java_version = attributes[:'java_version'] if attributes[:'java_version']

      self.license_type = attributes[:'licenseType'] if attributes[:'licenseType']

      raise 'You cannot provide both :licenseType and :license_type' if attributes.key?(:'licenseType') && attributes.key?(:'license_type')

      self.license_type = attributes[:'license_type'] if attributes[:'license_type']

      self.is_default = attributes[:'isDefault'] unless attributes[:'isDefault'].nil?

      raise 'You cannot provide both :isDefault and :is_default' if attributes.key?(:'isDefault') && attributes.key?(:'is_default')

      self.is_default = attributes[:'is_default'] unless attributes[:'is_default'].nil?

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

      self.system_tags = attributes[:'systemTags'] if attributes[:'systemTags']

      raise 'You cannot provide both :systemTags and :system_tags' if attributes.key?(:'systemTags') && attributes.key?(:'system_tags')

      self.system_tags = attributes[:'system_tags'] if attributes[:'system_tags']
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
    # @param [Object] lifecycle_details Object to be assigned
    def lifecycle_details=(lifecycle_details)
      # rubocop:disable Style/ConditionalAssignment
      if lifecycle_details && !LIFECYCLE_DETAILS_ENUM.include?(lifecycle_details)
        OCI.logger.debug("Unknown value for 'lifecycle_details' [" + lifecycle_details + "]. Mapping to 'LIFECYCLE_DETAILS_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @lifecycle_details = LIFECYCLE_DETAILS_UNKNOWN_ENUM_VALUE
      else
        @lifecycle_details = lifecycle_details
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
        created_by == other.created_by &&
        last_updated_by == other.last_updated_by &&
        description == other.description &&
        value == other.value &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        time_last_used == other.time_last_used &&
        time_expires == other.time_expires &&
        java_version == other.java_version &&
        license_type == other.license_type &&
        is_default == other.is_default &&
        lifecycle_state == other.lifecycle_state &&
        lifecycle_details == other.lifecycle_details &&
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
      [id, display_name, compartment_id, created_by, last_updated_by, description, value, time_created, time_updated, time_last_used, time_expires, java_version, license_type, is_default, lifecycle_state, lifecycle_details, freeform_tags, defined_tags, system_tags].hash
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
