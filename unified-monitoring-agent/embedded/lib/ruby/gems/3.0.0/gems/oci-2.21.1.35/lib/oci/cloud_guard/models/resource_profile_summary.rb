# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200131
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Summary information for a resource profile.
  class CloudGuard::Models::ResourceProfileSummary
    # Number of sightings associated with the resource profile
    # @return [Integer]
    attr_accessor :sightings_count

    # **[Required]** Unique identifier for the resource profile
    # @return [String]
    attr_accessor :id

    # **[Required]** Unique identifier for the resource associated with the resource profile
    # @return [String]
    attr_accessor :resource_id

    # **[Required]** Display name for the resource profile
    # @return [String]
    attr_accessor :display_name

    # **[Required]** Resource type for the resource profile
    # @return [String]
    attr_accessor :type

    # **[Required]** Risk score for the resource profile
    # @return [Float]
    attr_accessor :risk_score

    # **[Required]** List of tactic summaries associated with the resource profile
    # @return [Array<OCI::CloudGuard::Models::TacticSummary>]
    attr_accessor :tactics

    # **[Required]** Time the activities were first detected. Format defined by RFC3339.
    # @return [DateTime]
    attr_accessor :time_first_detected

    # **[Required]** Time the activities were last detected. Format defined by RFC3339.
    # @return [DateTime]
    attr_accessor :time_last_detected

    # Time the activities were first performed. Format defined by RFC3339.
    # @return [DateTime]
    attr_accessor :time_first_occurred

    # Time the activities were last performed. Format defined by RFC3339.
    # @return [DateTime]
    attr_accessor :time_last_occurred

    # Number of problems associated with this resource profile
    # @return [Integer]
    attr_accessor :problems_count

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'sightings_count': :'sightingsCount',
        'id': :'id',
        'resource_id': :'resourceId',
        'display_name': :'displayName',
        'type': :'type',
        'risk_score': :'riskScore',
        'tactics': :'tactics',
        'time_first_detected': :'timeFirstDetected',
        'time_last_detected': :'timeLastDetected',
        'time_first_occurred': :'timeFirstOccurred',
        'time_last_occurred': :'timeLastOccurred',
        'problems_count': :'problemsCount'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'sightings_count': :'Integer',
        'id': :'String',
        'resource_id': :'String',
        'display_name': :'String',
        'type': :'String',
        'risk_score': :'Float',
        'tactics': :'Array<OCI::CloudGuard::Models::TacticSummary>',
        'time_first_detected': :'DateTime',
        'time_last_detected': :'DateTime',
        'time_first_occurred': :'DateTime',
        'time_last_occurred': :'DateTime',
        'problems_count': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [Integer] :sightings_count The value to assign to the {#sightings_count} property
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :resource_id The value to assign to the {#resource_id} property
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :type The value to assign to the {#type} property
    # @option attributes [Float] :risk_score The value to assign to the {#risk_score} property
    # @option attributes [Array<OCI::CloudGuard::Models::TacticSummary>] :tactics The value to assign to the {#tactics} property
    # @option attributes [DateTime] :time_first_detected The value to assign to the {#time_first_detected} property
    # @option attributes [DateTime] :time_last_detected The value to assign to the {#time_last_detected} property
    # @option attributes [DateTime] :time_first_occurred The value to assign to the {#time_first_occurred} property
    # @option attributes [DateTime] :time_last_occurred The value to assign to the {#time_last_occurred} property
    # @option attributes [Integer] :problems_count The value to assign to the {#problems_count} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.sightings_count = attributes[:'sightingsCount'] if attributes[:'sightingsCount']

      raise 'You cannot provide both :sightingsCount and :sightings_count' if attributes.key?(:'sightingsCount') && attributes.key?(:'sightings_count')

      self.sightings_count = attributes[:'sightings_count'] if attributes[:'sightings_count']

      self.id = attributes[:'id'] if attributes[:'id']

      self.resource_id = attributes[:'resourceId'] if attributes[:'resourceId']

      raise 'You cannot provide both :resourceId and :resource_id' if attributes.key?(:'resourceId') && attributes.key?(:'resource_id')

      self.resource_id = attributes[:'resource_id'] if attributes[:'resource_id']

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.type = attributes[:'type'] if attributes[:'type']

      self.risk_score = attributes[:'riskScore'] if attributes[:'riskScore']

      raise 'You cannot provide both :riskScore and :risk_score' if attributes.key?(:'riskScore') && attributes.key?(:'risk_score')

      self.risk_score = attributes[:'risk_score'] if attributes[:'risk_score']

      self.tactics = attributes[:'tactics'] if attributes[:'tactics']

      self.time_first_detected = attributes[:'timeFirstDetected'] if attributes[:'timeFirstDetected']

      raise 'You cannot provide both :timeFirstDetected and :time_first_detected' if attributes.key?(:'timeFirstDetected') && attributes.key?(:'time_first_detected')

      self.time_first_detected = attributes[:'time_first_detected'] if attributes[:'time_first_detected']

      self.time_last_detected = attributes[:'timeLastDetected'] if attributes[:'timeLastDetected']

      raise 'You cannot provide both :timeLastDetected and :time_last_detected' if attributes.key?(:'timeLastDetected') && attributes.key?(:'time_last_detected')

      self.time_last_detected = attributes[:'time_last_detected'] if attributes[:'time_last_detected']

      self.time_first_occurred = attributes[:'timeFirstOccurred'] if attributes[:'timeFirstOccurred']

      raise 'You cannot provide both :timeFirstOccurred and :time_first_occurred' if attributes.key?(:'timeFirstOccurred') && attributes.key?(:'time_first_occurred')

      self.time_first_occurred = attributes[:'time_first_occurred'] if attributes[:'time_first_occurred']

      self.time_last_occurred = attributes[:'timeLastOccurred'] if attributes[:'timeLastOccurred']

      raise 'You cannot provide both :timeLastOccurred and :time_last_occurred' if attributes.key?(:'timeLastOccurred') && attributes.key?(:'time_last_occurred')

      self.time_last_occurred = attributes[:'time_last_occurred'] if attributes[:'time_last_occurred']

      self.problems_count = attributes[:'problemsCount'] if attributes[:'problemsCount']

      raise 'You cannot provide both :problemsCount and :problems_count' if attributes.key?(:'problemsCount') && attributes.key?(:'problems_count')

      self.problems_count = attributes[:'problems_count'] if attributes[:'problems_count']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        sightings_count == other.sightings_count &&
        id == other.id &&
        resource_id == other.resource_id &&
        display_name == other.display_name &&
        type == other.type &&
        risk_score == other.risk_score &&
        tactics == other.tactics &&
        time_first_detected == other.time_first_detected &&
        time_last_detected == other.time_last_detected &&
        time_first_occurred == other.time_first_occurred &&
        time_last_occurred == other.time_last_occurred &&
        problems_count == other.problems_count
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
      [sightings_count, id, resource_id, display_name, type, risk_score, tactics, time_first_detected, time_last_detected, time_first_occurred, time_last_occurred, problems_count].hash
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
