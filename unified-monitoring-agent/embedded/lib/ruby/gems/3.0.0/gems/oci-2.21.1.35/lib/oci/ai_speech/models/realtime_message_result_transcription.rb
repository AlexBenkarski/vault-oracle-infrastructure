# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220101
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Transcription object.
  class AiSpeech::Models::RealtimeMessageResultTranscription
    # **[Required]** Transcription text.
    # @return [String]
    attr_accessor :transcription

    # **[Required]** Whether the transcription is final or partial.
    # @return [BOOLEAN]
    attr_accessor :is_final

    # **[Required]** Start time in milliseconds for the transcription text.
    # @return [Integer]
    attr_accessor :start_time_in_ms

    # **[Required]** End time in milliseconds for the transcription text.
    # @return [Integer]
    attr_accessor :end_time_in_ms

    # **[Required]** Confidence for the transcription text.
    # @return [Float]
    attr_accessor :confidence

    # **[Required]** Trailing silence after the transcription text.
    # @return [Integer]
    attr_accessor :trailing_silence

    # **[Required]** Array of individual transcription tokens.
    # @return [Array<OCI::AiSpeech::Models::RealtimeMessageResultTranscriptionToken>]
    attr_accessor :tokens

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'transcription': :'transcription',
        'is_final': :'isFinal',
        'start_time_in_ms': :'startTimeInMs',
        'end_time_in_ms': :'endTimeInMs',
        'confidence': :'confidence',
        'trailing_silence': :'trailingSilence',
        'tokens': :'tokens'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'transcription': :'String',
        'is_final': :'BOOLEAN',
        'start_time_in_ms': :'Integer',
        'end_time_in_ms': :'Integer',
        'confidence': :'Float',
        'trailing_silence': :'Integer',
        'tokens': :'Array<OCI::AiSpeech::Models::RealtimeMessageResultTranscriptionToken>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :transcription The value to assign to the {#transcription} property
    # @option attributes [BOOLEAN] :is_final The value to assign to the {#is_final} property
    # @option attributes [Integer] :start_time_in_ms The value to assign to the {#start_time_in_ms} property
    # @option attributes [Integer] :end_time_in_ms The value to assign to the {#end_time_in_ms} property
    # @option attributes [Float] :confidence The value to assign to the {#confidence} property
    # @option attributes [Integer] :trailing_silence The value to assign to the {#trailing_silence} property
    # @option attributes [Array<OCI::AiSpeech::Models::RealtimeMessageResultTranscriptionToken>] :tokens The value to assign to the {#tokens} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.transcription = attributes[:'transcription'] if attributes[:'transcription']

      self.is_final = attributes[:'isFinal'] unless attributes[:'isFinal'].nil?

      raise 'You cannot provide both :isFinal and :is_final' if attributes.key?(:'isFinal') && attributes.key?(:'is_final')

      self.is_final = attributes[:'is_final'] unless attributes[:'is_final'].nil?

      self.start_time_in_ms = attributes[:'startTimeInMs'] if attributes[:'startTimeInMs']

      raise 'You cannot provide both :startTimeInMs and :start_time_in_ms' if attributes.key?(:'startTimeInMs') && attributes.key?(:'start_time_in_ms')

      self.start_time_in_ms = attributes[:'start_time_in_ms'] if attributes[:'start_time_in_ms']

      self.end_time_in_ms = attributes[:'endTimeInMs'] if attributes[:'endTimeInMs']

      raise 'You cannot provide both :endTimeInMs and :end_time_in_ms' if attributes.key?(:'endTimeInMs') && attributes.key?(:'end_time_in_ms')

      self.end_time_in_ms = attributes[:'end_time_in_ms'] if attributes[:'end_time_in_ms']

      self.confidence = attributes[:'confidence'] if attributes[:'confidence']

      self.trailing_silence = attributes[:'trailingSilence'] if attributes[:'trailingSilence']

      raise 'You cannot provide both :trailingSilence and :trailing_silence' if attributes.key?(:'trailingSilence') && attributes.key?(:'trailing_silence')

      self.trailing_silence = attributes[:'trailing_silence'] if attributes[:'trailing_silence']

      self.tokens = attributes[:'tokens'] if attributes[:'tokens']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        transcription == other.transcription &&
        is_final == other.is_final &&
        start_time_in_ms == other.start_time_in_ms &&
        end_time_in_ms == other.end_time_in_ms &&
        confidence == other.confidence &&
        trailing_silence == other.trailing_silence &&
        tokens == other.tokens
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
      [transcription, is_final, start_time_in_ms, end_time_in_ms, confidence, trailing_silence, tokens].hash
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
