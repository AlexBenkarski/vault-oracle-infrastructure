require 'oci/hydra_frontend_public_client/hydra_frontend_public_client'
require 'securerandom'
require 'observability/output_response_metrics'

module Fluent
  module Plugin
    module PublicLoggingUtils
      include AgentObservability::OutputPluginResponseMetrics

      PUBLIC_CLIENT_SPEC_VERSION = "1.0"
      PUBLIC_LOGGING_PREFIX = "com.oraclecloud.logging.custom."
      UTF_8 = "UTF-8"
      MASKED_VALUE = "*"

      ##
      # Build the wrapper for all the log entries to be sent to lumberjack.
      #
      # @return [OCI::HydraFrontendPublicClient::Models::PutLogsDetails] PutLogsDetails wrapper to be filled with log entries
      def get_put_logs_details_request
        request = OCI::HydraFrontendPublicClient::Models::PutLogsDetails.new
        request.specversion = PUBLIC_CLIENT_SPEC_VERSION
        request
      end

      ##
      # Build the requests to be sent to the Lumberjack endpoint.
      #
      # @param [Time] time Fluentd event time (may be different from event's
      #                    timestamp)
      # @param [Hash] record The fluentd record.
      # @param [String] tagpath The fluentd path if populated.
      # @param [Hash] log_batches_map List of pre-existing log batch.
      # @param [String] sourceidentifier The fluentd contianing the source path.
      #
      # @return [Array] requests List of requests for Lumberjack's backend.
      def build_request(time, record, tagpath, log_batches_map, sourceidentifier, uma_source_config)
        log = @log || Logger.new(STDOUT)
        if @hide_metadata && record.key?('tailed_path')
          record.delete('tailed_path')
        end
        content = @flatten? flatten_hash(record): record
        add_uma_source_to_content(content) unless uma_source_config.nil?
        # create lumberjack request records
        logentry = ::OCI::HydraFrontendPublicClient::Models::LogEntry.new
        logentry.time = Time.at(time).utc.strftime('%FT%T.%LZ')
        begin
          logentry.data = content.to_json
        rescue
          begin
            log.warn("log line contains Non-ASCII characters, which is not accepted by agent, re-encode into UTF-8")
            # Fluentd treats logs as ASCII encoding by default, it cannot deal with Non-ASCII char, need to re-encode
            # them into UTF-8 encoding and send backend
            content = encode_to_utf8(content)
            logentry.data = content.to_json
          rescue
            log.warn("unexpected encoding in the log request, will send log as a string instead of json")
            # instead of loosing data because of an unknown encoding issue send the data as a string
            logentry.data = content.to_s
          end
        end
        logentry.id = SecureRandom.uuid

        requestkey = tagpath+sourceidentifier
        unless log_batches_map.key?(requestkey)
          log_entry_batch = OCI::HydraFrontendPublicClient::Models::LogEntryBatch.new
          log_entry_batch.defaultlogentrytime = Time.at(time).utc.strftime('%FT%T.%LZ')
          log_entry_batch.entries = []
          if @hide_metadata
            log_entry_batch.source = MASKED_VALUE
            log_entry_batch.type = MASKED_VALUE
          else
            log_entry_batch.source = @hostname
            log_entry_batch.type = PUBLIC_LOGGING_PREFIX + tagpath
            log_entry_batch.subject = sourceidentifier
          end

          log_batches_map[requestkey] = log_entry_batch
        end

        log_batches_map[requestkey].entries << logentry
      end

      def add_uma_source_to_content(content)
        unless @uma_source_config.nil? && content.key?(@uma_source_config.source_id_label)
          content.store(@uma_source_config.source_id_label, @uma_source_config.source_id_value)
          end
      end
      ##
      # Send prebuilt requests to the Lumberjack endpoint.
      #
      # @param [Hash] log_batches_map
      #
      # @raises Anything exception created by
      #         OCI::HydraPikaClient::HydraPikaFrontendClient.add_logs
      def send_requests(log_batches_map)
        log = @log || Logger.new(STDOUT)  # for testing

        request = get_put_logs_details_request
        request.log_entry_batches = log_batches_map.values
        batches_map_tag = ""
        begin
          log.info "put_logs request with log_object_id #{@log_object_id}"
          request.log_entry_batches.each do |batch|
            log.info "log_batch_subject #{batch.subject}, "\
                      "hostname #{batch.source}, default_log_entry_time #{batch.defaultlogentrytime}, " \
                      "batch_size #{batch.entries.size}, batch_type #{batch.type}"
            if batches_map_tag == ""
              batches_map_tag = batch.type
              batches_map_tag = batches_map_tag.sub(/^#{Regexp.escape(PUBLIC_LOGGING_PREFIX)}/, '')
            end
          end

          if @hide_metadata
            headers = {:'hide_metadata' => @hide_metadata }
            resp = @client.put_logs(@log_object_id, request, additional_headers: headers)
          else
            resp = @client.put_logs(@log_object_id, request)
          end

        rescue OCI::Errors::ServiceError => service_error
          log.error "Service Error received sending request: #{service_error}"
          if service_error.status_code == 400
            log.info "Eating service error as it is caused by Bad Request[400 HTTP code]"
            update_output_plugin_response_map("oci_logging", service_error.status_code, batches_map_tag)
          else
            log.error "Throwing service error for status code:#{service_error.status_code} as we want fluentd to re-try"
            update_output_plugin_response_map("oci_logging", service_error.status_code, batches_map_tag)
            raise
          end
        rescue OCI::Errors::NetworkError => network_error
          log.error "Network Error received sending request: #{network_error}"
          if network_error.code == 400
            log.info "Eating network error as it is caused by Bad Request[400 HTTP code]"
            update_output_plugin_response_map("oci_logging", network_error.code, batches_map_tag)
          else
            log.error "Throwing network error for code:#{network_error.code} as we want fluentd to re-try"
            update_output_plugin_response_map("oci_logging", network_error.code, batches_map_tag)
            raise
          end
        rescue StandardError => standard_error
          log.error "Standard Error received sending request: #{standard_error}"
          raise
        end

        log.info "response #{resp.status} id: #{resp.request_id}"
        update_output_plugin_response_map("oci_logging", resp.status, batches_map_tag)
      end

      ##
      # Flatten the keys of a hash.
      #
      # @param [Hash] record The hash object to flatten.
      #
      # @return [Hash] The updated, flattened, hash.
      def flatten_hash(record)
        record.each_with_object({}) do |(k, v), h|
          if v.is_a? Hash
            flatten_hash(v).map { |h_k, h_v| h["#{k}.#{h_k}"] = h_v }
          elsif k == 'log'
            h['msg'] = v
          else
            h[k] = v
          end
        end
      end

      ##
      # Re-encode characters to UTF-8
      #
      # @param [Hash] record needing to have the encoding changes
      #
      # @return [Hash] The updated hash.
      def encode_to_utf8(record)
        record.each_with_object({}) do |(k, v), h|
          h[k] = v.to_s.encode!(UTF_8, UTF_8)
        end
      end

      ##
      # Parse out the log_type from the chunk metadata tag
      #
      # @param [String] rawtag the string of the chunk metadata tag that needs to be parsed
      #
      # @return [String] take out the tag after the first '.' character or return the whole tag if there is no '.'
      def get_modified_tag(rawtag)
        tag = rawtag || 'empty'
        tag.split('.').length > 1 ? tag.partition('.')[2]: tag
      end
    end
  end
end
