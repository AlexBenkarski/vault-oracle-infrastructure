# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20201101
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The details of SQL statements and plans to be loaded from cursor cache. You can specify
  # the plans to load using SQL ID, plan identifier, or filterName and filterValue pair.
  # You can also control the SQL plan baseline into which the plans are loaded using either
  # SQL text or SQL handle.
  # It takes either credentials or databaseCredential. It's recommended to provide databaseCredential
  #
  class DatabaseManagement::Models::LoadSqlPlanBaselinesFromCursorCacheDetails
    FILTER_NAME_ENUM = [
      FILTER_NAME_SQL_TEXT = 'SQL_TEXT'.freeze,
      FILTER_NAME_PARSING_SCHEMA_NAME = 'PARSING_SCHEMA_NAME'.freeze,
      FILTER_NAME_MODULE = 'MODULE'.freeze,
      FILTER_NAME_ACTION = 'ACTION'.freeze
    ].freeze

    # **[Required]** The name of the database job used for loading SQL plan baselines.
    # @return [String]
    attr_accessor :job_name

    # The description of the job.
    # @return [String]
    attr_accessor :job_description

    # The SQL statement identifier. Identifies a SQL statement in the cursor cache.
    # @return [String]
    attr_accessor :sql_id

    # The plan identifier. By default, all plans present in the cursor cache
    # for the SQL statement identified by `sqlId` are captured.
    #
    # @return [Float]
    attr_accessor :plan_hash

    # The SQL text to use in identifying the SQL plan baseline into which the plans
    # are loaded. If the SQL plan baseline does not exist, it is created.
    #
    # @return [String]
    attr_accessor :sql_text

    # The SQL handle to use in identifying the SQL plan baseline into which
    # the plans are loaded.
    #
    # @return [String]
    attr_accessor :sql_handle

    # The name of the filter.
    #
    # - SQL_TEXT: Search pattern to apply to SQL text.
    # - PARSING_SCHEMA_NAME: Name of the parsing schema.
    # - MODULE: Name of the module.
    # - ACTION: Name of the action.
    #
    # @return [String]
    attr_reader :filter_name

    # The filter value. It is upper-cased except when it is enclosed in
    # double quotes or filter name is `SQL_TEXT`.
    #
    # @return [String]
    attr_accessor :filter_value

    # Indicates whether the plans are loaded as fixed plans (`true`) or non-fixed plans (`false`).
    # By default, they are loaded as non-fixed plans.
    #
    # @return [BOOLEAN]
    attr_accessor :is_fixed

    # Indicates whether the loaded plans are enabled (`true`) or not (`false`).
    # By default, they are enabled.
    #
    # @return [BOOLEAN]
    attr_accessor :is_enabled

    # @return [OCI::DatabaseManagement::Models::ManagedDatabaseCredential]
    attr_accessor :credentials

    # @return [OCI::DatabaseManagement::Models::DatabaseCredentialDetails]
    attr_accessor :database_credential

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'job_name': :'jobName',
        'job_description': :'jobDescription',
        'sql_id': :'sqlId',
        'plan_hash': :'planHash',
        'sql_text': :'sqlText',
        'sql_handle': :'sqlHandle',
        'filter_name': :'filterName',
        'filter_value': :'filterValue',
        'is_fixed': :'isFixed',
        'is_enabled': :'isEnabled',
        'credentials': :'credentials',
        'database_credential': :'databaseCredential'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'job_name': :'String',
        'job_description': :'String',
        'sql_id': :'String',
        'plan_hash': :'Float',
        'sql_text': :'String',
        'sql_handle': :'String',
        'filter_name': :'String',
        'filter_value': :'String',
        'is_fixed': :'BOOLEAN',
        'is_enabled': :'BOOLEAN',
        'credentials': :'OCI::DatabaseManagement::Models::ManagedDatabaseCredential',
        'database_credential': :'OCI::DatabaseManagement::Models::DatabaseCredentialDetails'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :job_name The value to assign to the {#job_name} property
    # @option attributes [String] :job_description The value to assign to the {#job_description} property
    # @option attributes [String] :sql_id The value to assign to the {#sql_id} property
    # @option attributes [Float] :plan_hash The value to assign to the {#plan_hash} property
    # @option attributes [String] :sql_text The value to assign to the {#sql_text} property
    # @option attributes [String] :sql_handle The value to assign to the {#sql_handle} property
    # @option attributes [String] :filter_name The value to assign to the {#filter_name} property
    # @option attributes [String] :filter_value The value to assign to the {#filter_value} property
    # @option attributes [BOOLEAN] :is_fixed The value to assign to the {#is_fixed} property
    # @option attributes [BOOLEAN] :is_enabled The value to assign to the {#is_enabled} property
    # @option attributes [OCI::DatabaseManagement::Models::ManagedDatabaseCredential] :credentials The value to assign to the {#credentials} property
    # @option attributes [OCI::DatabaseManagement::Models::DatabaseCredentialDetails] :database_credential The value to assign to the {#database_credential} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.job_name = attributes[:'jobName'] if attributes[:'jobName']

      raise 'You cannot provide both :jobName and :job_name' if attributes.key?(:'jobName') && attributes.key?(:'job_name')

      self.job_name = attributes[:'job_name'] if attributes[:'job_name']

      self.job_description = attributes[:'jobDescription'] if attributes[:'jobDescription']

      raise 'You cannot provide both :jobDescription and :job_description' if attributes.key?(:'jobDescription') && attributes.key?(:'job_description')

      self.job_description = attributes[:'job_description'] if attributes[:'job_description']

      self.sql_id = attributes[:'sqlId'] if attributes[:'sqlId']

      raise 'You cannot provide both :sqlId and :sql_id' if attributes.key?(:'sqlId') && attributes.key?(:'sql_id')

      self.sql_id = attributes[:'sql_id'] if attributes[:'sql_id']

      self.plan_hash = attributes[:'planHash'] if attributes[:'planHash']

      raise 'You cannot provide both :planHash and :plan_hash' if attributes.key?(:'planHash') && attributes.key?(:'plan_hash')

      self.plan_hash = attributes[:'plan_hash'] if attributes[:'plan_hash']

      self.sql_text = attributes[:'sqlText'] if attributes[:'sqlText']

      raise 'You cannot provide both :sqlText and :sql_text' if attributes.key?(:'sqlText') && attributes.key?(:'sql_text')

      self.sql_text = attributes[:'sql_text'] if attributes[:'sql_text']

      self.sql_handle = attributes[:'sqlHandle'] if attributes[:'sqlHandle']

      raise 'You cannot provide both :sqlHandle and :sql_handle' if attributes.key?(:'sqlHandle') && attributes.key?(:'sql_handle')

      self.sql_handle = attributes[:'sql_handle'] if attributes[:'sql_handle']

      self.filter_name = attributes[:'filterName'] if attributes[:'filterName']

      raise 'You cannot provide both :filterName and :filter_name' if attributes.key?(:'filterName') && attributes.key?(:'filter_name')

      self.filter_name = attributes[:'filter_name'] if attributes[:'filter_name']

      self.filter_value = attributes[:'filterValue'] if attributes[:'filterValue']

      raise 'You cannot provide both :filterValue and :filter_value' if attributes.key?(:'filterValue') && attributes.key?(:'filter_value')

      self.filter_value = attributes[:'filter_value'] if attributes[:'filter_value']

      self.is_fixed = attributes[:'isFixed'] unless attributes[:'isFixed'].nil?

      raise 'You cannot provide both :isFixed and :is_fixed' if attributes.key?(:'isFixed') && attributes.key?(:'is_fixed')

      self.is_fixed = attributes[:'is_fixed'] unless attributes[:'is_fixed'].nil?

      self.is_enabled = attributes[:'isEnabled'] unless attributes[:'isEnabled'].nil?

      raise 'You cannot provide both :isEnabled and :is_enabled' if attributes.key?(:'isEnabled') && attributes.key?(:'is_enabled')

      self.is_enabled = attributes[:'is_enabled'] unless attributes[:'is_enabled'].nil?

      self.credentials = attributes[:'credentials'] if attributes[:'credentials']

      self.database_credential = attributes[:'databaseCredential'] if attributes[:'databaseCredential']

      raise 'You cannot provide both :databaseCredential and :database_credential' if attributes.key?(:'databaseCredential') && attributes.key?(:'database_credential')

      self.database_credential = attributes[:'database_credential'] if attributes[:'database_credential']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] filter_name Object to be assigned
    def filter_name=(filter_name)
      raise "Invalid value for 'filter_name': this must be one of the values in FILTER_NAME_ENUM." if filter_name && !FILTER_NAME_ENUM.include?(filter_name)

      @filter_name = filter_name
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        job_name == other.job_name &&
        job_description == other.job_description &&
        sql_id == other.sql_id &&
        plan_hash == other.plan_hash &&
        sql_text == other.sql_text &&
        sql_handle == other.sql_handle &&
        filter_name == other.filter_name &&
        filter_value == other.filter_value &&
        is_fixed == other.is_fixed &&
        is_enabled == other.is_enabled &&
        credentials == other.credentials &&
        database_credential == other.database_credential
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
      [job_name, job_description, sql_id, plan_hash, sql_text, sql_handle, filter_name, filter_value, is_fixed, is_enabled, credentials, database_credential].hash
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
