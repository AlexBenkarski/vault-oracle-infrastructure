# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200601
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The configuration details of collection rule to enable automatic log collection from an object storage bucket.
  #
  class LogAnalytics::Models::CreateLogAnalyticsObjectCollectionRuleDetails
    COLLECTION_TYPE_ENUM = [
      COLLECTION_TYPE_LIVE = 'LIVE'.freeze,
      COLLECTION_TYPE_HISTORIC = 'HISTORIC'.freeze,
      COLLECTION_TYPE_HISTORIC_LIVE = 'HISTORIC_LIVE'.freeze
    ].freeze

    LOG_SET_KEY_ENUM = [
      LOG_SET_KEY_OBJECT_PATH = 'OBJECT_PATH'.freeze
    ].freeze

    LOG_TYPE_ENUM = [
      LOG_TYPE_LOG = 'LOG'.freeze,
      LOG_TYPE_LOG_EVENTS = 'LOG_EVENTS'.freeze
    ].freeze

    # **[Required]** A unique name given to the rule. The name must be unique within the tenancy, and cannot be modified.
    # @return [String]
    attr_accessor :name

    # A string that describes the details of the rule. It does not have to be unique, and can be changed.
    # Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :description

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the compartment to which this rule belongs.
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** Object Storage namespace.
    # @return [String]
    attr_accessor :os_namespace

    # **[Required]** Name of the Object Storage bucket.
    # @return [String]
    attr_accessor :os_bucket_name

    # The type of collection.
    #
    # @return [String]
    attr_reader :collection_type

    # The oldest time of the file in the bucket to consider for collection.
    # Accepted values are: BEGINNING or CURRENT_TIME or RFC3339 formatted datetime string.
    # Use this for HISTORIC or HISTORIC_LIVE collection types. When collectionType is LIVE, specifying pollSince value other than CURRENT_TIME will result in error.
    #
    # @return [String]
    attr_accessor :poll_since

    # The newest time of the file in the bucket to consider for collection.
    # Accepted values are: CURRENT_TIME or RFC3339 formatted datetime string.
    # Use this for HISTORIC collection type. When collectionType is LIVE or HISTORIC_LIVE, specifying pollTill will result in error.
    #
    # @return [String]
    attr_accessor :poll_till

    # **[Required]** Logging Analytics Log group OCID to associate the processed logs with.
    # @return [String]
    attr_accessor :log_group_id

    # **[Required]** Name of the Logging Analytics Source to use for the processing.
    # @return [String]
    attr_accessor :log_source_name

    # Logging Analytics entity OCID. Associates the processed logs with the given entity (optional).
    # @return [String]
    attr_accessor :entity_id

    # An optional character encoding to aid in detecting the character encoding of the contents of the objects while processing.
    # It is recommended to set this value as ISO_8859_1 when configuring content of the objects having more numeric characters,
    # and very few alphabets.
    # For e.g. this applies when configuring VCN Flow Logs.
    #
    # @return [String]
    attr_accessor :char_encoding

    # Whether or not this rule is currently enabled.
    #
    # @return [BOOLEAN]
    attr_accessor :is_enabled

    # Timezone to be used when processing log entries whose timestamps do not include an explicit timezone.
    # When this property is not specified, the timezone of the entity specified is used.
    # If the entity is also not specified or do not have a valid timezone then UTC is used.
    #
    # @return [String]
    attr_accessor :timezone

    # The logSet to be associated with the processed logs. The logSet feature can be used by customers with high volume of data
    # and this feature has to be enabled for a given tenancy prior to its usage.
    # When logSetExtRegex value is provided, it will take precedence over this logSet value and logSet will be computed dynamically
    # using logSetKey and logSetExtRegex.
    #
    # @return [String]
    attr_accessor :log_set

    # An optional parameter to indicate from where the logSet to be extracted using logSetExtRegex. Default value is OBJECT_PATH (e.g. /n/<namespace>/b/<bucketname>/o/<objectname>).
    #
    # @return [String]
    attr_reader :log_set_key

    # The regex to be applied against given logSetKey. Regex has to be in string escaped format.
    #
    # @return [String]
    attr_accessor :log_set_ext_regex

    # The override is used to modify some important configuration properties for objects matching a specific pattern inside the bucket.
    # Supported propeties for override are: logSourceName, charEncoding, entityId.
    # Supported matchType for override are \"contains\".
    #
    # @return [Hash<String, Array<OCI::LogAnalytics::Models::PropertyOverride>>]
    attr_accessor :overrides

    # When the filters are provided, only the objects matching the filters are picked up for processing.
    # The matchType supported is exact match and accommodates wildcard \"*\".
    # For more information on filters, see [Event Filters](https://docs.oracle.com/en-us/iaas/Content/Events/Concepts/filterevents.htm).
    #
    # @return [Array<String>]
    attr_accessor :object_name_filters

    # Type of files/objects in this object collection rule.
    #
    # @return [String]
    attr_reader :log_type

    # Flag to allow historic collection if poll period overlaps with existing ACTIVE collection rule
    #
    # @return [BOOLEAN]
    attr_accessor :is_force_historic_collection

    # Defined tags for this resource. Each key is predefined and scoped to a namespace.
    # Example: `{\"foo-namespace\": {\"bar-key\": \"value\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only.
    # Example: `{\"bar-key\": \"value\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'name',
        'description': :'description',
        'compartment_id': :'compartmentId',
        'os_namespace': :'osNamespace',
        'os_bucket_name': :'osBucketName',
        'collection_type': :'collectionType',
        'poll_since': :'pollSince',
        'poll_till': :'pollTill',
        'log_group_id': :'logGroupId',
        'log_source_name': :'logSourceName',
        'entity_id': :'entityId',
        'char_encoding': :'charEncoding',
        'is_enabled': :'isEnabled',
        'timezone': :'timezone',
        'log_set': :'logSet',
        'log_set_key': :'logSetKey',
        'log_set_ext_regex': :'logSetExtRegex',
        'overrides': :'overrides',
        'object_name_filters': :'objectNameFilters',
        'log_type': :'logType',
        'is_force_historic_collection': :'isForceHistoricCollection',
        'defined_tags': :'definedTags',
        'freeform_tags': :'freeformTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'String',
        'description': :'String',
        'compartment_id': :'String',
        'os_namespace': :'String',
        'os_bucket_name': :'String',
        'collection_type': :'String',
        'poll_since': :'String',
        'poll_till': :'String',
        'log_group_id': :'String',
        'log_source_name': :'String',
        'entity_id': :'String',
        'char_encoding': :'String',
        'is_enabled': :'BOOLEAN',
        'timezone': :'String',
        'log_set': :'String',
        'log_set_key': :'String',
        'log_set_ext_regex': :'String',
        'overrides': :'Hash<String, Array<OCI::LogAnalytics::Models::PropertyOverride>>',
        'object_name_filters': :'Array<String>',
        'log_type': :'String',
        'is_force_historic_collection': :'BOOLEAN',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'freeform_tags': :'Hash<String, String>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :os_namespace The value to assign to the {#os_namespace} property
    # @option attributes [String] :os_bucket_name The value to assign to the {#os_bucket_name} property
    # @option attributes [String] :collection_type The value to assign to the {#collection_type} property
    # @option attributes [String] :poll_since The value to assign to the {#poll_since} property
    # @option attributes [String] :poll_till The value to assign to the {#poll_till} property
    # @option attributes [String] :log_group_id The value to assign to the {#log_group_id} property
    # @option attributes [String] :log_source_name The value to assign to the {#log_source_name} property
    # @option attributes [String] :entity_id The value to assign to the {#entity_id} property
    # @option attributes [String] :char_encoding The value to assign to the {#char_encoding} property
    # @option attributes [BOOLEAN] :is_enabled The value to assign to the {#is_enabled} property
    # @option attributes [String] :timezone The value to assign to the {#timezone} property
    # @option attributes [String] :log_set The value to assign to the {#log_set} property
    # @option attributes [String] :log_set_key The value to assign to the {#log_set_key} property
    # @option attributes [String] :log_set_ext_regex The value to assign to the {#log_set_ext_regex} property
    # @option attributes [Hash<String, Array<OCI::LogAnalytics::Models::PropertyOverride>>] :overrides The value to assign to the {#overrides} property
    # @option attributes [Array<String>] :object_name_filters The value to assign to the {#object_name_filters} property
    # @option attributes [String] :log_type The value to assign to the {#log_type} property
    # @option attributes [BOOLEAN] :is_force_historic_collection The value to assign to the {#is_force_historic_collection} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.name = attributes[:'name'] if attributes[:'name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.os_namespace = attributes[:'osNamespace'] if attributes[:'osNamespace']

      raise 'You cannot provide both :osNamespace and :os_namespace' if attributes.key?(:'osNamespace') && attributes.key?(:'os_namespace')

      self.os_namespace = attributes[:'os_namespace'] if attributes[:'os_namespace']

      self.os_bucket_name = attributes[:'osBucketName'] if attributes[:'osBucketName']

      raise 'You cannot provide both :osBucketName and :os_bucket_name' if attributes.key?(:'osBucketName') && attributes.key?(:'os_bucket_name')

      self.os_bucket_name = attributes[:'os_bucket_name'] if attributes[:'os_bucket_name']

      self.collection_type = attributes[:'collectionType'] if attributes[:'collectionType']
      self.collection_type = "LIVE" if collection_type.nil? && !attributes.key?(:'collectionType') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :collectionType and :collection_type' if attributes.key?(:'collectionType') && attributes.key?(:'collection_type')

      self.collection_type = attributes[:'collection_type'] if attributes[:'collection_type']
      self.collection_type = "LIVE" if collection_type.nil? && !attributes.key?(:'collectionType') && !attributes.key?(:'collection_type') # rubocop:disable Style/StringLiterals

      self.poll_since = attributes[:'pollSince'] if attributes[:'pollSince']
      self.poll_since = "CURRENT_TIME" if poll_since.nil? && !attributes.key?(:'pollSince') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :pollSince and :poll_since' if attributes.key?(:'pollSince') && attributes.key?(:'poll_since')

      self.poll_since = attributes[:'poll_since'] if attributes[:'poll_since']
      self.poll_since = "CURRENT_TIME" if poll_since.nil? && !attributes.key?(:'pollSince') && !attributes.key?(:'poll_since') # rubocop:disable Style/StringLiterals

      self.poll_till = attributes[:'pollTill'] if attributes[:'pollTill']
      self.poll_till = "null" if poll_till.nil? && !attributes.key?(:'pollTill') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :pollTill and :poll_till' if attributes.key?(:'pollTill') && attributes.key?(:'poll_till')

      self.poll_till = attributes[:'poll_till'] if attributes[:'poll_till']
      self.poll_till = "null" if poll_till.nil? && !attributes.key?(:'pollTill') && !attributes.key?(:'poll_till') # rubocop:disable Style/StringLiterals

      self.log_group_id = attributes[:'logGroupId'] if attributes[:'logGroupId']

      raise 'You cannot provide both :logGroupId and :log_group_id' if attributes.key?(:'logGroupId') && attributes.key?(:'log_group_id')

      self.log_group_id = attributes[:'log_group_id'] if attributes[:'log_group_id']

      self.log_source_name = attributes[:'logSourceName'] if attributes[:'logSourceName']

      raise 'You cannot provide both :logSourceName and :log_source_name' if attributes.key?(:'logSourceName') && attributes.key?(:'log_source_name')

      self.log_source_name = attributes[:'log_source_name'] if attributes[:'log_source_name']

      self.entity_id = attributes[:'entityId'] if attributes[:'entityId']

      raise 'You cannot provide both :entityId and :entity_id' if attributes.key?(:'entityId') && attributes.key?(:'entity_id')

      self.entity_id = attributes[:'entity_id'] if attributes[:'entity_id']

      self.char_encoding = attributes[:'charEncoding'] if attributes[:'charEncoding']

      raise 'You cannot provide both :charEncoding and :char_encoding' if attributes.key?(:'charEncoding') && attributes.key?(:'char_encoding')

      self.char_encoding = attributes[:'char_encoding'] if attributes[:'char_encoding']

      self.is_enabled = attributes[:'isEnabled'] unless attributes[:'isEnabled'].nil?
      self.is_enabled = true if is_enabled.nil? && !attributes.key?(:'isEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isEnabled and :is_enabled' if attributes.key?(:'isEnabled') && attributes.key?(:'is_enabled')

      self.is_enabled = attributes[:'is_enabled'] unless attributes[:'is_enabled'].nil?
      self.is_enabled = true if is_enabled.nil? && !attributes.key?(:'isEnabled') && !attributes.key?(:'is_enabled') # rubocop:disable Style/StringLiterals

      self.timezone = attributes[:'timezone'] if attributes[:'timezone']

      self.log_set = attributes[:'logSet'] if attributes[:'logSet']

      raise 'You cannot provide both :logSet and :log_set' if attributes.key?(:'logSet') && attributes.key?(:'log_set')

      self.log_set = attributes[:'log_set'] if attributes[:'log_set']

      self.log_set_key = attributes[:'logSetKey'] if attributes[:'logSetKey']
      self.log_set_key = "OBJECT_PATH" if log_set_key.nil? && !attributes.key?(:'logSetKey') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :logSetKey and :log_set_key' if attributes.key?(:'logSetKey') && attributes.key?(:'log_set_key')

      self.log_set_key = attributes[:'log_set_key'] if attributes[:'log_set_key']
      self.log_set_key = "OBJECT_PATH" if log_set_key.nil? && !attributes.key?(:'logSetKey') && !attributes.key?(:'log_set_key') # rubocop:disable Style/StringLiterals

      self.log_set_ext_regex = attributes[:'logSetExtRegex'] if attributes[:'logSetExtRegex']

      raise 'You cannot provide both :logSetExtRegex and :log_set_ext_regex' if attributes.key?(:'logSetExtRegex') && attributes.key?(:'log_set_ext_regex')

      self.log_set_ext_regex = attributes[:'log_set_ext_regex'] if attributes[:'log_set_ext_regex']

      self.overrides = attributes[:'overrides'] if attributes[:'overrides']

      self.object_name_filters = attributes[:'objectNameFilters'] if attributes[:'objectNameFilters']

      raise 'You cannot provide both :objectNameFilters and :object_name_filters' if attributes.key?(:'objectNameFilters') && attributes.key?(:'object_name_filters')

      self.object_name_filters = attributes[:'object_name_filters'] if attributes[:'object_name_filters']

      self.log_type = attributes[:'logType'] if attributes[:'logType']
      self.log_type = "LOG" if log_type.nil? && !attributes.key?(:'logType') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :logType and :log_type' if attributes.key?(:'logType') && attributes.key?(:'log_type')

      self.log_type = attributes[:'log_type'] if attributes[:'log_type']
      self.log_type = "LOG" if log_type.nil? && !attributes.key?(:'logType') && !attributes.key?(:'log_type') # rubocop:disable Style/StringLiterals

      self.is_force_historic_collection = attributes[:'isForceHistoricCollection'] unless attributes[:'isForceHistoricCollection'].nil?
      self.is_force_historic_collection = false if is_force_historic_collection.nil? && !attributes.key?(:'isForceHistoricCollection') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isForceHistoricCollection and :is_force_historic_collection' if attributes.key?(:'isForceHistoricCollection') && attributes.key?(:'is_force_historic_collection')

      self.is_force_historic_collection = attributes[:'is_force_historic_collection'] unless attributes[:'is_force_historic_collection'].nil?
      self.is_force_historic_collection = false if is_force_historic_collection.nil? && !attributes.key?(:'isForceHistoricCollection') && !attributes.key?(:'is_force_historic_collection') # rubocop:disable Style/StringLiterals

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] collection_type Object to be assigned
    def collection_type=(collection_type)
      raise "Invalid value for 'collection_type': this must be one of the values in COLLECTION_TYPE_ENUM." if collection_type && !COLLECTION_TYPE_ENUM.include?(collection_type)

      @collection_type = collection_type
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] log_set_key Object to be assigned
    def log_set_key=(log_set_key)
      raise "Invalid value for 'log_set_key': this must be one of the values in LOG_SET_KEY_ENUM." if log_set_key && !LOG_SET_KEY_ENUM.include?(log_set_key)

      @log_set_key = log_set_key
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] log_type Object to be assigned
    def log_type=(log_type)
      raise "Invalid value for 'log_type': this must be one of the values in LOG_TYPE_ENUM." if log_type && !LOG_TYPE_ENUM.include?(log_type)

      @log_type = log_type
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        name == other.name &&
        description == other.description &&
        compartment_id == other.compartment_id &&
        os_namespace == other.os_namespace &&
        os_bucket_name == other.os_bucket_name &&
        collection_type == other.collection_type &&
        poll_since == other.poll_since &&
        poll_till == other.poll_till &&
        log_group_id == other.log_group_id &&
        log_source_name == other.log_source_name &&
        entity_id == other.entity_id &&
        char_encoding == other.char_encoding &&
        is_enabled == other.is_enabled &&
        timezone == other.timezone &&
        log_set == other.log_set &&
        log_set_key == other.log_set_key &&
        log_set_ext_regex == other.log_set_ext_regex &&
        overrides == other.overrides &&
        object_name_filters == other.object_name_filters &&
        log_type == other.log_type &&
        is_force_historic_collection == other.is_force_historic_collection &&
        defined_tags == other.defined_tags &&
        freeform_tags == other.freeform_tags
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
      [name, description, compartment_id, os_namespace, os_bucket_name, collection_type, poll_since, poll_till, log_group_id, log_source_name, entity_id, char_encoding, is_enabled, timezone, log_set, log_set_key, log_set_ext_regex, overrides, object_name_filters, log_type, is_force_historic_collection, defined_tags, freeform_tags].hash
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
