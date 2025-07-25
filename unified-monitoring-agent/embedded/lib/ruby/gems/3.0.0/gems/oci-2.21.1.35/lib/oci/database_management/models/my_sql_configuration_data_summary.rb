# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20201101
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The configuration variables for a MySQL Database.
  class DatabaseManagement::Models::MySqlConfigurationDataSummary
    SOURCE_ENUM = [
      SOURCE_COMPILED = 'COMPILED'.freeze,
      SOURCE_GLOBAL = 'GLOBAL'.freeze,
      SOURCE_SERVER = 'SERVER'.freeze,
      SOURCE_EXPLICIT = 'EXPLICIT'.freeze,
      SOURCE_EXTRA = 'EXTRA'.freeze,
      SOURCE_USER = 'USER'.freeze,
      SOURCE_LOGIN = 'LOGIN'.freeze,
      SOURCE_COMMAND_LINE = 'COMMAND_LINE'.freeze,
      SOURCE_PERSISTED = 'PERSISTED'.freeze,
      SOURCE_DYNAMIC = 'DYNAMIC'.freeze,
      SOURCE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The name of the configuration variable
    # @return [String]
    attr_accessor :name

    # **[Required]** The value of the variable.
    # @return [String]
    attr_accessor :value

    # **[Required]** The source from which the variable was most recently set.
    # @return [String]
    attr_reader :source

    # **[Required]** The minimum value of the variable.
    # @return [Float]
    attr_accessor :min_value

    # **[Required]** The maximum value of the variable.
    # @return [Float]
    attr_accessor :max_value

    # **[Required]** The type of variable.
    # @return [String]
    attr_accessor :type

    # **[Required]** The default value of the variable.
    # @return [String]
    attr_accessor :default_value

    # **[Required]** The time when the value of the variable was set.
    # @return [DateTime]
    attr_accessor :time_set

    # **[Required]** The host from where the value of the variable was set. This is empty for a MySQL Database System.
    # @return [String]
    attr_accessor :host_set

    # **[Required]** The user who sets the value of the variable. This is empty for a MySQL Database System.
    # @return [String]
    attr_accessor :user_set

    # **[Required]** Indicates whether the variable can be set dynamically or not.
    # @return [BOOLEAN]
    attr_accessor :is_dynamic

    # **[Required]** Indicates whether the variable is set at server startup.
    # @return [BOOLEAN]
    attr_accessor :is_init

    # **[Required]** Indicates whether the variable is configurable.
    # @return [BOOLEAN]
    attr_accessor :is_configurable

    # **[Required]** The path name of the option file (VARIABLE_PATH), if the variable was set in an option file. If the variable was not set in an
    # @return [String]
    attr_accessor :path

    # **[Required]** The description of the variable.
    # @return [String]
    attr_accessor :description

    # **[Required]** The comma-separated list of possible values for the variable in value:valueDescription format.
    # @return [String]
    attr_accessor :possible_values

    # **[Required]** The comma-separated list of MySQL versions that support the variable.
    # @return [String]
    attr_accessor :supported_versions

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'name',
        'value': :'value',
        'source': :'source',
        'min_value': :'minValue',
        'max_value': :'maxValue',
        'type': :'type',
        'default_value': :'defaultValue',
        'time_set': :'timeSet',
        'host_set': :'hostSet',
        'user_set': :'userSet',
        'is_dynamic': :'isDynamic',
        'is_init': :'isInit',
        'is_configurable': :'isConfigurable',
        'path': :'path',
        'description': :'description',
        'possible_values': :'possibleValues',
        'supported_versions': :'supportedVersions'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'String',
        'value': :'String',
        'source': :'String',
        'min_value': :'Float',
        'max_value': :'Float',
        'type': :'String',
        'default_value': :'String',
        'time_set': :'DateTime',
        'host_set': :'String',
        'user_set': :'String',
        'is_dynamic': :'BOOLEAN',
        'is_init': :'BOOLEAN',
        'is_configurable': :'BOOLEAN',
        'path': :'String',
        'description': :'String',
        'possible_values': :'String',
        'supported_versions': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :value The value to assign to the {#value} property
    # @option attributes [String] :source The value to assign to the {#source} property
    # @option attributes [Float] :min_value The value to assign to the {#min_value} property
    # @option attributes [Float] :max_value The value to assign to the {#max_value} property
    # @option attributes [String] :type The value to assign to the {#type} property
    # @option attributes [String] :default_value The value to assign to the {#default_value} property
    # @option attributes [DateTime] :time_set The value to assign to the {#time_set} property
    # @option attributes [String] :host_set The value to assign to the {#host_set} property
    # @option attributes [String] :user_set The value to assign to the {#user_set} property
    # @option attributes [BOOLEAN] :is_dynamic The value to assign to the {#is_dynamic} property
    # @option attributes [BOOLEAN] :is_init The value to assign to the {#is_init} property
    # @option attributes [BOOLEAN] :is_configurable The value to assign to the {#is_configurable} property
    # @option attributes [String] :path The value to assign to the {#path} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :possible_values The value to assign to the {#possible_values} property
    # @option attributes [String] :supported_versions The value to assign to the {#supported_versions} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.name = attributes[:'name'] if attributes[:'name']

      self.value = attributes[:'value'] if attributes[:'value']

      self.source = attributes[:'source'] if attributes[:'source']

      self.min_value = attributes[:'minValue'] if attributes[:'minValue']

      raise 'You cannot provide both :minValue and :min_value' if attributes.key?(:'minValue') && attributes.key?(:'min_value')

      self.min_value = attributes[:'min_value'] if attributes[:'min_value']

      self.max_value = attributes[:'maxValue'] if attributes[:'maxValue']

      raise 'You cannot provide both :maxValue and :max_value' if attributes.key?(:'maxValue') && attributes.key?(:'max_value')

      self.max_value = attributes[:'max_value'] if attributes[:'max_value']

      self.type = attributes[:'type'] if attributes[:'type']

      self.default_value = attributes[:'defaultValue'] if attributes[:'defaultValue']

      raise 'You cannot provide both :defaultValue and :default_value' if attributes.key?(:'defaultValue') && attributes.key?(:'default_value')

      self.default_value = attributes[:'default_value'] if attributes[:'default_value']

      self.time_set = attributes[:'timeSet'] if attributes[:'timeSet']

      raise 'You cannot provide both :timeSet and :time_set' if attributes.key?(:'timeSet') && attributes.key?(:'time_set')

      self.time_set = attributes[:'time_set'] if attributes[:'time_set']

      self.host_set = attributes[:'hostSet'] if attributes[:'hostSet']

      raise 'You cannot provide both :hostSet and :host_set' if attributes.key?(:'hostSet') && attributes.key?(:'host_set')

      self.host_set = attributes[:'host_set'] if attributes[:'host_set']

      self.user_set = attributes[:'userSet'] if attributes[:'userSet']

      raise 'You cannot provide both :userSet and :user_set' if attributes.key?(:'userSet') && attributes.key?(:'user_set')

      self.user_set = attributes[:'user_set'] if attributes[:'user_set']

      self.is_dynamic = attributes[:'isDynamic'] unless attributes[:'isDynamic'].nil?

      raise 'You cannot provide both :isDynamic and :is_dynamic' if attributes.key?(:'isDynamic') && attributes.key?(:'is_dynamic')

      self.is_dynamic = attributes[:'is_dynamic'] unless attributes[:'is_dynamic'].nil?

      self.is_init = attributes[:'isInit'] unless attributes[:'isInit'].nil?

      raise 'You cannot provide both :isInit and :is_init' if attributes.key?(:'isInit') && attributes.key?(:'is_init')

      self.is_init = attributes[:'is_init'] unless attributes[:'is_init'].nil?

      self.is_configurable = attributes[:'isConfigurable'] unless attributes[:'isConfigurable'].nil?

      raise 'You cannot provide both :isConfigurable and :is_configurable' if attributes.key?(:'isConfigurable') && attributes.key?(:'is_configurable')

      self.is_configurable = attributes[:'is_configurable'] unless attributes[:'is_configurable'].nil?

      self.path = attributes[:'path'] if attributes[:'path']

      self.description = attributes[:'description'] if attributes[:'description']

      self.possible_values = attributes[:'possibleValues'] if attributes[:'possibleValues']

      raise 'You cannot provide both :possibleValues and :possible_values' if attributes.key?(:'possibleValues') && attributes.key?(:'possible_values')

      self.possible_values = attributes[:'possible_values'] if attributes[:'possible_values']

      self.supported_versions = attributes[:'supportedVersions'] if attributes[:'supportedVersions']

      raise 'You cannot provide both :supportedVersions and :supported_versions' if attributes.key?(:'supportedVersions') && attributes.key?(:'supported_versions')

      self.supported_versions = attributes[:'supported_versions'] if attributes[:'supported_versions']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] source Object to be assigned
    def source=(source)
      # rubocop:disable Style/ConditionalAssignment
      if source && !SOURCE_ENUM.include?(source)
        OCI.logger.debug("Unknown value for 'source' [" + source + "]. Mapping to 'SOURCE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @source = SOURCE_UNKNOWN_ENUM_VALUE
      else
        @source = source
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        name == other.name &&
        value == other.value &&
        source == other.source &&
        min_value == other.min_value &&
        max_value == other.max_value &&
        type == other.type &&
        default_value == other.default_value &&
        time_set == other.time_set &&
        host_set == other.host_set &&
        user_set == other.user_set &&
        is_dynamic == other.is_dynamic &&
        is_init == other.is_init &&
        is_configurable == other.is_configurable &&
        path == other.path &&
        description == other.description &&
        possible_values == other.possible_values &&
        supported_versions == other.supported_versions
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
      [name, value, source, min_value, max_value, type, default_value, time_set, host_set, user_set, is_dynamic, is_init, is_configurable, path, description, possible_values, supported_versions].hash
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
