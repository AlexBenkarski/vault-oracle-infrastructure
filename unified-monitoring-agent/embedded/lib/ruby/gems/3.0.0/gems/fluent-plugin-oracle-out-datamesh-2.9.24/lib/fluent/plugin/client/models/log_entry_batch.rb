# Copyright (c) 2016, 2022, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

require 'date'

module DM
  # A single batch of Log Entries.
  class DMLoggingingestion::Models::LogEntryBatch
    # **[Required]** List of data entries.
    # @return [Array<DM::DMLoggingingestion::Models::LogEntry>]
    attr_accessor :entries

    # **[Required]** This field signifies the type of logs being ingested.
    # For example: ServerA.requestLogs.
    #
    # @return [String]
    attr_accessor :type

    # This optional field is useful for specifying the specific sub-resource
    # or input file used to read the event.
    # For example: \"/var/log/application.log\".
    #
    # @return [String]
    attr_accessor :subject

    # **[Required]** The timestamp for all log entries in this batch. This can be
    # considered as the default timestamp for each entry, unless it is
    # overwritten by the entry time. An RFC3339-formatted date-time string
    # with milliseconds precision.
    #
    # @return [DateTime]
    attr_accessor :default_time

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        'entries': :'entries',
        'type': :'type',
        'subject': :'subject',
        'default_time': :'default_time'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [Array<OCI::Loggingingestion::Models::LogEntry>] :entries The value to assign to the {#entries} property
    # @option attributes [String] :type The value to assign to the {#type} property
    # @option attributes [String] :subject The value to assign to the {#subject} property
    # @option attributes [DateTime] :default_time The value to assign to the {#default_time} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.entries = attributes[:'entries'] if attributes[:'entries']

      self.type = attributes[:'type'] if attributes[:'type']

      self.subject = attributes[:'subject'] if attributes[:'subject']

      self.default_time = attributes[:'default_time'] if attributes[:'default_time']
    end

    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        entries == other.entries &&
        type == other.type &&
        subject == other.subject &&
        default_time == other.default_time
    end

    # @see the `==` method
    # @param [Object] other the other object to be compared
    def eql?(other)
      self == other
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [entries, type, subject, default_time].hash
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