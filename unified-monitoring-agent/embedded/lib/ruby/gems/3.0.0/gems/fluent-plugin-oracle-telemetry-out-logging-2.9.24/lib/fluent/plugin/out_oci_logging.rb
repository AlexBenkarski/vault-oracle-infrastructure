require_relative 'logging_utils'
require_relative 'logging_setup'
require 'socket'
require 'proxy_file_loader'
require 'uma_source_loader'

module Fluent
  module Plugin
    class PublicLoggingOutput < Fluent::Plugin::Output
      include Fluent::Plugin::PublicLoggingUtils
      include Fluent::Plugin::PublicLoggingSetup

      Fluent::Plugin.register_output("oci_logging", self)

      ## overrides for testing
      # allow instance metadata to be configurable (for testing)
      config_param :metadata_override, :hash, default: nil
      # Path to the PEM CA certificate file for TLS. Can contain several CA certs.
      # We are defaulting to '/etc/oci-pki/ca-bundle.pem'
      # This can be overriden for testing.
      config_param :ca_file, :string, default: PUBLIC_DEFAULT_LINUX_CA_PATH
      # Override to manually provide the host endpoint
      config_param :logging_endpoint_override, :string, default: nil
      # Override to manually provide the federation endpoint
      config_param :federation_endpoint_override, :string, default: nil
      # The only required parameter used to identify where we are sending logs for LJ
      config_param :log_object_id, :string
      # optional forced override for debugging, testing, and potential custom configurations
      config_param :principal_override, :string, default: nil
      # parameter for hiding metadata
      config_param :hide_metadata, :bool, default: false
      # parameter for flattening the json payload
      config_param :flatten, :bool, default: true

      attr_accessor :client
      attr_accessor :hostname
      helpers :event_emitter

      PAYLOAD_SIZE = 9*1024*1024 #restricting payload size at 9MB

      def configure(conf)
        super
        log.debug "determining the signer type"

        oci_config, signer_type = get_signer_type(principal_override: @principal_override)
        signer = get_signer(oci_config, signer_type)
        log.info "using authentication principal #{signer_type}"

        log.info 'Loading proxy settings'
        config_dir ||= OS.windows? ? WINDOWS_OCI_CONFIG_DIR : LINUX_OCI_CONFIG_DIR
        proxy_settings = OCI::ProxyFileLoader.load_proxy_settings(config_dir: config_dir, log: log)
        @uma_source_config = OCI::UmaSourceLoader.load_uma_source_config(config_dir: config_dir, log: log)
        @client = OCI::HydraFrontendPublicClient::LoggingClient.new(
          config: oci_config,
          endpoint: get_logging_endpoint(@region, logging_endpoint_override: @logging_endpoint_override),
          signer: signer,
          proxy_settings: proxy_settings,
          retry_config: nil
        )
        @flatten=(ENV['FLATTEN_JSON_PAYLOAD'] || @flatten).to_s == 'true'
        @client.api_client.request_option_overrides = { ca_file: @ca_file }
      end

      def multi_workers_ready?
        true
      end

      def start
        super
        # ...
        log.debug 'start'
      end

      #### Sync Buffered Output ##############################
      # Implement write() if your plugin uses a normal buffer.
      # Read "Sync Buffered Output" for details.
      ########################################################
      def write(chunk)
        log.debug "writing chunk metadata #{chunk.metadata}", \
                  dump_unique_id_hex(chunk.unique_id)
        log_batches_map = {}
        size = 0
        # For standard chunk format (without #format() method)
        chunk.each do |time, record|
          begin
            tag = get_modified_tag(chunk.metadata.tag)
            source_identifier = record.key?('tailed_path') ? record['tailed_path'] : ""
            if tag.include?('wlp_') && File.fnmatch('/var/log/wlp-agent*/audit/wlp-events.log', source_identifier)
              metadata = get_instance_metadata
              record.merge!(metadata)
            end
            content = @flatten? flatten_hash(record): record
            utf8_content = content.to_s.encode('UTF-8', invalid: :replace, undef: :replace, replace: ' ')
            size += utf8_content.to_json.bytesize
            build_request(time, record, tag, log_batches_map, source_identifier, @uma_source_config)
            if size >= PAYLOAD_SIZE
              log.info "Exceeding payload size. Size : #{size}"
              send_requests(log_batches_map)
              log_batches_map = {}
              size = 0
            end
          rescue StandardError => e
            log.error(e.full_message)
          end
        end
        # flushing data to LJ
        unless log_batches_map.empty?
          log.info "Payload size : #{size}"
          send_requests(log_batches_map)
        end
      end
    end
  end
end
