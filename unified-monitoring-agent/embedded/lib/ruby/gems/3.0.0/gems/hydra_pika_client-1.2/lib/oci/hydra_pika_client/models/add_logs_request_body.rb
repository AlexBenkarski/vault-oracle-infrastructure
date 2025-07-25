# Copyright (c) 2016, 2022, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # AddLogsRequestBody model.
  class HydraPikaClient::Models::AddLogsRequestBody
    # **[Required]** The data entries.
    # @return [Array<OCI::HydraPikaClient::Models::LogEntry>]
    attr_accessor :payload

    # **[Required]** The timestamp, in milliseconds since epoch, for all log entries in
    # this request. This can be considered as the default timestamp for each
    # entry, unless it is overwritten by the entry timestamp.
    #
    # @return [Integer]
    attr_accessor :segment_timestamp

    # Optional. The identifier for the file where the log entries
    # originated.
    #
    # @return [String]
    attr_accessor :file_identifier

    # Optional. The offset, relative to the fileIdentifier, for the first
    # entry in this request. The nth entry in this request is assumed to
    # have an offset of segmentStartOffset+n-1. The fileIdentifier, in
    # conjunction with segmentStartOffset, should uniquely identify a log
    # entry. If defined, the offset must be non-negative.
    #
    # @return [Integer]
    attr_accessor :segment_start_offset

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'payload': :'payload',
        'segment_timestamp': :'segmentTimestamp',
        'file_identifier': :'fileIdentifier',
        'segment_start_offset': :'segmentStartOffset'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'payload': :'Array<OCI::HydraPikaClient::Models::LogEntry>',
        'segment_timestamp': :'Integer',
        'file_identifier': :'String',
        'segment_start_offset': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [Array<OCI::HydraPikaClient::Models::LogEntry>] :payload The value to assign to the {#payload} property
    # @option attributes [Integer] :segment_timestamp The value to assign to the {#segment_timestamp} property
    # @option attributes [String] :file_identifier The value to assign to the {#file_identifier} property
    # @option attributes [Integer] :segment_start_offset The value to assign to the {#segment_start_offset} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.payload = attributes[:'payload'] if attributes[:'payload']

      self.segment_timestamp = attributes[:'segmentTimestamp'] if attributes[:'segmentTimestamp']

      raise 'You cannot provide both :segmentTimestamp and :segment_timestamp' if attributes.key?(:'segmentTimestamp') && attributes.key?(:'segment_timestamp')

      self.segment_timestamp = attributes[:'segment_timestamp'] if attributes[:'segment_timestamp']

      self.file_identifier = attributes[:'fileIdentifier'] if attributes[:'fileIdentifier']

      raise 'You cannot provide both :fileIdentifier and :file_identifier' if attributes.key?(:'fileIdentifier') && attributes.key?(:'file_identifier')

      self.file_identifier = attributes[:'file_identifier'] if attributes[:'file_identifier']

      self.segment_start_offset = attributes[:'segmentStartOffset'] if attributes[:'segmentStartOffset']

      raise 'You cannot provide both :segmentStartOffset and :segment_start_offset' if attributes.key?(:'segmentStartOffset') && attributes.key?(:'segment_start_offset')

      self.segment_start_offset = attributes[:'segment_start_offset'] if attributes[:'segment_start_offset']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        payload == other.payload &&
        segment_timestamp == other.segment_timestamp &&
        file_identifier == other.file_identifier &&
        segment_start_offset == other.segment_start_offset
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
      [payload, segment_timestamp, file_identifier, segment_start_offset].hash
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
