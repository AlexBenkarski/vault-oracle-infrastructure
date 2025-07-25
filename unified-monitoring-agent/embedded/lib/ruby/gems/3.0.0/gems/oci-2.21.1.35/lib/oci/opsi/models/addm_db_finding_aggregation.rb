# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20200630
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Summarizes a specific ADDM finding
  class Opsi::Models::AddmDbFindingAggregation
    # **[Required]** The [OCID](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/identifiers.htm) of the Database insight.
    # @return [String]
    attr_accessor :id

    # **[Required]** Unique finding id
    # @return [String]
    attr_accessor :finding_id

    # **[Required]** Category name
    # @return [String]
    attr_accessor :category_name

    # **[Required]** Category display name
    # @return [String]
    attr_accessor :category_display_name

    # **[Required]** Finding name
    # @return [String]
    attr_accessor :name

    # **[Required]** Finding message
    # @return [String]
    attr_accessor :message

    # **[Required]** Overall impact in terms of percentage of total activity
    # @return [Float]
    attr_accessor :impact_overall_percent

    # **[Required]** Maximum impact in terms of percentage of total activity
    # @return [Float]
    attr_accessor :impact_max_percent

    # Impact in terms of average active sessions
    # @return [Float]
    attr_accessor :impact_avg_active_sessions

    # **[Required]** Number of occurrences for this finding
    # @return [Integer]
    attr_accessor :frequency_count

    # **[Required]** Number of recommendations for this finding
    # @return [Integer]
    attr_accessor :recommendation_count

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'finding_id': :'findingId',
        'category_name': :'categoryName',
        'category_display_name': :'categoryDisplayName',
        'name': :'name',
        'message': :'message',
        'impact_overall_percent': :'impactOverallPercent',
        'impact_max_percent': :'impactMaxPercent',
        'impact_avg_active_sessions': :'impactAvgActiveSessions',
        'frequency_count': :'frequencyCount',
        'recommendation_count': :'recommendationCount'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'finding_id': :'String',
        'category_name': :'String',
        'category_display_name': :'String',
        'name': :'String',
        'message': :'String',
        'impact_overall_percent': :'Float',
        'impact_max_percent': :'Float',
        'impact_avg_active_sessions': :'Float',
        'frequency_count': :'Integer',
        'recommendation_count': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :finding_id The value to assign to the {#finding_id} property
    # @option attributes [String] :category_name The value to assign to the {#category_name} property
    # @option attributes [String] :category_display_name The value to assign to the {#category_display_name} property
    # @option attributes [String] :name The value to assign to the {#name} property
    # @option attributes [String] :message The value to assign to the {#message} property
    # @option attributes [Float] :impact_overall_percent The value to assign to the {#impact_overall_percent} property
    # @option attributes [Float] :impact_max_percent The value to assign to the {#impact_max_percent} property
    # @option attributes [Float] :impact_avg_active_sessions The value to assign to the {#impact_avg_active_sessions} property
    # @option attributes [Integer] :frequency_count The value to assign to the {#frequency_count} property
    # @option attributes [Integer] :recommendation_count The value to assign to the {#recommendation_count} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.finding_id = attributes[:'findingId'] if attributes[:'findingId']

      raise 'You cannot provide both :findingId and :finding_id' if attributes.key?(:'findingId') && attributes.key?(:'finding_id')

      self.finding_id = attributes[:'finding_id'] if attributes[:'finding_id']

      self.category_name = attributes[:'categoryName'] if attributes[:'categoryName']

      raise 'You cannot provide both :categoryName and :category_name' if attributes.key?(:'categoryName') && attributes.key?(:'category_name')

      self.category_name = attributes[:'category_name'] if attributes[:'category_name']

      self.category_display_name = attributes[:'categoryDisplayName'] if attributes[:'categoryDisplayName']

      raise 'You cannot provide both :categoryDisplayName and :category_display_name' if attributes.key?(:'categoryDisplayName') && attributes.key?(:'category_display_name')

      self.category_display_name = attributes[:'category_display_name'] if attributes[:'category_display_name']

      self.name = attributes[:'name'] if attributes[:'name']

      self.message = attributes[:'message'] if attributes[:'message']

      self.impact_overall_percent = attributes[:'impactOverallPercent'] if attributes[:'impactOverallPercent']

      raise 'You cannot provide both :impactOverallPercent and :impact_overall_percent' if attributes.key?(:'impactOverallPercent') && attributes.key?(:'impact_overall_percent')

      self.impact_overall_percent = attributes[:'impact_overall_percent'] if attributes[:'impact_overall_percent']

      self.impact_max_percent = attributes[:'impactMaxPercent'] if attributes[:'impactMaxPercent']

      raise 'You cannot provide both :impactMaxPercent and :impact_max_percent' if attributes.key?(:'impactMaxPercent') && attributes.key?(:'impact_max_percent')

      self.impact_max_percent = attributes[:'impact_max_percent'] if attributes[:'impact_max_percent']

      self.impact_avg_active_sessions = attributes[:'impactAvgActiveSessions'] if attributes[:'impactAvgActiveSessions']

      raise 'You cannot provide both :impactAvgActiveSessions and :impact_avg_active_sessions' if attributes.key?(:'impactAvgActiveSessions') && attributes.key?(:'impact_avg_active_sessions')

      self.impact_avg_active_sessions = attributes[:'impact_avg_active_sessions'] if attributes[:'impact_avg_active_sessions']

      self.frequency_count = attributes[:'frequencyCount'] if attributes[:'frequencyCount']

      raise 'You cannot provide both :frequencyCount and :frequency_count' if attributes.key?(:'frequencyCount') && attributes.key?(:'frequency_count')

      self.frequency_count = attributes[:'frequency_count'] if attributes[:'frequency_count']

      self.recommendation_count = attributes[:'recommendationCount'] if attributes[:'recommendationCount']

      raise 'You cannot provide both :recommendationCount and :recommendation_count' if attributes.key?(:'recommendationCount') && attributes.key?(:'recommendation_count')

      self.recommendation_count = attributes[:'recommendation_count'] if attributes[:'recommendation_count']
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
        finding_id == other.finding_id &&
        category_name == other.category_name &&
        category_display_name == other.category_display_name &&
        name == other.name &&
        message == other.message &&
        impact_overall_percent == other.impact_overall_percent &&
        impact_max_percent == other.impact_max_percent &&
        impact_avg_active_sessions == other.impact_avg_active_sessions &&
        frequency_count == other.frequency_count &&
        recommendation_count == other.recommendation_count
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
      [id, finding_id, category_name, category_display_name, name, message, impact_overall_percent, impact_max_percent, impact_avg_active_sessions, frequency_count, recommendation_count].hash
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
