# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220901
require 'date'
require_relative 'listing_revision_attachment'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Video attachment for the listing revision.
  class MarketplacePublisher::Models::VideoAttachment < MarketplacePublisher::Models::ListingRevisionAttachment
    # **[Required]** The URL for the video.
    # @return [String]
    attr_accessor :content_url

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'compartment_id': :'compartmentId',
        'listing_revision_id': :'listingRevisionId',
        'display_name': :'displayName',
        'description': :'description',
        'attachment_type': :'attachmentType',
        'lifecycle_state': :'lifecycleState',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags',
        'content_url': :'contentUrl'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'compartment_id': :'String',
        'listing_revision_id': :'String',
        'display_name': :'String',
        'description': :'String',
        'attachment_type': :'String',
        'lifecycle_state': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>',
        'content_url': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#id #id} proprety
    # @option attributes [String] :compartment_id The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#compartment_id #compartment_id} proprety
    # @option attributes [String] :listing_revision_id The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#listing_revision_id #listing_revision_id} proprety
    # @option attributes [String] :display_name The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#display_name #display_name} proprety
    # @option attributes [String] :description The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#description #description} proprety
    # @option attributes [String] :lifecycle_state The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#lifecycle_state #lifecycle_state} proprety
    # @option attributes [DateTime] :time_created The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#time_created #time_created} proprety
    # @option attributes [DateTime] :time_updated The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#time_updated #time_updated} proprety
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#freeform_tags #freeform_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#defined_tags #defined_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {OCI::MarketplacePublisher::Models::ListingRevisionAttachment#system_tags #system_tags} proprety
    # @option attributes [String] :content_url The value to assign to the {#content_url} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['attachmentType'] = 'VIDEO'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.content_url = attributes[:'contentUrl'] if attributes[:'contentUrl']

      raise 'You cannot provide both :contentUrl and :content_url' if attributes.key?(:'contentUrl') && attributes.key?(:'content_url')

      self.content_url = attributes[:'content_url'] if attributes[:'content_url']
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
        compartment_id == other.compartment_id &&
        listing_revision_id == other.listing_revision_id &&
        display_name == other.display_name &&
        description == other.description &&
        attachment_type == other.attachment_type &&
        lifecycle_state == other.lifecycle_state &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        system_tags == other.system_tags &&
        content_url == other.content_url
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
      [id, compartment_id, listing_revision_id, display_name, description, attachment_type, lifecycle_state, time_created, time_updated, freeform_tags, defined_tags, system_tags, content_url].hash
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
