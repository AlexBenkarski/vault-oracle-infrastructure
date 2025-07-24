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

require 'oci/errors'
require 'oci/hydra_pika_client/hydra_pika_client'
require 'oci/internal/internal'
require 'oci/retry/retry'
require 'oci/response_headers'
require 'oci/object_storage/object_storage'

module Fluent
  module Plugin

    DEFAULT_PLUGIN_ID = "lumberjack-worker-1".freeze

    class BadRequestError < StandardError

      def initialize(msg = "Bad Request")
        super
      end

    end
    ##
    # Module containing functionality related to logstream management
    module LumberjackLogstream
      ##
      # Calculate logstream id and create it or return if already calculated.
      # Updates the value of @lsid_hash.
      #
      # @param [String] group The log group.
      # @param [String] resource The log resource.
      def get_lsid(group, resource, custom_identifier, plugin_id)
        # add a default for plugin not passing the plugin id
        plugin_id = plugin_id || DEFAULT_PLUGIN_ID
        log = @log || Logger.new(STDOUT)  # for testing
        hostname = getTrueHostName(custom_identifier)
        # Adding this temporarily to handle syslog differently
        # LSID's will be based on unique file name vs unique file path
        # Thus reducing the number of log streams drastically and decreasing CPU usage of griffin in syslogcanon
        is_syslogcanon = custom_identifier.include? SYSLOGCANON
        syslog_custom_identifier = ""
        if custom_identifier == ""
          key = "#{group}|#{resource}|#{plugin_id}|#{@logType}|#{hostname}"
        elsif is_syslogcanon
          syslog_custom_identifier = getKey(custom_identifier)
          key = "#{group}|#{resource}|#{plugin_id}|#{@logType}|#{hostname}|#{syslog_custom_identifier}"
        else
          key = "#{group}|#{resource}|#{plugin_id}|#{@logType}|#{hostname}|#{custom_identifier}"
        end

        unless @log_object_id.nil?
          key += "|#{@log_object_id}"
        end

        lsid = ""

        begin
          unless @lsid_hash.key?(key)
            body = OCI::HydraPikaClient::Models::\
                   AddLogStreamDefinitionRequestBody.new
            body.log_group = group
            body.resource = resource
            body.log_type = @logType

            if custom_identifier == ""
              body.custom_identifiers = {:compartmentId => @is_service_enclave ? @env['metadata']['newCompartmentId'] || @env['compartmentId'] : @env['compartmentId'], :hostname => hostname, :worker_id => plugin_id}
            elsif is_syslogcanon
              body.custom_identifiers = {:compartmentId => @env['metadata']['newCompartmentId'] || @env['compartmentId'], :source_path => "#{syslog_custom_identifier}", :hostname => hostname}
            else
              body.custom_identifiers = {:compartmentId => @is_service_enclave ? @env['metadata']['newCompartmentId'] || @env['compartmentId'] : @env['compartmentId'], :source_path => custom_identifier, :hostname => hostname, :worker_id => plugin_id}
            end

            unless @log_object_id.nil?
              body.custom_identifiers[:siem_logid] = @log_object_id
            end

            log.info "Logstream add definition request with target compartment #{@compartment}, namespace #{@namespace}, "\
            "body #{body}"

            if @is_service_enclave
              if @logging_tenancy.nil?
                raise "logging tenancy must be set in service enclave"
              end
              resp = @client.add_log_stream_definition(
                    @compartment, @namespace, body, additional_headers: {:'x-cross-tenancy-request' => @logging_tenancy})
            else
              resp = @client.add_log_stream_definition(@compartment, @namespace, body)
            end

            log.info "Logstream add definition response #{resp.status} "\
                     "id: #{resp.request_id}, log_stream_definition: #{resp.data.log_stream_definition}"
            lsid = resp.data.log_stream_definition.lsid
            log.debug "Logstream add definition got lsid #{lsid} for key #{key}"
            @lsid_hash[key] = lsid
            @lsid_to_metadata_map[lsid] = key
          end
          @lsid_hash[key]

        rescue OCI::Errors::ServiceError => service_error
          log.error "Service error received sending request with lsid #{lsid}: #{service_error.full_message}"
          if service_error.status_code == 400
            log.info "Bad request error received :#{service_error.status_code}"
            raise BadRequestError
          else
            log.info "Throwing service error for status code:#{service_error.status_code} as we want fluentd to re-try"
            raise
          end
        rescue OCI::Errors::NetworkError => network_error
          log.error "Network Error received sending request with lsid #{lsid}: #{network_error.full_message}"
          if network_error.code == 400
            log.info "Bad request error received :#{network_error.code}"
            raise BadRequestError
          else
            log.info "Throwing network error for code:#{network_error.code} as we want fluentd to re-try"
            raise
          end
        rescue StandardError => standard_error
          log.error "Standard Error received sending request with lsid #{lsid}: #{standard_error.full_message}"
          raise
        end

      end

      # Adding this API to extract substring from new syslog log file structure.
      # getKey("path/to/log/director/10.166.x.x-2022-03-03-21_h.log") =>  10.166.x.x.log
      # getKey("path/to/log/director/local.log") =>  local.log
      def getKey(custom_identifier)
        log_file_name = File.basename(custom_identifier, ".*")
        split_file_names = log_file_name.split('-',2);
        "#{split_file_names[0]}.log"
      end

      #Adding this API to get hostname and if required true host name(for example CDSLOGGING)
      # hostname = @env[‘hostname’]
      # Extract the true host name for CDSLOGGING
      # getTrueHostName("/var/log/hosts/*/audit.log") =>  *

      def getTrueHostName(custom_identifier)
        hostname = @env['hostname']
        hostclass = @env['hostclass']
        if custom_identifier.include?('audit.log') && hostclass == CDSLOGGING
          truehostname =File.basename(File.dirname(custom_identifier))
          unless truehostname.nil? || truehostname == ""
            hostname =  truehostname
          end
        end
        return hostname
      end
    end
  end
end
