# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20181201
require 'date'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Description of report definition.
  class DataSafe::Models::ReportDefinition
    CATEGORY_ENUM = [
      CATEGORY_CUSTOM_REPORTS = 'CUSTOM_REPORTS'.freeze,
      CATEGORY_SUMMARY = 'SUMMARY'.freeze,
      CATEGORY_ACTIVITY_AUDITING = 'ACTIVITY_AUDITING'.freeze,
      CATEGORY_FIREWALL_VIOLATIONS = 'FIREWALL_VIOLATIONS'.freeze,
      CATEGORY_ALLOWED_SQL = 'ALLOWED_SQL'.freeze,
      CATEGORY_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    DATA_SOURCE_ENUM = [
      DATA_SOURCE_EVENTS = 'EVENTS'.freeze,
      DATA_SOURCE_ALERTS = 'ALERTS'.freeze,
      DATA_SOURCE_VIOLATIONS = 'VIOLATIONS'.freeze,
      DATA_SOURCE_ALLOWED_SQL = 'ALLOWED_SQL'.freeze,
      DATA_SOURCE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    LIFECYCLE_STATE_ENUM = [
      LIFECYCLE_STATE_CREATING = 'CREATING'.freeze,
      LIFECYCLE_STATE_UPDATING = 'UPDATING'.freeze,
      LIFECYCLE_STATE_ACTIVE = 'ACTIVE'.freeze,
      LIFECYCLE_STATE_DELETING = 'DELETING'.freeze,
      LIFECYCLE_STATE_DELETED = 'DELETED'.freeze,
      LIFECYCLE_STATE_FAILED = 'FAILED'.freeze,
      LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    SCHEDULED_REPORT_MIME_TYPE_ENUM = [
      SCHEDULED_REPORT_MIME_TYPE_PDF = 'PDF'.freeze,
      SCHEDULED_REPORT_MIME_TYPE_XLS = 'XLS'.freeze,
      SCHEDULED_REPORT_MIME_TYPE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Name of the report definition.
    # @return [String]
    attr_accessor :display_name

    # **[Required]** The OCID of the report definition.
    # @return [String]
    attr_accessor :id

    # The OCID of the parent report definition. In the case of seeded report definition, this is same as definition OCID.
    # @return [String]
    attr_accessor :parent_id

    # Specifies the name of the category that this report belongs to.
    # @return [String]
    attr_reader :category

    # A description of the report definition.
    # @return [String]
    attr_accessor :description

    # Specifies the name of a resource that provides data for the report. For example alerts, events.
    # @return [String]
    attr_reader :data_source

    # Signifies whether the definition is seeded or user defined. Values can either be 'true' or 'false'.
    # @return [BOOLEAN]
    attr_accessor :is_seeded

    # Specifies how the report definitions are ordered in the display.
    # @return [Integer]
    attr_accessor :display_order

    # Specifies the date and time the report definition was created.
    # @return [DateTime]
    attr_accessor :time_created

    # The date and time the report definition was updated.
    # @return [DateTime]
    attr_accessor :time_updated

    # Additional SCIM filters used to define the report.
    # @return [String]
    attr_accessor :scim_filter

    # An array of column objects in the order (left to right) displayed in the report. A column object stores all information about a column, including the name displayed on the UI, corresponding field name in the data source, data type of the column, and column visibility (if the column is visible to the user).
    # @return [Array<OCI::DataSafe::Models::Column>]
    attr_accessor :column_info

    # An array of columnFilter objects. A columnFilter object stores all information about a column filter including field name, an operator, one or more expressions, if the filter is enabled, or if the filter is hidden.
    # @return [Array<OCI::DataSafe::Models::ColumnFilter>]
    attr_accessor :column_filters

    # An array of column sorting objects. Each column sorting object stores the column name to be sorted and if the sorting is in ascending order; sorting is done by the first column in the array, then by the second column in the array, etc.
    # @return [Array<OCI::DataSafe::Models::ColumnSorting>]
    attr_accessor :column_sortings

    # An array of report summary objects in the order (left to right)  displayed in the report.  A  report summary object stores all information about summary of report to be displayed, including the name displayed on UI, the display order, corresponding group by and count of values, summary visibility (if the summary is visible to user).
    # @return [Array<OCI::DataSafe::Models::Summary>]
    attr_accessor :summary

    # **[Required]** The OCID of the compartment containing the report definition.
    # @return [String]
    attr_accessor :compartment_id

    # **[Required]** The current state of the report.
    # @return [String]
    attr_reader :lifecycle_state

    # The schedule to generate the report periodically in the specified format:
    # <version-string>;<version-specific-schedule>
    #
    # Allowed version strings - \"v1\"
    # v1's version specific schedule -<ss> <mm> <hh> <day-of-week> <day-of-month>
    # Each of the above fields potentially introduce constraints. A workrequest is created only
    # when clock time satisfies all the constraints. Constraints introduced:
    # 1. seconds = <ss> (So, the allowed range for <ss> is [0, 59])
    # 2. minutes = <mm> (So, the allowed range for <mm> is [0, 59])
    # 3. hours = <hh> (So, the allowed range for <hh> is [0, 23])
    # 4. <day-of-week> can be either '*' (without quotes or a number between 1(Monday) and 7(Sunday))
    # No constraint introduced when it is '*'. When not, day of week must equal the given value
    # 5. <day-of-month> can be either '*' (without quotes or a number between 1 and 28)
    # No constraint introduced when it is '*'. When not, day of month must equal the given value
    #
    # @return [String]
    attr_accessor :schedule

    # Specifies the format of the report ( either .xls or .pdf or .json)
    # @return [String]
    attr_reader :scheduled_report_mime_type

    # Specifies the limit on the number of rows in the report.
    # @return [Integer]
    attr_accessor :scheduled_report_row_limit

    # The name of the report to be scheduled.
    # @return [String]
    attr_accessor :scheduled_report_name

    # The OCID of the compartment in which the scheduled resource will be created.
    #
    # @return [String]
    attr_accessor :scheduled_report_compartment_id

    # The time span for the records in the report to be scheduled.
    # <period-value><period>
    # Allowed period strings - \"H\",\"D\",\"M\",\"Y\"
    # Each of the above fields potentially introduce constraints. A workRequest is created only
    # when period-value satisfies all the constraints. Constraints introduced:
    # 1. period = H (The allowed range for period-value is [1, 23])
    # 2. period = D (The allowed range for period-value is [1, 30])
    # 3. period = M (The allowed range for period-value is [1, 11])
    # 4. period = Y (The minimum period-value is 1)
    #
    # @return [String]
    attr_accessor :record_time_span

    # The list of the data protection regulations/standards used in the report that will help demonstrate compliance.
    # @return [Array<String>]
    attr_accessor :compliance_standards

    # Details about the current state of the report definition in Data Safe.
    # @return [String]
    attr_accessor :lifecycle_details

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

    # System tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags.
    # Example: `{\"orcl-cloud\": {\"free-tier-retained\": \"true\"}}`
    #
    # @return [Hash<String, Hash<String, Object>>]
    attr_accessor :system_tags

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'displayName',
        'id': :'id',
        'parent_id': :'parentId',
        'category': :'category',
        'description': :'description',
        'data_source': :'dataSource',
        'is_seeded': :'isSeeded',
        'display_order': :'displayOrder',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'scim_filter': :'scimFilter',
        'column_info': :'columnInfo',
        'column_filters': :'columnFilters',
        'column_sortings': :'columnSortings',
        'summary': :'summary',
        'compartment_id': :'compartmentId',
        'lifecycle_state': :'lifecycleState',
        'schedule': :'schedule',
        'scheduled_report_mime_type': :'scheduledReportMimeType',
        'scheduled_report_row_limit': :'scheduledReportRowLimit',
        'scheduled_report_name': :'scheduledReportName',
        'scheduled_report_compartment_id': :'scheduledReportCompartmentId',
        'record_time_span': :'recordTimeSpan',
        'compliance_standards': :'complianceStandards',
        'lifecycle_details': :'lifecycleDetails',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'display_name': :'String',
        'id': :'String',
        'parent_id': :'String',
        'category': :'String',
        'description': :'String',
        'data_source': :'String',
        'is_seeded': :'BOOLEAN',
        'display_order': :'Integer',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'scim_filter': :'String',
        'column_info': :'Array<OCI::DataSafe::Models::Column>',
        'column_filters': :'Array<OCI::DataSafe::Models::ColumnFilter>',
        'column_sortings': :'Array<OCI::DataSafe::Models::ColumnSorting>',
        'summary': :'Array<OCI::DataSafe::Models::Summary>',
        'compartment_id': :'String',
        'lifecycle_state': :'String',
        'schedule': :'String',
        'scheduled_report_mime_type': :'String',
        'scheduled_report_row_limit': :'Integer',
        'scheduled_report_name': :'String',
        'scheduled_report_compartment_id': :'String',
        'record_time_span': :'String',
        'compliance_standards': :'Array<String>',
        'lifecycle_details': :'String',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :display_name The value to assign to the {#display_name} property
    # @option attributes [String] :id The value to assign to the {#id} property
    # @option attributes [String] :parent_id The value to assign to the {#parent_id} property
    # @option attributes [String] :category The value to assign to the {#category} property
    # @option attributes [String] :description The value to assign to the {#description} property
    # @option attributes [String] :data_source The value to assign to the {#data_source} property
    # @option attributes [BOOLEAN] :is_seeded The value to assign to the {#is_seeded} property
    # @option attributes [Integer] :display_order The value to assign to the {#display_order} property
    # @option attributes [DateTime] :time_created The value to assign to the {#time_created} property
    # @option attributes [DateTime] :time_updated The value to assign to the {#time_updated} property
    # @option attributes [String] :scim_filter The value to assign to the {#scim_filter} property
    # @option attributes [Array<OCI::DataSafe::Models::Column>] :column_info The value to assign to the {#column_info} property
    # @option attributes [Array<OCI::DataSafe::Models::ColumnFilter>] :column_filters The value to assign to the {#column_filters} property
    # @option attributes [Array<OCI::DataSafe::Models::ColumnSorting>] :column_sortings The value to assign to the {#column_sortings} property
    # @option attributes [Array<OCI::DataSafe::Models::Summary>] :summary The value to assign to the {#summary} property
    # @option attributes [String] :compartment_id The value to assign to the {#compartment_id} property
    # @option attributes [String] :lifecycle_state The value to assign to the {#lifecycle_state} property
    # @option attributes [String] :schedule The value to assign to the {#schedule} property
    # @option attributes [String] :scheduled_report_mime_type The value to assign to the {#scheduled_report_mime_type} property
    # @option attributes [Integer] :scheduled_report_row_limit The value to assign to the {#scheduled_report_row_limit} property
    # @option attributes [String] :scheduled_report_name The value to assign to the {#scheduled_report_name} property
    # @option attributes [String] :scheduled_report_compartment_id The value to assign to the {#scheduled_report_compartment_id} property
    # @option attributes [String] :record_time_span The value to assign to the {#record_time_span} property
    # @option attributes [Array<String>] :compliance_standards The value to assign to the {#compliance_standards} property
    # @option attributes [String] :lifecycle_details The value to assign to the {#lifecycle_details} property
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {#freeform_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {#defined_tags} property
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {#system_tags} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.display_name = attributes[:'displayName'] if attributes[:'displayName']

      raise 'You cannot provide both :displayName and :display_name' if attributes.key?(:'displayName') && attributes.key?(:'display_name')

      self.display_name = attributes[:'display_name'] if attributes[:'display_name']

      self.id = attributes[:'id'] if attributes[:'id']

      self.parent_id = attributes[:'parentId'] if attributes[:'parentId']

      raise 'You cannot provide both :parentId and :parent_id' if attributes.key?(:'parentId') && attributes.key?(:'parent_id')

      self.parent_id = attributes[:'parent_id'] if attributes[:'parent_id']

      self.category = attributes[:'category'] if attributes[:'category']

      self.description = attributes[:'description'] if attributes[:'description']

      self.data_source = attributes[:'dataSource'] if attributes[:'dataSource']

      raise 'You cannot provide both :dataSource and :data_source' if attributes.key?(:'dataSource') && attributes.key?(:'data_source')

      self.data_source = attributes[:'data_source'] if attributes[:'data_source']

      self.is_seeded = attributes[:'isSeeded'] unless attributes[:'isSeeded'].nil?

      raise 'You cannot provide both :isSeeded and :is_seeded' if attributes.key?(:'isSeeded') && attributes.key?(:'is_seeded')

      self.is_seeded = attributes[:'is_seeded'] unless attributes[:'is_seeded'].nil?

      self.display_order = attributes[:'displayOrder'] if attributes[:'displayOrder']

      raise 'You cannot provide both :displayOrder and :display_order' if attributes.key?(:'displayOrder') && attributes.key?(:'display_order')

      self.display_order = attributes[:'display_order'] if attributes[:'display_order']

      self.time_created = attributes[:'timeCreated'] if attributes[:'timeCreated']

      raise 'You cannot provide both :timeCreated and :time_created' if attributes.key?(:'timeCreated') && attributes.key?(:'time_created')

      self.time_created = attributes[:'time_created'] if attributes[:'time_created']

      self.time_updated = attributes[:'timeUpdated'] if attributes[:'timeUpdated']

      raise 'You cannot provide both :timeUpdated and :time_updated' if attributes.key?(:'timeUpdated') && attributes.key?(:'time_updated')

      self.time_updated = attributes[:'time_updated'] if attributes[:'time_updated']

      self.scim_filter = attributes[:'scimFilter'] if attributes[:'scimFilter']

      raise 'You cannot provide both :scimFilter and :scim_filter' if attributes.key?(:'scimFilter') && attributes.key?(:'scim_filter')

      self.scim_filter = attributes[:'scim_filter'] if attributes[:'scim_filter']

      self.column_info = attributes[:'columnInfo'] if attributes[:'columnInfo']

      raise 'You cannot provide both :columnInfo and :column_info' if attributes.key?(:'columnInfo') && attributes.key?(:'column_info')

      self.column_info = attributes[:'column_info'] if attributes[:'column_info']

      self.column_filters = attributes[:'columnFilters'] if attributes[:'columnFilters']

      raise 'You cannot provide both :columnFilters and :column_filters' if attributes.key?(:'columnFilters') && attributes.key?(:'column_filters')

      self.column_filters = attributes[:'column_filters'] if attributes[:'column_filters']

      self.column_sortings = attributes[:'columnSortings'] if attributes[:'columnSortings']

      raise 'You cannot provide both :columnSortings and :column_sortings' if attributes.key?(:'columnSortings') && attributes.key?(:'column_sortings')

      self.column_sortings = attributes[:'column_sortings'] if attributes[:'column_sortings']

      self.summary = attributes[:'summary'] if attributes[:'summary']

      self.compartment_id = attributes[:'compartmentId'] if attributes[:'compartmentId']

      raise 'You cannot provide both :compartmentId and :compartment_id' if attributes.key?(:'compartmentId') && attributes.key?(:'compartment_id')

      self.compartment_id = attributes[:'compartment_id'] if attributes[:'compartment_id']

      self.lifecycle_state = attributes[:'lifecycleState'] if attributes[:'lifecycleState']

      raise 'You cannot provide both :lifecycleState and :lifecycle_state' if attributes.key?(:'lifecycleState') && attributes.key?(:'lifecycle_state')

      self.lifecycle_state = attributes[:'lifecycle_state'] if attributes[:'lifecycle_state']

      self.schedule = attributes[:'schedule'] if attributes[:'schedule']

      self.scheduled_report_mime_type = attributes[:'scheduledReportMimeType'] if attributes[:'scheduledReportMimeType']

      raise 'You cannot provide both :scheduledReportMimeType and :scheduled_report_mime_type' if attributes.key?(:'scheduledReportMimeType') && attributes.key?(:'scheduled_report_mime_type')

      self.scheduled_report_mime_type = attributes[:'scheduled_report_mime_type'] if attributes[:'scheduled_report_mime_type']

      self.scheduled_report_row_limit = attributes[:'scheduledReportRowLimit'] if attributes[:'scheduledReportRowLimit']

      raise 'You cannot provide both :scheduledReportRowLimit and :scheduled_report_row_limit' if attributes.key?(:'scheduledReportRowLimit') && attributes.key?(:'scheduled_report_row_limit')

      self.scheduled_report_row_limit = attributes[:'scheduled_report_row_limit'] if attributes[:'scheduled_report_row_limit']

      self.scheduled_report_name = attributes[:'scheduledReportName'] if attributes[:'scheduledReportName']

      raise 'You cannot provide both :scheduledReportName and :scheduled_report_name' if attributes.key?(:'scheduledReportName') && attributes.key?(:'scheduled_report_name')

      self.scheduled_report_name = attributes[:'scheduled_report_name'] if attributes[:'scheduled_report_name']

      self.scheduled_report_compartment_id = attributes[:'scheduledReportCompartmentId'] if attributes[:'scheduledReportCompartmentId']

      raise 'You cannot provide both :scheduledReportCompartmentId and :scheduled_report_compartment_id' if attributes.key?(:'scheduledReportCompartmentId') && attributes.key?(:'scheduled_report_compartment_id')

      self.scheduled_report_compartment_id = attributes[:'scheduled_report_compartment_id'] if attributes[:'scheduled_report_compartment_id']

      self.record_time_span = attributes[:'recordTimeSpan'] if attributes[:'recordTimeSpan']

      raise 'You cannot provide both :recordTimeSpan and :record_time_span' if attributes.key?(:'recordTimeSpan') && attributes.key?(:'record_time_span')

      self.record_time_span = attributes[:'record_time_span'] if attributes[:'record_time_span']

      self.compliance_standards = attributes[:'complianceStandards'] if attributes[:'complianceStandards']

      raise 'You cannot provide both :complianceStandards and :compliance_standards' if attributes.key?(:'complianceStandards') && attributes.key?(:'compliance_standards')

      self.compliance_standards = attributes[:'compliance_standards'] if attributes[:'compliance_standards']

      self.lifecycle_details = attributes[:'lifecycleDetails'] if attributes[:'lifecycleDetails']

      raise 'You cannot provide both :lifecycleDetails and :lifecycle_details' if attributes.key?(:'lifecycleDetails') && attributes.key?(:'lifecycle_details')

      self.lifecycle_details = attributes[:'lifecycle_details'] if attributes[:'lifecycle_details']

      self.freeform_tags = attributes[:'freeformTags'] if attributes[:'freeformTags']

      raise 'You cannot provide both :freeformTags and :freeform_tags' if attributes.key?(:'freeformTags') && attributes.key?(:'freeform_tags')

      self.freeform_tags = attributes[:'freeform_tags'] if attributes[:'freeform_tags']

      self.defined_tags = attributes[:'definedTags'] if attributes[:'definedTags']

      raise 'You cannot provide both :definedTags and :defined_tags' if attributes.key?(:'definedTags') && attributes.key?(:'defined_tags')

      self.defined_tags = attributes[:'defined_tags'] if attributes[:'defined_tags']

      self.system_tags = attributes[:'systemTags'] if attributes[:'systemTags']

      raise 'You cannot provide both :systemTags and :system_tags' if attributes.key?(:'systemTags') && attributes.key?(:'system_tags')

      self.system_tags = attributes[:'system_tags'] if attributes[:'system_tags']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] category Object to be assigned
    def category=(category)
      # rubocop:disable Style/ConditionalAssignment
      if category && !CATEGORY_ENUM.include?(category)
        OCI.logger.debug("Unknown value for 'category' [" + category + "]. Mapping to 'CATEGORY_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @category = CATEGORY_UNKNOWN_ENUM_VALUE
      else
        @category = category
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] data_source Object to be assigned
    def data_source=(data_source)
      # rubocop:disable Style/ConditionalAssignment
      if data_source && !DATA_SOURCE_ENUM.include?(data_source)
        OCI.logger.debug("Unknown value for 'data_source' [" + data_source + "]. Mapping to 'DATA_SOURCE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @data_source = DATA_SOURCE_UNKNOWN_ENUM_VALUE
      else
        @data_source = data_source
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] lifecycle_state Object to be assigned
    def lifecycle_state=(lifecycle_state)
      # rubocop:disable Style/ConditionalAssignment
      if lifecycle_state && !LIFECYCLE_STATE_ENUM.include?(lifecycle_state)
        OCI.logger.debug("Unknown value for 'lifecycle_state' [" + lifecycle_state + "]. Mapping to 'LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @lifecycle_state = LIFECYCLE_STATE_UNKNOWN_ENUM_VALUE
      else
        @lifecycle_state = lifecycle_state
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] scheduled_report_mime_type Object to be assigned
    def scheduled_report_mime_type=(scheduled_report_mime_type)
      # rubocop:disable Style/ConditionalAssignment
      if scheduled_report_mime_type && !SCHEDULED_REPORT_MIME_TYPE_ENUM.include?(scheduled_report_mime_type)
        OCI.logger.debug("Unknown value for 'scheduled_report_mime_type' [" + scheduled_report_mime_type + "]. Mapping to 'SCHEDULED_REPORT_MIME_TYPE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @scheduled_report_mime_type = SCHEDULED_REPORT_MIME_TYPE_UNKNOWN_ENUM_VALUE
      else
        @scheduled_report_mime_type = scheduled_report_mime_type
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        display_name == other.display_name &&
        id == other.id &&
        parent_id == other.parent_id &&
        category == other.category &&
        description == other.description &&
        data_source == other.data_source &&
        is_seeded == other.is_seeded &&
        display_order == other.display_order &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        scim_filter == other.scim_filter &&
        column_info == other.column_info &&
        column_filters == other.column_filters &&
        column_sortings == other.column_sortings &&
        summary == other.summary &&
        compartment_id == other.compartment_id &&
        lifecycle_state == other.lifecycle_state &&
        schedule == other.schedule &&
        scheduled_report_mime_type == other.scheduled_report_mime_type &&
        scheduled_report_row_limit == other.scheduled_report_row_limit &&
        scheduled_report_name == other.scheduled_report_name &&
        scheduled_report_compartment_id == other.scheduled_report_compartment_id &&
        record_time_span == other.record_time_span &&
        compliance_standards == other.compliance_standards &&
        lifecycle_details == other.lifecycle_details &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        system_tags == other.system_tags
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
      [display_name, id, parent_id, category, description, data_source, is_seeded, display_order, time_created, time_updated, scim_filter, column_info, column_filters, column_sortings, summary, compartment_id, lifecycle_state, schedule, scheduled_report_mime_type, scheduled_report_row_limit, scheduled_report_name, scheduled_report_compartment_id, record_time_span, compliance_standards, lifecycle_details, freeform_tags, defined_tags, system_tags].hash
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
