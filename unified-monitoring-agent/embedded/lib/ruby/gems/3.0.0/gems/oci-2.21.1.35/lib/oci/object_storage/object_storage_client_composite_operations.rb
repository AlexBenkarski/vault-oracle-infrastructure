# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20160918

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # This class provides a wrapper around {OCI::ObjectStorage::ObjectStorageClient} and offers convenience methods
  # for operations that would otherwise need to be chained together. For example, instead of performing an action
  # on a resource (e.g. launching an instance, creating a load balancer) and then using a waiter to wait for the resource
  # to enter a given state, you can call a single method in this class to accomplish the same functionality
  class ObjectStorage::ObjectStorageClientCompositeOperations
    # The {OCI::ObjectStorage::ObjectStorageClient} used to communicate with the service_client
    #
    # @return [OCI::ObjectStorage::ObjectStorageClient]
    attr_reader :service_client

    # Initializes a new ObjectStorageClientCompositeOperations
    #
    # @param [OCI::ObjectStorage::ObjectStorageClient] service_client The client used to communicate with the service.
    #   Defaults to a new service client created via {OCI::ObjectStorage::ObjectStorageClient#initialize} with no arguments
    def initialize(service_client = OCI::ObjectStorage::ObjectStorageClient.new)
      @service_client = service_client
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:disable Layout/EmptyLines


    # Calls {OCI::ObjectStorage::ObjectStorageClient#copy_object} and then waits for the {OCI::ObjectStorage::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] namespace_name The Object Storage namespace used for the request.
    # @param [String] bucket_name The name of the bucket. Avoid entering confidential information.
    #   Example: `my-new-bucket1`
    #
    # @param [OCI::ObjectStorage::Models::CopyObjectDetails] copy_object_details The source and destination of the object to be copied.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::ObjectStorage::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::ObjectStorage::ObjectStorageClient#copy_object}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::ObjectStorage::Models::WorkRequest}
    def copy_object_and_wait_for_state(namespace_name, bucket_name, copy_object_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.copy_object(namespace_name, bucket_name, copy_object_details, base_operation_opts)
      use_util = OCI::ObjectStorage::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::ObjectStorage::Util.wait_on_work_request(
            @service_client,
            wait_for_resource_id,
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        else
          waiter_result = @service_client.get_work_request(wait_for_resource_id).wait_until(
            eval_proc: ->(response) { response.data.respond_to?(:status) && lowered_wait_for_states.include?(response.data.status.downcase) },
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        end
        result_to_return = waiter_result

        return result_to_return
      rescue StandardError
        raise OCI::Errors::CompositeOperationError.new(partial_results: [operation_result])
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:enable Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:disable Layout/EmptyLines


    # Calls {OCI::ObjectStorage::ObjectStorageClient#create_private_endpoint} and then waits for the {OCI::ObjectStorage::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] namespace_name The Object Storage namespace used for the request.
    # @param [OCI::ObjectStorage::Models::CreatePrivateEndpointDetails] create_private_endpoint_details Details to create a private endpoint.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::ObjectStorage::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::ObjectStorage::ObjectStorageClient#create_private_endpoint}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::ObjectStorage::Models::WorkRequest}
    def create_private_endpoint_and_wait_for_state(namespace_name, create_private_endpoint_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.create_private_endpoint(namespace_name, create_private_endpoint_details, base_operation_opts)
      use_util = OCI::ObjectStorage::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::ObjectStorage::Util.wait_on_work_request(
            @service_client,
            wait_for_resource_id,
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        else
          waiter_result = @service_client.get_work_request(wait_for_resource_id).wait_until(
            eval_proc: ->(response) { response.data.respond_to?(:status) && lowered_wait_for_states.include?(response.data.status.downcase) },
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        end
        result_to_return = waiter_result

        return result_to_return
      rescue StandardError
        raise OCI::Errors::CompositeOperationError.new(partial_results: [operation_result])
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:enable Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:disable Layout/EmptyLines


    # Calls {OCI::ObjectStorage::ObjectStorageClient#delete_private_endpoint} and then waits for the {OCI::ObjectStorage::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] namespace_name The Object Storage namespace used for the request.
    # @param [String] pe_name The name of the private endpoint. Avoid entering confidential information.
    #   Example: `my-new-pe-1`
    #
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::ObjectStorage::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::ObjectStorage::ObjectStorageClient#delete_private_endpoint}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::ObjectStorage::Models::WorkRequest}
    def delete_private_endpoint_and_wait_for_state(namespace_name, pe_name, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.delete_private_endpoint(namespace_name, pe_name, base_operation_opts)
      use_util = OCI::ObjectStorage::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::ObjectStorage::Util.wait_on_work_request(
            @service_client,
            wait_for_resource_id,
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        else
          waiter_result = @service_client.get_work_request(wait_for_resource_id).wait_until(
            eval_proc: ->(response) { response.data.respond_to?(:status) && lowered_wait_for_states.include?(response.data.status.downcase) },
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        end
        result_to_return = waiter_result

        return result_to_return
      rescue StandardError
        raise OCI::Errors::CompositeOperationError.new(partial_results: [operation_result])
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:enable Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:disable Layout/EmptyLines


    # Calls {OCI::ObjectStorage::ObjectStorageClient#reencrypt_bucket} and then waits for the {OCI::ObjectStorage::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] namespace_name The Object Storage namespace used for the request.
    # @param [String] bucket_name The name of the bucket. Avoid entering confidential information.
    #   Example: `my-new-bucket1`
    #
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::ObjectStorage::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::ObjectStorage::ObjectStorageClient#reencrypt_bucket}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::ObjectStorage::Models::WorkRequest}
    def reencrypt_bucket_and_wait_for_state(namespace_name, bucket_name, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.reencrypt_bucket(namespace_name, bucket_name, base_operation_opts)
      use_util = OCI::ObjectStorage::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::ObjectStorage::Util.wait_on_work_request(
            @service_client,
            wait_for_resource_id,
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        else
          waiter_result = @service_client.get_work_request(wait_for_resource_id).wait_until(
            eval_proc: ->(response) { response.data.respond_to?(:status) && lowered_wait_for_states.include?(response.data.status.downcase) },
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        end
        result_to_return = waiter_result

        return result_to_return
      rescue StandardError
        raise OCI::Errors::CompositeOperationError.new(partial_results: [operation_result])
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:enable Layout/EmptyLines

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:disable Layout/EmptyLines


    # Calls {OCI::ObjectStorage::ObjectStorageClient#update_private_endpoint} and then waits for the {OCI::ObjectStorage::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] namespace_name The Object Storage namespace used for the request.
    # @param [String] pe_name The name of the private endpoint. Avoid entering confidential information.
    #   Example: `my-new-pe-1`
    #
    # @param [OCI::ObjectStorage::Models::UpdatePrivateEndpointDetails] update_private_endpoint_details Request object for updating the Private Endpoint.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::ObjectStorage::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::ObjectStorage::ObjectStorageClient#update_private_endpoint}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::ObjectStorage::Models::WorkRequest}
    def update_private_endpoint_and_wait_for_state(namespace_name, pe_name, update_private_endpoint_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.update_private_endpoint(namespace_name, pe_name, update_private_endpoint_details, base_operation_opts)
      use_util = OCI::ObjectStorage::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::ObjectStorage::Util.wait_on_work_request(
            @service_client,
            wait_for_resource_id,
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        else
          waiter_result = @service_client.get_work_request(wait_for_resource_id).wait_until(
            eval_proc: ->(response) { response.data.respond_to?(:status) && lowered_wait_for_states.include?(response.data.status.downcase) },
            max_interval_seconds: waiter_opts.key?(:max_interval_seconds) ? waiter_opts[:max_interval_seconds] : 30,
            max_wait_seconds: waiter_opts.key?(:max_wait_seconds) ? waiter_opts[:max_wait_seconds] : 1200
          )
        end
        result_to_return = waiter_result

        return result_to_return
      rescue StandardError
        raise OCI::Errors::CompositeOperationError.new(partial_results: [operation_result])
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:enable Layout/EmptyLines
  end
end
# rubocop:enable Lint/UnneededCopDisableDirective, Metrics/LineLength
