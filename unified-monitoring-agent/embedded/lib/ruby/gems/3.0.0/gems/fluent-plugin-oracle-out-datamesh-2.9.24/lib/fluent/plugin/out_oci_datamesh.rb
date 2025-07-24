# frozen_string_literal: true

require 'socket'

require_relative 'datamesh_utils'
require_relative 'datamesh_setup'
require_relative 'client/data_mesh'

module Fluent
  module Plugin
    # OCI Datamesh Fluentd Output plugin
    class DatameshOutput < Fluent::Plugin::Output
      include Fluent::Plugin::DatameshUtils
      include Fluent::Plugin::DatameshSetup

      Fluent::Plugin.register_output('oci_datamesh', self)

      # The only required parameter used to identify where we are sending logs for LJ
      config_param :log_object_id, :string
      # allow instance metadata to be configurable (for testing)
      config_param :metadata_override, :hash, default: nil
      # allow vnics metadata to be configurable (for testing)
      config_param :vnics_override, :hash, default: nil
      # Path to the PEM CA certificate file for TLS. Can contain several CA certs.
      # We are defaulting to '/etc/oci-pki/ca-bundle.pem'
      # This can be overriden for testing.
      config_param :ca_file, :string, default: PUBLIC_DEFAULT_LINUX_CA_PATH
      # Override to manually provide the host endpoint
      config_param :oci_datamesh_endpoint_override, :string, default: nil
      # Override to manually provide the federation endpoint
      config_param :federation_endpoint_override, :string, default: nil
      # optional forced override for debugging, testing, and potential custom configurations
      config_param :principal_override, :string, default: nil

      attr_accessor :client, :hostname
      attr_reader :origin

      helpers :event_emitter

      def configure(conf)
        super
        log.debug('determining the signer type')

        oci_config, signer_type = config_and_signer_type(principal_override: @principal_override)
        oci_config.logger = log if log
        md = @metadata_override || retry_instance_md
        array_vnics_override = Array[@vnics_override] if @vnics_override
        vnics = array_vnics_override || retry_vnics_md
        signer = signer(oci_config, signer_type, md)
        
        log.info "using authentication principal #{signer_type}"

        @origin = get_origin(md, vnics)

        @client = DM::DMLoggingingestion::DMLoggingClient.new(
          config: oci_config,
          endpoint: oci_datamesh_endpoint(oci_datamesh_endpoint_override: @oci_datamesh_endpoint_override),
          region: @region,
          signer: signer,
          proxy_settings: nil,
          retry_config: nil
        )

        @client.api_client.request_option_overrides = { ca_file: @ca_file }
      end

      def start
        super
        log.debug 'start'
      end

      def multi_workers_ready?
        true
      end

      # There is no way to know the properties configured for the parser and input plugins that
      # generated this event, such plugins build a Hash with the properties configured, this
      # is best effort to attempt to extrat the source identifier from such Hash structure
      def extract_source_identifier(record, or_else)
        if record.key?('tailed_path')
          record['tailed_path']
        elsif record.key?('path') 
          record['path']
        else 
          or_else
        end
      end

      # There is no way to know the properties configured for the parser and input plugins that
      # generated this event, such plugins build a Hash with the properties configured, this
      # is best effort to attempt to extrat the actual contents (without the decorations) from such Hash structure
      def extract_content(record)
        if record.key?('message') 
          record['message']
        elsif record.key?('content') 
          record['content']
        else 
          record
        end
      end

      #### Sync Buffered Output ##############################
      # Implement write() if your plugin uses a normal buffer.
      ########################################################
      def write(chunk)
        log.debug("writing chunk metadata #{chunk.metadata}", dump_unique_id_hex(chunk.unique_id))
        log_batches_map = {}

        # For standard chunk format (without #format() method)
        chunk.each do |time, record|
          begin
            tag = get_modified_tag(chunk.metadata.tag)
            source_identifier = extract_source_identifier(record, tag)
            content_str = sanitized_content_str(extract_content(record))
            build_request(time, content_str, tag, log_batches_map, source_identifier)
          rescue StandardError => e
            log.error(e.full_message)
          end
        end
        # flushing data
        send_requests(log_batches_map, @origin)
      end
    end
  end
end
