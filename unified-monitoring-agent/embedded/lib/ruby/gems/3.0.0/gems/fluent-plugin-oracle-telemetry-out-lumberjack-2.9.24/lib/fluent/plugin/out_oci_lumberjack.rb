# frozen_string_literal: true

require 'oci/metrics-relay/out_oci_service'
require 'oci/mtls_hydra_pika_fe_client'
require 'oci/auth/signers/resource_principals_federation_signer'
require 'oci/auth/signers/ephemeral_resource_principals_signer'
require_relative 'lumberjack_utils'
require_relative 'lumberjack_logstream'
require_relative 'lumberjack_requests'
require_relative 'lumberjack_auditd_filter'


module Fluent
  module Plugin

    SYSLOGCANON = "lumberjack-syslogcanon".freeze
    CDSLOGGING ="CDSLOGGING".freeze
    TEN_DAYS_IN_SECONDS = 10 * 24 * 60 * 60 # 10 Days in seconds
    FIVE_MINUTES_IN_SECONDS = 5 * 60 # 5 minutes in seconds

    class LumberjackOutput < Fluent::Plugin::MetricsRelay::OciServiceOutput
      include Fluent::Plugin::LumberjackUtils
      include Fluent::Plugin::LumberjackLogstream
      include Fluent::Plugin::LumberjackRequests
      include Fluent::Plugin::LumberjackAuditdFilter


      Fluent::Plugin.register_output('oci_lumberjack', self)

      # OCI Target compartment
      config_param :compartment, :string
      # Lumberjack logs namespace
      config_param :namespace, :string
      # logging tenancy, this is used for the cross tenancy header and is required only when using service principals
      config_param :logging_tenancy, :string, default: nil
      # Lumberjack log group
      config_param :log_group, :string, default: nil
      # Lumberjack log type
      config_param :logType, :string, default: 'standard'
      # Lumberjack log id
      # Make it an optional parameter for backward compatibility
      config_param :log_object_id, :string, default: nil
      # Flatten
      # Make it an optional parameter for backward compatibility
      config_param :flatten, :string, default: true
      ## overrides for testing
      # allow instance metadata to be configurable (for testing)
      config_param :metadata_override, :hash, default: nil
      # Path to the PEM CA certificate file for TLS. Can contain several CA certs.
      # We are defaulting to '/etc/oci-pki/ca-bundle.pem'
      # This can be overriden for testing.
      config_param :ca_file, :string, default: nil
      # Override to manually provide the host endpoint
      config_param :logging_endpoint_override, :string, default: nil
      # Override to manually provide the federation endpoint
      config_param :federation_endpoint_override, :string, default: nil

      attr_accessor :client
      attr_accessor :lsid_hash
      attr_accessor :env
      attr_accessor :lsid_to_key_map
      helpers :event_emitter

      def configure(conf)
        super
        @tag = conf.arg
        log.debug "compartment #{@compartment} namespace #{@namespace} tag #{@tag}"

        if @metadata_override.nil?
          metadata_response = @env.instance_metadata
          log.info "using metadata #{metadata_response}"
        else
          metadata_response = @metadata_override
          @env.instance_metadata = @metadata_override
          log.info "using metadata override #{metadata_response}"
        end

        @flatten=(ENV['FLATTEN_JSON_PAYLOAD'] || @flatten).to_s == 'true'

        # @is_service_enclave is used in lumberjack_logstream.rb
        @is_service_enclave = metadata_response['is_service_enclave']

        log.info "plugin id is #{@id}"

        # constructing lumberjack endpoint
        # using override if provided for testing
        if @logging_endpoint_override.nil?
          @logging_endpoint = @env.get_logging_endpoint(metadata_response)
          log.info "using logging endpoint #{@logging_endpoint}"
        else
          @logging_endpoint = @logging_endpoint_override
          log.info "using logging endpoint override #{@logging_endpoint}"
        end

        # setting the federation endpoint
        @principal[0]['federation_endpoint'] = @federation_endpoint_override || @env.get_federation_endpoint
        log.info "using federation_endpoint #{@principal[0]['federation_endpoint']}"

        set_default_ca_file

        unless File.file?(@ca_file)
          msg = "Does not exist or cannot open ca file: #{@ca_file}"
          log.error msg
          raise Fluent::ConfigError, msg
        end

        # setting the cert_bundle_path
        @principal[0]['cert_bundle_path'] = @ca_file
        log.info "using cert_bundle_path #{@principal[0]['cert_bundle_path']}"

        @client = if @env['is_service_enclave'] && (@principal[0]['@type'] == 'mtls' || @principal[0]['@type'] == 'auto')
          OCI::MTLSHydraPikaFEClient.new(
              config: @oci_config,
              endpoint: "#{@logging_endpoint}:12000", # FE uses 12000 port for mtls
              proxy_settings: nil,
              retry_config: nil
          )
        else
          OCI::HydraPikaClient::HydraPikaFrontendClient.new(
              config: @oci_config,
              endpoint: @logging_endpoint,
              signer:  create_signer(@principal[0]),
              proxy_settings: nil,
              retry_config: nil
          )
        end

        @client.api_client.request_option_overrides = { ca_file: @ca_file }

        # @lsid_hash is map where key is request metadata, value is the lsid
        # @lsid_to_metadata_map is a map where key is lsid, value is request metadata.
        @lsid_hash = {}
        @lsid_to_metadata_map = {}

        # Filter configuration
        @filter_metrics = {}
        @filter_data = {}
        @filter_config = {
          :name => nil,
          # the default filter return false, i.e don't drop the record
          :validate_function => -> (record) { return false },
          :setup_metrics_function => -> () { return },
          :update_metrics_function => -> () { return }
        }

        # Setup auditd filter
        if @tag.match(/^parsed\.auditd(\.override.*)?$/)
          setup_auditd_filter(@env['hostclass'])
        end

      end

      def start
        super
        # ...
        log.debug 'start'
      end

      # Expose filter metrics for use in agent metrics plugin
      def filter_statistics
        { 'output' => @filter_metrics }
      end

      #### Sync Buffered Output ##############################
      # Implement write() if your plugin uses a normal buffer.
      # Read "Sync Buffered Output" for details.
      ########################################################
      def write(chunk)
        log.debug "writing chunk metadata #{chunk.metadata}", \
                  dump_unique_id_hex(chunk.unique_id)
        requests = {}
        current_timestamp = Fluent::EventTime.now

        # Setup metrics structure for current flush thread
        # We reset it to prevent send_requests failure which trigger retries
        # to count several time the same record
        @filter_config[:setup_metrics_function].()

        chunk.each do |time, record|
          # Give tag a value
          tag = chunk.metadata.tag || 'dummy'

          # We first check each record is within valid timestamp and then we
          # call filter function. Both test can potentially drop records.
          if ! isValidRecord(record, time, current_timestamp)
            log.warn "Record timestamp out of range, ignore #{record}"
            next
          elsif @filter_config[:validate_function].(record)
            log.debug "Record dropped by #{@filter_config[:name]} filter, ignore #{record}"
            next
          end

          source_identifier = ""
          if record.key?('tailed_path')
            source_identifier = record['tailed_path']
          end

          begin
            chunk_lsid = get_lsid(@log_group, @env['id'], source_identifier, @id);
          rescue BadRequestError
            log.info("exiting chunk flush due to a bad request as re-trying wont help. This could be due to bad configuration of source_path: #{source_identifier}")
            return
          end

          begin
            build_request(time, record, tag, requests, chunk_lsid)
          rescue StandardError => e
            # this will be a poison pill and protects if a record content is nil
            log.error(e.full_message)
          end
        end

        # flushing data to LJ
        send_requests(requests)

        # update plugin instance metrics
        # the metrics will only report records really sent by the plugin
        @filter_config[:update_metrics_function].()
      end

      def isValidRecord(record, record_timestamp, current_timestamp)
        # be rejectLogs older than 10 days and more than 5 min in future will ed by Lumberjack
        if record_timestamp >= (current_timestamp - TEN_DAYS_IN_SECONDS) && record_timestamp <= (current_timestamp + FIVE_MINUTES_IN_SECONDS)
          return true
        end
        log.info("isValid Check failed since either logs are older than 10 days or 5 mins+ into future. The record ts #{record_timestamp} and current ts #{current_timestamp} ")
        return false
      end

    end
  end
end
