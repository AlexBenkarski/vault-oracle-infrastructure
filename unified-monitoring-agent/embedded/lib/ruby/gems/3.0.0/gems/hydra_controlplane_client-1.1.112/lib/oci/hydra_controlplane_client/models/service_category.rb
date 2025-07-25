# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A service category entity to register logging category for partner service.
  #
  class HydraControlplaneClient::Models::ServiceCategory
    # **[Required]** The OCID of the resource.
    # @return [String]
    attr_accessor :id

    # The id of the service to which the category belongs
    # @return [String]
    attr_accessor :service_id

    # **[Required]** The unique name of the resource and is not changeable. Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :name

    # **[Required]** The user-friendly display name. This must be unique within the enclosing resource,
    # and it's changeable. Avoid entering confidential information.
    #
    # @return [String]
    attr_accessor :display_name

    # **[Required]** url to be stored.
    # @return [String]
    attr_accessor :endpoint

    # **[Required]** Flag to use proxy or not
    # @return [BOOLEAN]
    attr_accessor :is_proxy_enabled

    # **[Required]** Type of the resource. This is the RQS schema name of the resource for which logging is being enabled.
    # @return [String]
    attr_accessor :resource_type

    # **[Required]** The stage in which the category is currently. It could be dev, stage or prod.
    #
    # @return [String]
    attr_accessor :category_stage

    # **[Required]** Maintains true if logging is enabled fo ethe category.
    # @return [BOOLEAN]
    attr_accessor :is_logging_enabled

    # **[Required]** Service parameters for this category.
    # @return [Array<OCI::HydraControlplaneClient::Models::ServiceRegistryParameter>]
    attr_accessor :parameters

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
        'service_id': :'serviceId',
        'name': :'name',
        'display_name': :'displayName',
        'endpoint': :'endpoint',
        'is_proxy_enabled': :'isProxyEnabled',
        'resource_type': :'resourceType',
        'category_stage': :'categoryStage',
        'is_logging_enabled': :'isLoggingEnabled',
        'parameters': :'parameters',
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
        'service_id': :'String',
        'name': :'String',
        'display_name': :'String',
        'endpoint': :'String',
        'is_proxy_enabled': :'BOOLEAN',
        'resource_type': :'String',
        'category_stage': :'String',
        'is_logging_enabled': :'BOOLEAN',
        'parameters': :'Array<OCI::HydraControlplaneClient::Models::ServiceRegistryParameter>',
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
    # @option attributes [String] :service_id The value to assign to the {#service_id} property
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :endpoint The value to assign to the {#endpoint} property
    # @option attributes [BOOLEAN] :is_proxy_enabled The value to assign to the {#is_proxy_enabled} property
    # @option attributes [String] :resource_type The value to assign to the {#resource_type} property
    # @option attributes [String] :category_stage The value to assign to the {#category_stage} property
    # @option attributes [BOOLEAN] :is_logging_enabled The value to assign to the {#is_logging_enabled} property
    # @option attributes [Array<OCI::HydraControlplaneClient::Models::ServiceRegistryParameter>] :parameters The value to assign to the {#parameters} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_last_modified The value to assign to the {#time_last_modified} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.service_id = attributes[:'serviceId'] if attributes[:'serviceId']

      raise 'You cannot provide both :serviceId and :service_id' if attributes.key?(:'serviceId') && attributes.key?(:'service_id')

      self.service_id = attributes[:'service_id'] if attributes[:'service_id']

      self.name = attributes[:'name'] if attributes[:'name']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.endpoint = attributes[:'endpoint'] if attributes[:'endpoint']

      self.is_proxy_enabled = attributes[:'isProxyEnabled'] unless attributes[:'isProxyEnabled'].nil?

      raise 'You cannot provide both :isProxyEnabled and :is_proxy_enabled' if attributes.key?(:'isProxyEnabled') && attributes.key?(:'is_proxy_enabled')

      self.is_proxy_enabled = attributes[:'is_proxy_enabled'] unless attributes[:'is_proxy_enabled'].nil?

      self.resource_type = attributes[:'resourceType'] if attributes[:'resourceType']

      raise 'You cannot provide both :resourceType and :resource_type' if attributes.key?(:'resourceType') && attributes.key?(:'resource_type')

      self.resource_type = attributes[:'resource_type'] if attributes[:'resource_type']

      self.category_stage = attributes[:'categoryStage'] if attributes[:'categoryStage']

      raise 'You cannot provide both :categoryStage and :category_stage' if attributes.key?(:'categoryStage') && attributes.key?(:'category_stage')

      self.category_stage = attributes[:'category_stage'] if attributes[:'category_stage']

      self.is_logging_enabled = attributes[:'isLoggingEnabled'] unless attributes[:'isLoggingEnabled'].nil?

      raise 'You cannot provide both :isLoggingEnabled and :is_logging_enabled' if attributes.key?(:'isLoggingEnabled') && attributes.key?(:'is_logging_enabled')

      self.is_logging_enabled = attributes[:'is_logging_enabled'] unless attributes[:'is_logging_enabled'].nil?

      self.parameters = attributes[:'parameters'] if attributes[:'parameters']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_last_modified = attributes[:'timeLastModified'] if attributes[:'timeLastModified']

      raise 'You cannot provide both :timeLastModified and :time_last_modified' if attributes.key?(:'timeLastModified') && attributes.key?(:'time_last_modified')

      self.time_last_modified = attributes[:'time_last_modified'] if attributes[:'time_last_modified']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        id == other.id &&
        service_id == other.service_id &&
        name == other.name &&
        display_name == other.display_name &&
        endpoint == other.endpoint &&
        is_proxy_enabled == other.is_proxy_enabled &&
        resource_type == other.resource_type &&
        category_stage == other.category_stage &&
        is_logging_enabled == other.is_logging_enabled &&
        parameters == other.parameters &&
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
      [id, service_id, name, display_name, endpoint, is_proxy_enabled, resource_type, category_stage, is_logging_enabled, parameters, time_created, time_last_modified].hash
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
