# Copyright (c) 2016, 2022, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

require 'date'

module DM
  # The request body for the PostLog request.
  class DMLoggingingestion::Models::PostLogBatches
    # **[Required]** Required to identify the source of the request.
    #
    # @return [DM::DMLoggingIngestion::Models::LogOrigin]
    attr_accessor :origin

    # **[Required]** List of log-batches. Each batch has a single source, type and subject.
    #
    # @return [Array<DM::DMLoggingingestion::Models::LogEntryBatch>]
    attr_accessor :batches

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        'origin': :'origin',
        'batches': :'batches'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :specversion The value to assign to the {#specversion} property
    # @option attributes [Array<DM::DMLoggingingestion::Models::LogEntryBatch>] :batches The value to assign to the {#batches} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.origin = attributes[:'origin'] if attributes[:'origin']
      self.batches = attributes[:'batches'] if attributes[:'batches']
    end

    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        origin == other.origin &&
        batches == other.batches
    end

    # @see the `==` method
    # @param [Object] other the other object to be compared
    def eql?(other)
      self == other
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [origin, batches].hash
    end


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