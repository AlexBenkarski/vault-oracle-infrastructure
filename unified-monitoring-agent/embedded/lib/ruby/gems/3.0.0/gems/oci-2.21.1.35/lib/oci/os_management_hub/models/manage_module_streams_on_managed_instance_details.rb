# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20220901
require 'date'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # The set of changes to make to the state of the modules, streams, and profiles on a managed instance
  class OsManagementHub::Models::ManageModuleStreamsOnManagedInstanceDetails
    # Indicates if this operation is a dry run or if the operation
    # should be committed.  If set to true, the result of the operation
    # will be evaluated but not committed.  If set to false, the
    # operation is committed to the managed instance.  The default is
    # false.
    #
    # @return [BOOLEAN]
    attr_accessor :is_dry_run

    # The set of module streams to enable. If any streams of a module are already enabled, the service switches from the current stream to the new stream.
    # Once complete, the streams will be in 'ENABLED' status.
    #
    # @return [Array<OCI::OsManagementHub::Models::ModuleStreamDetails>]
    attr_accessor :enable

    # The set of module streams to disable. Any profiles that are installed for the module stream will be removed as part of the operation.
    # Once complete, the streams will be in 'DISABLED' status.
    #
    # @return [Array<OCI::OsManagementHub::Models::ModuleStreamDetails>]
    attr_accessor :disable

    # The set of module stream profiles to install. Any packages that are part of the profile are installed on the managed instance.
    # Once complete, the profile will be in 'INSTALLED' status. The operation will return an error if you attempt to install a profile from a disabled stream, unless enabling the new module stream is included in this operation.
    #
    # @return [Array<OCI::OsManagementHub::Models::ModuleStreamProfileDetails>]
    attr_accessor :install

    # The set of module stream profiles to remove. Once complete, the profile will be in 'AVAILABLE' status.
    # The status of packages within the profile after the operation is complete is defined by the package manager on the managed instance group.
    #
    # @return [Array<OCI::OsManagementHub::Models::ModuleStreamProfileDetails>]
    attr_accessor :remove

    # @return [OCI::OsManagementHub::Models::WorkRequestDetails]
    attr_accessor :work_request_details

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'is_dry_run': :'isDryRun',
        'enable': :'enable',
        'disable': :'disable',
        'install': :'install',
        'remove': :'remove',
        'work_request_details': :'workRequestDetails'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'is_dry_run': :'BOOLEAN',
        'enable': :'Array<OCI::OsManagementHub::Models::ModuleStreamDetails>',
        'disable': :'Array<OCI::OsManagementHub::Models::ModuleStreamDetails>',
        'install': :'Array<OCI::OsManagementHub::Models::ModuleStreamProfileDetails>',
        'remove': :'Array<OCI::OsManagementHub::Models::ModuleStreamProfileDetails>',
        'work_request_details': :'OCI::OsManagementHub::Models::WorkRequestDetails'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [BOOLEAN] :is_dry_run The value to assign to the {#is_dry_run} property
    # @option attributes [Array<OCI::OsManagementHub::Models::ModuleStreamDetails>] :enable The value to assign to the {#enable} property
    # @option attributes [Array<OCI::OsManagementHub::Models::ModuleStreamDetails>] :disable The value to assign to the {#disable} property
    # @option attributes [Array<OCI::OsManagementHub::Models::ModuleStreamProfileDetails>] :install The value to assign to the {#install} property
    # @option attributes [Array<OCI::OsManagementHub::Models::ModuleStreamProfileDetails>] :remove The value to assign to the {#remove} property
    # @option attributes [OCI::OsManagementHub::Models::WorkRequestDetails] :work_request_details The value to assign to the {#work_request_details} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.is_dry_run = attributes[:'isDryRun'] unless attributes[:'isDryRun'].nil?
      self.is_dry_run = false if is_dry_run.nil? && !attributes.key?(:'isDryRun') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isDryRun and :is_dry_run' if attributes.key?(:'isDryRun') && attributes.key?(:'is_dry_run')

      self.is_dry_run = attributes[:'is_dry_run'] unless attributes[:'is_dry_run'].nil?
      self.is_dry_run = false if is_dry_run.nil? && !attributes.key?(:'isDryRun') && !attributes.key?(:'is_dry_run') # rubocop:disable Style/StringLiterals

      self.enable = attributes[:'enable'] if attributes[:'enable']

      self.disable = attributes[:'disable'] if attributes[:'disable']

      self.install = attributes[:'install'] if attributes[:'install']

      self.remove = attributes[:'remove'] if attributes[:'remove']

      self.work_request_details = attributes[:'workRequestDetails'] if attributes[:'workRequestDetails']

      raise 'You cannot provide both :workRequestDetails and :work_request_details' if attributes.key?(:'workRequestDetails') && attributes.key?(:'work_request_details')

      self.work_request_details = attributes[:'work_request_details'] if attributes[:'work_request_details']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        is_dry_run == other.is_dry_run &&
        enable == other.enable &&
        disable == other.disable &&
        install == other.install &&
        remove == other.remove &&
        work_request_details == other.work_request_details
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
      [is_dry_run, enable, disable, install, remove, work_request_details].hash
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
