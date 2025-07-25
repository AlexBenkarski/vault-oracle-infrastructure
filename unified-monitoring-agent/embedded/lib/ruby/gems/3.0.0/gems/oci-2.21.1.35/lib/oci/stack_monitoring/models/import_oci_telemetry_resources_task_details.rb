# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20210330
require 'date'
require 'logger'
require_relative 'monitored_resource_task_details'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Request details for importing resources from Telemetry like resources from OCI Native Services and prometheus.
  #
  class StackMonitoring::Models::ImportOciTelemetryResourcesTaskDetails < StackMonitoring::Models::MonitoredResourceTaskDetails
    SOURCE_ENUM = [
      SOURCE_OCI_TELEMETRY_NATIVE = 'OCI_TELEMETRY_NATIVE'.freeze,
      SOURCE_OCI_TELEMETRY_PROMETHEUS = 'OCI_TELEMETRY_PROMETHEUS'.freeze,
      SOURCE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Source from where the metrics pushed to telemetry.
    # Possible values:
    #   * OCI_TELEMETRY_NATIVE      - The metrics are pushed to telemetry from OCI Native Services.
    #   * OCI_TELEMETRY_PROMETHEUS  - The metrics are pushed to telemetry from Prometheus.
    #
    # @return [String]
    attr_reader :source

    # **[Required]** Name space to be used for OCI Native service resources discovery.
    # @return [String]
    attr_accessor :namespace

    # The resource group to use while fetching metrics from telemetry.
    # If not specified, resource group will be skipped in the list metrics request.
    #
    # @return [String]
    attr_accessor :resource_group

    # Flag to indicate whether status is calculated using metrics or
    # LifeCycleState attribute of the resource in OCI service.
    #
    # @return [BOOLEAN]
    attr_accessor :should_use_metrics_flow_for_status

    # The base URL of the OCI service to which the resource belongs to.
    # Also this property is applicable only when source is OCI_TELEMETRY_NATIVE.
    #
    # @return [String]
    attr_accessor :service_base_url

    # The console path prefix to use for providing service home url page navigation.
    # For example if the prefix provided is 'security/bastion/bastions', the URL used for navigation will be
    # https://<cloudhostname>/security/bastion/bastions/<resourceOcid>. If not provided, service home page link
    # will not be shown in the stack monitoring home page.
    #
    # @return [String]
    attr_accessor :console_path_prefix

    # Lifecycle states of the external resource which reflects the status of the resource being up.
    #
    # @return [Array<String>]
    attr_accessor :lifecycle_status_mappings_for_up_status

    # The resource name property in the metric dimensions.
    # Resources imported will be using this property value for resource name.
    #
    # @return [String]
    attr_accessor :resource_name_mapping

    # The external resource identifier property in the metric dimensions.
    # Resources imported will be using this property value for external id.
    #
    # @return [String]
    attr_accessor :external_id_mapping

    # The resource type property in the metric dimensions.
    # Resources imported will be using this property value for resource type.
    # If not specified, namespace will be used for resource type.
    #
    # @return [String]
    attr_accessor :resource_type_mapping

    # The resource name filter. Resources matching with the resource name filter will be imported.
    # Regular expressions will be accepted.
    #
    # @return [String]
    attr_accessor :resource_name_filter

    # The resource type filter. Resources matching with the resource type filter will be imported.
    # Regular expressions will be accepted.
    #
    # @return [String]
    attr_accessor :resource_type_filter

    # List of metrics to be used to calculate the availability of the resource.
    # Resource is considered to be up if at least one of the specified metrics is available for
    # the resource during the specified interval using the property
    # 'availabilityProxyMetricCollectionIntervalInSeconds'.
    # If no metrics are specified, availability will not be calculated for the resource.
    #
    # @return [Array<String>]
    attr_accessor :availability_proxy_metrics

    # Metrics collection interval in seconds used when calculating the availability of the
    # resource based on metrics specified using the property 'availabilityProxyMetrics'.
    #
    # @return [Integer]
    attr_accessor :availability_proxy_metric_collection_interval

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'type': :'type',
        'source': :'source',
        'namespace': :'namespace',
        'resource_group': :'resourceGroup',
        'should_use_metrics_flow_for_status': :'shouldUseMetricsFlowForStatus',
        'service_base_url': :'serviceBaseUrl',
        'console_path_prefix': :'consolePathPrefix',
        'lifecycle_status_mappings_for_up_status': :'lifecycleStatusMappingsForUpStatus',
        'resource_name_mapping': :'resourceNameMapping',
        'external_id_mapping': :'externalIdMapping',
        'resource_type_mapping': :'resourceTypeMapping',
        'resource_name_filter': :'resourceNameFilter',
        'resource_type_filter': :'resourceTypeFilter',
        'availability_proxy_metrics': :'availabilityProxyMetrics',
        'availability_proxy_metric_collection_interval': :'availabilityProxyMetricCollectionInterval'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'type': :'String',
        'source': :'String',
        'namespace': :'String',
        'resource_group': :'String',
        'should_use_metrics_flow_for_status': :'BOOLEAN',
        'service_base_url': :'String',
        'console_path_prefix': :'String',
        'lifecycle_status_mappings_for_up_status': :'Array<String>',
        'resource_name_mapping': :'String',
        'external_id_mapping': :'String',
        'resource_type_mapping': :'String',
        'resource_name_filter': :'String',
        'resource_type_filter': :'String',
        'availability_proxy_metrics': :'Array<String>',
        'availability_proxy_metric_collection_interval': :'Integer'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :source The value to assign to the {#source} property
    # @option attributes [String] :namespace The value to assign to the {#namespace} property
    # @option attributes [String] :resource_group The value to assign to the {#resource_group} property
    # @option attributes [BOOLEAN] :should_use_metrics_flow_for_status The value to assign to the {#should_use_metrics_flow_for_status} property
    # @option attributes [String] :service_base_url The value to assign to the {#service_base_url} property
    # @option attributes [String] :console_path_prefix The value to assign to the {#console_path_prefix} property
    # @option attributes [Array<String>] :lifecycle_status_mappings_for_up_status The value to assign to the {#lifecycle_status_mappings_for_up_status} property
    # @option attributes [String] :resource_name_mapping The value to assign to the {#resource_name_mapping} property
    # @option attributes [String] :external_id_mapping The value to assign to the {#external_id_mapping} property
    # @option attributes [String] :resource_type_mapping The value to assign to the {#resource_type_mapping} property
    # @option attributes [String] :resource_name_filter The value to assign to the {#resource_name_filter} property
    # @option attributes [String] :resource_type_filter The value to assign to the {#resource_type_filter} property
    # @option attributes [Array<String>] :availability_proxy_metrics The value to assign to the {#availability_proxy_metrics} property
    # @option attributes [Integer] :availability_proxy_metric_collection_interval The value to assign to the {#availability_proxy_metric_collection_interval} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['type'] = 'IMPORT_OCI_TELEMETRY_RESOURCES'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.source = attributes[:'source'] if attributes[:'source']

      self.namespace = attributes[:'namespace'] if attributes[:'namespace']

      self.resource_group = attributes[:'resourceGroup'] if attributes[:'resourceGroup']

      raise 'You cannot provide both :resourceGroup and :resource_group' if attributes.key?(:'resourceGroup') && attributes.key?(:'resource_group')

      self.resource_group = attributes[:'resource_group'] if attributes[:'resource_group']

      self.should_use_metrics_flow_for_status = attributes[:'shouldUseMetricsFlowForStatus'] unless attributes[:'shouldUseMetricsFlowForStatus'].nil?
      self.should_use_metrics_flow_for_status = false if should_use_metrics_flow_for_status.nil? && !attributes.key?(:'shouldUseMetricsFlowForStatus') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :shouldUseMetricsFlowForStatus and :should_use_metrics_flow_for_status' if attributes.key?(:'shouldUseMetricsFlowForStatus') && attributes.key?(:'should_use_metrics_flow_for_status')

      self.should_use_metrics_flow_for_status = attributes[:'should_use_metrics_flow_for_status'] unless attributes[:'should_use_metrics_flow_for_status'].nil?
      self.should_use_metrics_flow_for_status = false if should_use_metrics_flow_for_status.nil? && !attributes.key?(:'shouldUseMetricsFlowForStatus') && !attributes.key?(:'should_use_metrics_flow_for_status') # rubocop:disable Style/StringLiterals

      self.service_base_url = attributes[:'serviceBaseUrl'] if attributes[:'serviceBaseUrl']

      raise 'You cannot provide both :serviceBaseUrl and :service_base_url' if attributes.key?(:'serviceBaseUrl') && attributes.key?(:'service_base_url')

      self.service_base_url = attributes[:'service_base_url'] if attributes[:'service_base_url']

      self.console_path_prefix = attributes[:'consolePathPrefix'] if attributes[:'consolePathPrefix']

      raise 'You cannot provide both :consolePathPrefix and :console_path_prefix' if attributes.key?(:'consolePathPrefix') && attributes.key?(:'console_path_prefix')

      self.console_path_prefix = attributes[:'console_path_prefix'] if attributes[:'console_path_prefix']

      self.lifecycle_status_mappings_for_up_status = attributes[:'lifecycleStatusMappingsForUpStatus'] if attributes[:'lifecycleStatusMappingsForUpStatus']

      raise 'You cannot provide both :lifecycleStatusMappingsForUpStatus and :lifecycle_status_mappings_for_up_status' if attributes.key?(:'lifecycleStatusMappingsForUpStatus') && attributes.key?(:'lifecycle_status_mappings_for_up_status')

      self.lifecycle_status_mappings_for_up_status = attributes[:'lifecycle_status_mappings_for_up_status'] if attributes[:'lifecycle_status_mappings_for_up_status']

      self.resource_name_mapping = attributes[:'resourceNameMapping'] if attributes[:'resourceNameMapping']
      self.resource_name_mapping = "resourceName" if resource_name_mapping.nil? && !attributes.key?(:'resourceNameMapping') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :resourceNameMapping and :resource_name_mapping' if attributes.key?(:'resourceNameMapping') && attributes.key?(:'resource_name_mapping')

      self.resource_name_mapping = attributes[:'resource_name_mapping'] if attributes[:'resource_name_mapping']
      self.resource_name_mapping = "resourceName" if resource_name_mapping.nil? && !attributes.key?(:'resourceNameMapping') && !attributes.key?(:'resource_name_mapping') # rubocop:disable Style/StringLiterals

      self.external_id_mapping = attributes[:'externalIdMapping'] if attributes[:'externalIdMapping']
      self.external_id_mapping = "resourceId" if external_id_mapping.nil? && !attributes.key?(:'externalIdMapping') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :externalIdMapping and :external_id_mapping' if attributes.key?(:'externalIdMapping') && attributes.key?(:'external_id_mapping')

      self.external_id_mapping = attributes[:'external_id_mapping'] if attributes[:'external_id_mapping']
      self.external_id_mapping = "resourceId" if external_id_mapping.nil? && !attributes.key?(:'externalIdMapping') && !attributes.key?(:'external_id_mapping') # rubocop:disable Style/StringLiterals

      self.resource_type_mapping = attributes[:'resourceTypeMapping'] if attributes[:'resourceTypeMapping']

      raise 'You cannot provide both :resourceTypeMapping and :resource_type_mapping' if attributes.key?(:'resourceTypeMapping') && attributes.key?(:'resource_type_mapping')

      self.resource_type_mapping = attributes[:'resource_type_mapping'] if attributes[:'resource_type_mapping']

      self.resource_name_filter = attributes[:'resourceNameFilter'] if attributes[:'resourceNameFilter']

      raise 'You cannot provide both :resourceNameFilter and :resource_name_filter' if attributes.key?(:'resourceNameFilter') && attributes.key?(:'resource_name_filter')

      self.resource_name_filter = attributes[:'resource_name_filter'] if attributes[:'resource_name_filter']

      self.resource_type_filter = attributes[:'resourceTypeFilter'] if attributes[:'resourceTypeFilter']

      raise 'You cannot provide both :resourceTypeFilter and :resource_type_filter' if attributes.key?(:'resourceTypeFilter') && attributes.key?(:'resource_type_filter')

      self.resource_type_filter = attributes[:'resource_type_filter'] if attributes[:'resource_type_filter']

      self.availability_proxy_metrics = attributes[:'availabilityProxyMetrics'] if attributes[:'availabilityProxyMetrics']

      raise 'You cannot provide both :availabilityProxyMetrics and :availability_proxy_metrics' if attributes.key?(:'availabilityProxyMetrics') && attributes.key?(:'availability_proxy_metrics')

      self.availability_proxy_metrics = attributes[:'availability_proxy_metrics'] if attributes[:'availability_proxy_metrics']

      self.availability_proxy_metric_collection_interval = attributes[:'availabilityProxyMetricCollectionInterval'] if attributes[:'availabilityProxyMetricCollectionInterval']

      raise 'You cannot provide both :availabilityProxyMetricCollectionInterval and :availability_proxy_metric_collection_interval' if attributes.key?(:'availabilityProxyMetricCollectionInterval') && attributes.key?(:'availability_proxy_metric_collection_interval')

      self.availability_proxy_metric_collection_interval = attributes[:'availability_proxy_metric_collection_interval'] if attributes[:'availability_proxy_metric_collection_interval']
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] source Object to be assigned
    def source=(source)
      # rubocop:disable Style/ConditionalAssignment
      if source && !SOURCE_ENUM.include?(source)
        OCI.logger.debug("Unknown value for 'source' [" + source + "]. Mapping to 'SOURCE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @source = SOURCE_UNKNOWN_ENUM_VALUE
      else
        @source = source
      end
      # rubocop:enable Style/ConditionalAssignment
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity, Layout/EmptyLines


    # Checks equality by comparing each attribute.
    # @param [Object] other the other object to be compared
    def ==(other)
      return true if equal?(other)

      self.class == other.class &&
        type == other.type &&
        source == other.source &&
        namespace == other.namespace &&
        resource_group == other.resource_group &&
        should_use_metrics_flow_for_status == other.should_use_metrics_flow_for_status &&
        service_base_url == other.service_base_url &&
        console_path_prefix == other.console_path_prefix &&
        lifecycle_status_mappings_for_up_status == other.lifecycle_status_mappings_for_up_status &&
        resource_name_mapping == other.resource_name_mapping &&
        external_id_mapping == other.external_id_mapping &&
        resource_type_mapping == other.resource_type_mapping &&
        resource_name_filter == other.resource_name_filter &&
        resource_type_filter == other.resource_type_filter &&
        availability_proxy_metrics == other.availability_proxy_metrics &&
        availability_proxy_metric_collection_interval == other.availability_proxy_metric_collection_interval
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
      [type, source, namespace, resource_group, should_use_metrics_flow_for_status, service_base_url, console_path_prefix, lifecycle_status_mappings_for_up_status, resource_name_mapping, external_id_mapping, resource_type_mapping, resource_name_filter, resource_type_filter, availability_proxy_metrics, availability_proxy_metric_collection_interval].hash
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
