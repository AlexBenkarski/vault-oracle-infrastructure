# Copyright (c) 20[0-9][0-9], Oracle and/or its affiliates. All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License
# (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License
# 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
# either license.

# frozen_string_literal: true

require_relative 'metrics_utils'
require 'fluent/plugin/output'
require 'oci/api_client'
require 'oci/monitoring/monitoring'
require 'oci/errors'
require 'oci/auth/federation_client'
require 'oci/auth/security_token_container'
require 'oci/auth/signers/resource_principals_federation_signer'
require 'oci/auth/signers/ephemeral_resource_principals_signer'
require 'oci/mtls_api_client'
require 'observability/output_response_metrics'

module OCI
  class << self
    attr_accessor :sdk_name

    # Defines the logger used for debugging for the OCI module.
    # For example, log to STDOUT by setting this to Logger.new(STDOUT).
    #
    # @return [Logger]
    attr_accessor :logger
  end
end

module Fluent
  module Plugin
    # OCI Logging Fluentd Output plugin
    class PublicMetricsOutput < Fluent::Plugin::Output
      include Fluent::Plugin::PublicMetricsUtils
      include AgentObservability::OutputPluginResponseMetrics

      Fluent::Plugin.register_output('oci_monitoring', self)
      helpers :formatter

      # allow instance metadata to be configurable (for testing)
      config_param :metadata_override, :hash, default: nil

      config_section :format do
        config_set_default :@type, 'oci_monitoring'
      end

      config_section :principal do
        # 'instance' / 'user' / 'resource'
        config_param :@type, :string, default: nil

        # when type == 'user' , use this profile from the oci config
        config_param :oci_config_profile, :string, default: 'DEFAULT'

        # when type == 'user' , use this location to load the oci config
        config_param :oci_config_path, :string, default: File.expand_path('~/.oci/config')

        # when type == 'user' , use these as overrides for auth signer creation, only if required
        config_param :federation_endpoint, :string, default: nil
        config_param :cert_bundle_path, :string, default: nil
      end

      # endpoint override
      config_param :endpoint_override, :string, default: nil

      # Which compartment_id will we use for sending metrics
      # 'internal' => send metrics to Telemetry internal compartment for this region
      # 'auto' => send metrics to compartmentId as fetched from oci sdk config or
      #           http://169.254.169.254
      # <any other value> => use this as compartmentId
      config_param :compartment, :string, default: 'auto'

      config_section :buffer do
        config_set_default :@type, 'memory'

        # limit buffers to 100MB (either file or memory)
        config_set_default :total_limit_size, 100 * 1024 * 1024

        # bulk send metrics in batches of utmost 50
        config_set_default :chunk_limit_records, 50

        config_set_default :retry_type, :exponential_backoff

        # metric chunks must expire quickly, otherwise they're 1) useless 2) filling up the buffers!
        config_set_default :retry_timeout, 300

        # discard failed chunks after they've expired
        config_set_default :disable_chunk_backup, true

        # Enqueue input data to output buffers each 10 seconds
        config_set_default :flush_mode, :interval
        config_set_default :flush_interval, 10

        # Write to destination when a chunk is of size chunk_limit_size * chunk_full_threshold
        config_set_default :chunk_limit_size, 4 * 1024 * 1024 # 4 MB
        config_set_default :chunk_full_threshold, 0.80

        # Write to destination with five threads, every half second
        # In case of filling buffers increase flushing to every fifth of a second
        config_set_default :flush_thread_count, 1
        config_set_default :flush_thread_interval, 0.5
        config_set_default :flush_thread_burst_interval, 0.2
      end

      def initialize
        super
        @log = $log # use the global logger
      end

      def configure(conf) # rubocop:disable Metrics/AbcSize (this is as simple as it gets)
        ensure_config_section(conf, 'format')
        workload_signer = ENV['WORKLOAD_SIGNER'] || false
        if workload_signer
          ensure_config_section(conf, 'principal', { '@type' => 'workload' })
        end

        super

        # only the 1st <principal> block is evaluated
        @principal = @principal[0]

        if @principal != nil && !SUPPORTED_PRINCIPALS.include?(@principal['@type'])
          raise Fluent::ConfigError, "Unsupported principal type during oci config creation: #{@principal['@type']}"
        end

        if @principal == nil
          get_principal, additional_parameters = get_signer_type
          @principal = {'@type' => get_principal}
          @principal.merge!(additional_parameters) if additional_parameters && !additional_parameters.empty?
        end

        @instance_metadata = get_metadata
        @log.info "OCI instance metadata: #{@instance_metadata}"

        @is_service_enclave = @instance_metadata['is_service_enclave']
        @log.info "Is Service Enclave: #{@is_service_enclave}"

        @oci_config = create_oci_config
        @log.info "OCI config: #{@oci_config}"

        @ca_file = set_default_ca_file
        @log.info("Default cert_bundle_path #{@ca_file} (used unless overridden in principal configuration).")

        @region = resolve_region
        @log.info("Resolved region: #{@region}")

        @realm_domain_component = set_realm_domain_component
        @log.debug("Realm domain component: #{@realm_domain_component}")

        @compartment = resolve_compartment(conf)
        @log.info("Sending metrics to compartment #{compartment}")
        add_compartmentId_to_metadata_if_user_principal(@compartment)

        @endpoint_url = resolve_endpoint(@endpoint_override)
        @log.info("Resolved endpoint: #{@endpoint_url}")

        @formatter = formatter_create
        @formatter.compartment_id = @compartment
        @formatter.instance_metadata = @instance_metadata
        @formatter.metrics_namespace = conf['metrics_namespace']

        @log.info('Loading proxy settings')
        @proxy_settings = create_proxy_settings
        if @is_service_enclave
          @http = ::Net::HTTP.new(@endpoint_url.host, @endpoint_url.port)
          @http.use_ssl = (@endpoint_url.scheme == 'https')
          @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          mtls_client = OCI::MTLSApiClient.new(@oci_config)
          @http.cert = mtls_client.get_pki_node_cert
          @http.key = mtls_client.get_pki_node_key
          @http.ca_file = OCI::MTLSApiClient::CA_BUNDLE_FILE
          @http.extra_chain_cert = mtls_client.get_pki_node_intermediate_list
          @header = { 'Content-Type' => 'application/json' }
          @http_req = ::Net::HTTP::Post.new(@endpoint_url.path, @header)
        else
          # In case of Customer Enclave Instances
          @signer = create_signer
          @api_client = OCI::ApiClient.new(@oci_config, @signer, proxy_settings: @proxy_settings)

          @client = OCI::Monitoring::MonitoringClient.new(
            config: @oci_config,
            endpoint: @endpoint_url,
            signer: @signer,
            proxy_settings: @proxy_settings
          )
          @client.api_client.request_option_overrides = { ca_file: @ca_file }
        end
      end

      def multi_workers_ready?
        true
      end

      def start
        super
        @log.info('Starting oci monitoring output plugin.')
      end

      def write(chunk) # rubocop:disable Metrics/AbcSize (this is as simple as it gets)
        chunk_id = Fluent::UniqueId.hex(chunk.unique_id)
        metrics = []
        chunk.each do |_, record|
          metrics.push(record)
        end
        if @is_service_enclave
          @log.debug("out_monitoring.write for substrate: chunk #{chunk_id} contains #{metrics.size} record(s)")
          send_metrics_to_T2(metrics)
        else
          @log.debug("out_monitoring.write for overlay: chunk #{chunk_id} contains #{metrics.size} record(s)")

          # opts = BASE_OPTS.dup
          # opts[:body] = @formatter.format(nil, nil, metrics)
          # opts[:return_type] = 'object'
          # resp = @api_client.call_api(:POST, '/metrics', "#{@endpoint_url}/20180401", opts)

          send_metrics(chunk_id, metrics)
        end
      rescue ::OCI::Errors::ServiceError => e
        # rubocop: disable Style/GuardClause (explicit is better than implicit)
        if e.status_code != 429 && e.status_code < 500 # ignore 4xx except 429
          @log.warn(e)
        else # worth retrying
          raise e
        end
        # rubocop: enable Style/GuardClause
      end

      private

      # @param [Object] metrics
      # @return [String, nil]
      def send_metrics_to_T2(metrics)
        res = nil
        begin
          @http_req.body = @formatter.format(nil, nil, metrics).to_json
          @log.trace "payload: #{@http_req.body}"
          res = @http.request(@http_req)
          @log.info "T2 post metrics response status: #{res.code} , opc-req-id=#{res.each_header.to_h["opc-request-id"]}"
          if (res != nil) && (res.code != nil)
            update_output_plugin_response_map("oci_monitoring", res.code, "monitoring")
          end
        rescue StandardError => e # rescue all StandardErrors
          log.warn "Http raises exception: #{e.class}, '#{e.message}'"
          raise e
        else
          unless res&.is_a?(::Net::HTTPSuccess)
            res_summary = if res
                            "#{res.code} #{res.message} #{res.body} / #{res.header['opc-request-id']}"
                          else
                            'res=nil'
                          end

            # for server error and 429, raise an error so that it can retry
            raise res_summary if res&.is_a?(::Net::HTTPServerError) ||
                                 res&.is_a?(::Net::HTTPTooManyRequests)

            log.warn "Http failed to #{@http_req.method} #{@endpoint_url} (#{res_summary})"
          end
        end
      end

      # @param [Object] chunk_id
      # @param [Object] metrics
      # @return [Object]
      def send_metrics(chunk_id, metrics)
        metricsDataDetailsList = []
        formattedData = @formatter.format(nil, nil, metrics)
        formattedData["metricData"].each do |item|
          metricsDataDetailsList.push(
            ::OCI::Monitoring::Models::MetricDataDetails.new(
              namespace: item["namespace"],
              resource_group: item["resourceGroup"],
              dimensions: item["dimensions"],
              name: item["name"],
              datapoints: item["datapoints"],
              compartment_id: item["compartmentId"]
            )
          )
        end

        log.debug("POSTing metrics: #{formattedData['metricData']}") if ENV.fetch('OCI_MONITORING_OUTPUT_TRACE', false)

        myPostMetricDataDetails = ::OCI::Monitoring::Models::PostMetricDataDetails.new(metric_data: metricsDataDetailsList)
        resp = @client.post_metric_data(myPostMetricDataDetails)

        @log.info("OCI monitoring post metrics response status: #{resp.status} #{resp.headers} "\
                  "(#{(metricsDataDetailsList.to_json.bytesize / 1024).round} KB, #{metrics.size} metrics, "\
                  "#{chunk_id} chunk)")
        if (resp != nil) && (resp.status != nil)
          update_output_plugin_response_map("oci_monitoring", resp.status, "monitoring")
        end
        handle_response(resp)
      end
    end
  end
end
