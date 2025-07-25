# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.
require 'date'
require_relative 'unified_agent_logging_filter'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Logging record transformer filter object mutates/transforms logs.
  # Ref: https://docs.fluentd.org/filter/record_transformer
  #
  class HydraControlplaneClient::Models::UnifiedAgentLoggingRecordTransformerFilter < HydraControlplaneClient::Models::UnifiedAgentLoggingFilter
    # **[Required]** Add new key-value pairs in logs
    # @return [Array<OCI::HydraControlplaneClient::Models::RecordTransformerPair>]
    attr_accessor :record_list

    # When set to true, the full Ruby syntax is enabled in the ${} expression.
    # @return [BOOLEAN]
    attr_accessor :is_ruby_enabled

    # If true, automatically casts the field types.
    # @return [BOOLEAN]
    attr_accessor :is_auto_typecast_enabled

    # If true, it modifies a new empty hash
    # @return [BOOLEAN]
    attr_accessor :is_renew_record_enabled

    # Overwrites the time of logs with this value, this value must be a Unix timestamp.
    # @return [String]
    attr_accessor :renew_time_key

    # A list of keys to keep. Only relevant if isRenewRecordEnabled is set to true
    # @return [Array<String>]
    attr_accessor :keep_keys

    # A list of keys to delete
    # @return [Array<String>]
    attr_accessor :remove_keys

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'name',
        'filter_type': :'filterType',
        'record_list': :'recordList',
        'is_ruby_enabled': :'isRubyEnabled',
        'is_auto_typecast_enabled': :'isAutoTypecastEnabled',
        'is_renew_record_enabled': :'isRenewRecordEnabled',
        'renew_time_key': :'renewTimeKey',
        'keep_keys': :'keepKeys',
        'remove_keys': :'removeKeys'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'name': :'String',
        'filter_type': :'String',
        'record_list': :'Array<OCI::HydraControlplaneClient::Models::RecordTransformerPair>',
        'is_ruby_enabled': :'BOOLEAN',
        'is_auto_typecast_enabled': :'BOOLEAN',
        'is_renew_record_enabled': :'BOOLEAN',
        'renew_time_key': :'String',
        'keep_keys': :'Array<String>',
        'remove_keys': :'Array<String>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :name The value to assign to the {OCI::HydraControlplaneClient::Models::UnifiedAgentLoggingFilter#name #name} proprety
    # @option attributes [Array<OCI::HydraControlplaneClient::Models::RecordTransformerPair>] :record_list The value to assign to the {#record_list} property
    # @option attributes [BOOLEAN] :is_ruby_enabled The value to assign to the {#is_ruby_enabled} property
    # @option attributes [BOOLEAN] :is_auto_typecast_enabled The value to assign to the {#is_auto_typecast_enabled} property
    # @option attributes [BOOLEAN] :is_renew_record_enabled The value to assign to the {#is_renew_record_enabled} property
    # @option attributes [String] :renew_time_key The value to assign to the {#renew_time_key} property
    # @option attributes [Array<String>] :keep_keys The value to assign to the {#keep_keys} property
    # @option attributes [Array<String>] :remove_keys The value to assign to the {#remove_keys} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['filterType'] = 'RECORD_TRANSFORMER_FILTER'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.record_list = attributes[:'recordList'] if attributes[:'recordList']

      raise 'You cannot provide both :recordList and :record_list' if attributes.key?(:'recordList') && attributes.key?(:'record_list')

      self.record_list = attributes[:'record_list'] if attributes[:'record_list']

      self.is_ruby_enabled = attributes[:'isRubyEnabled'] unless attributes[:'isRubyEnabled'].nil?
      self.is_ruby_enabled = false if is_ruby_enabled.nil? && !attributes.key?(:'isRubyEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isRubyEnabled and :is_ruby_enabled' if attributes.key?(:'isRubyEnabled') && attributes.key?(:'is_ruby_enabled')

      self.is_ruby_enabled = attributes[:'is_ruby_enabled'] unless attributes[:'is_ruby_enabled'].nil?
      self.is_ruby_enabled = false if is_ruby_enabled.nil? && !attributes.key?(:'isRubyEnabled') && !attributes.key?(:'is_ruby_enabled') # rubocop:disable Style/StringLiterals

      self.is_auto_typecast_enabled = attributes[:'isAutoTypecastEnabled'] unless attributes[:'isAutoTypecastEnabled'].nil?
      self.is_auto_typecast_enabled = false if is_auto_typecast_enabled.nil? && !attributes.key?(:'isAutoTypecastEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isAutoTypecastEnabled and :is_auto_typecast_enabled' if attributes.key?(:'isAutoTypecastEnabled') && attributes.key?(:'is_auto_typecast_enabled')

      self.is_auto_typecast_enabled = attributes[:'is_auto_typecast_enabled'] unless attributes[:'is_auto_typecast_enabled'].nil?
      self.is_auto_typecast_enabled = false if is_auto_typecast_enabled.nil? && !attributes.key?(:'isAutoTypecastEnabled') && !attributes.key?(:'is_auto_typecast_enabled') # rubocop:disable Style/StringLiterals

      self.is_renew_record_enabled = attributes[:'isRenewRecordEnabled'] unless attributes[:'isRenewRecordEnabled'].nil?
      self.is_renew_record_enabled = false if is_renew_record_enabled.nil? && !attributes.key?(:'isRenewRecordEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isRenewRecordEnabled and :is_renew_record_enabled' if attributes.key?(:'isRenewRecordEnabled') && attributes.key?(:'is_renew_record_enabled')

      self.is_renew_record_enabled = attributes[:'is_renew_record_enabled'] unless attributes[:'is_renew_record_enabled'].nil?
      self.is_renew_record_enabled = false if is_renew_record_enabled.nil? && !attributes.key?(:'isRenewRecordEnabled') && !attributes.key?(:'is_renew_record_enabled') # rubocop:disable Style/StringLiterals

      self.renew_time_key = attributes[:'renewTimeKey'] if attributes[:'renewTimeKey']

      raise 'You cannot provide both :renewTimeKey and :renew_time_key' if attributes.key?(:'renewTimeKey') && attributes.key?(:'renew_time_key')

      self.renew_time_key = attributes[:'renew_time_key'] if attributes[:'renew_time_key']

      self.keep_keys = attributes[:'keepKeys'] if attributes[:'keepKeys']

      raise 'You cannot provide both :keepKeys and :keep_keys' if attributes.key?(:'keepKeys') && attributes.key?(:'keep_keys')

      self.keep_keys = attributes[:'keep_keys'] if attributes[:'keep_keys']

      self.remove_keys = attributes[:'removeKeys'] if attributes[:'removeKeys']

      raise 'You cannot provide both :removeKeys and :remove_keys' if attributes.key?(:'removeKeys') && attributes.key?(:'remove_keys')

      self.remove_keys = attributes[:'remove_keys'] if attributes[:'remove_keys']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        name == other.name &&
        filter_type == other.filter_type &&
        record_list == other.record_list &&
        is_ruby_enabled == other.is_ruby_enabled &&
        is_auto_typecast_enabled == other.is_auto_typecast_enabled &&
        is_renew_record_enabled == other.is_renew_record_enabled &&
        renew_time_key == other.renew_time_key &&
        keep_keys == other.keep_keys &&
        remove_keys == other.remove_keys
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
      [name, filter_type, record_list, is_ruby_enabled, is_auto_typecast_enabled, is_renew_record_enabled, renew_time_key, keep_keys, remove_keys].hash
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
