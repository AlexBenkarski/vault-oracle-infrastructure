# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20210201

require 'uri'
require 'logger'

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # Use the Queue API to produce and consume messages, create queues, and manage related items. For more information, see [Queue](/iaas/Content/queue/overview.htm).
  class Queue::QueueClient
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


    # Creates a new QueueClient.
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
        @endpoint = endpoint + '/20210201'
      else
        region ||= config.region
        region ||= signer.region if signer.respond_to?(:region)
        self.region = region
      end
      logger.info "QueueClient endpoint set to '#{@endpoint}'." if logger
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Layout/EmptyLines, Metrics/PerceivedComplexity

    # Set the region that will be used to determine the service endpoint.
    # This will usually correspond to a value in {OCI::Regions::REGION_ENUM},
    # but may be an arbitrary string.
    def region=(new_region)
      @region = new_region

      raise 'A region must be specified.' unless @region

      @endpoint = OCI::Regions.get_service_endpoint_for_template(@region, 'https://messaging.{region}.oci.{secondLevelDomain}') + '/20210201'
      logger.info "QueueClient endpoint set to '#{@endpoint} from region #{@region}'." if logger
    end

    # @return [Logger] The logger for this client. May be nil.
    def logger
      @api_client.config.logger
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/PerceivedComplexity
    # rubocop:disable Style/IfUnlessModifier, Metrics/ParameterLists
    # rubocop:disable Metrics/MethodLength, Layout/EmptyLines


    # Deletes the message represented by the receipt from the queue.
    # You must use the [messages endpoint](https://docs.cloud.oracle.com/iaas/Content/queue/messages.htm#messages__messages-endpoint) to delete messages.
    # The messages endpoint may be different for different queues. Use {#get_queue get_queue} to find the queue's `messagesEndpoint`.
    #
    # @param [String] queue_id The unique queue identifier.
    # @param [String] message_receipt The receipt of the message retrieved from a GetMessages call.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about a particular request, please provide the request ID.
    # @return [Response] A Response object with data of type nil
    # @note Click [here](https://docs.cloud.oracle.com/en-us/iaas/tools/ruby-sdk-examples/latest/queue/delete_message.rb.html) to see an example of how to use delete_message API.
    def delete_message(queue_id, message_receipt, opts = {})
      logger.debug 'Calling operation QueueClient#delete_message.' if logger

      raise "Missing the required parameter 'queue_id' when calling delete_message." if queue_id.nil?
      raise "Missing the required parameter 'message_receipt' when calling delete_message." if message_receipt.nil?
      raise "Parameter value for 'queue_id' must not be blank" if OCI::Internal::Util.blank_string?(queue_id)
      raise "Parameter value for 'message_receipt' must not be blank" if OCI::Internal::Util.blank_string?(message_receipt)

      path = '/queues/{queueId}/messages/{messageReceipt}'.sub('{queueId}', queue_id.to_s).sub('{messageReceipt}', message_receipt.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil

      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'QueueClient#delete_message') do
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


    # Deletes multiple messages from the queue or the consumer group. Only messages from the same queue/consumer group can be deleted at once.
    # You must use the [messages endpoint](https://docs.cloud.oracle.com/iaas/Content/queue/messages.htm#messages__messages-endpoint) to delete messages.
    # The messages endpoint may be different for different queues. Use {#get_queue get_queue} to find the queue's `messagesEndpoint`.
    #
    # @param [String] queue_id The unique queue identifier.
    # @param [OCI::Queue::Models::DeleteMessagesDetails] delete_messages_details Details for the messages to delete.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about a particular request, please provide the request ID.
    # @return [Response] A Response object with data of type {OCI::Queue::Models::DeleteMessagesResult DeleteMessagesResult}
    # @note Click [here](https://docs.cloud.oracle.com/en-us/iaas/tools/ruby-sdk-examples/latest/queue/delete_messages.rb.html) to see an example of how to use delete_messages API.
    def delete_messages(queue_id, delete_messages_details, opts = {})
      logger.debug 'Calling operation QueueClient#delete_messages.' if logger

      raise "Missing the required parameter 'queue_id' when calling delete_messages." if queue_id.nil?
      raise "Missing the required parameter 'delete_messages_details' when calling delete_messages." if delete_messages_details.nil?
      raise "Parameter value for 'queue_id' must not be blank" if OCI::Internal::Util.blank_string?(queue_id)

      path = '/queues/{queueId}/messages/actions/deleteMessages'.sub('{queueId}', queue_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(delete_messages_details)

      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'QueueClient#delete_messages') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::Queue::Models::DeleteMessagesResult'
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


    # Consumes messages from the queue.
    # You must use the [messages endpoint](https://docs.cloud.oracle.com/iaas/Content/queue/messages.htm#messages__messages-endpoint) to consume messages.
    # The messages endpoint may be different for different queues. Use {#get_queue get_queue} to find the queue's `messagesEndpoint`.
    # GetMessages accepts optional channelFilter query parameter that can filter source channels of the messages.
    # When channelFilter is present, service will return available messages from the channel which ID exactly matched the filter.
    # When filter is not specified, messages will be returned from a random non-empty channel within a queue.
    #
    # @param [String] queue_id The unique queue identifier.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [Integer] :visibility_in_seconds If the `visibilityInSeconds` parameter is set, messages will be hidden for `visibilityInSeconds` seconds and won't be consumable by other consumers during that time.
    #   If it isn't set it defaults to the value set at the queue level.
    #
    #   Using a `visibilityInSeconds` value of 0 effectively acts as a peek functionality.
    #   Messages retrieved that way aren't meant to be deleted because they will most likely be delivered to another consumer as their visibility won't change, but will still increase the delivery count by one.
    #
    # @option opts [Integer] :timeout_in_seconds If the `timeoutInSeconds parameter` isn't set or it is set to a value greater than 0, the request is using the long-polling mode and will only return when a message is available for consumption (it does not wait for limit messages but still only returns at-most limit messages) or after `timeoutInSeconds` seconds (in which case it will return an empty response), whichever comes first.
    #
    #   If the parameter is set to 0, the request is using the short-polling mode and immediately returns whether messages have been retrieved or not.
    #   In same rare-cases a long-polling request could be interrupted (returned with empty response) before the end of the timeout.
    #    (default to 30)
    # @option opts [Integer] :limit The limit parameter controls how many messages is returned at-most.
    #    (default to 1)
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about a particular request, please provide the request ID.
    # @option opts [String] :channel_filter Optional parameter to filter the channels.
    # @return [Response] A Response object with data of type {OCI::Queue::Models::GetMessages GetMessages}
    # @note Click [here](https://docs.cloud.oracle.com/en-us/iaas/tools/ruby-sdk-examples/latest/queue/get_messages.rb.html) to see an example of how to use get_messages API.
    def get_messages(queue_id, opts = {})
      logger.debug 'Calling operation QueueClient#get_messages.' if logger

      raise "Missing the required parameter 'queue_id' when calling get_messages." if queue_id.nil?
      raise "Parameter value for 'queue_id' must not be blank" if OCI::Internal::Util.blank_string?(queue_id)

      path = '/queues/{queueId}/messages'.sub('{queueId}', queue_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:visibilityInSeconds] = opts[:visibility_in_seconds] if opts[:visibility_in_seconds]
      query_params[:timeoutInSeconds] = opts[:timeout_in_seconds] if opts[:timeout_in_seconds]
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:channelFilter] = opts[:channel_filter] if opts[:channel_filter]

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil

      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'QueueClient#get_messages') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::Queue::Models::GetMessages'
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


    # Gets the statistics for the queue and its dead letter queue.
    # You must use the [messages endpoint](https://docs.cloud.oracle.com/iaas/Content/queue/messages.htm#messages__messages-endpoint) to get a queue's statistics.
    # The messages endpoint may be different for different queues. Use {#get_queue get_queue} to find the queue's `messagesEndpoint`.
    #
    # @param [String] queue_id The unique queue identifier.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about a particular request, please provide the request ID.
    # @option opts [String] :channel_id Id to specify channel.
    # @return [Response] A Response object with data of type {OCI::Queue::Models::QueueStats QueueStats}
    # @note Click [here](https://docs.cloud.oracle.com/en-us/iaas/tools/ruby-sdk-examples/latest/queue/get_stats.rb.html) to see an example of how to use get_stats API.
    def get_stats(queue_id, opts = {})
      logger.debug 'Calling operation QueueClient#get_stats.' if logger

      raise "Missing the required parameter 'queue_id' when calling get_stats." if queue_id.nil?
      raise "Parameter value for 'queue_id' must not be blank" if OCI::Internal::Util.blank_string?(queue_id)

      path = '/queues/{queueId}/stats'.sub('{queueId}', queue_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:channelId] = opts[:channel_id] if opts[:channel_id]

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil

      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'QueueClient#get_stats') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::Queue::Models::QueueStats'
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


    # Gets the list of IDs of non-empty channels.
    # It will return an approximate list of IDs of non-empty channels. That information is based on the queue level statistics.
    # API supports optional channelFilter parameter which will filter the returned results according to the specified filter.
    # List of channel IDs is approximate, because statistics is refreshed once per-second, and that list represents a snapshot of the past information. API is paginated.
    #
    # @param [String] queue_id The unique queue identifier.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about a particular request, please provide the request ID.
    # @option opts [Integer] :limit For list pagination. The maximum number of results per page, or items to return in a paginated \"List\" call. For important details about how pagination works, see [List Pagination](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/usingapi.htm#nine). (default to 10)
    # @option opts [String] :page For list pagination. The value of the opc-next-page response header from the previous \"List\" call. For important details about how pagination works, see [List Pagination](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/usingapi.htm#nine).
    # @option opts [String] :channel_filter Optional parameter to filter the channels.
    # @return [Response] A Response object with data of type {OCI::Queue::Models::ChannelCollection ChannelCollection}
    # @note Click [here](https://docs.cloud.oracle.com/en-us/iaas/tools/ruby-sdk-examples/latest/queue/list_channels.rb.html) to see an example of how to use list_channels API.
    def list_channels(queue_id, opts = {})
      logger.debug 'Calling operation QueueClient#list_channels.' if logger

      raise "Missing the required parameter 'queue_id' when calling list_channels." if queue_id.nil?
      raise "Parameter value for 'queue_id' must not be blank" if OCI::Internal::Util.blank_string?(queue_id)

      path = '/queues/{queueId}/channels'.sub('{queueId}', queue_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}
      query_params[:limit] = opts[:limit] if opts[:limit]
      query_params[:page] = opts[:page] if opts[:page]
      query_params[:channelFilter] = opts[:channel_filter] if opts[:channel_filter]

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = nil

      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'QueueClient#list_channels') do
        @api_client.call_api(
          :GET,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::Queue::Models::ChannelCollection'
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


    # Puts messages into the queue.
    # You must use the [messages endpoint](https://docs.cloud.oracle.com/iaas/Content/queue/messages.htm#messages__messages-endpoint) to produce messages.
    # The messages endpoint may be different for different queues. Use {#get_queue get_queue} to find the queue's `messagesEndpoint`.
    #
    # @param [String] queue_id The unique queue identifier.
    # @param [OCI::Queue::Models::PutMessagesDetails] put_messages_details Details for the messages to publish.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about a particular request, please provide the request ID.
    # @return [Response] A Response object with data of type {OCI::Queue::Models::PutMessages PutMessages}
    # @note Click [here](https://docs.cloud.oracle.com/en-us/iaas/tools/ruby-sdk-examples/latest/queue/put_messages.rb.html) to see an example of how to use put_messages API.
    def put_messages(queue_id, put_messages_details, opts = {})
      logger.debug 'Calling operation QueueClient#put_messages.' if logger

      raise "Missing the required parameter 'queue_id' when calling put_messages." if queue_id.nil?
      raise "Missing the required parameter 'put_messages_details' when calling put_messages." if put_messages_details.nil?
      raise "Parameter value for 'queue_id' must not be blank" if OCI::Internal::Util.blank_string?(queue_id)

      path = '/queues/{queueId}/messages'.sub('{queueId}', queue_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(put_messages_details)

      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'QueueClient#put_messages') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::Queue::Models::PutMessages'
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


    # Updates the visibility of the message represented by the receipt.
    # You must use the [messages endpoint](https://docs.cloud.oracle.com/iaas/Content/queue/messages.htm#messages__messages-endpoint) to update messages.
    # The messages endpoint may be different for different queues. Use {#get_queue get_queue} to find the queue's `messagesEndpoint`.
    #
    # @param [String] queue_id The unique queue identifier.
    # @param [String] message_receipt The receipt of the message retrieved from a GetMessages call.
    # @param [OCI::Queue::Models::UpdateMessageDetails] update_message_details Details for the message to update.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about a particular request, please provide the request ID.
    # @return [Response] A Response object with data of type {OCI::Queue::Models::UpdatedMessage UpdatedMessage}
    # @note Click [here](https://docs.cloud.oracle.com/en-us/iaas/tools/ruby-sdk-examples/latest/queue/update_message.rb.html) to see an example of how to use update_message API.
    def update_message(queue_id, message_receipt, update_message_details, opts = {})
      logger.debug 'Calling operation QueueClient#update_message.' if logger

      raise "Missing the required parameter 'queue_id' when calling update_message." if queue_id.nil?
      raise "Missing the required parameter 'message_receipt' when calling update_message." if message_receipt.nil?
      raise "Missing the required parameter 'update_message_details' when calling update_message." if update_message_details.nil?
      raise "Parameter value for 'queue_id' must not be blank" if OCI::Internal::Util.blank_string?(queue_id)
      raise "Parameter value for 'message_receipt' must not be blank" if OCI::Internal::Util.blank_string?(message_receipt)

      path = '/queues/{queueId}/messages/{messageReceipt}'.sub('{queueId}', queue_id.to_s).sub('{messageReceipt}', message_receipt.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_message_details)

      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'QueueClient#update_message') do
        @api_client.call_api(
          :PUT,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::Queue::Models::UpdatedMessage'
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


    # Updates multiple messages in the queue or the consumer group. Only messages from the same queue/consumer group can be updated at once.
    # You must use the [messages endpoint](https://docs.cloud.oracle.com/iaas/Content/queue/messages.htm#messages__messages-endpoint) to update messages.
    # The messages endpoint may be different for different queues. Use {#get_queue get_queue} to find the queue's `messagesEndpoint`.
    #
    # @param [String] queue_id The unique queue identifier.
    # @param [OCI::Queue::Models::UpdateMessagesDetails] update_messages_details Details for the messages to update.
    # @param [Hash] opts the optional parameters
    # @option opts [OCI::Retry::RetryConfig] :retry_config The retry configuration to apply to this operation. If no key is provided then the service-level
    #   retry configuration defined by {#retry_config} will be used. If an explicit `nil` value is provided then the operation will not retry
    # @option opts [String] :opc_request_id Unique Oracle-assigned identifier for the request. If you need to contact Oracle about a particular request, please provide the request ID.
    # @return [Response] A Response object with data of type {OCI::Queue::Models::UpdateMessagesResult UpdateMessagesResult}
    # @note Click [here](https://docs.cloud.oracle.com/en-us/iaas/tools/ruby-sdk-examples/latest/queue/update_messages.rb.html) to see an example of how to use update_messages API.
    def update_messages(queue_id, update_messages_details, opts = {})
      logger.debug 'Calling operation QueueClient#update_messages.' if logger

      raise "Missing the required parameter 'queue_id' when calling update_messages." if queue_id.nil?
      raise "Missing the required parameter 'update_messages_details' when calling update_messages." if update_messages_details.nil?
      raise "Parameter value for 'queue_id' must not be blank" if OCI::Internal::Util.blank_string?(queue_id)

      path = '/queues/{queueId}/messages/actions/updateMessages'.sub('{queueId}', queue_id.to_s)
      operation_signing_strategy = :standard

      # rubocop:disable Style/NegatedIf
      # Query Params
      query_params = {}

      # Header Params
      header_params = {}
      header_params[:accept] = 'application/json'
      header_params[:'content-type'] = 'application/json'
      header_params[:'opc-request-id'] = opts[:opc_request_id] if opts[:opc_request_id]
      # rubocop:enable Style/NegatedIf

      post_body = @api_client.object_to_http_body(update_messages_details)

      # rubocop:disable Metrics/BlockLength
      OCI::Retry.make_retrying_call(applicable_retry_config(opts), call_name: 'QueueClient#update_messages') do
        @api_client.call_api(
          :POST,
          path,
          endpoint,
          header_params: header_params,
          query_params: query_params,
          operation_signing_strategy: operation_signing_strategy,
          body: post_body,
          return_type: 'OCI::Queue::Models::UpdateMessagesResult'
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
