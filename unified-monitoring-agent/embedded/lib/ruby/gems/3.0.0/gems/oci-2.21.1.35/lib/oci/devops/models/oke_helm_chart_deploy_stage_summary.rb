# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20210630
require 'date'
require 'logger'
require_relative 'deploy_stage_summary'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Specifies the OKE cluster deployment stage using Helm charts.
  class Devops::Models::OkeHelmChartDeployStageSummary < Devops::Models::DeployStageSummary
    PURPOSE_ENUM = [
      PURPOSE_EXECUTE_HELM_UPGRADE = 'EXECUTE_HELM_UPGRADE'.freeze,
      PURPOSE_EXECUTE_HELM_COMMAND = 'EXECUTE_HELM_COMMAND'.freeze,
      PURPOSE_UNKNOWN_ENUM_VALUE = 'UNKNOWN_ENUM_VALUE'.freeze
    ].freeze

    # **[Required]** Kubernetes cluster environment OCID for deployment.
    # @return [String]
    attr_accessor :oke_cluster_deploy_environment_id

    # **[Required]** Helm chart artifact OCID.
    # @return [String]
    attr_accessor :helm_chart_deploy_artifact_id

    # List of values.yaml file artifact OCIDs.
    # @return [Array<String>]
    attr_accessor :values_artifact_ids

    # **[Required]** Release name of the Helm chart.
    # @return [String]
    attr_accessor :release_name

    # Uninstall the Helm chart release on deleting the stage.
    # @return [BOOLEAN]
    attr_accessor :is_uninstall_on_stage_delete

    # List of Helm command artifact OCIDs.
    # @return [Array<String>]
    attr_accessor :helm_command_artifact_ids

    # The purpose of running this Helm stage
    # @return [String]
    attr_reader :purpose

    # Default namespace to be used for Kubernetes deployment when not specified in the manifest.
    # @return [String]
    attr_accessor :namespace

    # Time to wait for execution of a helm stage. Defaults to 300 seconds.
    # @return [Integer]
    attr_accessor :timeout_in_seconds

    # @return [OCI::Devops::Models::DeployStageRollbackPolicy]
    attr_accessor :rollback_policy

    # @return [OCI::Devops::Models::HelmSetValueCollection]
    attr_accessor :set_values

    # @return [OCI::Devops::Models::HelmSetValueCollection]
    attr_accessor :set_string

    # Disable pre/post upgrade hooks.
    # @return [BOOLEAN]
    attr_accessor :are_hooks_enabled

    # During upgrade, reuse the values of the last release and merge overrides from the command line. Set to false by default.
    # @return [BOOLEAN]
    attr_accessor :should_reuse_values

    # During upgrade, reset the values to the ones built into the chart. It overrides shouldReuseValues. Set to false by default.
    # @return [BOOLEAN]
    attr_accessor :should_reset_values

    # Force resource update through delete; or if required, recreate. Set to false by default.
    # @return [BOOLEAN]
    attr_accessor :is_force_enabled

    # Allow deletion of new resources created during when an upgrade fails. Set to false by default.
    # @return [BOOLEAN]
    attr_accessor :should_cleanup_on_fail

    # Limit the maximum number of revisions saved per release. Use 0 for no limit. Set to 10 by default
    # @return [Integer]
    attr_accessor :max_history

    # If set, no CRDs are installed. By default, CRDs are installed only if they are not present already.  Set to false by default.
    # @return [BOOLEAN]
    attr_accessor :should_skip_crds

    # If set, renders subchart notes along with the parent. Set to false by default.
    # @return [BOOLEAN]
    attr_accessor :should_skip_render_subchart_notes

    # Waits until all the resources are in a ready state to mark the release as successful. Set to false by default.
    # @return [BOOLEAN]
    attr_accessor :should_not_wait

    # Enables helm --debug option to stream output. Set to false by default.
    # @return [BOOLEAN]
    attr_accessor :is_debug_enabled

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'id',
        'description': :'description',
        'display_name': :'displayName',
        'project_id': :'projectId',
        'deploy_pipeline_id': :'deployPipelineId',
        'compartment_id': :'compartmentId',
        'deploy_stage_type': :'deployStageType',
        'time_created': :'timeCreated',
        'time_updated': :'timeUpdated',
        'lifecycle_state': :'lifecycleState',
        'lifecycle_details': :'lifecycleDetails',
        'deploy_stage_predecessor_collection': :'deployStagePredecessorCollection',
        'freeform_tags': :'freeformTags',
        'defined_tags': :'definedTags',
        'system_tags': :'systemTags',
        'oke_cluster_deploy_environment_id': :'okeClusterDeployEnvironmentId',
        'helm_chart_deploy_artifact_id': :'helmChartDeployArtifactId',
        'values_artifact_ids': :'valuesArtifactIds',
        'release_name': :'releaseName',
        'is_uninstall_on_stage_delete': :'isUninstallOnStageDelete',
        'helm_command_artifact_ids': :'helmCommandArtifactIds',
        'purpose': :'purpose',
        'namespace': :'namespace',
        'timeout_in_seconds': :'timeoutInSeconds',
        'rollback_policy': :'rollbackPolicy',
        'set_values': :'setValues',
        'set_string': :'setString',
        'are_hooks_enabled': :'areHooksEnabled',
        'should_reuse_values': :'shouldReuseValues',
        'should_reset_values': :'shouldResetValues',
        'is_force_enabled': :'isForceEnabled',
        'should_cleanup_on_fail': :'shouldCleanupOnFail',
        'max_history': :'maxHistory',
        'should_skip_crds': :'shouldSkipCrds',
        'should_skip_render_subchart_notes': :'shouldSkipRenderSubchartNotes',
        'should_not_wait': :'shouldNotWait',
        'is_debug_enabled': :'isDebugEnabled'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        # rubocop:disable Style/SymbolLiteral
        'id': :'String',
        'description': :'String',
        'display_name': :'String',
        'project_id': :'String',
        'deploy_pipeline_id': :'String',
        'compartment_id': :'String',
        'deploy_stage_type': :'String',
        'time_created': :'DateTime',
        'time_updated': :'DateTime',
        'lifecycle_state': :'String',
        'lifecycle_details': :'String',
        'deploy_stage_predecessor_collection': :'OCI::Devops::Models::DeployStagePredecessorCollection',
        'freeform_tags': :'Hash<String, String>',
        'defined_tags': :'Hash<String, Hash<String, Object>>',
        'system_tags': :'Hash<String, Hash<String, Object>>',
        'oke_cluster_deploy_environment_id': :'String',
        'helm_chart_deploy_artifact_id': :'String',
        'values_artifact_ids': :'Array<String>',
        'release_name': :'String',
        'is_uninstall_on_stage_delete': :'BOOLEAN',
        'helm_command_artifact_ids': :'Array<String>',
        'purpose': :'String',
        'namespace': :'String',
        'timeout_in_seconds': :'Integer',
        'rollback_policy': :'OCI::Devops::Models::DeployStageRollbackPolicy',
        'set_values': :'OCI::Devops::Models::HelmSetValueCollection',
        'set_string': :'OCI::Devops::Models::HelmSetValueCollection',
        'are_hooks_enabled': :'BOOLEAN',
        'should_reuse_values': :'BOOLEAN',
        'should_reset_values': :'BOOLEAN',
        'is_force_enabled': :'BOOLEAN',
        'should_cleanup_on_fail': :'BOOLEAN',
        'max_history': :'Integer',
        'should_skip_crds': :'BOOLEAN',
        'should_skip_render_subchart_notes': :'BOOLEAN',
        'should_not_wait': :'BOOLEAN',
        'is_debug_enabled': :'BOOLEAN'
        # rubocop:enable Style/SymbolLiteral
      }
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral


    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    # @option attributes [String] :id The value to assign to the {OCI::Devops::Models::DeployStageSummary#id #id} proprety
    # @option attributes [String] :description The value to assign to the {OCI::Devops::Models::DeployStageSummary#description #description} proprety
    # @option attributes [String] :display_name The value to assign to the {OCI::Devops::Models::DeployStageSummary#display_name #display_name} proprety
    # @option attributes [String] :project_id The value to assign to the {OCI::Devops::Models::DeployStageSummary#project_id #project_id} proprety
    # @option attributes [String] :deploy_pipeline_id The value to assign to the {OCI::Devops::Models::DeployStageSummary#deploy_pipeline_id #deploy_pipeline_id} proprety
    # @option attributes [String] :compartment_id The value to assign to the {OCI::Devops::Models::DeployStageSummary#compartment_id #compartment_id} proprety
    # @option attributes [DateTime] :time_created The value to assign to the {OCI::Devops::Models::DeployStageSummary#time_created #time_created} proprety
    # @option attributes [DateTime] :time_updated The value to assign to the {OCI::Devops::Models::DeployStageSummary#time_updated #time_updated} proprety
    # @option attributes [String] :lifecycle_state The value to assign to the {OCI::Devops::Models::DeployStageSummary#lifecycle_state #lifecycle_state} proprety
    # @option attributes [String] :lifecycle_details The value to assign to the {OCI::Devops::Models::DeployStageSummary#lifecycle_details #lifecycle_details} proprety
    # @option attributes [OCI::Devops::Models::DeployStagePredecessorCollection] :deploy_stage_predecessor_collection The value to assign to the {OCI::Devops::Models::DeployStageSummary#deploy_stage_predecessor_collection #deploy_stage_predecessor_collection} proprety
    # @option attributes [Hash<String, String>] :freeform_tags The value to assign to the {OCI::Devops::Models::DeployStageSummary#freeform_tags #freeform_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :defined_tags The value to assign to the {OCI::Devops::Models::DeployStageSummary#defined_tags #defined_tags} proprety
    # @option attributes [Hash<String, Hash<String, Object>>] :system_tags The value to assign to the {OCI::Devops::Models::DeployStageSummary#system_tags #system_tags} proprety
    # @option attributes [String] :oke_cluster_deploy_environment_id The value to assign to the {#oke_cluster_deploy_environment_id} property
    # @option attributes [String] :helm_chart_deploy_artifact_id The value to assign to the {#helm_chart_deploy_artifact_id} property
    # @option attributes [Array<String>] :values_artifact_ids The value to assign to the {#values_artifact_ids} property
    # @option attributes [String] :release_name The value to assign to the {#release_name} property
    # @option attributes [BOOLEAN] :is_uninstall_on_stage_delete The value to assign to the {#is_uninstall_on_stage_delete} property
    # @option attributes [Array<String>] :helm_command_artifact_ids The value to assign to the {#helm_command_artifact_ids} property
    # @option attributes [String] :purpose The value to assign to the {#purpose} property
    # @option attributes [String] :namespace The value to assign to the {#namespace} property
    # @option attributes [Integer] :timeout_in_seconds The value to assign to the {#timeout_in_seconds} property
    # @option attributes [OCI::Devops::Models::DeployStageRollbackPolicy] :rollback_policy The value to assign to the {#rollback_policy} property
    # @option attributes [OCI::Devops::Models::HelmSetValueCollection] :set_values The value to assign to the {#set_values} property
    # @option attributes [OCI::Devops::Models::HelmSetValueCollection] :set_string The value to assign to the {#set_string} property
    # @option attributes [BOOLEAN] :are_hooks_enabled The value to assign to the {#are_hooks_enabled} property
    # @option attributes [BOOLEAN] :should_reuse_values The value to assign to the {#should_reuse_values} property
    # @option attributes [BOOLEAN] :should_reset_values The value to assign to the {#should_reset_values} property
    # @option attributes [BOOLEAN] :is_force_enabled The value to assign to the {#is_force_enabled} property
    # @option attributes [BOOLEAN] :should_cleanup_on_fail The value to assign to the {#should_cleanup_on_fail} property
    # @option attributes [Integer] :max_history The value to assign to the {#max_history} property
    # @option attributes [BOOLEAN] :should_skip_crds The value to assign to the {#should_skip_crds} property
    # @option attributes [BOOLEAN] :should_skip_render_subchart_notes The value to assign to the {#should_skip_render_subchart_notes} property
    # @option attributes [BOOLEAN] :should_not_wait The value to assign to the {#should_not_wait} property
    # @option attributes [BOOLEAN] :is_debug_enabled The value to assign to the {#is_debug_enabled} property
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      attributes['deployStageType'] = 'OKE_HELM_CHART_DEPLOYMENT'

      super(attributes)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      self.oke_cluster_deploy_environment_id = attributes[:'okeClusterDeployEnvironmentId'] if attributes[:'okeClusterDeployEnvironmentId']

      raise 'You cannot provide both :okeClusterDeployEnvironmentId and :oke_cluster_deploy_environment_id' if attributes.key?(:'okeClusterDeployEnvironmentId') && attributes.key?(:'oke_cluster_deploy_environment_id')

      self.oke_cluster_deploy_environment_id = attributes[:'oke_cluster_deploy_environment_id'] if attributes[:'oke_cluster_deploy_environment_id']

      self.helm_chart_deploy_artifact_id = attributes[:'helmChartDeployArtifactId'] if attributes[:'helmChartDeployArtifactId']

      raise 'You cannot provide both :helmChartDeployArtifactId and :helm_chart_deploy_artifact_id' if attributes.key?(:'helmChartDeployArtifactId') && attributes.key?(:'helm_chart_deploy_artifact_id')

      self.helm_chart_deploy_artifact_id = attributes[:'helm_chart_deploy_artifact_id'] if attributes[:'helm_chart_deploy_artifact_id']

      self.values_artifact_ids = attributes[:'valuesArtifactIds'] if attributes[:'valuesArtifactIds']

      raise 'You cannot provide both :valuesArtifactIds and :values_artifact_ids' if attributes.key?(:'valuesArtifactIds') && attributes.key?(:'values_artifact_ids')

      self.values_artifact_ids = attributes[:'values_artifact_ids'] if attributes[:'values_artifact_ids']

      self.release_name = attributes[:'releaseName'] if attributes[:'releaseName']

      raise 'You cannot provide both :releaseName and :release_name' if attributes.key?(:'releaseName') && attributes.key?(:'release_name')

      self.release_name = attributes[:'release_name'] if attributes[:'release_name']

      self.is_uninstall_on_stage_delete = attributes[:'isUninstallOnStageDelete'] unless attributes[:'isUninstallOnStageDelete'].nil?
      self.is_uninstall_on_stage_delete = false if is_uninstall_on_stage_delete.nil? && !attributes.key?(:'isUninstallOnStageDelete') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isUninstallOnStageDelete and :is_uninstall_on_stage_delete' if attributes.key?(:'isUninstallOnStageDelete') && attributes.key?(:'is_uninstall_on_stage_delete')

      self.is_uninstall_on_stage_delete = attributes[:'is_uninstall_on_stage_delete'] unless attributes[:'is_uninstall_on_stage_delete'].nil?
      self.is_uninstall_on_stage_delete = false if is_uninstall_on_stage_delete.nil? && !attributes.key?(:'isUninstallOnStageDelete') && !attributes.key?(:'is_uninstall_on_stage_delete') # rubocop:disable Style/StringLiterals

      self.helm_command_artifact_ids = attributes[:'helmCommandArtifactIds'] if attributes[:'helmCommandArtifactIds']

      raise 'You cannot provide both :helmCommandArtifactIds and :helm_command_artifact_ids' if attributes.key?(:'helmCommandArtifactIds') && attributes.key?(:'helm_command_artifact_ids')

      self.helm_command_artifact_ids = attributes[:'helm_command_artifact_ids'] if attributes[:'helm_command_artifact_ids']

      self.purpose = attributes[:'purpose'] if attributes[:'purpose']
      self.purpose = "EXECUTE_HELM_UPGRADE" if purpose.nil? && !attributes.key?(:'purpose') # rubocop:disable Style/StringLiterals

      self.namespace = attributes[:'namespace'] if attributes[:'namespace']
      self.namespace = "default" if namespace.nil? && !attributes.key?(:'namespace') # rubocop:disable Style/StringLiterals

      self.timeout_in_seconds = attributes[:'timeoutInSeconds'] if attributes[:'timeoutInSeconds']

      raise 'You cannot provide both :timeoutInSeconds and :timeout_in_seconds' if attributes.key?(:'timeoutInSeconds') && attributes.key?(:'timeout_in_seconds')

      self.timeout_in_seconds = attributes[:'timeout_in_seconds'] if attributes[:'timeout_in_seconds']

      self.rollback_policy = attributes[:'rollbackPolicy'] if attributes[:'rollbackPolicy']

      raise 'You cannot provide both :rollbackPolicy and :rollback_policy' if attributes.key?(:'rollbackPolicy') && attributes.key?(:'rollback_policy')

      self.rollback_policy = attributes[:'rollback_policy'] if attributes[:'rollback_policy']

      self.set_values = attributes[:'setValues'] if attributes[:'setValues']

      raise 'You cannot provide both :setValues and :set_values' if attributes.key?(:'setValues') && attributes.key?(:'set_values')

      self.set_values = attributes[:'set_values'] if attributes[:'set_values']

      self.set_string = attributes[:'setString'] if attributes[:'setString']

      raise 'You cannot provide both :setString and :set_string' if attributes.key?(:'setString') && attributes.key?(:'set_string')

      self.set_string = attributes[:'set_string'] if attributes[:'set_string']

      self.are_hooks_enabled = attributes[:'areHooksEnabled'] unless attributes[:'areHooksEnabled'].nil?
      self.are_hooks_enabled = false if are_hooks_enabled.nil? && !attributes.key?(:'areHooksEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :areHooksEnabled and :are_hooks_enabled' if attributes.key?(:'areHooksEnabled') && attributes.key?(:'are_hooks_enabled')

      self.are_hooks_enabled = attributes[:'are_hooks_enabled'] unless attributes[:'are_hooks_enabled'].nil?
      self.are_hooks_enabled = false if are_hooks_enabled.nil? && !attributes.key?(:'areHooksEnabled') && !attributes.key?(:'are_hooks_enabled') # rubocop:disable Style/StringLiterals

      self.should_reuse_values = attributes[:'shouldReuseValues'] unless attributes[:'shouldReuseValues'].nil?
      self.should_reuse_values = false if should_reuse_values.nil? && !attributes.key?(:'shouldReuseValues') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :shouldReuseValues and :should_reuse_values' if attributes.key?(:'shouldReuseValues') && attributes.key?(:'should_reuse_values')

      self.should_reuse_values = attributes[:'should_reuse_values'] unless attributes[:'should_reuse_values'].nil?
      self.should_reuse_values = false if should_reuse_values.nil? && !attributes.key?(:'shouldReuseValues') && !attributes.key?(:'should_reuse_values') # rubocop:disable Style/StringLiterals

      self.should_reset_values = attributes[:'shouldResetValues'] unless attributes[:'shouldResetValues'].nil?
      self.should_reset_values = false if should_reset_values.nil? && !attributes.key?(:'shouldResetValues') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :shouldResetValues and :should_reset_values' if attributes.key?(:'shouldResetValues') && attributes.key?(:'should_reset_values')

      self.should_reset_values = attributes[:'should_reset_values'] unless attributes[:'should_reset_values'].nil?
      self.should_reset_values = false if should_reset_values.nil? && !attributes.key?(:'shouldResetValues') && !attributes.key?(:'should_reset_values') # rubocop:disable Style/StringLiterals

      self.is_force_enabled = attributes[:'isForceEnabled'] unless attributes[:'isForceEnabled'].nil?
      self.is_force_enabled = false if is_force_enabled.nil? && !attributes.key?(:'isForceEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isForceEnabled and :is_force_enabled' if attributes.key?(:'isForceEnabled') && attributes.key?(:'is_force_enabled')

      self.is_force_enabled = attributes[:'is_force_enabled'] unless attributes[:'is_force_enabled'].nil?
      self.is_force_enabled = false if is_force_enabled.nil? && !attributes.key?(:'isForceEnabled') && !attributes.key?(:'is_force_enabled') # rubocop:disable Style/StringLiterals

      self.should_cleanup_on_fail = attributes[:'shouldCleanupOnFail'] unless attributes[:'shouldCleanupOnFail'].nil?
      self.should_cleanup_on_fail = false if should_cleanup_on_fail.nil? && !attributes.key?(:'shouldCleanupOnFail') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :shouldCleanupOnFail and :should_cleanup_on_fail' if attributes.key?(:'shouldCleanupOnFail') && attributes.key?(:'should_cleanup_on_fail')

      self.should_cleanup_on_fail = attributes[:'should_cleanup_on_fail'] unless attributes[:'should_cleanup_on_fail'].nil?
      self.should_cleanup_on_fail = false if should_cleanup_on_fail.nil? && !attributes.key?(:'shouldCleanupOnFail') && !attributes.key?(:'should_cleanup_on_fail') # rubocop:disable Style/StringLiterals

      self.max_history = attributes[:'maxHistory'] if attributes[:'maxHistory']

      raise 'You cannot provide both :maxHistory and :max_history' if attributes.key?(:'maxHistory') && attributes.key?(:'max_history')

      self.max_history = attributes[:'max_history'] if attributes[:'max_history']

      self.should_skip_crds = attributes[:'shouldSkipCrds'] unless attributes[:'shouldSkipCrds'].nil?
      self.should_skip_crds = false if should_skip_crds.nil? && !attributes.key?(:'shouldSkipCrds') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :shouldSkipCrds and :should_skip_crds' if attributes.key?(:'shouldSkipCrds') && attributes.key?(:'should_skip_crds')

      self.should_skip_crds = attributes[:'should_skip_crds'] unless attributes[:'should_skip_crds'].nil?
      self.should_skip_crds = false if should_skip_crds.nil? && !attributes.key?(:'shouldSkipCrds') && !attributes.key?(:'should_skip_crds') # rubocop:disable Style/StringLiterals

      self.should_skip_render_subchart_notes = attributes[:'shouldSkipRenderSubchartNotes'] unless attributes[:'shouldSkipRenderSubchartNotes'].nil?
      self.should_skip_render_subchart_notes = false if should_skip_render_subchart_notes.nil? && !attributes.key?(:'shouldSkipRenderSubchartNotes') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :shouldSkipRenderSubchartNotes and :should_skip_render_subchart_notes' if attributes.key?(:'shouldSkipRenderSubchartNotes') && attributes.key?(:'should_skip_render_subchart_notes')

      self.should_skip_render_subchart_notes = attributes[:'should_skip_render_subchart_notes'] unless attributes[:'should_skip_render_subchart_notes'].nil?
      self.should_skip_render_subchart_notes = false if should_skip_render_subchart_notes.nil? && !attributes.key?(:'shouldSkipRenderSubchartNotes') && !attributes.key?(:'should_skip_render_subchart_notes') # rubocop:disable Style/StringLiterals

      self.should_not_wait = attributes[:'shouldNotWait'] unless attributes[:'shouldNotWait'].nil?
      self.should_not_wait = false if should_not_wait.nil? && !attributes.key?(:'shouldNotWait') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :shouldNotWait and :should_not_wait' if attributes.key?(:'shouldNotWait') && attributes.key?(:'should_not_wait')

      self.should_not_wait = attributes[:'should_not_wait'] unless attributes[:'should_not_wait'].nil?
      self.should_not_wait = false if should_not_wait.nil? && !attributes.key?(:'shouldNotWait') && !attributes.key?(:'should_not_wait') # rubocop:disable Style/StringLiterals

      self.is_debug_enabled = attributes[:'isDebugEnabled'] unless attributes[:'isDebugEnabled'].nil?
      self.is_debug_enabled = false if is_debug_enabled.nil? && !attributes.key?(:'isDebugEnabled') # rubocop:disable Style/StringLiterals

      raise 'You cannot provide both :isDebugEnabled and :is_debug_enabled' if attributes.key?(:'isDebugEnabled') && attributes.key?(:'is_debug_enabled')

      self.is_debug_enabled = attributes[:'is_debug_enabled'] unless attributes[:'is_debug_enabled'].nil?
      self.is_debug_enabled = false if is_debug_enabled.nil? && !attributes.key?(:'isDebugEnabled') && !attributes.key?(:'is_debug_enabled') # rubocop:disable Style/StringLiterals
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines, Style/SymbolLiteral

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] purpose Object to be assigned
    def purpose=(purpose)
      # rubocop:disable Style/ConditionalAssignment
      if purpose && !PURPOSE_ENUM.include?(purpose)
        OCI.logger.debug("Unknown value for 'purpose' [" + purpose + "]. Mapping to 'PURPOSE_UNKNOWN_ENUM_VALUE'") if OCI.logger
        @purpose = PURPOSE_UNKNOWN_ENUM_VALUE
      else
        @purpose = purpose
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
        description == other.description &&
        display_name == other.display_name &&
        project_id == other.project_id &&
        deploy_pipeline_id == other.deploy_pipeline_id &&
        compartment_id == other.compartment_id &&
        deploy_stage_type == other.deploy_stage_type &&
        time_created == other.time_created &&
        time_updated == other.time_updated &&
        lifecycle_state == other.lifecycle_state &&
        lifecycle_details == other.lifecycle_details &&
        deploy_stage_predecessor_collection == other.deploy_stage_predecessor_collection &&
        freeform_tags == other.freeform_tags &&
        defined_tags == other.defined_tags &&
        system_tags == other.system_tags &&
        oke_cluster_deploy_environment_id == other.oke_cluster_deploy_environment_id &&
        helm_chart_deploy_artifact_id == other.helm_chart_deploy_artifact_id &&
        values_artifact_ids == other.values_artifact_ids &&
        release_name == other.release_name &&
        is_uninstall_on_stage_delete == other.is_uninstall_on_stage_delete &&
        helm_command_artifact_ids == other.helm_command_artifact_ids &&
        purpose == other.purpose &&
        namespace == other.namespace &&
        timeout_in_seconds == other.timeout_in_seconds &&
        rollback_policy == other.rollback_policy &&
        set_values == other.set_values &&
        set_string == other.set_string &&
        are_hooks_enabled == other.are_hooks_enabled &&
        should_reuse_values == other.should_reuse_values &&
        should_reset_values == other.should_reset_values &&
        is_force_enabled == other.is_force_enabled &&
        should_cleanup_on_fail == other.should_cleanup_on_fail &&
        max_history == other.max_history &&
        should_skip_crds == other.should_skip_crds &&
        should_skip_render_subchart_notes == other.should_skip_render_subchart_notes &&
        should_not_wait == other.should_not_wait &&
        is_debug_enabled == other.is_debug_enabled
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
      [id, description, display_name, project_id, deploy_pipeline_id, compartment_id, deploy_stage_type, time_created, time_updated, lifecycle_state, lifecycle_details, deploy_stage_predecessor_collection, freeform_tags, defined_tags, system_tags, oke_cluster_deploy_environment_id, helm_chart_deploy_artifact_id, values_artifact_ids, release_name, is_uninstall_on_stage_delete, helm_command_artifact_ids, purpose, namespace, timeout_in_seconds, rollback_policy, set_values, set_string, are_hooks_enabled, should_reuse_values, should_reset_values, is_force_enabled, should_cleanup_on_fail, max_history, should_skip_crds, should_skip_render_subchart_notes, should_not_wait, is_debug_enabled].hash
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
