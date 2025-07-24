# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

require 'uri'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Use the Logging Management API to create, read, list, update, move and delete
  # log groups, log objects, log saved searches, and agent configurations.
  # 
  # For more information, see [Logging Overview](/iaas/Content/Logging/Concepts/loggingoverview.htm).
  class HydraControlplaneClient::LoggingManagementClient
    # Client used to make HTTP requests.
    # @return [OCI::ApiClient]
    attr_reader :api_client

    # Fully qualified endpoint URL
    # @return [String]
    attr_reader :endpoint

    # The default retry configuration to apply to all operations in this service client. This can be overridden
    # on a per-operation basis. The default retry configuration value is `nil`, which means that an operation 
    # will not perform any retries
    # @return [OCI::Retry::RetryConfig]
    attr_reader :retry_config

    # The region, which will usually correspond to a value in {OCI::Regions::REGION_ENUM}.
    # @return [String]
    attr_reader :region

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity


    # Creates a new LoggingManagementClient.
    # Notes:
    #   If a config is not specified, then the global OCI.config will be used.
    #
    #   This client is not thread-safe
    #
    #   Either a region or an endpoint must be specified.  If an endpoint is specified, it will be used instead of the
    #     region. A region may be specified in the config or via or the region parameter. If specified in both, then the
    #     region parameter will be used.  
    # @param [Config] config A Config object. 
    # @param [String] region A region used to determine the service endpoint. This will usually
    #   correspond to a value in {OCI::Regions::REGION_ENUM}, but may be an arbitrary string.
    # @param [String] endpoint The fully qualified endpoint URL
    # @param [OCI::BaseSigner] signer A signer implementation which can be used by this client. If this is not provided then
    #   a signer will be constructed via the provided config. One use case of this parameter is instance principals authentication,
    #   so that the instance principals signer can be provided to the client
    # @param [OCI::ApiClientProxySettings] proxy_settings If your environment requires you to use a proxy server for outgoing HTTP requests
    #   the details for the proxy can be provided in this parameter
    # @param [OCI::Retry::RetryConfig] retry_config The retry configuration for this service client. This represents the default retry configuration to
    #   apply across all operations. This can be overridden on a per-operation basis. The default retry configuration value is `nil`, which means that an operation 
    #   will not perform any retries
    def initialize(config: nil, region: nil, endpoint: nil, signer: nil, proxy_settings: nil, retry_config: nil)
      # If the signer is an InstancePrincipalsSecurityTokenSigner or SecurityTokenSigner and no config was supplied (they are self-sufficient signers)
      # then create a dummy config to pass to the ApiClient constructor. If customers wish to create a client which uses instance principals
      # and has config (either populated programmatically or loaded from a file), they must construct that config themselves and then
      # pass it to this constructor.
      #
      # If there is no signer (or the signer is not an instance principals signer) and no config was supplied, this is not valid
      # so try and load the config from the default file.
      config = OCI::Config.validate_and_build_config_with_signer(config, signer)

      signer = OCI::Signer.config_file_auth_builder(config) if signer.nil?

      @api_client = OCI::ApiClient.new(config, signer, proxy_settings: proxy_settings)
      @retry_config = retry_config

      if endpoint
        @endpoint = endpoint + '/20200531'
      else
        region ||= config.region
        region ||= signer.region if signer.respond_to?(:region)
        self.region = region
      end
      logger.info "LoggingManagementClient endpoint set to '#{@endpoint}'." if logger
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity

    # Set the region that will be used to determine the service endpoint.
    # This will usually correspond to a value in {OCI::Regions::REGION_ENUM},
    # but may be an arbitrary string.
    def region=(new_region)
      @region = new_region

      raise 'A region must be specified.' unless @region

      @endpoint = OCI::Regions.get_service_endpoint_for_template(@region, 'https://logging.{region}.oci.{secondLevelDomain}') + '/20200531'
      logger.info "LoggingManagementClient endpoint set to '#{@endpoint} from region #{@region}'." if logger
    end

    # @return [Logger] The logger for this client. May be nil.
    def logger
      @api_client.config.logger
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # execute an admin task.
    # @param [OCI::HydraControlplaneClient::Models::AdminActionRequestDetails] admin_action_request_details Executes the action.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::AdminActionOperationResponse AdminActionOperationResponse}
    def admin_action(admin_action_request_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#admin_action.' if logger

      raise "Missing the required parameter 'admin_action_request_details' when calling admin_action." if admin_action_request_details.nil?

      path = '/adminAction'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(admin_action_request_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#admin_action') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::AdminActionOperationResponse'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves a continuous query into a different compartment within the same tenancy.  When provided, the If-Match is checked against the resource ETag values.
    # For information about moving resources between compartments, see [Moving Resources Between Compartments]({{DOC_SERVER_URL}}/iaas/Content/Identity/Tasks/managingcompartments.htm#moveRes).
    # 
    # @param [String] continuous_query_id The OCID of the continuous query.
    # @param [OCI::HydraControlplaneClient::Models::ChangeContinuousQueryCompartmentDetails] change_continuous_query_compartment_details Request to change the compartment of a given resource.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_continuous_query_compartment(continuous_query_id, change_continuous_query_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_continuous_query_compartment.' if logger

      raise "Missing the required parameter 'continuous_query_id' when calling change_continuous_query_compartment." if continuous_query_id.nil?
      raise "Missing the required parameter 'change_continuous_query_compartment_details' when calling change_continuous_query_compartment." if change_continuous_query_compartment_details.nil?
      raise "Parameter value for 'continuous_query_id' must not be blank" if OCI::Internal::Util.blank_string?(continuous_query_id)

      path = '/continuousQuery/{continuousQueryId}/actions/changeCompartment'.sub('{continuousQueryId}', continuous_query_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(change_continuous_query_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_continuous_query_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Change the compartment of the log data model within the same tenancy.
    # @param [String] log_data_model_id The OCID of the log data model object.
    # @param [OCI::HydraControlplaneClient::Models::ChangeLogDataModelCompartmentDetails] change_log_data_model_compartment_details Log data model UPDATE compartment request details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_log_data_model_compartment(log_data_model_id, change_log_data_model_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_log_data_model_compartment.' if logger

      raise "Missing the required parameter 'log_data_model_id' when calling change_log_data_model_compartment." if log_data_model_id.nil?
      raise "Missing the required parameter 'change_log_data_model_compartment_details' when calling change_log_data_model_compartment." if change_log_data_model_compartment_details.nil?
      raise "Parameter value for 'log_data_model_id' must not be blank" if OCI::Internal::Util.blank_string?(log_data_model_id)

      path = '/logDataModels/{logDataModelId}/actions/changeCompartment'.sub('{logDataModelId}', log_data_model_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(change_log_data_model_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_log_data_model_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves a log group into a different compartment within the same tenancy.  When provided, the If-Match is checked against the resource ETag values.
    # For information about moving resources between compartments, see [Moving Resources Between Compartments]({{DOC_SERVER_URL}}/iaas/Content/Identity/Tasks/managingcompartments.htm#moveRes).
    # 
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [OCI::HydraControlplaneClient::Models::ChangeLogGroupCompartmentDetails] change_log_group_compartment_details Request to change the compartment of a given resource.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_log_group_compartment(log_group_id, change_log_group_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_log_group_compartment.' if logger

      raise "Missing the required parameter 'log_group_id' when calling change_log_group_compartment." if log_group_id.nil?
      raise "Missing the required parameter 'change_log_group_compartment_details' when calling change_log_group_compartment." if change_log_group_compartment_details.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)

      path = '/logGroups/{logGroupId}/actions/changeCompartment'.sub('{logGroupId}', log_group_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(change_log_group_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_log_group_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves a log into a different log group within the same tenancy.  When provided, the If-Match is checked against the ETag values of the resource.
    # 
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [String] log_id OCID of a log to work with.
    # @param [OCI::HydraControlplaneClient::Models::ChangeLogLogGroupDetails] change_log_log_group_details Request to change the log group of a given log.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_log_log_group(log_group_id, log_id, change_log_log_group_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_log_log_group.' if logger

      raise "Missing the required parameter 'log_group_id' when calling change_log_log_group." if log_group_id.nil?
      raise "Missing the required parameter 'log_id' when calling change_log_log_group." if log_id.nil?
      raise "Missing the required parameter 'change_log_log_group_details' when calling change_log_log_group." if change_log_log_group_details.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)
      raise "Parameter value for 'log_id' must not be blank" if OCI::Internal::Util.blank_string?(log_id)

      path = '/logGroups/{logGroupId}/logs/{logId}/actions/changeLogGroup'.sub('{logGroupId}', log_group_id.to_s).sub('{logId}', log_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(change_log_log_group_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_log_log_group') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves a log pipeline into a different compartment within the same tenancy.  When provided, the If-Match is checked against the resource ETag values.
    # For information about moving resources between compartments, see [Moving Resources Between Compartments]({{DOC_SERVER_URL}}/iaas/Content/Identity/Tasks/managingcompartments.htm#moveRes).
    # 
    # @param [String] log_pipeline_id The OCID of the log pipeline.
    # @param [OCI::HydraControlplaneClient::Models::ChangeLogPipelineCompartmentDetails] change_log_pipeline_compartment_details Request to change the compartment of a given resource.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_log_pipeline_compartment(log_pipeline_id, change_log_pipeline_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_log_pipeline_compartment.' if logger

      raise "Missing the required parameter 'log_pipeline_id' when calling change_log_pipeline_compartment." if log_pipeline_id.nil?
      raise "Missing the required parameter 'change_log_pipeline_compartment_details' when calling change_log_pipeline_compartment." if change_log_pipeline_compartment_details.nil?
      raise "Parameter value for 'log_pipeline_id' must not be blank" if OCI::Internal::Util.blank_string?(log_pipeline_id)

      path = '/logPipelines/{logPipelineId}/actions/changeCompartment'.sub('{logPipelineId}', log_pipeline_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(change_log_pipeline_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_log_pipeline_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves a log rule into a different compartment within the same tenancy.  When provided, the If-Match is checked against the resource ETag values.
    # For information about moving resources between compartments, see [Moving Resources Between Compartments]({{DOC_SERVER_URL}}/iaas/Content/Identity/Tasks/managingcompartments.htm#moveRes).
    # 
    # @param [String] log_rule_id The OCID of the log rule.
    # @param [OCI::HydraControlplaneClient::Models::ChangeLogRuleCompartmentDetails] change_log_rule_compartment_details Request to change the compartment of a given resource.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_log_rule_compartment(log_rule_id, change_log_rule_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_log_rule_compartment.' if logger

      raise "Missing the required parameter 'log_rule_id' when calling change_log_rule_compartment." if log_rule_id.nil?
      raise "Missing the required parameter 'change_log_rule_compartment_details' when calling change_log_rule_compartment." if change_log_rule_compartment_details.nil?
      raise "Parameter value for 'log_rule_id' must not be blank" if OCI::Internal::Util.blank_string?(log_rule_id)

      path = '/logRules/{logRuleId}/actions/changeCompartment'.sub('{logRuleId}', log_rule_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(change_log_rule_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_log_rule_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves a saved search into a different compartment within the same tenancy. For information about moving
    # resources between compartments, see [Moving Resources to a Different Compartment]({{DOC_SERVER_URL}}/iaas/Content/Identity/Tasks/managingcompartments.htm#moveRes).
    # 
    # @param [String] log_saved_search_id OCID of the logSavedSearch.
    #   
    # @param [OCI::HydraControlplaneClient::Models::ChangeLogSavedSearchCompartmentDetails] change_log_saved_search_compartment_details Contains details indicating which compartment the resource should move to.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_log_saved_search_compartment(log_saved_search_id, change_log_saved_search_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_log_saved_search_compartment.' if logger

      raise "Missing the required parameter 'log_saved_search_id' when calling change_log_saved_search_compartment." if log_saved_search_id.nil?
      raise "Missing the required parameter 'change_log_saved_search_compartment_details' when calling change_log_saved_search_compartment." if change_log_saved_search_compartment_details.nil?
      raise "Parameter value for 'log_saved_search_id' must not be blank" if OCI::Internal::Util.blank_string?(log_saved_search_id)

      path = '/logSavedSearches/{logSavedSearchId}/actions/changeCompartment'.sub('{logSavedSearchId}', log_saved_search_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(change_log_saved_search_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_log_saved_search_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves a managed continuous query into a different compartment within the same tenancy.  When provided, the If-Match is checked against the resource ETag values.
    # For information about moving resources between compartments, see [Moving Resources Between Compartments]({{DOC_SERVER_URL}}/iaas/Content/Identity/Tasks/managingcompartments.htm#moveRes).
    # 
    # @param [String] continuous_query_id The OCID of the continuous query.
    # @param [OCI::HydraControlplaneClient::Models::ChangeManagedContinuousQueryCompartmentDetails] change_managed_continuous_query_compartment_details Request to change the compartment of a given resource.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_managed_continuous_query_compartment(continuous_query_id, change_managed_continuous_query_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_managed_continuous_query_compartment.' if logger

      raise "Missing the required parameter 'continuous_query_id' when calling change_managed_continuous_query_compartment." if continuous_query_id.nil?
      raise "Missing the required parameter 'change_managed_continuous_query_compartment_details' when calling change_managed_continuous_query_compartment." if change_managed_continuous_query_compartment_details.nil?
      raise "Parameter value for 'continuous_query_id' must not be blank" if OCI::Internal::Util.blank_string?(continuous_query_id)

      path = '/managedContinuousQuery/{continuousQueryId}/actions/changeCompartment'.sub('{continuousQueryId}', continuous_query_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(change_managed_continuous_query_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_managed_continuous_query_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Move a service registry into another compartment within same tenancy.
    # 
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [OCI::HydraControlplaneClient::Models::ChangeServiceRegistryCompartmentDetails] change_service_registry_compartment_details Request to change the compartment of a given resource.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_service_registry_compartment(service_registry_id, change_service_registry_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_service_registry_compartment.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling change_service_registry_compartment." if service_registry_id.nil?
      raise "Missing the required parameter 'change_service_registry_compartment_details' when calling change_service_registry_compartment." if change_service_registry_compartment_details.nil?
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)

      path = '/serviceregistries/{serviceRegistryId}/actions/changeCompartment'.sub('{serviceRegistryId}', service_registry_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(change_service_registry_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_service_registry_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves the unified agent configuration into a different compartment within the same tenancy. When provided, the If-Match is checked against the ETag values of the resource.
    # For information about moving resources between compartments, see [Moving Resources Between Compartments]({{DOC_SERVER_URL}}/iaas/Content/Identity/Tasks/managingcompartments.htm#moveRes).
    # 
    # @param [String] registration_id The OCID of the UA config registration.
    # @param [OCI::HydraControlplaneClient::Models::ChangeUAConfigRegistrationCompartmentDetails] change_ua_config_registration_compartment_details Request to change the compartment of a given resource.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_ua_config_registration_compartment(registration_id, change_ua_config_registration_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_ua_config_registration_compartment.' if logger

      raise "Missing the required parameter 'registration_id' when calling change_ua_config_registration_compartment." if registration_id.nil?
      raise "Missing the required parameter 'change_ua_config_registration_compartment_details' when calling change_ua_config_registration_compartment." if change_ua_config_registration_compartment_details.nil?
      raise "Parameter value for 'registration_id' must not be blank" if OCI::Internal::Util.blank_string?(registration_id)

      path = '/unifiedAgent/configRegistration/{registrationId}/actions/changeCompartment'.sub('{registrationId}', registration_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(change_ua_config_registration_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_ua_config_registration_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Moves the unified agent configuration into a different compartment within the same tenancy.  When provided, the If-Match is checked against the ETag values of the resource.
    # For information about moving resources between compartments, see [Moving Resources Between Compartments]({{DOC_SERVER_URL}}/iaas/Content/Identity/Tasks/managingcompartments.htm#moveRes).
    # 
    # @param [String] unified_agent_configuration_id The OCID of the Unified Agent configuration.
    # @param [OCI::HydraControlplaneClient::Models::ChangeUnifiedAgentConfigurationCompartmentDetails] change_unified_agent_configuration_compartment_details Request to change the compartment of a given resource.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def change_unified_agent_configuration_compartment(unified_agent_configuration_id, change_unified_agent_configuration_compartment_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#change_unified_agent_configuration_compartment.' if logger

      raise "Missing the required parameter 'unified_agent_configuration_id' when calling change_unified_agent_configuration_compartment." if unified_agent_configuration_id.nil?
      raise "Missing the required parameter 'change_unified_agent_configuration_compartment_details' when calling change_unified_agent_configuration_compartment." if change_unified_agent_configuration_compartment_details.nil?
      raise "Parameter value for 'unified_agent_configuration_id' must not be blank" if OCI::Internal::Util.blank_string?(unified_agent_configuration_id)

      path = '/unifiedAgentConfigurations/{unifiedAgentConfigurationId}/actions/changeCompartment'.sub('{unifiedAgentConfigurationId}', unified_agent_configuration_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(change_unified_agent_configuration_compartment_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#change_unified_agent_configuration_compartment') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create query engine service.
    # @param [OCI::HydraControlplaneClient::Models::CreateContinuousQueryDetails] create_continuous_query_details Continuous Query creation object.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_continuous_query(create_continuous_query_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_continuous_query.' if logger

      raise "Missing the required parameter 'create_continuous_query_details' when calling create_continuous_query." if create_continuous_query_details.nil?

      path = '/continuousQuery'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_continuous_query_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_continuous_query') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Creates a log within the specified log group. This call fails if a log group has already been created
    # with the same displayName or (service, resource, category) triplet.
    # 
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [OCI::HydraControlplaneClient::Models::CreateLogDetails] create_log_details Log object configuration details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_log(log_group_id, create_log_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_log.' if logger

      raise "Missing the required parameter 'log_group_id' when calling create_log." if log_group_id.nil?
      raise "Missing the required parameter 'create_log_details' when calling create_log." if create_log_details.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)

      path = '/logGroups/{logGroupId}/logs'.sub('{logGroupId}', log_group_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_log_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_log') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create the log data model.
    # @param [OCI::HydraControlplaneClient::Models::CreateLogDataModelDetails] create_log_data_model_details Log data model CREATE request details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_log_data_model(create_log_data_model_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_log_data_model.' if logger

      raise "Missing the required parameter 'create_log_data_model_details' when calling create_log_data_model." if create_log_data_model_details.nil?

      path = '/logDataModels'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_log_data_model_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_log_data_model') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create a new log group with a unique display name. This call fails
    # if the log group is already created with the same displayName in the compartment.
    # 
    # @param [OCI::HydraControlplaneClient::Models::CreateLogGroupDetails] create_log_group_details Details to create log group.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_log_group(create_log_group_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_log_group.' if logger

      raise "Missing the required parameter 'create_log_group_details' when calling create_log_group." if create_log_group_details.nil?

      path = '/logGroups'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_log_group_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_log_group') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create log pipeline resource.
    # @param [OCI::HydraControlplaneClient::Models::CreateLogPipelineDetails] create_log_pipeline_details Log pipeline creation request details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_log_pipeline(create_log_pipeline_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_log_pipeline.' if logger

      raise "Missing the required parameter 'create_log_pipeline_details' when calling create_log_pipeline." if create_log_pipeline_details.nil?

      path = '/logPipelines'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_log_pipeline_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_log_pipeline') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create log rule resource.
    # @param [OCI::HydraControlplaneClient::Models::CreateLogRuleDetails] create_log_rule_details Log rule creation request details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_log_rule(create_log_rule_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_log_rule.' if logger

      raise "Missing the required parameter 'create_log_rule_details' when calling create_log_rule." if create_log_rule_details.nil?

      path = '/logRules'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_log_rule_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_log_rule') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Creates a new LogSavedSearch.
    # 
    # @param [OCI::HydraControlplaneClient::Models::CreateLogSavedSearchDetails] create_log_saved_search_details Specification of the saved search to create.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogSavedSearch LogSavedSearch}
    def create_log_saved_search(create_log_saved_search_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_log_saved_search.' if logger

      raise "Missing the required parameter 'create_log_saved_search_details' when calling create_log_saved_search." if create_log_saved_search_details.nil?

      path = '/logSavedSearches'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_log_saved_search_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_log_saved_search') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogSavedSearch'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create managed continuous query engine service.
    # @param [OCI::HydraControlplaneClient::Models::CreateManagedContinuousQueryDetails] create_managed_continuous_query_details Managed Continuous Query creation object.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_managed_continuous_query(create_managed_continuous_query_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_managed_continuous_query.' if logger

      raise "Missing the required parameter 'create_managed_continuous_query_details' when calling create_managed_continuous_query." if create_managed_continuous_query_details.nil?

      path = '/managedContinuousQuery'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_managed_continuous_query_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_managed_continuous_query') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Creates a service category for given service. This call fails if a category already exists with the specified configuratiuons.
    # 
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [OCI::HydraControlplaneClient::Models::CreateServiceCategoryDetails] create_service_category_details Category configuration details
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ServiceCategory ServiceCategory}
    def create_service_category(service_registry_id, create_service_category_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_service_category.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling create_service_category." if service_registry_id.nil?
      raise "Missing the required parameter 'create_service_category_details' when calling create_service_category." if create_service_category_details.nil?
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)

      path = '/serviceregistries/{serviceRegistryId}/categories'.sub('{serviceRegistryId}', service_registry_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_service_category_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_service_category') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ServiceCategory'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create the service registry entry for a partner service
    # @param [OCI::HydraControlplaneClient::Models::CreateServiceRegistryDetails] create_service_registry_details Create Service Registry object.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ServiceRegistry ServiceRegistry}
    def create_service_registry(create_service_registry_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_service_registry.' if logger

      raise "Missing the required parameter 'create_service_registry_details' when calling create_service_registry." if create_service_registry_details.nil?

      path = '/serviceregistries'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_service_registry_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_service_registry') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ServiceRegistry'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create unified agent configuration registration.
    # @param [OCI::HydraControlplaneClient::Models::CreateUnifiedAgentConfigurationDetails] create_unified_agent_configuration_details Unified agent configuration creation object.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_unified_agent_configuration(create_unified_agent_configuration_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_unified_agent_configuration.' if logger

      raise "Missing the required parameter 'create_unified_agent_configuration_details' when calling create_unified_agent_configuration." if create_unified_agent_configuration_details.nil?

      path = '/unifiedAgentConfigurations'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(create_unified_agent_configuration_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_unified_agent_configuration') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Create the unified agent configuration registration.
    # @param [OCI::HydraControlplaneClient::Models::UAConfigRegistrationDetails] config_registration_details UA config registration object details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def create_unified_agent_registration(config_registration_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#create_unified_agent_registration.' if logger

      raise "Missing the required parameter 'config_registration_details' when calling create_unified_agent_registration." if config_registration_details.nil?

      path = '/unifiedAgent/configRegistration'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = @api_client.object_to_http_body(config_registration_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#create_unified_agent_registration') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Delete query engine service.
    # @param [String] continuous_query_id The OCID of the continuous query.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_continuous_query(continuous_query_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_continuous_query.' if logger

      raise "Missing the required parameter 'continuous_query_id' when calling delete_continuous_query." if continuous_query_id.nil?
      raise "Parameter value for 'continuous_query_id' must not be blank" if OCI::Internal::Util.blank_string?(continuous_query_id)

      path = '/continuousQuery/{continuousQueryId}'.sub('{continuousQueryId}', continuous_query_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_continuous_query') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Deletes the log object in a log group.
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [String] log_id OCID of a log to work with.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_log(log_group_id, log_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_log.' if logger

      raise "Missing the required parameter 'log_group_id' when calling delete_log." if log_group_id.nil?
      raise "Missing the required parameter 'log_id' when calling delete_log." if log_id.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)
      raise "Parameter value for 'log_id' must not be blank" if OCI::Internal::Util.blank_string?(log_id)

      path = '/logGroups/{logGroupId}/logs/{logId}'.sub('{logGroupId}', log_group_id.to_s).sub('{logId}', log_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_log') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Delete the log data model.
    # @param [String] log_data_model_id The OCID of the log data model object.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_log_data_model(log_data_model_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_log_data_model.' if logger

      raise "Missing the required parameter 'log_data_model_id' when calling delete_log_data_model." if log_data_model_id.nil?
      raise "Parameter value for 'log_data_model_id' must not be blank" if OCI::Internal::Util.blank_string?(log_data_model_id)

      path = '/logDataModels/{logDataModelId}'.sub('{logDataModelId}', log_data_model_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_log_data_model') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Deletes the specified log group.
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_log_group(log_group_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_log_group.' if logger

      raise "Missing the required parameter 'log_group_id' when calling delete_log_group." if log_group_id.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)

      path = '/logGroups/{logGroupId}'.sub('{logGroupId}', log_group_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_log_group') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Delete log pipeline resource.
    # @param [String] log_pipeline_id The OCID of the log pipeline.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_log_pipeline(log_pipeline_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_log_pipeline.' if logger

      raise "Missing the required parameter 'log_pipeline_id' when calling delete_log_pipeline." if log_pipeline_id.nil?
      raise "Parameter value for 'log_pipeline_id' must not be blank" if OCI::Internal::Util.blank_string?(log_pipeline_id)

      path = '/logPipelines/{logPipelineId}'.sub('{logPipelineId}', log_pipeline_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_log_pipeline') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Delete log rule resource.
    # @param [String] log_rule_id The OCID of the log rule.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_log_rule(log_rule_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_log_rule.' if logger

      raise "Missing the required parameter 'log_rule_id' when calling delete_log_rule." if log_rule_id.nil?
      raise "Parameter value for 'log_rule_id' must not be blank" if OCI::Internal::Util.blank_string?(log_rule_id)

      path = '/logRules/{logRuleId}'.sub('{logRuleId}', log_rule_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_log_rule') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Deletes the specified LogSavedSearch.
    # @param [String] log_saved_search_id OCID of the logSavedSearch.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_log_saved_search(log_saved_search_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_log_saved_search.' if logger

      raise "Missing the required parameter 'log_saved_search_id' when calling delete_log_saved_search." if log_saved_search_id.nil?
      raise "Parameter value for 'log_saved_search_id' must not be blank" if OCI::Internal::Util.blank_string?(log_saved_search_id)

      path = '/logSavedSearches/{logSavedSearchId}'.sub('{logSavedSearchId}', log_saved_search_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_log_saved_search') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Delete Managed continuous query engine service.
    # @param [String] continuous_query_id The OCID of the continuous query.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_managed_continuous_query(continuous_query_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_managed_continuous_query.' if logger

      raise "Missing the required parameter 'continuous_query_id' when calling delete_managed_continuous_query." if continuous_query_id.nil?
      raise "Parameter value for 'continuous_query_id' must not be blank" if OCI::Internal::Util.blank_string?(continuous_query_id)

      path = '/managedContinuousQuery/{continuousQueryId}'.sub('{continuousQueryId}', continuous_query_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_managed_continuous_query') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Deletes the service category in a service registry.
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [String] category_id The OCID of the Service Category entry.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_service_category(service_registry_id, category_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_service_category.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling delete_service_category." if service_registry_id.nil?
      raise "Missing the required parameter 'category_id' when calling delete_service_category." if category_id.nil?
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)
      raise "Parameter value for 'category_id' must not be blank" if OCI::Internal::Util.blank_string?(category_id)

      path = '/serviceregistries/{serviceRegistryId}/categories/{categoryId}'.sub('{serviceRegistryId}', service_registry_id.to_s).sub('{categoryId}', category_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_service_category') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Delete service registry.
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_service_registry(service_registry_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_service_registry.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling delete_service_registry." if service_registry_id.nil?
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)

      path = '/serviceregistries/{serviceRegistryId}'.sub('{serviceRegistryId}', service_registry_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_service_registry') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Delete unified agent configuration.
    # @param [String] unified_agent_configuration_id The OCID of the Unified Agent configuration.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_unified_agent_configuration(unified_agent_configuration_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_unified_agent_configuration.' if logger

      raise "Missing the required parameter 'unified_agent_configuration_id' when calling delete_unified_agent_configuration." if unified_agent_configuration_id.nil?
      raise "Parameter value for 'unified_agent_configuration_id' must not be blank" if OCI::Internal::Util.blank_string?(unified_agent_configuration_id)

      path = '/unifiedAgentConfigurations/{unifiedAgentConfigurationId}'.sub('{unifiedAgentConfigurationId}', unified_agent_configuration_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_unified_agent_configuration') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Delete the unified agent configuration registration.
    # @param [String] registration_id The OCID of the UA config registration.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_unified_agent_registration(registration_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_unified_agent_registration.' if logger

      raise "Missing the required parameter 'registration_id' when calling delete_unified_agent_registration." if registration_id.nil?
      raise "Parameter value for 'registration_id' must not be blank" if OCI::Internal::Util.blank_string?(registration_id)

      path = '/unifiedAgent/configRegistration/{registrationId}'.sub('{registrationId}', registration_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_unified_agent_registration') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Cancel a work request that has not started yet.
    # 
    # @param [String] work_request_id The asynchronous request ID.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def delete_work_request(work_request_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#delete_work_request.' if logger

      raise "Missing the required parameter 'work_request_id' when calling delete_work_request." if work_request_id.nil?
      raise "Parameter value for 'work_request_id' must not be blank" if OCI::Internal::Util.blank_string?(work_request_id)

      path = '/workRequests/{workRequestId}'.sub('{workRequestId}', work_request_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#delete_work_request') do
        @api_client.call_api(
          :DELETE,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Filters log objects based on logId, or compartmentId, with optional resource, service and logType.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :compartment_id Compartment OCID to list resources in. Please see compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @option opts [String] :id <b>Filter</b> results by [OCID]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/identifiers.htm). Must be an OCID of the correct type for the resource type.
    #   
    # @option opts [String] :log_type The logType that the log object is for, whether custom or service.
    #   Allowed values are: CUSTOM, SERVICE, SIEM
    # @option opts [String] :source_service Service that created the log object, which is a field of LogSummary.Configuration.Source.
    # @option opts [String] :source_resource Log object resource, which is a field of LogSummary.Configuration.Source.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::LogSummary LogSummary}>
    def filter_logs(opts = {})
      logger.debug 'Calling operation LoggingManagementClient#filter_logs.' if logger


      if opts[:log_type] && !%w[CUSTOM SERVICE SIEM].include?(opts[:log_type])
        raise 'Invalid value for "log_type", must be one of CUSTOM, SERVICE, SIEM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/actions/filterLogs'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = opts[:compartment_id] if opts[:compartment_id]
      query_params[:id] = opts[:id] if opts[:id]
      query_params[:logType] = opts[:log_type] if opts[:log_type]
      query_params[:sourceService] = opts[:source_service] if opts[:source_service]
      query_params[:sourceResource] = opts[:source_resource] if opts[:source_resource]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#filter_logs') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::LogSummary>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Returns a generated agent fluent configuration for a host instance.
    # @param [OCI::HydraControlplaneClient::Models::AgentHostMetadataDetails] agent_host_metadata_details Meta details of the host where agent is running/needs to run.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :host_identifier Unique Identifier for the host running the agent that calls the CP. It can either be hostname or user id
    #   
    # @option opts [BOOLEAN] :is_config_valid Represents the validity of configuration on the agent.
    #    (default to false)
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::AgentFluentConfiguration AgentFluentConfiguration}
    def generate_agent_fluent_config(agent_host_metadata_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#generate_agent_fluent_config.' if logger

      raise "Missing the required parameter 'agent_host_metadata_details' when calling generate_agent_fluent_config." if agent_host_metadata_details.nil?

      path = '/unifiedAgent/configRegistration/actions/generateAgentConfig'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'host-identifier'] = opts[:host_identifier] if opts[:host_identifier]
      header_params[:'is-config-valid'] = opts[:is_config_valid] if !opts[:is_config_valid].nil?
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(agent_host_metadata_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#generate_agent_fluent_config') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::AgentFluentConfiguration'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # API that only accepts mtls requests. Returns the generated agent fluent configuration for a host instance.
    # @param [OCI::HydraControlplaneClient::Models::AgentHostMetadataDetails] agent_host_metadata_details Meta details of the host where agent is running/needs to run.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :host_identifier Unique Identifier for the host running the agent that calls the CP. It can either be hostname or user id
    #   
    # @option opts [BOOLEAN] :is_config_valid Represents the validity of configuration on the agent.
    #    (default to false)
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::AgentFluentConfiguration AgentFluentConfiguration}
    def generate_agent_fluent_config_mtls(agent_host_metadata_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#generate_agent_fluent_config_mtls.' if logger

      raise "Missing the required parameter 'agent_host_metadata_details' when calling generate_agent_fluent_config_mtls." if agent_host_metadata_details.nil?

      path = '/unifiedAgent/configRegistration/actions/generateSubstrateAgentConfig'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'host-identifier'] = opts[:host_identifier] if opts[:host_identifier]
      header_params[:'is-config-valid'] = opts[:is_config_valid] if !opts[:is_config_valid].nil?
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(agent_host_metadata_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#generate_agent_fluent_config_mtls') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::AgentFluentConfiguration'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get continuous query.
    # @param [String] continuous_query_id The OCID of the continuous query.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ContinuousQuery ContinuousQuery}
    def get_continuous_query(continuous_query_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_continuous_query.' if logger

      raise "Missing the required parameter 'continuous_query_id' when calling get_continuous_query." if continuous_query_id.nil?
      raise "Parameter value for 'continuous_query_id' must not be blank" if OCI::Internal::Util.blank_string?(continuous_query_id)

      path = '/continuousQuery/{continuousQueryId}'.sub('{continuousQueryId}', continuous_query_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_continuous_query') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ContinuousQuery'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get the generated agent configuration for a unified agent.
    # @param [String] fluent_type Type of fluent d/bit.
    #   Allowed values are: FLUENTD
    # @param [String] fluent_version Version of fluent d/bit.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :configuration_type Type of configuration
    #   Allowed values are: LOG, METRIC, LOG_AND_METRIC
    # @option opts [String] :operating_system_type The Unified Agent configuration System type
    #   Allowed values are: LINUX, WINDOWS
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :host_identifier Unique Identifier for the host running the agent that calls the CP. It can either be hostname or user id
    #   
    # @option opts [BOOLEAN] :is_config_valid Represents the validity of configuration on the agent.
    #    (default to false)
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::UnifiedAgentGeneratedConfiguration UnifiedAgentGeneratedConfiguration}
    def get_generated_unified_agent_configuration(fluent_type, fluent_version, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_generated_unified_agent_configuration.' if logger

      raise "Missing the required parameter 'fluent_type' when calling get_generated_unified_agent_configuration." if fluent_type.nil?
      unless %w[FLUENTD].include?(fluent_type)
        raise "Invalid value for 'fluent_type', must be one of FLUENTD."
      end
      raise "Missing the required parameter 'fluent_version' when calling get_generated_unified_agent_configuration." if fluent_version.nil?

      if opts[:configuration_type] && !%w[LOG METRIC LOG_AND_METRIC].include?(opts[:configuration_type])
        raise 'Invalid value for "configuration_type", must be one of LOG, METRIC, LOG_AND_METRIC.'
      end

      if opts[:operating_system_type] && !%w[LINUX WINDOWS].include?(opts[:operating_system_type])
        raise 'Invalid value for "operating_system_type", must be one of LINUX, WINDOWS.'
      end

      path = '/generatedUnifiedAgentConfiguration'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:fluentType] = fluent_type
      query_params[:fluentVersion] = fluent_version
      query_params[:configurationType] = opts[:configuration_type] if opts[:configuration_type]
      query_params[:operatingSystemType] = opts[:operating_system_type] if opts[:operating_system_type]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'host-identifier'] = opts[:host_identifier] if opts[:host_identifier]
      header_params[:'is-config-valid'] = opts[:is_config_valid] if !opts[:is_config_valid].nil?
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_generated_unified_agent_configuration') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::UnifiedAgentGeneratedConfiguration'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Gets the log object configuration for the log object OCID.
    # 
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [String] log_id OCID of a log to work with.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::Log Log}
    def get_log(log_group_id, log_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_log.' if logger

      raise "Missing the required parameter 'log_group_id' when calling get_log." if log_group_id.nil?
      raise "Missing the required parameter 'log_id' when calling get_log." if log_id.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)
      raise "Parameter value for 'log_id' must not be blank" if OCI::Internal::Util.blank_string?(log_id)

      path = '/logGroups/{logGroupId}/logs/{logId}'.sub('{logGroupId}', log_group_id.to_s).sub('{logId}', log_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_log') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::Log'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get the specified log data model.
    # @param [String] log_data_model_id The OCID of the log data model object.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogDataModel LogDataModel}
    def get_log_data_model(log_data_model_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_log_data_model.' if logger

      raise "Missing the required parameter 'log_data_model_id' when calling get_log_data_model." if log_data_model_id.nil?
      raise "Parameter value for 'log_data_model_id' must not be blank" if OCI::Internal::Util.blank_string?(log_data_model_id)

      path = '/logDataModels/{logDataModelId}'.sub('{logDataModelId}', log_data_model_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_log_data_model') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogDataModel'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get the specified log group's information.
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogGroup LogGroup}
    def get_log_group(log_group_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_log_group.' if logger

      raise "Missing the required parameter 'log_group_id' when calling get_log_group." if log_group_id.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)

      path = '/logGroups/{logGroupId}'.sub('{logGroupId}', log_group_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_log_group') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogGroup'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get log pipeline.
    # @param [String] log_pipeline_id The OCID of the log pipeline.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogPipeline LogPipeline}
    def get_log_pipeline(log_pipeline_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_log_pipeline.' if logger

      raise "Missing the required parameter 'log_pipeline_id' when calling get_log_pipeline." if log_pipeline_id.nil?
      raise "Parameter value for 'log_pipeline_id' must not be blank" if OCI::Internal::Util.blank_string?(log_pipeline_id)

      path = '/logPipelines/{logPipelineId}'.sub('{logPipelineId}', log_pipeline_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_log_pipeline') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogPipeline'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get log rule.
    # @param [String] log_rule_id The OCID of the log rule.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogRule LogRule}
    def get_log_rule(log_rule_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_log_rule.' if logger

      raise "Missing the required parameter 'log_rule_id' when calling get_log_rule." if log_rule_id.nil?
      raise "Parameter value for 'log_rule_id' must not be blank" if OCI::Internal::Util.blank_string?(log_rule_id)

      path = '/logRules/{logRuleId}'.sub('{logRuleId}', log_rule_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_log_rule') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogRule'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Retrieves a LogSavedSearch.
    # @param [String] log_saved_search_id OCID of the logSavedSearch.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogSavedSearch LogSavedSearch}
    def get_log_saved_search(log_saved_search_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_log_saved_search.' if logger

      raise "Missing the required parameter 'log_saved_search_id' when calling get_log_saved_search." if log_saved_search_id.nil?
      raise "Parameter value for 'log_saved_search_id' must not be blank" if OCI::Internal::Util.blank_string?(log_saved_search_id)

      path = '/logSavedSearches/{logSavedSearchId}'.sub('{logSavedSearchId}', log_saved_search_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_log_saved_search') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogSavedSearch'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get managed continuous query.
    # @param [String] continuous_query_id The OCID of the continuous query.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :opc_retry_token A token that uniquely identifies a request so it can be retried in case
    #   of a timeout or server error, without risk of executing that same action
    #   again. Retry tokens expire after 24 hours, but can be invalidated
    #   before then due to conflicting operations (e.g., if a resource has been
    #   deleted and purged from the system, then a retry of the original
    #   creation request may be rejected).
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ManagedContinuousQuery ManagedContinuousQuery}
    def get_managed_continuous_query(continuous_query_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_managed_continuous_query.' if logger

      raise "Missing the required parameter 'continuous_query_id' when calling get_managed_continuous_query." if continuous_query_id.nil?
      raise "Parameter value for 'continuous_query_id' must not be blank" if OCI::Internal::Util.blank_string?(continuous_query_id)

      path = '/managedContinuousQuery/{continuousQueryId}'.sub('{continuousQueryId}', continuous_query_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'opc-retry-token'] = opts[:opc_retry_token] if opts[:opc_retry_token]
      # rubocop:enable Style/NegatedIf
      header_params[:'opc-retry-token'] ||= OCI::Retry.generate_opc_retry_token

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_managed_continuous_query') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ManagedContinuousQuery'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Gets the service category configuration for the given category name.
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [String] category_id The OCID of the Service Category entry.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ServiceCategory ServiceCategory}
    def get_service_category(service_registry_id, category_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_service_category.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling get_service_category." if service_registry_id.nil?
      raise "Missing the required parameter 'category_id' when calling get_service_category." if category_id.nil?
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)
      raise "Parameter value for 'category_id' must not be blank" if OCI::Internal::Util.blank_string?(category_id)

      path = '/serviceregistries/{serviceRegistryId}/categories/{categoryId}'.sub('{serviceRegistryId}', service_registry_id.to_s).sub('{categoryId}', category_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_service_category') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ServiceCategory'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get the service registry entry with specified resource OCID.
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ServiceRegistry ServiceRegistry}
    def get_service_registry(service_registry_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_service_registry.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling get_service_registry." if service_registry_id.nil?
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)

      path = '/serviceregistries/{serviceRegistryId}'.sub('{serviceRegistryId}', service_registry_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_service_registry') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ServiceRegistry'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get the resource compartment ID for a given work request.
    # 
    # @param [String] work_request_id The asynchronous request ID.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::WorkRequestResourceCompartment WorkRequestResourceCompartment}
    def get_target_compartment_for_wr(work_request_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_target_compartment_for_wr.' if logger

      raise "Missing the required parameter 'work_request_id' when calling get_target_compartment_for_wr." if work_request_id.nil?
      raise "Parameter value for 'work_request_id' must not be blank" if OCI::Internal::Util.blank_string?(work_request_id)

      path = '/workRequests/{workRequestId}/resourceCompartment'.sub('{workRequestId}', work_request_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_target_compartment_for_wr') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::WorkRequestResourceCompartment'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get the unified agent configuration registration.
    # @param [String] registration_id The OCID of the UA config registration.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::UAConfigRegistration UAConfigRegistration}
    def get_unified_agent_config_registration(registration_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_unified_agent_config_registration.' if logger

      raise "Missing the required parameter 'registration_id' when calling get_unified_agent_config_registration." if registration_id.nil?
      raise "Parameter value for 'registration_id' must not be blank" if OCI::Internal::Util.blank_string?(registration_id)

      path = '/unifiedAgent/configRegistration/{registrationId}'.sub('{registrationId}', registration_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_unified_agent_config_registration') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::UAConfigRegistration'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Get the unified agent configuration for an ID.
    # @param [String] unified_agent_configuration_id The OCID of the Unified Agent configuration.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::UnifiedAgentConfiguration UnifiedAgentConfiguration}
    def get_unified_agent_configuration(unified_agent_configuration_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_unified_agent_configuration.' if logger

      raise "Missing the required parameter 'unified_agent_configuration_id' when calling get_unified_agent_configuration." if unified_agent_configuration_id.nil?
      raise "Parameter value for 'unified_agent_configuration_id' must not be blank" if OCI::Internal::Util.blank_string?(unified_agent_configuration_id)

      path = '/unifiedAgentConfigurations/{unifiedAgentConfigurationId}'.sub('{unifiedAgentConfigurationId}', unified_agent_configuration_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_unified_agent_configuration') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::UnifiedAgentConfiguration'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Gets the details of the work request with the given ID.
    # @param [String] work_request_id The asynchronous request ID.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::WorkRequest WorkRequest}
    def get_work_request(work_request_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#get_work_request.' if logger

      raise "Missing the required parameter 'work_request_id' when calling get_work_request." if work_request_id.nil?
      raise "Parameter value for 'work_request_id' must not be blank" if OCI::Internal::Util.blank_string?(work_request_id)

      path = '/workRequests/{workRequestId}'.sub('{workRequestId}', work_request_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#get_work_request') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::WorkRequest'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists all non-default log groups.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::LogGroup LogGroup}>
    def list_all_log_groups(opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_all_log_groups.' if logger


      path = '/bulkLogGroups'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_all_log_groups') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::LogGroup>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists all known log objects.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :log_id OCID of a log object to work with.
    # @option opts [String] :source_service Service that created the log object, which is a field of LogSummary.Configuration.Source.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::Log Log}>
    def list_all_logs(opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_all_logs.' if logger


      path = '/bulkLogs'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:logId] = opts[:log_id] if opts[:log_id]
      query_params[:sourceService] = opts[:source_service] if opts[:source_service]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_all_logs') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::Log>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # List continuous queries.
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :severity Severity of the continuous query.
    # @option opts [String] :frequency Frequency in minutes.
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :lifecycle_state Lifecycle state of the Continuous Query
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only) for continuous queries. Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName, severity, frequency, lifecycleState
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ContinuousQuerySummaryCollection ContinuousQuerySummaryCollection}
    def list_continuous_query(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_continuous_query.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_continuous_query." if compartment_id.nil?

      if opts[:severity] && !OCI::HydraControlplaneClient::Models::ContinuousQuery::SEVERITY_ENUM.include?(opts[:severity])
        raise 'Invalid value for "severity", must be one of the values in OCI::HydraControlplaneClient::Models::ContinuousQuery::SEVERITY_ENUM.'
      end

      if opts[:lifecycle_state] && !OCI::HydraControlplaneClient::Models::ContinuousQuery::LIFECYCLE_STATE_ENUM.include?(opts[:lifecycle_state])
        raise 'Invalid value for "lifecycle_state", must be one of the values in OCI::HydraControlplaneClient::Models::ContinuousQuery::LIFECYCLE_STATE_ENUM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName severity frequency lifecycleState].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName, severity, frequency, lifecycleState.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/continuousQuery'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:severity] = opts[:severity] if opts[:severity]
      query_params[:frequency] = opts[:frequency] if opts[:frequency]
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:lifecycleState] = opts[:lifecycle_state] if opts[:lifecycle_state]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_continuous_query') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ContinuousQuerySummaryCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # List all the log data models in the specified compartment.
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [BOOLEAN] :is_compartment_id_in_subtree Specifies whether or not nested compartments should be traversed. Defaults to false. (default to false)
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :template Template name query parameter of the log data model object.
    # @option opts [String] :lifecycle_state Lifecycle state query parameter of the log data model object.
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogDataModelSummaryCollection LogDataModelSummaryCollection}
    def list_log_data_models(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_log_data_models.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_log_data_models." if compartment_id.nil?

      if opts[:lifecycle_state] && !OCI::HydraControlplaneClient::Models::LOG_DATA_MODEL_LIFECYCLE_STATE_ENUM.include?(opts[:lifecycle_state])
        raise 'Invalid value for "lifecycle_state", must be one of the values in OCI::HydraControlplaneClient::Models::LOG_DATA_MODEL_LIFECYCLE_STATE_ENUM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/logDataModels'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:isCompartmentIdInSubtree] = opts[:is_compartment_id_in_subtree] if !opts[:is_compartment_id_in_subtree].nil?
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:template] = opts[:template] if opts[:template]
      query_params[:lifecycleState] = opts[:lifecycle_state] if opts[:lifecycle_state]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_log_data_models') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogDataModelSummaryCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists all log groups for the specified compartment or tenancy.
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [BOOLEAN] :is_compartment_id_in_subtree Specifies whether or not nested compartments should be traversed. Defaults to false. (default to false)
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::LogGroupSummary LogGroupSummary}>
    def list_log_groups(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_log_groups.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_log_groups." if compartment_id.nil?

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/logGroups'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:isCompartmentIdInSubtree] = opts[:is_compartment_id_in_subtree] if !opts[:is_compartment_id_in_subtree].nil?
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_log_groups') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::LogGroupSummary>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # List log pipelines with specified parameters.
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :lifecycle_state Lifecycle state of the log pipeline.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogPipelineSummaryCollection LogPipelineSummaryCollection}
    def list_log_pipelines(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_log_pipelines.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_log_pipelines." if compartment_id.nil?

      if opts[:lifecycle_state] && !OCI::HydraControlplaneClient::Models::LOG_PIPELINE_LIFECYCLE_STATE_ENUM.include?(opts[:lifecycle_state])
        raise 'Invalid value for "lifecycle_state", must be one of the values in OCI::HydraControlplaneClient::Models::LOG_PIPELINE_LIFECYCLE_STATE_ENUM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/logPipelines'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:lifecycleState] = opts[:lifecycle_state] if opts[:lifecycle_state]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_log_pipelines') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogPipelineSummaryCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # List log rules with specified parameters.
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :severity Severity of the log rule.
    # @option opts [String] :frequency Frequency in minutes.
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :lifecycle_state Lifecycle state of the log rule.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only) for log rules. Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName, severity, frequency, lifecycleState
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogRuleSummaryCollection LogRuleSummaryCollection}
    def list_log_rules(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_log_rules.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_log_rules." if compartment_id.nil?

      if opts[:severity] && !OCI::HydraControlplaneClient::Models::LogRule::SEVERITY_ENUM.include?(opts[:severity])
        raise 'Invalid value for "severity", must be one of the values in OCI::HydraControlplaneClient::Models::LogRule::SEVERITY_ENUM.'
      end

      if opts[:lifecycle_state] && !OCI::HydraControlplaneClient::Models::LogRule::LIFECYCLE_STATE_ENUM.include?(opts[:lifecycle_state])
        raise 'Invalid value for "lifecycle_state", must be one of the values in OCI::HydraControlplaneClient::Models::LogRule::LIFECYCLE_STATE_ENUM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName severity frequency lifecycleState].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName, severity, frequency, lifecycleState.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/logRules'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:severity] = opts[:severity] if opts[:severity]
      query_params[:frequency] = opts[:frequency] if opts[:frequency]
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:lifecycleState] = opts[:lifecycle_state] if opts[:lifecycle_state]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_log_rules') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogRuleSummaryCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists LogSavedSearches for this compartment.
    # 
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :log_saved_search_id OCID of the LogSavedSearch.
    #   
    # @option opts [String] :name Resource name.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogSavedSearchSummaryCollection LogSavedSearchSummaryCollection}
    def list_log_saved_searches(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_log_saved_searches.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_log_saved_searches." if compartment_id.nil?

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/logSavedSearches'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:logSavedSearchId] = opts[:log_saved_search_id] if opts[:log_saved_search_id]
      query_params[:name] = opts[:name] if opts[:name]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_log_saved_searches') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogSavedSearchSummaryCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists the specified log group's log objects.
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :log_type The logType that the log object is for, whether custom or service.
    #   Allowed values are: CUSTOM, SERVICE, SIEM
    # @option opts [String] :source_service Service that created the log object, which is a field of LogSummary.Configuration.Source.
    # @option opts [String] :source_resource Log object resource, which is a field of LogSummary.Configuration.Source.
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :lifecycle_state Lifecycle state of the log object
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::LogSummary LogSummary}>
    def list_logs(log_group_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_logs.' if logger

      raise "Missing the required parameter 'log_group_id' when calling list_logs." if log_group_id.nil?

      if opts[:log_type] && !%w[CUSTOM SERVICE SIEM].include?(opts[:log_type])
        raise 'Invalid value for "log_type", must be one of CUSTOM, SERVICE, SIEM.'
      end

      if opts[:lifecycle_state] && !OCI::HydraControlplaneClient::Models::LOG_LIFECYCLE_STATE_ENUM.include?(opts[:lifecycle_state])
        raise 'Invalid value for "lifecycle_state", must be one of the values in OCI::HydraControlplaneClient::Models::LOG_LIFECYCLE_STATE_ENUM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)

      path = '/logGroups/{logGroupId}/logs'.sub('{logGroupId}', log_group_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:logType] = opts[:log_type] if opts[:log_type]
      query_params[:sourceService] = opts[:source_service] if opts[:source_service]
      query_params[:sourceResource] = opts[:source_resource] if opts[:source_resource]
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:lifecycleState] = opts[:lifecycle_state] if opts[:lifecycle_state]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_logs') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::LogSummary>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # List managed continuous queries.
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :severity Severity of the managed continuous query
    # @option opts [String] :frequency Frequency in minutes.
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :lifecycle_state Lifecycle state of the managed continuous query
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only) for continuous queries. Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName, severity, frequency, lifecycleState
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ManagedContinuousQuerySummaryCollection ManagedContinuousQuerySummaryCollection}
    def list_managed_continuous_query(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_managed_continuous_query.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_managed_continuous_query." if compartment_id.nil?

      if opts[:severity] && !OCI::HydraControlplaneClient::Models::ManagedContinuousQuery::SEVERITY_ENUM.include?(opts[:severity])
        raise 'Invalid value for "severity", must be one of the values in OCI::HydraControlplaneClient::Models::ManagedContinuousQuery::SEVERITY_ENUM.'
      end

      if opts[:lifecycle_state] && !OCI::HydraControlplaneClient::Models::ManagedContinuousQuery::LIFECYCLE_STATE_ENUM.include?(opts[:lifecycle_state])
        raise 'Invalid value for "lifecycle_state", must be one of the values in OCI::HydraControlplaneClient::Models::ManagedContinuousQuery::LIFECYCLE_STATE_ENUM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName severity frequency lifecycleState].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName, severity, frequency, lifecycleState.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/managedContinuousQuery'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:severity] = opts[:severity] if opts[:severity]
      query_params[:frequency] = opts[:frequency] if opts[:frequency]
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:lifecycleState] = opts[:lifecycle_state] if opts[:lifecycle_state]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_managed_continuous_query') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ManagedContinuousQuerySummaryCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists all categories registered under specific service registry.
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :resource_type Resource Type to filter categories with.
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::ServiceCategorySummary ServiceCategorySummary}>
    def list_service_categories(service_registry_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_service_categories.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling list_service_categories." if service_registry_id.nil?

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)

      path = '/serviceregistries/{serviceRegistryId}/categories'.sub('{serviceRegistryId}', service_registry_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:resourceType] = opts[:resource_type] if opts[:resource_type]
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_service_categories') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::ServiceCategorySummary>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists all services registered under specific compartment.
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [BOOLEAN] :is_compartment_id_in_subtree Specifies whether or not nested compartments should be traversed. Defaults to false. (default to false)
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ServiceRegistryCollection ServiceRegistryCollection}
    def list_service_registries(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_service_registries.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_service_registries." if compartment_id.nil?

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/serviceregistries'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:isCompartmentIdInSubtree] = opts[:is_compartment_id_in_subtree] if !opts[:is_compartment_id_in_subtree].nil?
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_service_registries') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ServiceRegistryCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists all services that support logging.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :service_stage Service stage of a service. The allowed values are \"ProductionStage\", \"DevStage\" and \"LAStage\".
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::ServiceSummary ServiceSummary}>
    def list_services(opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_services.' if logger


      path = '/v2/registry/services'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:serviceStage] = opts[:service_stage] if opts[:service_stage]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_services') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::ServiceSummary>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists all unified agent configurations in the specified compartment.
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :log_id Custom log OCID to list resources with the log as destination.
    #   
    # @option opts [BOOLEAN] :is_compartment_id_in_subtree Specifies whether or not nested compartments should be traversed. Defaults to false. (default to false)
    # @option opts [String] :group_id The OCID of a group or a dynamic group.
    # @option opts [String] :display_name Resource name.
    # @option opts [String] :lifecycle_state Lifecycle state of the log object
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::UnifiedAgentConfigurationCollection UnifiedAgentConfigurationCollection}
    def list_unified_agent_configurations(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_unified_agent_configurations.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_unified_agent_configurations." if compartment_id.nil?

      if opts[:lifecycle_state] && !OCI::HydraControlplaneClient::Models::LOG_LIFECYCLE_STATE_ENUM.include?(opts[:lifecycle_state])
        raise 'Invalid value for "lifecycle_state", must be one of the values in OCI::HydraControlplaneClient::Models::LOG_LIFECYCLE_STATE_ENUM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/unifiedAgentConfigurations'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:logId] = opts[:log_id] if opts[:log_id]
      query_params[:isCompartmentIdInSubtree] = opts[:is_compartment_id_in_subtree] if !opts[:is_compartment_id_in_subtree].nil?
      query_params[:groupId] = opts[:group_id] if opts[:group_id]
      query_params[:displayName] = opts[:display_name] if opts[:display_name]
      query_params[:lifecycleState] = opts[:lifecycle_state] if opts[:lifecycle_state]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_unified_agent_configurations') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::UnifiedAgentConfigurationCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Return a list of errors for a given work request.
    # 
    # @param [String] work_request_id The asynchronous request ID.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::WorkRequestError WorkRequestError}>
    def list_work_request_errors(work_request_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_work_request_errors.' if logger

      raise "Missing the required parameter 'work_request_id' when calling list_work_request_errors." if work_request_id.nil?
      raise "Parameter value for 'work_request_id' must not be blank" if OCI::Internal::Util.blank_string?(work_request_id)

      path = '/workRequests/{workRequestId}/errors'.sub('{workRequestId}', work_request_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_work_request_errors') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::WorkRequestError>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Return a list of logs for a given work request.
    # 
    # @param [String] work_request_id The asynchronous request ID.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::WorkRequestLog WorkRequestLog}>
    def list_work_request_logs(work_request_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_work_request_logs.' if logger

      raise "Missing the required parameter 'work_request_id' when calling list_work_request_logs." if work_request_id.nil?
      raise "Parameter value for 'work_request_id' must not be blank" if OCI::Internal::Util.blank_string?(work_request_id)

      path = '/workRequests/{workRequestId}/logs'.sub('{workRequestId}', work_request_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_work_request_logs') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::WorkRequestLog>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists the work requests in a compartment.
    # 
    # @param [String] compartment_id Compartment OCID to list resources in. See compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :status Filter results by work request status.
    # @option opts [String] :id <b>Filter</b> results by [OCID]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/identifiers.htm). Must be an OCID of the correct type for the resource type.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :sort_by Specifies the field to sort by. Accepts only one field. By default, when you sort by time fields, results are shown in descending order. All other fields default to ascending order.
    #   
    #   Allowed values are: operationType, status, timeAccepted
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::WorkRequestSummary WorkRequestSummary}>
    def list_work_requests(compartment_id, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#list_work_requests.' if logger

      raise "Missing the required parameter 'compartment_id' when calling list_work_requests." if compartment_id.nil?

      if opts[:status] && !OCI::HydraControlplaneClient::Models::OPERATION_STATUS_ENUM.include?(opts[:status])
        raise 'Invalid value for "status", must be one of the values in OCI::HydraControlplaneClient::Models::OPERATION_STATUS_ENUM.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      if opts[:sort_by] && !%w[operationType status timeAccepted].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of operationType, status, timeAccepted.'
      end

      path = '/workRequests'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = compartment_id
      query_params[:status] = opts[:status] if opts[:status]
      query_params[:id] = opts[:id] if opts[:id]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#list_work_requests') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::WorkRequestSummary>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Gets the object with either id or pair of parentId and name.
    # @param [String] id Either id or pair of parentId and name of the object missed in the primary object-storage-file-based cache.
    # @param [String] version Version of the object missed in the primary object-storage-file-based cache.
    # @param [String] service Partner service requesting cache data.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :name Name of the object missed in the primary object-storage-file-based cache.
    # @option opts [String] :type Type of the object missed in the primary object-storage-file-based cache.
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ReplicationEvent ReplicationEvent}
    def replication_object_missed(id, version, service, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#replication_object_missed.' if logger

      raise "Missing the required parameter 'id' when calling replication_object_missed." if id.nil?
      raise "Missing the required parameter 'version' when calling replication_object_missed." if version.nil?
      raise "Missing the required parameter 'service' when calling replication_object_missed." if service.nil?

      path = '/replicationObjectMissed'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:id] = id
      query_params[:version] = version
      query_params[:service] = service
      query_params[:name] = opts[:name] if opts[:name]
      query_params[:type] = opts[:type] if opts[:type]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#replication_object_missed') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ReplicationEvent'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists the next set of replication events.
    # @param [Integer] replication_event_id The event id from which to get more events.
    # @param [String] version Version of the object missed in the primary object-storage-file-based cache.
    # @param [String] service Partner service requesting cache data.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ReplicationEventCollection ReplicationEventCollection}
    def replication_queue(replication_event_id, version, service, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#replication_queue.' if logger

      raise "Missing the required parameter 'replication_event_id' when calling replication_queue." if replication_event_id.nil?
      raise "Missing the required parameter 'version' when calling replication_queue." if version.nil?
      raise "Missing the required parameter 'service' when calling replication_queue." if service.nil?

      path = '/replicationQueue'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:replicationEventId] = replication_event_id
      query_params[:version] = version
      query_params[:service] = service
      query_params[:limit] = opts[:limit] if opts[:limit]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#replication_queue') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ReplicationEventCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Lists the specified log objects.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :compartment_id Compartment OCID to list resources in. Please see compartmentIdInSubtree
    #        for nested compartments traversal.
    #   
    # @option opts [String] :log_id Custom log OCID to list resources with the log as destination.
    #   
    # @option opts [String] :log_type The logType that the log object is for, whether custom or service.
    #   Allowed values are: CUSTOM, SERVICE, SIEM
    # @option opts [String] :source_service Service that created the log object, which is a field of LogSummary.Configuration.Source.
    # @option opts [String] :source_resource Log object resource, which is a field of LogSummary.Configuration.Source.
    # @option opts [String] :page For list pagination. The value of the `opc-next-page` or `opc-previous-page` response header from the previous \"List\" call.
    #   For important details about how pagination works, see [List Pagination]({{DOC_SERVER_URL}}/iaas/Content/API/Concepts/usingapi.htm#nine).
    #   
    # @option opts [Integer] :limit The maximum number of items to return in a paginated \"List\" call.
    #    (default to 100)
    # @option opts [String] :sort_by The field to sort by (one column only). Default sort order is
    #   ascending exception of `timeCreated` and `timeLastModified` columns (descending).
    #   
    #   Allowed values are: timeCreated, displayName
    # @option opts [String] :sort_order The sort order to use, whether 'asc' or 'desc'.
    #   
    #   Allowed values are: ASC, DESC
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type Array<{OCI::HydraControlplaneClient::Models::LogSummary LogSummary}>
    def search_logs(opts = {})
      logger.debug 'Calling operation LoggingManagementClient#search_logs.' if logger


      if opts[:log_type] && !%w[CUSTOM SERVICE SIEM].include?(opts[:log_type])
        raise 'Invalid value for "log_type", must be one of CUSTOM, SERVICE, SIEM.'
      end

      if opts[:sort_by] && !%w[timeCreated displayName].include?(opts[:sort_by])
        raise 'Invalid value for "sort_by", must be one of timeCreated, displayName.'
      end

      if opts[:sort_order] && !%w[ASC DESC].include?(opts[:sort_order])
        raise 'Invalid value for "sort_order", must be one of ASC, DESC.'
      end

      path = '/searchLogs'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:compartmentId] = opts[:compartment_id] if opts[:compartment_id]
      query_params[:logId] = opts[:log_id] if opts[:log_id]
      query_params[:logType] = opts[:log_type] if opts[:log_type]
      query_params[:sourceService] = opts[:source_service] if opts[:source_service]
      query_params[:sourceResource] = opts[:source_resource] if opts[:source_resource]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:sortBy] = opts[:sort_by] if opts[:sort_by]
      query_params[:sortOrder] = opts[:sort_order] if opts[:sort_order]

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#search_logs') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'Array<OCI::HydraControlplaneClient::Models::LogSummary>'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Updates the query engine service.
    # @param [String] continuous_query_id The OCID of the continuous query.
    # @param [OCI::HydraControlplaneClient::Models::UpdateContinuousQueryDetails] update_continuous_query_details Continuous Query creation object.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def update_continuous_query(continuous_query_id, update_continuous_query_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_continuous_query.' if logger

      raise "Missing the required parameter 'continuous_query_id' when calling update_continuous_query." if continuous_query_id.nil?
      raise "Missing the required parameter 'update_continuous_query_details' when calling update_continuous_query." if update_continuous_query_details.nil?
      raise "Parameter value for 'continuous_query_id' must not be blank" if OCI::Internal::Util.blank_string?(continuous_query_id)

      path = '/continuousQuery/{continuousQueryId}'.sub('{continuousQueryId}', continuous_query_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_continuous_query_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_continuous_query') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Updates the existing log object with the associated configuration. This call
    #       fails if the log object does not exist.
    # 
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [String] log_id OCID of a log to work with.
    # @param [OCI::HydraControlplaneClient::Models::UpdateLogDetails] update_log_details Log config parameters to update.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def update_log(log_group_id, log_id, update_log_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_log.' if logger

      raise "Missing the required parameter 'log_group_id' when calling update_log." if log_group_id.nil?
      raise "Missing the required parameter 'log_id' when calling update_log." if log_id.nil?
      raise "Missing the required parameter 'update_log_details' when calling update_log." if update_log_details.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)
      raise "Parameter value for 'log_id' must not be blank" if OCI::Internal::Util.blank_string?(log_id)

      path = '/logGroups/{logGroupId}/logs/{logId}'.sub('{logGroupId}', log_group_id.to_s).sub('{logId}', log_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_log_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_log') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Update the existing log data model.
    # @param [String] log_data_model_id The OCID of the log data model object.
    # @param [OCI::HydraControlplaneClient::Models::UpdateLogDataModelDetails] update_log_data_model_details Log data model UPDATE request details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def update_log_data_model(log_data_model_id, update_log_data_model_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_log_data_model.' if logger

      raise "Missing the required parameter 'log_data_model_id' when calling update_log_data_model." if log_data_model_id.nil?
      raise "Missing the required parameter 'update_log_data_model_details' when calling update_log_data_model." if update_log_data_model_details.nil?
      raise "Parameter value for 'log_data_model_id' must not be blank" if OCI::Internal::Util.blank_string?(log_data_model_id)

      path = '/logDataModels/{logDataModelId}'.sub('{logDataModelId}', log_data_model_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_log_data_model_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_log_data_model') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Updates the existing log group with the associated configuration. This call
    #       fails if the log group does not exist.
    # 
    # @param [String] log_group_id OCID of a log group to work with.
    # @param [OCI::HydraControlplaneClient::Models::UpdateLogGroupDetails] update_log_group_details LogGroup config parameters to update.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def update_log_group(log_group_id, update_log_group_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_log_group.' if logger

      raise "Missing the required parameter 'log_group_id' when calling update_log_group." if log_group_id.nil?
      raise "Missing the required parameter 'update_log_group_details' when calling update_log_group." if update_log_group_details.nil?
      raise "Parameter value for 'log_group_id' must not be blank" if OCI::Internal::Util.blank_string?(log_group_id)

      path = '/logGroups/{logGroupId}'.sub('{logGroupId}', log_group_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_log_group_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_log_group') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Updates the log pipeline resource.
    # @param [String] log_pipeline_id The OCID of the log pipeline.
    # @param [OCI::HydraControlplaneClient::Models::UpdateLogPipelineDetails] update_log_pipeline_details Log pipeline UPDATE request details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def update_log_pipeline(log_pipeline_id, update_log_pipeline_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_log_pipeline.' if logger

      raise "Missing the required parameter 'log_pipeline_id' when calling update_log_pipeline." if log_pipeline_id.nil?
      raise "Missing the required parameter 'update_log_pipeline_details' when calling update_log_pipeline." if update_log_pipeline_details.nil?
      raise "Parameter value for 'log_pipeline_id' must not be blank" if OCI::Internal::Util.blank_string?(log_pipeline_id)

      path = '/logPipelines/{logPipelineId}'.sub('{logPipelineId}', log_pipeline_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_log_pipeline_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_log_pipeline') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Updates the log rule resource.
    # @param [String] log_rule_id The OCID of the log rule.
    # @param [OCI::HydraControlplaneClient::Models::UpdateLogRuleDetails] update_log_rule_details Log rule UPDATE request details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def update_log_rule(log_rule_id, update_log_rule_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_log_rule.' if logger

      raise "Missing the required parameter 'log_rule_id' when calling update_log_rule." if log_rule_id.nil?
      raise "Missing the required parameter 'update_log_rule_details' when calling update_log_rule." if update_log_rule_details.nil?
      raise "Parameter value for 'log_rule_id' must not be blank" if OCI::Internal::Util.blank_string?(log_rule_id)

      path = '/logRules/{logRuleId}'.sub('{logRuleId}', log_rule_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_log_rule_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_log_rule') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Updates an  existing LogSavedSearch.
    # 
    # @param [String] log_saved_search_id OCID of the logSavedSearch.
    #   
    # @param [OCI::HydraControlplaneClient::Models::UpdateLogSavedSearchDetails] update_log_saved_search_details Updates to the saved search.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogSavedSearch LogSavedSearch}
    def update_log_saved_search(log_saved_search_id, update_log_saved_search_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_log_saved_search.' if logger

      raise "Missing the required parameter 'log_saved_search_id' when calling update_log_saved_search." if log_saved_search_id.nil?
      raise "Missing the required parameter 'update_log_saved_search_details' when calling update_log_saved_search." if update_log_saved_search_details.nil?
      raise "Parameter value for 'log_saved_search_id' must not be blank" if OCI::Internal::Util.blank_string?(log_saved_search_id)

      path = '/logSavedSearches/{logSavedSearchId}'.sub('{logSavedSearchId}', log_saved_search_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_log_saved_search_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_log_saved_search') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogSavedSearch'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Update the managed continuous query engine service.
    # @param [String] continuous_query_id The OCID of the continuous query.
    # @param [OCI::HydraControlplaneClient::Models::UpdateManagedContinuousQueryDetails] update_managed_continuous_query_details Managed Continuous Query update object.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def update_managed_continuous_query(continuous_query_id, update_managed_continuous_query_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_managed_continuous_query.' if logger

      raise "Missing the required parameter 'continuous_query_id' when calling update_managed_continuous_query." if continuous_query_id.nil?
      raise "Missing the required parameter 'update_managed_continuous_query_details' when calling update_managed_continuous_query." if update_managed_continuous_query_details.nil?
      raise "Parameter value for 'continuous_query_id' must not be blank" if OCI::Internal::Util.blank_string?(continuous_query_id)

      path = '/managedContinuousQuery/{continuousQueryId}'.sub('{continuousQueryId}', continuous_query_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_managed_continuous_query_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_managed_continuous_query') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Update existing service logging category. This call will fail if service category with given name does not exist in corresponding service registry.
    # 
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [String] category_id The OCID of the Service Category entry.
    # @param [OCI::HydraControlplaneClient::Models::UpdateServiceCategoryDetails] update_service_category_details ServiceCategory parameters to be updated.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ServiceCategory ServiceCategory}
    def update_service_category(service_registry_id, category_id, update_service_category_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_service_category.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling update_service_category." if service_registry_id.nil?
      raise "Missing the required parameter 'category_id' when calling update_service_category." if category_id.nil?
      raise "Missing the required parameter 'update_service_category_details' when calling update_service_category." if update_service_category_details.nil?
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)
      raise "Parameter value for 'category_id' must not be blank" if OCI::Internal::Util.blank_string?(category_id)

      path = '/serviceregistries/{serviceRegistryId}/categories/{categoryId}'.sub('{serviceRegistryId}', service_registry_id.to_s).sub('{categoryId}', category_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_service_category_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_service_category') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ServiceCategory'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Updates the existing service registry configuretion. This call will fail if the service registry entity does not exist.
    # 
    # @param [String] service_registry_id The OCID of the Service registry entry.
    # @param [OCI::HydraControlplaneClient::Models::UpdateServiceRegistryDetails] update_service_registry_details ServiceRegistry parameters to be updated.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::ServiceRegistry ServiceRegistry}
    def update_service_registry(service_registry_id, update_service_registry_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_service_registry.' if logger

      raise "Missing the required parameter 'service_registry_id' when calling update_service_registry." if service_registry_id.nil?
      raise "Missing the required parameter 'update_service_registry_details' when calling update_service_registry." if update_service_registry_details.nil?
      raise "Parameter value for 'service_registry_id' must not be blank" if OCI::Internal::Util.blank_string?(service_registry_id)

      path = '/serviceregistries/{serviceRegistryId}'.sub('{serviceRegistryId}', service_registry_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_service_registry_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_service_registry') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::ServiceRegistry'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Update an existing unified agent configuration. This call
    #       fails if the log group does not exist.
    # 
    # @param [String] unified_agent_configuration_id The OCID of the Unified Agent configuration.
    # @param [OCI::HydraControlplaneClient::Models::UpdateUnifiedAgentConfigurationDetails] update_unified_agent_configuration_details Unified agent configuration to update. Empty group associations list doesn't modify the list, null value for group association clears all the previous associations.
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :if_match For optimistic concurrency control. In the PUT or DELETE call for a
    #   resource, set the `if-match` parameter to the value of the etag from a
    #   previous GET or POST response for that resource. The resource will be
    #   updated or deleted only if the etag you provide matches the resource's
    #   current etag value.
    #   
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def update_unified_agent_configuration(unified_agent_configuration_id, update_unified_agent_configuration_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#update_unified_agent_configuration.' if logger

      raise "Missing the required parameter 'unified_agent_configuration_id' when calling update_unified_agent_configuration." if unified_agent_configuration_id.nil?
      raise "Missing the required parameter 'update_unified_agent_configuration_details' when calling update_unified_agent_configuration." if update_unified_agent_configuration_details.nil?
      raise "Parameter value for 'unified_agent_configuration_id' must not be blank" if OCI::Internal::Util.blank_string?(unified_agent_configuration_id)

      path = '/unifiedAgentConfigurations/{unifiedAgentConfigurationId}'.sub('{unifiedAgentConfigurationId}', unified_agent_configuration_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'if-match'] = opts[:if_match] if opts[:if_match]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_unified_agent_configuration_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#update_unified_agent_configuration') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Validate the log data mapping rules
    # @param [OCI::HydraControlplaneClient::Models::ValidateLogDataMappingRuleCollectionDetails] validate_log_data_mapping_rule_collection_details Log data mapping rule collection details.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraControlplaneClient::Models::LogDataMappingRuleValidityCollection LogDataMappingRuleValidityCollection}
    def validate_log_data_mapping_rules(validate_log_data_mapping_rule_collection_details, opts = {})
      logger.debug 'Calling operation LoggingManagementClient#validate_log_data_mapping_rules.' if logger

      raise "Missing the required parameter 'validate_log_data_mapping_rule_collection_details' when calling validate_log_data_mapping_rules." if validate_log_data_mapping_rule_collection_details.nil?

      path = '/logDataModels/actions/validateLogDataMappingRules'
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(validate_log_data_mapping_rule_collection_details)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'LoggingManagementClient#validate_log_data_mapping_rules') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraControlplaneClient::Models::LogDataMappingRuleValidityCollection'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines

    private

    def applicable_retry_config(opts = {})
      return @retry_config unless opts.key?(:retry_config)

      opts[:retry_config]
    end
  end
end
# rubocop:enable Lint/UnneededCopDisableDirective, Metrics/LineLength
