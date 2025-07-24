require 'oci/hydra_controlplane_client/hydra_controlplane_client'
require 'oci/retry/retry'
require 'retriable'
require 'fluent/plugin/buf_memory'
require 'fluent/plugin/logging_setup'

module PublicCPRequests
  include Fluent::Plugin::PublicLoggingSetup
  # This version should be consistent with current fluentd version in ../../../lib/version.rb
  # cannot get access to the number in the version file during run time as the file is not included in gems
  FLUENT_VERSION = "1.16.5"
  FLUENT_TYPE = "FLUENTD"
  R1 = 'r1'
  R1_CP_ENDPOINT = "https://logging.r1.oci.oracleiaas.com"
  WINDOWS_UPLOADER_OUTPUT_LOG = "C:\\oracle_unified_agent\\unified-monitoring-agent\\unified-agent-config-updater.log"
  CONFIGURATION_TYPE_LOG = 'LOG'
  CONFIGURATION_TYPE_METRIC = 'METRIC'
  CONFIGURATION_TYPE_LOG_AND_METRIC = 'LOG_AND_METRIC'

  def initialize_public_cp_client(proxy_settings=nil, retry_config=nil)
    oci_config, signer_type = get_signer_type
    signer = get_signer(oci_config, signer_type)
    cp_endpoint = create_cp_endpoint
    @hostname_or_user_id = get_host_name

    logger.info"Using controlplane endpoint #{cp_endpoint}, signer type #{signer_type}"

    @cp_client ||= OCI::HydraControlplaneClient::LoggingManagementClient.new(
        config: oci_config,
        endpoint: cp_endpoint,
        signer:  signer,
        proxy_settings: proxy_settings,
        retry_config: retry_config
    )

    # cp_client is a wrapper to api_client in oci sdk.
    # To pass custom values to api_client, we use request_option_overrides
    @cp_client.api_client.request_option_overrides = { ca_file: @ca_file }

    # windows doesn't use OpenSSL natively which is how ruby invokes HTTPS so we need to allow the custom value
    # to override the default for public logging
    if OS.windows?
      @cp_client.api_client.request_option_overrides = { ca_file: @ca_file }
    end

  end

  def logger
    @log ||= OS.windows? ? Logger.new(WINDOWS_UPLOADER_OUTPUT_LOG) : ENV['CONFIG_DOWNLOADER_LOG']? Logger.new(ENV['CONFIG_DOWNLOADER_LOG']): Logger.new(STDOUT)
  end

  def get_generated_conf(opts = {})
    fluent_type = FLUENT_TYPE
    fluent_version = FLUENT_VERSION
    opts[:host_identifier] = @hostname_or_user_id
    opts[:configuration_type] = ENV['UMA_CONFIGURATION_TYPE'] == CONFIGURATION_TYPE_METRIC ? CONFIGURATION_TYPE_METRIC : CONFIGURATION_TYPE_LOG_AND_METRIC
    opts[:operating_system_type] = OS.windows? ? "WINDOWS": "LINUX"
    # Don't log the retry_config
    hdrs = opts.clone()
    opts[:retry_config] = OCI::Retry.default_retry_config

    logger.info("Load agent config from config service with fluent type #{fluent_type}, fluent version #{fluent_version}, headers #{hdrs}")

    begin
      resp = @cp_client.get_generated_unified_agent_configuration(fluent_type, fluent_version, opts)
      logger.info("resp:#{resp.status}, #{resp.data}, #{resp.data.configuration}")
      data_size = resp.data.configuration.bytesize if resp.status == 200 && resp.data && resp.data.configuration
      logger.info("data_size:#{data_size}")
    rescue => e
      logger.error("failed to send request to config service with fluent type #{fluent_type}, fluent version #{fluent_version}," \
              "error: [#{e}]")
      raise
    end

    logger.info("Successfully get response from config service, status code #{resp.status}, request id #{resp.request_id}, "\
            "metadata #{resp.data.metadata}, generated fluentd config \n ====================\n#{resp.data.configuration} \n=====================\n")

    { response: resp, data_size: data_size }
  end

  private

  ##
  # Calculate public cp endpoint from environment
  # Preference is given to the environment variable 'CP_ENDPOINT'.
  # @return [String] host The logging endpoint that will be used.
  def create_cp_endpoint
    if ENV['CP_ENDPOINT']
      endpoint = ENV['CP_ENDPOINT']
    else
      if @region == R1
        # SDK doesnt provide endpoint for r1
        endpoint = R1_CP_ENDPOINT
      else
        endpoint = "https://logging.#{@region}.oci.#{@realmDomainComponent}"
      end
    end

    logger.info("get cp endpoint #{endpoint}")
    endpoint
  end

end
