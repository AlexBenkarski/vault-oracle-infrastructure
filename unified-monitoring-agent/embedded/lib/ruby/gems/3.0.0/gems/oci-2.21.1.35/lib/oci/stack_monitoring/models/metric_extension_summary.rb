# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20210330
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Summary information about metric extension resources
  class StackMonitoring::Models::MetricExtensionSummary
    STATUS_ENUM = [
      STATUS_DRAFT = 'DRAFT'.freeze,
      STATUS_PUBLISHED = 'PUBLISHED'.freeze,
      STATUS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    COLLECTION_METHOD_ENUM = [
      COLLECTION_METHOD_OS_COMMAND = 'OS_COMMAND'.freeze,
      COLLECTION_METHOD_SQL = 'SQL'.freeze,
      COLLECTION_METHOD_JMX = 'JMX'.freeze,
      COLLECTION_METHOD_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm) of metric extension.
    # @return [String]
    attr_accessor :id

    # **[Required]** Metric Extension Resource name.
    # @return [String]
    attr_accessor :name

    # Metric Extension resource display name.
    # @return [String]
    attr_accessor :display_name

    # Description of the metric extension.
    # @return [String]
    attr_accessor :description

    # **[Required]** Resource type to which Metric Extension applies
    # @return [String]
    attr_accessor :resource_type

    # **[Required]** Compartment Identifier [OCID](https://docs.cloud.oracle.com/Content/General/Concepts/identifiers.htm)
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** The current state of the metric extension.
    # @return [String]
    attr_reader :status

    # The current lifecycle state of the metric extension
    # @return [String]
    attr_reader :lifecycle_state

    # Metric Extension creation time. An RFC3339 formatted datetime string
    # @return [DateTime]
    attr_accessor :time_created

    # Metric Extension updation time. An RFC3339 formatted datetime string
    # @return [DateTime]
    attr_accessor :time_updated

    # Type of possible collection methods.
    # @return [String]
    attr_reader :collection_method

    # Count of resources on which this metric extension is enabled.
    # @return [Integer]
    attr_accessor :enabled_on_resources_count

    # The URI path that the user can do a GET on to access the metric extension metadata
    # @return [String]
    attr_accessor :resource_uri

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'name': :'name',
        'display_name': :'displayName',
        'description': :'description',
        'resource_type': :'resourceType',
        'compartment_id': :'compartmentId',
        'status': :'status',
        'lifecycle_state': :'lifecycleState',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'collection_method': :'collectionMethod',
        'enabled_on_resources_count': :'enabledOnResourcesCount',
        'resource_uri': :'resourceUri'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'name': :'String',
        'display_name': :'String',
        'description': :'String',
        'resource_type': :'String',
        'compartment_id': :'String',
        'status': :'String',
        'lifecycle_state': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'collection_method': :'String',
        'enabled_on_resources_count': :'Integer',
        'resource_uri': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :resource_type The value to assign to the {#resource_type} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :status The value to assign to the {#status} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [String] :collection_method The value to assign to the {#collection_method} property
    # @option attributes [Integer] :enabled_on_resources_count The value to assign to the {#enabled_on_resources_count} property
    # @option attributes [String] :resource_uri The value to assign to the {#resource_uri} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.name = attributes[:'name'] if attributes[:'name']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.resource_type = attributes[:'resourceType'] if attributes[:'resourceType']

      raise 'You cannot provide both :resourceType and :resource_type' if attributes.key?(:'resourceType') && attributes.key?(:'resource_type')

      self.resource_type = attributes[:'resource_type'] if attributes[:'resource_type']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.status = attributes[:'status'] if attributes[:'status']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.collection_method = attributes[:'collectionMethod'] if attributes[:'collectionMethod']

      raise 'You cannot provide both :collectionMethod and :collection_method' if attributes.key?(:'collectionMethod') && attributes.key?(:'collection_method')

      self.collection_method = attributes[:'collection_method'] if attributes[:'collection_method']

      self.enabled_on_resources_count = attributes[:'enabledOnResourcesCount'] if attributes[:'enabledOnResourcesCount']

      raise 'You cannot provide both :enabledOnResourcesCount and :enabled_on_resources_count' if attributes.key?(:'enabledOnResourcesCount') && attributes.key?(:'enabled_on_resources_count')

      self.enabled_on_resources_count = attributes[:'enabled_on_resources_count'] if attributes[:'enabled_on_resources_count']

      self.resource_uri = attributes[:'resourceUri'] if attributes[:'resourceUri']

      raise 'You cannot provide both :resourceUri and :resource_uri' if attributes.key?(:'resourceUri') && attributes.key?(:'resource_uri')

      self.resource_uri = attributes[:'resource_uri'] if attributes[:'resource_uri']
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
    # @param [Object] collection_method Object to be assigned
    def collection_method=(collection_method)
      # rubocop:disable Style/ConditionalAssignment
      if collection_method && !COLLECTION_METHOD_ENUM.include?(collection_method)
        OCI.logger.debug("Unknown value for 'collection_method' [" + collection_method + "]. Mapping to 'COLLECTION_METHOD_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @collection_method = COLLECTION_METHOD_UNKNOWN_ENUM_VALUE
      else
        @collection_method = collection_method
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
        name == other.name &&
        display_name == other.display_name &&
        description == other.description &&
        resource_type == other.resource_type &&
        compartment_id == other.compartment_id &&
        status == other.status &&
        lifecycle_state == other.lifecycle_state &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        collection_method == other.collection_method &&
        enabled_on_resources_count == other.enabled_on_resources_count &&
        resource_uri == other.resource_uri
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
      [id, name, display_name, description, resource_type, compartment_id, status, lifecycle_state, time_created, time_updated, collection_method, enabled_on_resources_count, resource_uri].hash
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
