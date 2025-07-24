# Copyright (c) 2016, 2022, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

require 'uri'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # A description of the HydraPikaFrontend API
  class HydraPikaClient::HydraPikaFrontendClient
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

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity


    # Creates a new HydraPikaFrontendClient.
    # Notes:
    #   If a config is not specified, then the global OCI.config will be used.
    #
    #   This client is not thread-safe
    # @param [Config] config A Config object. 
    # @param [String] endpoint The fully qualified endpoint URL
    # @param [OCI::BaseSigner] signer A signer implementation which can be used by this client. If this is not provided then
    #   a signer will be constructed via the provided config. One use case of this parameter is instance principals authentication,
    #   so that the instance principals signer can be provided to the client
    # @param [OCI::ApiClientProxySettings] proxy_settings If your environment requires you to use a proxy server for outgoing HTTP requests
    #   the details for the proxy can be provided in this parameter
    # @param [OCI::Retry::RetryConfig] retry_config The retry configuration for this service client. This represents the default retry configuration to
    #   apply across all operations. This can be overridden on a per-operation basis. The default retry configuration value is `nil`, which means that an operation 
    #   will not perform any retries
    def initialize(config: nil, endpoint: nil, signer: nil, proxy_settings: nil, retry_config: nil)
      raise 'A fully qualified endpoint URL must be defined' unless endpoint

      @endpoint = endpoint + '/v1'

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
      logger.info "HydraPikaFrontendClient endpoint set to '#{@endpoint}'." if logger
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity

    # @return [Logger] The logger for this client. May be nil.
    def logger
      @api_client.config.logger
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Registers the definition for a log stream. It also associates the log
    # stream with a compartment, which is used for resource-based access
    # control.
    # 
    # @param [String] compartment The compartment that the log stream is associated with.
    # @param [String] namespace The namespace that the log should be under. This must be unique
    #   within a compartment.
    #   
    # @param [OCI::HydraPikaClient::Models::AddLogStreamDefinitionRequestBody] add_log_stream_definition_request_body Additional identifiers and definitions to associate with the log
    #   stream
    #   
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [Integer] :retry_count Retry count value we use to emit a
    #   metric to identify a retry request
    #   value > 0 : retry request
    #   value = 0 : initial request
    #   
    # @option opts [String] :computed_content_sha256 It contains body content-sha256. If it is not specified the body
    #   verification is skipped by the server.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraPikaClient::Models::AddLogStreamDefinitionResponseBody AddLogStreamDefinitionResponseBody}
    def add_log_stream_definition(compartment, namespace, add_log_stream_definition_request_body, opts = {})
      logger.debug 'Calling operation HydraPikaFrontendClient#add_log_stream_definition.' if logger

      raise "Missing the required parameter 'compartment' when calling add_log_stream_definition." if compartment.nil?
      raise "Missing the required parameter 'namespace' when calling add_log_stream_definition." if namespace.nil?
      raise "Missing the required parameter 'add_log_stream_definition_request_body' when calling add_log_stream_definition." if add_log_stream_definition_request_body.nil?
      raise "Parameter value for 'compartment' must not be blank" if OCI::Internal::Util.blank_string?(compartment)
      raise "Parameter value for 'namespace' must not be blank" if OCI::Internal::Util.blank_string?(namespace)

      path = '/definition/c/{compartment}/ns/{namespace}'.sub('{compartment}', compartment.to_s).sub('{namespace}', namespace.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:retrycount] = opts[:retry_count] if opts[:retry_count]
      header_params[:'computed-content-sha256'] = opts[:computed_content_sha256] if opts[:computed_content_sha256]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(add_log_stream_definition_request_body)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'HydraPikaFrontendClient#add_log_stream_definition') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraPikaClient::Models::AddLogStreamDefinitionResponseBody'
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


    # Emits logs for a log stream.
    # @param [String] lsid The ID of the log stream.
    # @param [OCI::HydraPikaClient::Models::AddLogsRequestBody] add_logs_request_body The logs to emit.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :computed_content_sha256 It contains body content-sha256. If it is not specified the body
    #   verification is skipped by the server.
    #   
    # @option opts [Integer] :opc_agent_processing_ts Effective timestamp, in milliseconds since epoch, for when the
    #   agent started processing the log segment being sent.
    #   
    # @option opts [String] :opc_agent_version Version of the agent sending the request.
    # @option opts [String] :opc_log_filename Name of the log file for which the content for this request was
    #   extracted.
    #   
    # @option opts [String] :opc_log_ingestion_method Method for which this log is ingested (for metrics emission
    #   purposes only). Can be one of \"bulk\" or \"streaming\"
    #   
    # @option opts [Integer] :retry_count Retry count value we use to emit a
    #   metric to identify a retry request
    #   value > 0 : retry request
    #   value = 0 : initial request
    #   
    # @option opts [String] :opc_specversion unified schema spec version.
    #   Presence of this header means that Logs are in Unified Schema.
    #   
    # @option opts [String] :opc_datacontenttype unified schema data content type.
    #   can only be provided if `opc-specversion` is provided.
    #   
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type nil
    def add_logs(lsid, add_logs_request_body, opts = {})
      logger.debug 'Calling operation HydraPikaFrontendClient#add_logs.' if logger

      raise "Missing the required parameter 'lsid' when calling add_logs." if lsid.nil?
      raise "Missing the required parameter 'add_logs_request_body' when calling add_logs." if add_logs_request_body.nil?
      raise "Parameter value for 'lsid' must not be blank" if OCI::Internal::Util.blank_string?(lsid)

      path = '/log/lsid/{lsid}'.sub('{lsid}', lsid.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'computed-content-sha256'] = opts[:computed_content_sha256] if opts[:computed_content_sha256]
      header_params[:'opc-agent-processing-ts'] = opts[:opc_agent_processing_ts] if opts[:opc_agent_processing_ts]
      header_params[:'opc-agent-version'] = opts[:opc_agent_version] if opts[:opc_agent_version]
      header_params[:'opc-log-filename'] = opts[:opc_log_filename] if opts[:opc_log_filename]
      header_params[:'opc-log-ingestion-method'] = opts[:opc_log_ingestion_method] if opts[:opc_log_ingestion_method]
      header_params[:retrycount] = opts[:retry_count] if opts[:retry_count]
      header_params[:'opc-specversion'] = opts[:opc_specversion] if opts[:opc_specversion]
      header_params[:'opc-datacontenttype'] = opts[:opc_datacontenttype] if opts[:opc_datacontenttype]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(add_logs_request_body)
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'HydraPikaFrontendClient#add_logs') do
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
    # rubocop:disable Lint/UnusedMethodArgument


    # Retrieves the definition for a log stream.
    # @param [String] lsid The ID of the log stream.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [Hash] :additional_headers A hash containing additional header parameters to include in the request.
    #   Note that any standard header attributes that are set by the client will overwrite any attributes specified in this hash
    # @return [Response] A Response object with data of type {OCI::HydraPikaClient::Models::GetLogStreamDefinitionResponseBody GetLogStreamDefinitionResponseBody}
    def get_log_stream_definition(lsid, opts = {})
      logger.debug 'Calling operation HydraPikaFrontendClient#get_log_stream_definition.' if logger

      raise "Missing the required parameter 'lsid' when calling get_log_stream_definition." if lsid.nil?
      raise "Parameter value for 'lsid' must not be blank" if OCI::Internal::Util.blank_string?(lsid)

      path = '/definition/lsid/{lsid}'.sub('{lsid}', lsid.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params = opts[:additional_headers].clone if opts[:additional_headers].is_a?(Hash)
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      # rubocop:enable Style/NegatedIf

      post_body = nil
      
      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'HydraPikaFrontendClient#get_log_stream_definition') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::HydraPikaClient::Models::GetLogStreamDefinitionResponseBody'
        )
      end
      # rubocop:enable Metrics/BlockLength
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:enable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:enable Metrics/MethodLength, Layout/EmptyLines
    # rubocop:enable Lint/UnusedMethodArgument

    private

    def applicable_retry_config(opts = {})
      return @retry_config unless opts.key?(:retry_config)

      opts[:retry_config]
    end
  end
end
# rubocop:enable Lint/UnneededCopDisableDirective, Metrics/LineLength
