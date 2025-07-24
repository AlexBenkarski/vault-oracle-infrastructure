# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Advanced options for logging configuration
  class HydraControlplaneClient::Models::UnifiedAgentTailSourceAdvancedOptions
    # Starts to read the logs from the head of the file or the last read position recorded in pos_file, not tail.
    # @return [BOOLEAN]
    attr_accessor :is_read_from_head

    # Enable the stat watcher based on inotify
    # @return [BOOLEAN]
    attr_accessor :is_enable_stat_watcher

    # Follow inodes instead of following file names.
    # @return [BOOLEAN]
    attr_accessor :is_follow_inodes

    # The interval of doing compaction of pos file.
    # @return [String]
    attr_accessor :pos_file_compaction_interval

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'is_read_from_head': :'isReadFromHead',
        'is_enable_stat_watcher': :'isEnableStatWatcher',
        'is_follow_inodes': :'isFollowInodes',
        'pos_file_compaction_interval': :'posFileCompactionInterval'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'is_read_from_head': :'BOOLEAN',
        'is_enable_stat_watcher': :'BOOLEAN',
        'is_follow_inodes': :'BOOLEAN',
        'pos_file_compaction_interval': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [BOOLEAN] :is_read_from_head The value to assign to the {#is_read_from_head} property
    # @option attributes [BOOLEAN] :is_enable_stat_watcher The value to assign to the {#is_enable_stat_watcher} property
    # @option attributes [BOOLEAN] :is_follow_inodes The value to assign to the {#is_follow_inodes} property
    # @option attributes [String] :pos_file_compaction_interval The value to assign to the {#pos_file_compaction_interval} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.is_read_from_head = attributes[:'isReadFromHead'] unless attributes[:'isReadFromHead'].nil?

      raise 'You cannot provide both :isReadFromHead and :is_read_from_head' if attributes.key?(:'isReadFromHead') && attributes.key?(:'is_read_from_head')

      self.is_read_from_head = attributes[:'is_read_from_head'] unless attributes[:'is_read_from_head'].nil?

      self.is_enable_stat_watcher = attributes[:'isEnableStatWatcher'] unless attributes[:'isEnableStatWatcher'].nil?

      raise 'You cannot provide both :isEnableStatWatcher and :is_enable_stat_watcher' if attributes.key?(:'isEnableStatWatcher') && attributes.key?(:'is_enable_stat_watcher')

      self.is_enable_stat_watcher = attributes[:'is_enable_stat_watcher'] unless attributes[:'is_enable_stat_watcher'].nil?

      self.is_follow_inodes = attributes[:'isFollowInodes'] unless attributes[:'isFollowInodes'].nil?

      raise 'You cannot provide both :isFollowInodes and :is_follow_inodes' if attributes.key?(:'isFollowInodes') && attributes.key?(:'is_follow_inodes')

      self.is_follow_inodes = attributes[:'is_follow_inodes'] unless attributes[:'is_follow_inodes'].nil?

      self.pos_file_compaction_interval = attributes[:'posFileCompactionInterval'] if attributes[:'posFileCompactionInterval']

      raise 'You cannot provide both :posFileCompactionInterval and :pos_file_compaction_interval' if attributes.key?(:'posFileCompactionInterval') && attributes.key?(:'pos_file_compaction_interval')

      self.pos_file_compaction_interval = attributes[:'pos_file_compaction_interval'] if attributes[:'pos_file_compaction_interval']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        is_read_from_head == other.is_read_from_head &&
        is_enable_stat_watcher == other.is_enable_stat_watcher &&
        is_follow_inodes == other.is_follow_inodes &&
        pos_file_compaction_interval == other.pos_file_compaction_interval
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
      [is_read_from_head, is_enable_stat_watcher, is_follow_inodes, pos_file_compaction_interval].hash
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
