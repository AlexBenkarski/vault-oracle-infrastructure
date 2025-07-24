require 'oci/hydra_pika_client/hydra_pika_client'
require 'oci/mtls_api_client'

# Remove signer from parent class as MTLS does not involve signing process for api call
module OCI
  class MTLSHydraPikaFEClient < OCI::HydraPikaClient::HydraPikaFrontendClient
    # Creates a new MTLSCPClient.
    # @param [Config] config A Config object.
    # @param [String] endpoint The fully qualified endpoint URL
    # @param [OCI::ApiClientProxySettings] proxy_settings If your environment requires you to use a proxy server for outgoing HTTP requests
    #   the details for the proxy can be provided in this parameter
    # @param [OCI::Retry::RetryConfig] retry_config The retry configuration for this service client. This represents the default retry configuration to
    #   apply across all operations. This can be overridden on a per-operation basis. The default retry configuration value is `nil`, which means that an operation
    #   will not perform any retries
    def initialize(config:, endpoint:, proxy_settings: nil, retry_config: nil)

      @api_client = OCI::MTLSApiClient.new(config, proxy_settings: proxy_settings)
      @retry_config = retry_config
      @endpoint = endpoint + '/v1'
      logger.info "HydraPikaFrontendClient endpoint set to '#{@endpoint}'." if logger
    end
  end
end

