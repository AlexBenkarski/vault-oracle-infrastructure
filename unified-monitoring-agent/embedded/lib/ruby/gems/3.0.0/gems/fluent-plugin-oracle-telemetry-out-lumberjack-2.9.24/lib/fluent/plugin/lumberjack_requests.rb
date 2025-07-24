# encoding: UTF-8

# Copyright 2019- Oracle
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'oci/hydra_pika_client/models/log_entry'
require 'oci/hydra_pika_client/models/add_logs_request_body'
require 'oci/errors'
require 'observability/output_response_metrics'

module Fluent
  module Plugin
    ##
    # Module handling communication with the Lumberjack backend.
    module LumberjackRequests
      ##
      # Build the requests to be sent to the Lumberjack endpoint.
      #
      # @param [Time] time Fluentd event time (may be different from event's
      #                    timestamp)
      # @param [Hash] record The fluentd record.
      # @param [String] tag The fluentd event tag.
      # @param [Array] requests List of pre-existing requests.
      #
      # @return [Array] requests List of requests for Lumberjack's backend.

      include AgentObservability::OutputPluginResponseMetrics

      def build_request(time, record, tag, requests, lsid)
        log = @log || Logger.new(STDOUT)  # for testing

        if record.key?('msg')
          record['msg'] = record['msg'].to_s.encode!('UTF-8','UTF-8')
        end
        if record.key?('tailed_path')
          record.delete('tailed_path')
        end
        content = @flatten? flatten_hash(record): record

        # If the record / content has a timestamp intended for use
        # by lumberjack then honor it, else create one for lumberjack
        # based on the fluentd-event's time
        if content.key?('ts')
          time_ms = getTSInMillisecond(content['ts'])
          content.delete('ts')
        else
          time_ms = (time.to_f * 1000.0).to_i
        end
        logentry = OCI::HydraPikaClient::Models::LogEntry.new
        logentry.timestamp = time_ms
        logentry.content = content.to_json

        unless requests.key?(lsid)
          log.debug "creating new request object for lsid #{lsid}"
          body = OCI::HydraPikaClient::Models::AddLogsRequestBody.new
          body.segment_timestamp = time_ms
          body.payload = []
          # added as part of requirement to remove override tag and send log to same log object id and tag https://jira.oci.oraclecorp.com/browse/UA-2805
          if tag.include?(".override.")
            tag = tag.sub(/.override.*/, "")
          end
          # need to populate this due to bug in lumberjack ingestion/indexing
          body.file_identifier = tag.split(//).last(40).join
          requests[lsid] = body
        end
        requests[lsid].payload << logentry
      end

      def getTSInMillisecond(ts)
        ts = ts.to_i
        if ts.to_s.length == 13
          return time_ms = ts
        elsif ts.to_s.length == 16
          return time_ms= ts.fdiv(1000).to_i
        else
          return time_ms = ts * 1000
        end
      end
      ##
      # Send prebuilt requests to the Lumberjack endpoint.
      #
      # @param [Array] requests List of pre-existing requests.
      #
      # @raises Anything exception created by
      #         OCI::HydraPikaClient::HydraPikaFrontendClient.add_logs
      def send_requests(requests)
        log = @log || Logger.new(STDOUT)  # for testing

        requests.each do |lsid, body|
          begin
            log.info "AddLog request with lsid #{lsid}, segment_timestamp #{body.segment_timestamp}, "\
                        "file_identifier #{body.file_identifier}, entries: #{body.payload.size}"

            if @is_service_enclave
              if @logging_tenancy.nil?
                raise "logging tenancy must be set in service enclave"
              end
              cross_tenancy = {:'x-cross-tenancy-request' => @logging_tenancy }
              resp = @client.add_logs(lsid, body, additional_headers: cross_tenancy)
            else
              resp = @client.add_logs(lsid, body)
            end
            log.info "response #{resp.status} id: #{resp.request_id}, entries: #{body.payload.size}, "\
                        "size : #{(body.payload.to_json.bytesize / 1024).round} KB, "\
                        "request metadata: #{@lsid_to_metadata_map[lsid]}"

            update_output_plugin_response_map("oci_lumberjack", resp.status, body.file_identifier)

          rescue OCI::Errors::ServiceError => service_error
            log.error "Service Error received sending request with lsid #{lsid}: #{service_error}"
            update_output_plugin_response_map("oci_lumberjack", service_error.status_code, body.file_identifier)
            if service_error.status_code == 400
              log.info "Eating service error as it is caused by Bad Request[400 HTTP code]"
            else
              log.error "Throwing service error for status code:#{service_error.status_code} as we want fluentd to re-try"
              raise
            end
          rescue OCI::Errors::NetworkError => network_error
            log.error "Network Error received sending request with lsid #{lsid}: #{network_error}"
            update_output_plugin_response_map("oci_lumberjack", network_error.code, body.file_identifier)
            if network_error.code == 400
              log.info "Eating network error as it is caused by Bad Request[400 HTTP code]"
            else
              log.error "Throwing network error for code:#{network_error.code} as we want fluentd to re-try"
              raise
            end
          rescue StandardError => standard_error
            log.error "Standard Error received sending request with lsid #{lsid}: #{standard_error}"
            raise
          end
        end
      end

    end
  end
end
