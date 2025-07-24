# Copyright (c) 2016, 2022, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

require 'uri'
require 'logger'

require_relative 'cookies_support'

module DM
  # Use the Logging Ingestion API to ingest your application logs.
  class DMLoggingingestion::DMLoggingClient
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

    # Creates a new LoggingClient.
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
      raise "Either endpoint or region must be set" if region.nil? && endpoint.nil?
      api_config = OCI::Config.validate_and_build_config_with_signer(config, signer)

      signer = OCI::Signer.config_file_auth_builder(api_config) if signer.nil?

      @api_client = OCI::ApiClient.new(api_config, signer, proxy_settings: proxy_settings)

      DM.logger = logger

      @cookie_handler = DM::CookieHandler.new()
      api_version = DM::DMLoggingingestion::Version::CURRENT
      @retry_config = retry_config

      base_endpoint = endpoint if endpoint
      base_endpoint = DM::DMLoggingingestion::Endpoint.get_endpoint(region) if endpoint.nil? && region
      @endpoint = base_endpoint + "/#{api_version}"

      logger.info "DMLoggingClient endpoint set to '#{@endpoint}'." if logger
    end

    # @return [Logger] The logger for this client. May be nil.
    def logger
      @api_client.config.logger
    end

    # This API allows ingesting logs associated with a logId. A success
    # response implies the data has been accepted.
    #
    # @param [String] log_id OCID of a log to work with.
    # @param [DM::DMLoggingingestion::Models::PostLogBatches] post_logs_batches The logs to emit.
    # @param [DM::DMLoggingingestion::Models::LogOrigin] origin The logs origin metadata.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [DateTime] :timestamp_opc_agent_processing Effective timestamp, for when the agent started processing the log
    #   segment being sent. An RFC3339-formatted date-time string with milliseconds precision.
    #
    # @option opts [String] :opc_agent_version Version of the agent sending the request.
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about
    #   a particular request, please provide the request ID.
    #
    # @return [Response] A Response object with data of type nil
    def post_logs(log_id, batches, origin, opts = {})
      logger.debug 'Calling operation DMLoggingClient#post_logs.' if logger

      raise "Missing the required parameter 'log_id' when calling post_logs." if log_id.nil?
      raise "Missing the required parameter 'batches' when calling post_logs." if batches.nil?
      raise "Parameter value for 'log_id' must not be blank" if OCI::Internal::Util.blank_string?(log_id)

      path = "/logs/#{log_id.to_s}"
      operation_signing_strategy = :standard

      request = post_log_batches_request(origin, batches)

      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'timestamp-opc-agent-processing'] = opts[:timestamp_opc_agent_processing] if opts[:timestamp_opc_agent_processing]
      header_params[:'opc-agent-version'] = opts[:opc_agent_version] if opts[:opc_agent_version]
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]

      header_params[:'cookie'] = @cookie_handler.current if @cookie_handler.current

      post_body = @api_client.object_to_http_body(request)

      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'DMLoggingClient#post_logs') do
        resp = @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body
        )

        @cookie_handler.extract(resp.headers['set-cookie'])
        resp
      end
    end

    ##
    # Build the wrapper for all the log entries to be sent to DM
    #
    # @return [DM::DMLoggingIngestion::Models::PostLogBatches] PostLogBatches wrapper to be filled with log entries
    def post_log_batches_request(origin, batches)
      request = DM::DMLoggingingestion::Models::PostLogBatches.new
      request.origin = origin
      request.batches = batches
      request
    end

    private

    def applicable_retry_config(opts = {})
      return @retry_config unless opts.key?(:retry_config)

      opts[:retry_config]
    end
  end
end
