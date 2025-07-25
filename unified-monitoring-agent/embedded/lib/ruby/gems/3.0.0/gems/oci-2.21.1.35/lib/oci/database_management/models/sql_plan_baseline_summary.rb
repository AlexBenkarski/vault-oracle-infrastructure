# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20201101
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The summary of a SQL plan baseline.
  class DatabaseManagement::Models::SqlPlanBaselineSummary
    ORIGIN_ENUM = [
      ORIGIN_ADDM_SQLTUNE = 'ADDM_SQLTUNE'.freeze,
      ORIGIN_AUTO_CAPTURE = 'AUTO_CAPTURE'.freeze,
      ORIGIN_AUTO_SQLTUNE = 'AUTO_SQLTUNE'.freeze,
      ORIGIN_EVOLVE_AUTO_INDEX_LOAD = 'EVOLVE_AUTO_INDEX_LOAD'.freeze,
      ORIGIN_EVOLVE_CREATE_FROM_ADAPTIVE = 'EVOLVE_CREATE_FROM_ADAPTIVE'.freeze,
      ORIGIN_EVOLVE_LOAD_FROM_STS = 'EVOLVE_LOAD_FROM_STS'.freeze,
      ORIGIN_EVOLVE_LOAD_FROM_AWR = 'EVOLVE_LOAD_FROM_AWR'.freeze,
      ORIGIN_EVOLVE_LOAD_FROM_CURSOR_CACHE = 'EVOLVE_LOAD_FROM_CURSOR_CACHE'.freeze,
      ORIGIN_MANUAL_LOAD = 'MANUAL_LOAD'.freeze,
      ORIGIN_MANUAL_LOAD_FROM_AWR = 'MANUAL_LOAD_FROM_AWR'.freeze,
      ORIGIN_MANUAL_LOAD_FROM_CURSOR_CACHE = 'MANUAL_LOAD_FROM_CURSOR_CACHE'.freeze,
      ORIGIN_MANUAL_LOAD_FROM_STS = 'MANUAL_LOAD_FROM_STS'.freeze,
      ORIGIN_MANUAL_SQLTUNE = 'MANUAL_SQLTUNE'.freeze,
      ORIGIN_STORED_OUTLINE = 'STORED_OUTLINE'.freeze,
      ORIGIN_UNKNOWN = 'UNKNOWN'.freeze,
      ORIGIN_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    ENABLED_ENUM = [
      ENABLED_YES = 'YES'.freeze,
      ENABLED_NO = 'NO'.freeze,
      ENABLED_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    ACCEPTED_ENUM = [
      ACCEPTED_YES = 'YES'.freeze,
      ACCEPTED_NO = 'NO'.freeze,
      ACCEPTED_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    FIXED_ENUM = [
      FIXED_YES = 'YES'.freeze,
      FIXED_NO = 'NO'.freeze,
      FIXED_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    REPRODUCED_ENUM = [
      REPRODUCED_YES = 'YES'.freeze,
      REPRODUCED_NO = 'NO'.freeze,
      REPRODUCED_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    AUTO_PURGE_ENUM = [
      AUTO_PURGE_YES = 'YES'.freeze,
      AUTO_PURGE_NO = 'NO'.freeze,
      AUTO_PURGE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    ADAPTIVE_ENUM = [
      ADAPTIVE_YES = 'YES'.freeze,
      ADAPTIVE_NO = 'NO'.freeze,
      ADAPTIVE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** The unique plan identifier.
    # @return [String]
    attr_accessor :plan_name

    # **[Required]** The unique SQL identifier.
    # @return [String]
    attr_accessor :sql_handle

    # **[Required]** The SQL text (truncated to the first 50 characters).
    # @return [String]
    attr_accessor :sql_text

    # The origin of the SQL plan baseline.
    # @return [String]
    attr_reader :origin

    # **[Required]** The date and time when the plan baseline was created.
    # @return [DateTime]
    attr_accessor :time_created

    # The date and time when the plan baseline was last modified.
    # @return [DateTime]
    attr_accessor :time_last_modified

    # The date and time when the plan baseline was last executed.
    #
    # **Note:** For performance reasons, database does not update this value
    # immediately after each execution of the plan baseline. Therefore, the plan
    # baseline may have been executed more recently than this value indicates.
    #
    # @return [DateTime]
    attr_accessor :time_last_executed

    # Indicates whether the plan baseline is enabled (`YES`) or disabled (`NO`).
    # @return [String]
    attr_reader :enabled

    # Indicates whether the plan baseline is accepted (`YES`) or not (`NO`).
    # @return [String]
    attr_reader :accepted

    # Indicates whether the plan baseline is fixed (`YES`) or not (`NO`).
    # @return [String]
    attr_reader :fixed

    # Indicates whether the optimizer was able to reproduce the plan (`YES`) or not (`NO`).
    # The value is set to `YES` when a plan is initially added to the plan baseline.
    #
    # @return [String]
    attr_reader :reproduced

    # Indicates whether the plan baseline is auto-purged (`YES`) or not (`NO`).
    # @return [String]
    attr_reader :auto_purge

    # Indicates whether a plan that is automatically captured by SQL plan management is marked adaptive or not.
    #
    # When a new adaptive plan is found for a SQL statement that has an existing SQL plan baseline, that new plan
    # will be added to the SQL plan baseline as an unaccepted plan, and the `ADAPTIVE` property will be marked `YES`.
    # When this new plan is verified (either manually or via the auto evolve task), the plan will be test executed
    # and the final plan determined at execution will become an accepted plan if its performance is better than
    # the existing plan baseline. At this point, the value of the `ADAPTIVE` property is set to `NO` since the plan
    # is no longer adaptive, but resolved.
    #
    # @return [String]
    attr_reader :adaptive

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'plan_name': :'planName',
        'sql_handle': :'sqlHandle',
        'sql_text': :'sqlText',
        'origin': :'origin',
        'time_created': :'timeCreated',
        'time_last_modified': :'timeLastModified',
        'time_last_executed': :'timeLastExecuted',
        'enabled': :'enabled',
        'accepted': :'accepted',
        'fixed': :'fixed',
        'reproduced': :'reproduced',
        'auto_purge': :'autoPurge',
        'adaptive': :'adaptive'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'plan_name': :'String',
        'sql_handle': :'String',
        'sql_text': :'String',
        'origin': :'String',
        'time_created': :'DateTime',
        'time_last_modified': :'DateTime',
        'time_last_executed': :'DateTime',
        'enabled': :'String',
        'accepted': :'String',
        'fixed': :'String',
        'reproduced': :'String',
        'auto_purge': :'String',
        'adaptive': :'String'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :plan_name The value to assign to the {#plan_name} property
    # @option attributes [String] :sql_handle The value to assign to the {#sql_handle} property
    # @option attributes [String] :sql_text The value to assign to the {#sql_text} property
    # @option attributes [String] :origin The value to assign to the {#origin} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_last_modified The value to assign to the {#time_last_modified} property
    # @option attributes [DateTime] :time_last_executed The value to assign to the {#time_last_executed} property
    # @option attributes [String] :enabled The value to assign to the {#enabled} property
    # @option attributes [String] :accepted The value to assign to the {#accepted} property
    # @option attributes [String] :fixed The value to assign to the {#fixed} property
    # @option attributes [String] :reproduced The value to assign to the {#reproduced} property
    # @option attributes [String] :auto_purge The value to assign to the {#auto_purge} property
    # @option attributes [String] :adaptive The value to assign to the {#adaptive} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.plan_name = attributes[:'planName'] if attributes[:'planName']

      raise 'You cannot provide both :planName and :plan_name' if attributes.key?(:'planName') && attributes.key?(:'plan_name')

      self.plan_name = attributes[:'plan_name'] if attributes[:'plan_name']

      self.sql_handle = attributes[:'sqlHandle'] if attributes[:'sqlHandle']

      raise 'You cannot provide both :sqlHandle and :sql_handle' if attributes.key?(:'sqlHandle') && attributes.key?(:'sql_handle')

      self.sql_handle = attributes[:'sql_handle'] if attributes[:'sql_handle']

      self.sql_text = attributes[:'sqlText'] if attributes[:'sqlText']

      raise 'You cannot provide both :sqlText and :sql_text' if attributes.key?(:'sqlText') && attributes.key?(:'sql_text')

      self.sql_text = attributes[:'sql_text'] if attributes[:'sql_text']

      self.origin = attributes[:'origin'] if attributes[:'origin']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_last_modified = attributes[:'timeLastModified'] if attributes[:'timeLastModified']

      raise 'You cannot provide both :timeLastModified and :time_last_modified' if attributes.key?(:'timeLastModified') && attributes.key?(:'time_last_modified')

      self.time_last_modified = attributes[:'time_last_modified'] if attributes[:'time_last_modified']

      self.time_last_executed = attributes[:'timeLastExecuted'] if attributes[:'timeLastExecuted']

      raise 'You cannot provide both :timeLastExecuted and :time_last_executed' if attributes.key?(:'timeLastExecuted') && attributes.key?(:'time_last_executed')

      self.time_last_executed = attributes[:'time_last_executed'] if attributes[:'time_last_executed']

      self.enabled = attributes[:'enabled'] if attributes[:'enabled']

      self.accepted = attributes[:'accepted'] if attributes[:'accepted']

      self.fixed = attributes[:'fixed'] if attributes[:'fixed']

      self.reproduced = attributes[:'reproduced'] if attributes[:'reproduced']

      self.auto_purge = attributes[:'autoPurge'] if attributes[:'autoPurge']

      raise 'You cannot provide both :autoPurge and :auto_purge' if attributes.key?(:'autoPurge') && attributes.key?(:'auto_purge')

      self.auto_purge = attributes[:'auto_purge'] if attributes[:'auto_purge']

      self.adaptive = attributes[:'adaptive'] if attributes[:'adaptive']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] origin Object to be assigned
    def origin=(origin)
      # rubocop:disable Style/ConditionalAssignment
      if origin && !ORIGIN_ENUM.include?(origin)
        OCI.logger.debug("Unknown value for 'origin' [" + origin + "]. Mapping to 'ORIGIN_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @origin = ORIGIN_UNKNOWN_ENUM_VALUE
      else
        @origin = origin
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] enabled Object to be assigned
    def enabled=(enabled)
      # rubocop:disable Style/ConditionalAssignment
      if enabled && !ENABLED_ENUM.include?(enabled)
        OCI.logger.debug("Unknown value for 'enabled' [" + enabled + "]. Mapping to 'ENABLED_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @enabled = ENABLED_UNKNOWN_ENUM_VALUE
      else
        @enabled = enabled
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] accepted Object to be assigned
    def accepted=(accepted)
      # rubocop:disable Style/ConditionalAssignment
      if accepted && !ACCEPTED_ENUM.include?(accepted)
        OCI.logger.debug("Unknown value for 'accepted' [" + accepted + "]. Mapping to 'ACCEPTED_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @accepted = ACCEPTED_UNKNOWN_ENUM_VALUE
      else
        @accepted = accepted
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] fixed Object to be assigned
    def fixed=(fixed)
      # rubocop:disable Style/ConditionalAssignment
      if fixed && !FIXED_ENUM.include?(fixed)
        OCI.logger.debug("Unknown value for 'fixed' [" + fixed + "]. Mapping to 'FIXED_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @fixed = FIXED_UNKNOWN_ENUM_VALUE
      else
        @fixed = fixed
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] reproduced Object to be assigned
    def reproduced=(reproduced)
      # rubocop:disable Style/ConditionalAssignment
      if reproduced && !REPRODUCED_ENUM.include?(reproduced)
        OCI.logger.debug("Unknown value for 'reproduced' [" + reproduced + "]. Mapping to 'REPRODUCED_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @reproduced = REPRODUCED_UNKNOWN_ENUM_VALUE
      else
        @reproduced = reproduced
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] auto_purge Object to be assigned
    def auto_purge=(auto_purge)
      # rubocop:disable Style/ConditionalAssignment
      if auto_purge && !AUTO_PURGE_ENUM.include?(auto_purge)
        OCI.logger.debug("Unknown value for 'auto_purge' [" + auto_purge + "]. Mapping to 'AUTO_PURGE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @auto_purge = AUTO_PURGE_UNKNOWN_ENUM_VALUE
      else
        @auto_purge = auto_purge
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] adaptive Object to be assigned
    def adaptive=(adaptive)
      # rubocop:disable Style/ConditionalAssignment
      if adaptive && !ADAPTIVE_ENUM.include?(adaptive)
        OCI.logger.debug("Unknown value for 'adaptive' [" + adaptive + "]. Mapping to 'ADAPTIVE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @adaptive = ADAPTIVE_UNKNOWN_ENUM_VALUE
      else
        @adaptive = adaptive
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        plan_name == other.plan_name &&
        sql_handle == other.sql_handle &&
        sql_text == other.sql_text &&
        origin == other.origin &&
        time_created == other.time_created &&
        time_last_modified == other.time_last_modified &&
        time_last_executed == other.time_last_executed &&
        enabled == other.enabled &&
        accepted == other.accepted &&
        fixed == other.fixed &&
        reproduced == other.reproduced &&
        auto_purge == other.auto_purge &&
        adaptive == other.adaptive
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
      [plan_name, sql_handle, sql_text, origin, time_created, time_last_modified, time_last_executed, enabled, accepted, fixed, reproduced, auto_purge, adaptive].hash
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
