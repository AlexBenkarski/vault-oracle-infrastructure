# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20181201
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Details to update the SQL Firewall policy.
  class DataSafe::Models::UpdateSqlFirewallPolicyDetails
    STATUS_ENUM = [
      STATUS_ENABLED = 'ENABLED'.freeze,
      STATUS_DISABLED = 'DISABLED'.freeze
    ].freeze

    ENFORCEMENT_SCOPE_ENUM = [
      ENFORCEMENT_SCOPE_ENFORCE_CONTEXT = 'ENFORCE_CONTEXT'.freeze,
      ENFORCEMENT_SCOPE_ENFORCE_SQL = 'ENFORCE_SQL'.freeze,
      ENFORCEMENT_SCOPE_ENFORCE_ALL = 'ENFORCE_ALL'.freeze
    ].freeze

    VIOLATION_ACTION_ENUM = [
      VIOLATION_ACTION_BLOCK = 'BLOCK'.freeze,
      VIOLATION_ACTION_OBSERVE = 'OBSERVE'.freeze
    ].freeze

    VIOLATION_AUDIT_ENUM = [
      VIOLATION_AUDIT_ENABLED = 'ENABLED'.freeze,
      VIOLATION_AUDIT_DISABLED = 'DISABLED'.freeze
    ].freeze

    # The display name of the SQL Firewall policy. The name does not have to be unique, and it is changeable.
    # @return [String]
    attr_accessor :display_name

    # The description of the SQL Firewall policy.
    # @return [String]
    attr_accessor :description

    # Specifies whether the SQL Firewall policy is enabled or disabled.
    # @return [String]
    attr_reader :status

    # Specifies the SQL Firewall policy enforcement option.
    # @return [String]
    attr_reader :enforcement_scope

    # Specifies the SQL Firewall action based on detection of SQL Firewall violations.
    # @return [String]
    attr_reader :violation_action

    # Specifies whether a unified audit policy should be enabled for auditing the SQL Firewall policy violations.
    # @return [String]
    attr_reader :violation_audit

    # List of allowed ip addresses for the SQL Firewall policy.
    # @return [Array<String>]
    attr_accessor :allowed_client_ips

    # List of allowed operating system user names for the SQL Firewall policy.
    # @return [Array<String>]
    attr_accessor :allowed_client_os_usernames

    # List of allowed client programs for the SQL Firewall policy.
    # @return [Array<String>]
    attr_accessor :allowed_client_programs

    # Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm)
    #
    # Example: `{\"Department\": \"Finance\"}`
    #
    # @return [Hash<String, String>]
    attr_accessor :freeform_tags

    # Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm)
    #
    # Example: `{\"Operations\": {\"CostCenter\": \"42\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :defined_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'displayName',
        'description': :'description',
        'status': :'status',
        'enforcement_scope': :'enforcementScope',
        'violation_action': :'violationAction',
        'violation_audit': :'violationAudit',
        'allowed_client_ips': :'allowedClientIps',
        'allowed_client_os_usernames': :'allowedClientOsUsernames',
        'allowed_client_programs': :'allowedClientPrograms',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'String',
        'description': :'String',
        'status': :'String',
        'enforcement_scope': :'String',
        'violation_action': :'String',
        'violation_audit': :'String',
        'allowed_client_ips': :'Array<String>',
        'allowed_client_os_usernames': :'Array<String>',
        'allowed_client_programs': :'Array<String>',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :status The value to assign to the {#status} property
    # @option attributes [String] :enforcement_scope The value to assign to the {#enforcement_scope} property
    # @option attributes [String] :violation_action The value to assign to the {#violation_action} property
    # @option attributes [String] :violation_audit The value to assign to the {#violation_audit} property
    # @option attributes [Array<String>] :allowed_client_ips The value to assign to the {#allowed_client_ips} property
    # @option attributes [Array<String>] :allowed_client_os_usernames The value to assign to the {#allowed_client_os_usernames} property
    # @option attributes [Array<String>] :allowed_client_programs The value to assign to the {#allowed_client_programs} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.description = attributes[:'description'] if attributes[:'description']

      self.status = attributes[:'status'] if attributes[:'status']

      self.enforcement_scope = attributes[:'enforcementScope'] if attributes[:'enforcementScope']

      raise 'You cannot provide both :enforcementScope and :enforcement_scope' if attributes.key?(:'enforcementScope') && attributes.key?(:'enforcement_scope')

      self.enforcement_scope = attributes[:'enforcement_scope'] if attributes[:'enforcement_scope']

      self.violation_action = attributes[:'violationAction'] if attributes[:'violationAction']

      raise 'You cannot provide both :violationAction and :violation_action' if attributes.key?(:'violationAction') && attributes.key?(:'violation_action')

      self.violation_action = attributes[:'violation_action'] if attributes[:'violation_action']

      self.violation_audit = attributes[:'violationAudit'] if attributes[:'violationAudit']

      raise 'You cannot provide both :violationAudit and :violation_audit' if attributes.key?(:'violationAudit') && attributes.key?(:'violation_audit')

      self.violation_audit = attributes[:'violation_audit'] if attributes[:'violation_audit']

      self.allowed_client_ips = attributes[:'allowedClientIps'] if attributes[:'allowedClientIps']

      raise 'You cannot provide both :allowedClientIps and :allowed_client_ips' if attributes.key?(:'allowedClientIps') && attributes.key?(:'allowed_client_ips')

      self.allowed_client_ips = attributes[:'allowed_client_ips'] if attributes[:'allowed_client_ips']

      self.allowed_client_os_usernames = attributes[:'allowedClientOsUsernames'] if attributes[:'allowedClientOsUsernames']

      raise 'You cannot provide both :allowedClientOsUsernames and :allowed_client_os_usernames' if attributes.key?(:'allowedClientOsUsernames') && attributes.key?(:'allowed_client_os_usernames')

      self.allowed_client_os_usernames = attributes[:'allowed_client_os_usernames'] if attributes[:'allowed_client_os_usernames']

      self.allowed_client_programs = attributes[:'allowedClientPrograms'] if attributes[:'allowedClientPrograms']

      raise 'You cannot provide both :allowedClientPrograms and :allowed_client_programs' if attributes.key?(:'allowedClientPrograms') && attributes.key?(:'allowed_client_programs')

      self.allowed_client_programs = attributes[:'allowed_client_programs'] if attributes[:'allowed_client_programs']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] status Object to be assigned
    def status=(status)
      raise "Invalid value for 'status': this must be one of the values in STATUS_ENUM." if status && !STATUS_ENUM.include?(status)

      @status = status
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] enforcement_scope Object to be assigned
    def enforcement_scope=(enforcement_scope)
      raise "Invalid value for 'enforcement_scope': this must be one of the values in ENFORCEMENT_SCOPE_ENUM." if enforcement_scope && !ENFORCEMENT_SCOPE_ENUM.include?(enforcement_scope)

      @enforcement_scope = enforcement_scope
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] violation_action Object to be assigned
    def violation_action=(violation_action)
      raise "Invalid value for 'violation_action': this must be one of the values in VIOLATION_ACTION_ENUM." if violation_action && !VIOLATION_ACTION_ENUM.include?(violation_action)

      @violation_action = violation_action
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] violation_audit Object to be assigned
    def violation_audit=(violation_audit)
      raise "Invalid value for 'violation_audit': this must be one of the values in VIOLATION_AUDIT_ENUM." if violation_audit && !VIOLATION_AUDIT_ENUM.include?(violation_audit)

      @violation_audit = violation_audit
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        display_name == other.display_name &&
        description == other.description &&
        status == other.status &&
        enforcement_scope == other.enforcement_scope &&
        violation_action == other.violation_action &&
        violation_audit == other.violation_audit &&
        allowed_client_ips == other.allowed_client_ips &&
        allowed_client_os_usernames == other.allowed_client_os_usernames &&
        allowed_client_programs == other.allowed_client_programs &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags
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
      [display_name, description, status, enforcement_scope, violation_action, violation_audit, allowed_client_ips, allowed_client_os_usernames, allowed_client_programs, freeform_tags, defined_tags].hash
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
