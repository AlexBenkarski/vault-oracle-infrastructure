# Copyright (c) 2016, 2024, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.

# NOTE: This class is auto generated by OracleSDKGenerator. DO NOT EDIT. API Version: 20230801

# rubocop:disable Lint/UnneededCopDisableDirective, Metrics/LineLength
module OCI
  # This class provides a wrapper around {OCI::DelegateAccessControl::DelegateAccessControlClient} and offers convenience methods
  # for operations that would otherwise need to be chained together. For example, instead of performing an action
  # on a resource (e.g. launching an instance, creating a load balancer) and then using a waiter to wait for the resource
  # to enter a given state, you can call a single method in this class to accomplish the same functionality
  class DelegateAccessControl::DelegateAccessControlClientCompositeOperations
    # The {OCI::DelegateAccessControl::DelegateAccessControlClient} used to communicate with the service_client
    #
    # @return [OCI::DelegateAccessControl::DelegateAccessControlClient]
    attr_reader :service_client

    # Initializes a new DelegateAccessControlClientCompositeOperations
    #
    # @param [OCI::DelegateAccessControl::DelegateAccessControlClient] service_client The client used to communicate with the service.
    #   Defaults to a new service client created via {OCI::DelegateAccessControl::DelegateAccessControlClient#initialize} with no arguments
    def initialize(service_client = OCI::DelegateAccessControl::DelegateAccessControlClient.new)
      @service_client = service_client
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/ParameterLists, Metrics/PerceivedComplexity
    # rubocop:disable Layout/EmptyLines


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#approve_delegated_resource_access_request} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegated_resource_access_request_id Unique Delegated Resource Access Request identifier
    # @param [OCI::DelegateAccessControl::Models::ApproveDelegatedResourceAccessRequestDetails] approve_delegated_resource_access_request_details Details regarding the approval of a Delegated Resource Access Request created by the support operator.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#approve_delegated_resource_access_request}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def approve_delegated_resource_access_request_and_wait_for_state(delegated_resource_access_request_id, approve_delegated_resource_access_request_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.approve_delegated_resource_access_request(delegated_resource_access_request_id, approve_delegated_resource_access_request_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#change_delegation_control_compartment} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegation_control_id unique Delegation Control identifier
    # @param [OCI::DelegateAccessControl::Models::ChangeDelegationControlCompartmentDetails] change_delegation_control_compartment_details Moves the Delegation Control resource into a different compartment.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#change_delegation_control_compartment}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def change_delegation_control_compartment_and_wait_for_state(delegation_control_id, change_delegation_control_compartment_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.change_delegation_control_compartment(delegation_control_id, change_delegation_control_compartment_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#change_delegation_subscription_compartment} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegation_subscription_id unique Delegation Subscription identifier
    # @param [OCI::DelegateAccessControl::Models::ChangeDelegationSubscriptionCompartmentDetails] change_delegation_subscription_compartment_details Moves the Delegation Subscription resource into a different compartment.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#change_delegation_subscription_compartment}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def change_delegation_subscription_compartment_and_wait_for_state(delegation_subscription_id, change_delegation_subscription_compartment_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.change_delegation_subscription_compartment(delegation_subscription_id, change_delegation_subscription_compartment_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#create_delegation_control} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [OCI::DelegateAccessControl::Models::CreateDelegationControlDetails] create_delegation_control_details Details for the new Delegation Control.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#create_delegation_control}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def create_delegation_control_and_wait_for_state(create_delegation_control_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.create_delegation_control(create_delegation_control_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#create_delegation_subscription} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [OCI::DelegateAccessControl::Models::CreateDelegationSubscriptionDetails] create_delegation_subscription_details Details for creating Delegation Subscription in Delegation Control.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#create_delegation_subscription}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def create_delegation_subscription_and_wait_for_state(create_delegation_subscription_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.create_delegation_subscription(create_delegation_subscription_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#delete_delegation_control} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegation_control_id unique Delegation Control identifier
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#delete_delegation_control}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def delete_delegation_control_and_wait_for_state(delegation_control_id, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.delete_delegation_control(delegation_control_id, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#delete_delegation_subscription} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegation_subscription_id unique Delegation Subscription identifier
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#delete_delegation_subscription}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def delete_delegation_subscription_and_wait_for_state(delegation_subscription_id, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.delete_delegation_subscription(delegation_subscription_id, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#reject_delegated_resource_access_request} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegated_resource_access_request_id Unique Delegated Resource Access Request identifier
    # @param [OCI::DelegateAccessControl::Models::RejectDelegatedResourceAccessRequestDetails] reject_delegated_resource_access_request_details Details regarding the rejection of a Delegated Resource Access Request created by the support operator.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#reject_delegated_resource_access_request}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def reject_delegated_resource_access_request_and_wait_for_state(delegated_resource_access_request_id, reject_delegated_resource_access_request_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.reject_delegated_resource_access_request(delegated_resource_access_request_id, reject_delegated_resource_access_request_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#revoke_delegated_resource_access_request} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegated_resource_access_request_id Unique Delegated Resource Access Request identifier
    # @param [OCI::DelegateAccessControl::Models::RevokeDelegatedResourceAccessRequestDetails] revoke_delegated_resource_access_request_details Details regarding the revocation of a Delegated Resource Access Request created by the support operator.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#revoke_delegated_resource_access_request}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def revoke_delegated_resource_access_request_and_wait_for_state(delegated_resource_access_request_id, revoke_delegated_resource_access_request_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.revoke_delegated_resource_access_request(delegated_resource_access_request_id, revoke_delegated_resource_access_request_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#update_delegation_control} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegation_control_id unique Delegation Control identifier
    # @param [OCI::DelegateAccessControl::Models::UpdateDelegationControlDetails] update_delegation_control_details Details for the new DelegationControl.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#update_delegation_control}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def update_delegation_control_and_wait_for_state(delegation_control_id, update_delegation_control_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.update_delegation_control(delegation_control_id, update_delegation_control_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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


    # Calls {OCI::DelegateAccessControl::DelegateAccessControlClient#update_delegation_subscription} and then waits for the {OCI::DelegateAccessControl::Models::WorkRequest}
    # to enter the given state(s).
    #
    # @param [String] delegation_subscription_id unique Delegation Subscription identifier
    # @param [OCI::DelegateAccessControl::Models::UpdateDelegationSubscriptionDetails] update_delegation_subscription_details Details for the DelegationSubscription to be updated.
    # @param [Array<String>] wait_for_states An array of states to wait on. These should be valid values for {OCI::DelegateAccessControl::Models::WorkRequest#status}
    # @param [Hash] base_operation_opts Any optional arguments accepted by {OCI::DelegateAccessControl::DelegateAccessControlClient#update_delegation_subscription}
    # @param [Hash] waiter_opts Optional arguments for the waiter. Keys should be symbols, and the following keys are supported:
    #   * max_interval_seconds: The maximum interval between queries, in seconds.
    #   * max_wait_seconds The maximum time to wait, in seconds
    #
    # @return [OCI::Response] A {OCI::Response} object containing the completed {OCI::DelegateAccessControl::Models::WorkRequest}
    def update_delegation_subscription_and_wait_for_state(delegation_subscription_id, update_delegation_subscription_details, wait_for_states = [], base_operation_opts = {}, waiter_opts = {})
      operation_result = @service_client.update_delegation_subscription(delegation_subscription_id, update_delegation_subscription_details, base_operation_opts)
      use_util = OCI::DelegateAccessControl::Util.respond_to?(:wait_on_work_request)

      return operation_result if wait_for_states.empty? && !use_util

      lowered_wait_for_states = wait_for_states.map(&:downcase)
      wait_for_resource_id = operation_result.headers['opc-work-request-id']
      return operation_result if wait_for_resource_id.nil? || wait_for_resource_id.empty?

      begin
        if use_util
          waiter_result = OCI::DelegateAccessControl::Util.wait_on_work_request(
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
