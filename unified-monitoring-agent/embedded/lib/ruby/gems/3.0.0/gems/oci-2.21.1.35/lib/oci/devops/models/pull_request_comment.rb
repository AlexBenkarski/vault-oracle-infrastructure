# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20210630
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # User comments created by reviewers during the pull request review.
  class Devops::Models::PullRequestComment
    FILE_TYPE_ENUM = [
      FILE_TYPE_SOURCE = 'SOURCE'.freeze,
      FILE_TYPE_DESTINATION = 'DESTINATION'.freeze,
      FILE_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    STATUS_ENUM = [
      STATUS_ACTIVE = 'ACTIVE'.freeze,
      STATUS_OUTDATED = 'OUTDATED'.freeze,
      STATUS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    CONTEXT_STATUS_ENUM = [
      CONTEXT_STATUS_PROCESSED = 'PROCESSED'.freeze,
      CONTEXT_STATUS_NEEDS_PROCESSING = 'NEEDS_PROCESSING'.freeze,
      CONTEXT_STATUS_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Unique identifier that is immutable on creation
    # @return [String]
    attr_accessor :id

    # **[Required]** OCID of the pull request that this comment belongs to
    # @return [String]
    attr_accessor :pull_request_id

    # **[Required]** Content of the Comment.
    # @return [String]
    attr_accessor :data

    # ID of parent Comment
    # @return [String]
    attr_accessor :parent_id

    # File path in the commit
    # @return [String]
    attr_accessor :file_path

    # Commit SHA
    # @return [String]
    attr_accessor :commit_id

    # File path in the target commit
    # @return [String]
    attr_reader :file_type

    # Line number in the file
    # @return [Integer]
    attr_accessor :line_number

    # @return [OCI::Devops::Models::PullRequestCommentLikeCollection]
    attr_accessor :likes

    # **[Required]** Status of the Comment
    # @return [String]
    attr_reader :status

    # **[Required]** Creation timestamp. Format defined by [RFC3339](https://datatracker.ietf.org/doc/html/rfc3339).
    # @return [DateTime]
    attr_accessor :time_created

    # This attribute is required.
    # @return [OCI::Devops::Models::PrincipalDetails]
    attr_accessor :created_by

    # Latest update timestamp. Format defined by [RFC3339](https://datatracker.ietf.org/doc/html/rfc3339).
    # @return [DateTime]
    attr_accessor :time_updated

    # @return [OCI::Devops::Models::PrincipalDetails]
    attr_accessor :updated_by

    # Shows the status of an inline comments context
    # @return [String]
    attr_reader :context_status

    # 4 line snippet to be displayed as context for inline comments
    # @return [Array<OCI::Devops::Models::DiffLineDetails>]
    attr_accessor :comment_context

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'pull_request_id': :'pullRequestId',
        'data': :'data',
        'parent_id': :'parentId',
        'file_path': :'filePath',
        'commit_id': :'commitId',
        'file_type': :'fileType',
        'line_number': :'lineNumber',
        'likes': :'likes',
        'status': :'status',
        'time_created': :'timeCreated',
        'created_by': :'createdBy',
        'time_updated': :'timeUpdated',
        'updated_by': :'updatedBy',
        'context_status': :'contextStatus',
        'comment_context': :'commentContext'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'pull_request_id': :'String',
        'data': :'String',
        'parent_id': :'String',
        'file_path': :'String',
        'commit_id': :'String',
        'file_type': :'String',
        'line_number': :'Integer',
        'likes': :'OCI::Devops::Models::PullRequestCommentLikeCollection',
        'status': :'String',
        'time_created': :'DateTime',
        'created_by': :'OCI::Devops::Models::PrincipalDetails',
        'time_updated': :'DateTime',
        'updated_by': :'OCI::Devops::Models::PrincipalDetails',
        'context_status': :'String',
        'comment_context': :'Array<OCI::Devops::Models::DiffLineDetails>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :pull_request_id The value to assign to the {#pull_request_id} property
    # @option attributes [String] :data The value to assign to the {#data} property
    # @option attributes [String] :parent_id The value to assign to the {#parent_id} property
    # @option attributes [String] :file_path The value to assign to the {#file_path} property
    # @option attributes [String] :commit_id The value to assign to the {#commit_id} property
    # @option attributes [String] :file_type The value to assign to the {#file_type} property
    # @option attributes [Integer] :line_number The value to assign to the {#line_number} property
    # @option attributes [OCI::Devops::Models::PullRequestCommentLikeCollection] :likes The value to assign to the {#likes} property
    # @option attributes [String] :status The value to assign to the {#status} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [OCI::Devops::Models::PrincipalDetails] :created_by The value to assign to the {#created_by} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [OCI::Devops::Models::PrincipalDetails] :updated_by The value to assign to the {#updated_by} property
    # @option attributes [String] :context_status The value to assign to the {#context_status} property
    # @option attributes [Array<OCI::Devops::Models::DiffLineDetails>] :comment_context The value to assign to the {#comment_context} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.id = attributes[:'id'] if attributes[:'id']

      self.pull_request_id = attributes[:'pullRequestId'] if attributes[:'pullRequestId']

      raise 'You cannot provide both :pullRequestId and :pull_request_id' if attributes.key?(:'pullRequestId') && attributes.key?(:'pull_request_id')

      self.pull_request_id = attributes[:'pull_request_id'] if attributes[:'pull_request_id']

      self.data = attributes[:'data'] if attributes[:'data']

      self.parent_id = attributes[:'parentId'] if attributes[:'parentId']

      raise 'You cannot provide both :parentId and :parent_id' if attributes.key?(:'parentId') && attributes.key?(:'parent_id')

      self.parent_id = attributes[:'parent_id'] if attributes[:'parent_id']

      self.file_path = attributes[:'filePath'] if attributes[:'filePath']

      raise 'You cannot provide both :filePath and :file_path' if attributes.key?(:'filePath') && attributes.key?(:'file_path')

      self.file_path = attributes[:'file_path'] if attributes[:'file_path']

      self.commit_id = attributes[:'commitId'] if attributes[:'commitId']

      raise 'You cannot provide both :commitId and :commit_id' if attributes.key?(:'commitId') && attributes.key?(:'commit_id')

      self.commit_id = attributes[:'commit_id'] if attributes[:'commit_id']

      self.file_type = attributes[:'fileType'] if attributes[:'fileType']

      raise 'You cannot provide both :fileType and :file_type' if attributes.key?(:'fileType') && attributes.key?(:'file_type')

      self.file_type = attributes[:'file_type'] if attributes[:'file_type']

      self.line_number = attributes[:'lineNumber'] if attributes[:'lineNumber']

      raise 'You cannot provide both :lineNumber and :line_number' if attributes.key?(:'lineNumber') && attributes.key?(:'line_number')

      self.line_number = attributes[:'line_number'] if attributes[:'line_number']

      self.likes = attributes[:'likes'] if attributes[:'likes']

      self.status = attributes[:'status'] if attributes[:'status']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.created_by = attributes[:'createdBy'] if attributes[:'createdBy']

      raise 'You cannot provide both :createdBy and :created_by' if attributes.key?(:'createdBy') && attributes.key?(:'created_by')

      self.created_by = attributes[:'created_by'] if attributes[:'created_by']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.updated_by = attributes[:'updatedBy'] if attributes[:'updatedBy']

      raise 'You cannot provide both :updatedBy and :updated_by' if attributes.key?(:'updatedBy') && attributes.key?(:'updated_by')

      self.updated_by = attributes[:'updated_by'] if attributes[:'updated_by']

      self.context_status = attributes[:'contextStatus'] if attributes[:'contextStatus']

      raise 'You cannot provide both :contextStatus and :context_status' if attributes.key?(:'contextStatus') && attributes.key?(:'context_status')

      self.context_status = attributes[:'context_status'] if attributes[:'context_status']

      self.comment_context = attributes[:'commentContext'] if attributes[:'commentContext']

      raise 'You cannot provide both :commentContext and :comment_context' if attributes.key?(:'commentContext') && attributes.key?(:'comment_context')

      self.comment_context = attributes[:'comment_context'] if attributes[:'comment_context']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] file_type Object to be assigned
    def file_type=(file_type)
      # rubocop:disable Style/ConditionalAssignment
      if file_type && !FILE_TYPE_ENUM.include?(file_type)
        OCI.logger.debug("Unknown value for 'file_type' [" + file_type + "]. Mapping to 'FILE_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @file_type = FILE_TYPE_UNKNOWN_ENUM_VALUE
      else
        @file_type = file_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] status Object to be assigned
    def status=(status)
      # rubocop:disable Style/ConditionalAssignment
      if status && !STATUS_ENUM.include?(status)
        OCI.logger.debug("Unknown value for 'status' [" + status + "]. Mapping to 'STATUS_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @status = STATUS_UNKNOWN_ENUM_VALUE
      else
        @status = status
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] context_status Object to be assigned
    def context_status=(context_status)
      # rubocop:disable Style/ConditionalAssignment
      if context_status && !CONTEXT_STATUS_ENUM.include?(context_status)
        OCI.logger.debug("Unknown value for 'context_status' [" + context_status + "]. Mapping to 'CONTEXT_STATUS_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @context_status = CONTEXT_STATUS_UNKNOWN_ENUM_VALUE
      else
        @context_status = context_status
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        id == other.id &&
        pull_request_id == other.pull_request_id &&
        data == other.data &&
        parent_id == other.parent_id &&
        file_path == other.file_path &&
        commit_id == other.commit_id &&
        file_type == other.file_type &&
        line_number == other.line_number &&
        likes == other.likes &&
        status == other.status &&
        time_created == other.time_created &&
        created_by == other.created_by &&
        time_updated == other.time_updated &&
        updated_by == other.updated_by &&
        context_status == other.context_status &&
        comment_context == other.comment_context
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
      [id, pull_request_id, data, parent_id, file_path, commit_id, file_type, line_number, likes, status, time_created, created_by, time_updated, updated_by, context_status, comment_context].hash
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
