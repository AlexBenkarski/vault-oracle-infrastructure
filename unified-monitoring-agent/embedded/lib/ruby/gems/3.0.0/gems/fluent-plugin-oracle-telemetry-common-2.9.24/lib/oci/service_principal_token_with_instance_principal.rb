# frozen_string_literal: true

# https://bitbucket.oci.oraclecorp.com/projects/UA/repos/fluentd-metrics-agent/browse/fluent-plugin-oracle-telemetry-common/lib/oci/service_principals_security_token_signer.rb
# https://bitbucket.oci.oraclecorp.com/projects/SDK/repos/ruby-sdk/browse/lib/oci/auth/signers/instance_principals_security_token_signer.rb
# Merge these two to force ServicePrincipalsSecurityTokenSigner to use service principal token from instance principal
# And added 'purpose' => 'SERVICE_PRINCIPAL'

require 'oci/base_signer'
require 'oci/regions'
require 'oci/api_client'
require 'net/http'
require 'uri'
require_relative 'environment'
require_relative 'file_based_certificate_supplier'
require 'oci/auth/signers/instance_principals_security_token_signer'
require 'oci/auth/signers/resource_principals_signer'
require 'oci/auth/signers/ephemeral_resource_principals_signer'
require 'oci/auth/signers/resource_principals_federation_signer'
require 'oci/auth/signers/security_token_signer'
require 'oci/auth/signers/instance_principals_delegation_token_signer'
require 'oci/auth/signers/x509_federation_client_based_security_token_signer'
require 'oci/auth/signers/resource_principal_token_path_provider/default_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/env_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/imds_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/string_rpt_path_provider'
require 'oci/auth/auth'
require 'oci/auth/util'
require 'oci/auth/session_key_supplier'
require 'oci/auth/url_based_certificate_retriever'
require 'oci/auth/federation_client'
require 'oci/auth/security_token_container'
require 'oci/auth/internal/auth_token_request_signer'

module OCI

  class << self
    attr_accessor :sdk_name

    # Defines the logger used for debugging for the OCI module.
    # For example, log to STDOUT by setting this to Logger.new(STDOUT).
    #
    # @return [Logger]
    attr_accessor :logger
  end

  # signer for service principal
  class ServicePrincipalsSecurityTokenSigner < OCI::Auth::Signers::X509FederationClientBasedSecurityTokenSigner
    # The region the instance is in, as returned from the metadata endpoint for the instance
    #   (http://169.254.169.254/opc/v2/instance/region)
    # @return [String] The region for the instance
    attr_reader :region

    METADATA_URL_BASE = 'http://169.254.169.254/opc/v2'.freeze
    GET_REGION_URL = "#{METADATA_URL_BASE}/instance/region".freeze
    GET_REGION_INFO_URL = "#{METADATA_URL_BASE}/instance/regionInfo/".freeze
    LEAF_CERTIFICATE_URL = "#{METADATA_URL_BASE}/identity/cert.pem".freeze
    LEAF_CERTIFICATE_PRIVATE_KEY_URL = "#{METADATA_URL_BASE}/identity/key.pem".freeze
    INTERMEDIATE_CERTIFICATE_URL = "#{METADATA_URL_BASE}/identity/intermediate.pem".freeze

    # Creates a new monkey patched ServicePrincipalsSecurityTokenSigner in which it is actually an InstancePrincipalsSecurityTokenSigner
    def initialize(
      federation_endpoint: nil
    )

      env = OCI::Environment.new
      # cert = FileBasedCertificateSupplier.new(cert_path, private_key_path: private_key_path)
      @leaf_certificate_retriever = OCI::Auth::UrlBasedCertificateRetriever.new(
        LEAF_CERTIFICATE_URL, private_key_url: LEAF_CERTIFICATE_PRIVATE_KEY_URL
      )
      @intermediate_certificate_retriever = OCI::Auth::UrlBasedCertificateRetriever.new(
        INTERMEDIATE_CERTIFICATE_URL
      )
      @tenancy_id = OCI::Auth::Util.get_tenancy_id_from_certificate(
        @leaf_certificate_retriever.certificate
      )
      uri = URI(GET_REGION_URL)
      raw_region_client = Net::HTTP.new(uri.hostname, uri.port)
      raw_region = nil
      raw_region_client.request(OCI::Auth::Util.get_metadata_request(GET_REGION_URL, 'get')) do |response|
        raw_region = response.body.strip.downcase
      end
      symbolised_raw_region = raw_region.to_sym
      @region = if OCI::Regions::REGION_SHORT_NAMES_TO_LONG_NAMES.key?(symbolised_raw_region)
                  OCI::Regions::REGION_SHORT_NAMES_TO_LONG_NAMES[symbolised_raw_region]
                else
                  raw_region
                end

      @federation_client = CustomFederationClient.new(
        federation_endpoint || env.endpoint('auth') + '/v1/x509',
        @tenancy_id,
        OCI::Auth::SessionKeySupplier.new,
        @leaf_certificate_retriever,
        intermediate_certificate_suppliers: [
          @intermediate_certificate_retriever
        ],
        cert_bundle_path: nil
      )

      super(
        @federation_client,
        signing_strategy: OCI::BaseSigner::STANDARD,
        headers_to_sign_in_all_requests: %i[date (request-target) host],
        body_headers_to_sign: OCI::BaseSigner::BODY_HEADERS
      )
    end

    def extract_tenant_id(x509_certificate)
      tenant_id = nil, type = nil

      subject_array = x509_certificate.subject.to_a
      subject_array.each do |subject_name|
        if subject_name[0] == 'O' && subject_name[1].start_with?('opc-identity:')
          tenant_id = subject_name[1][13..-1]
        elsif subject_name[0] == 'OU' && subject_name[1].start_with?('opc-certtype:')
          type = subject_name[1][13..-1]
        end
      end

      return tenant_id if type == 'service' && !tenant_id.nil?

      raise 'Certificate did not contain a tenancy in its subject'
    end

  end

  # overriding default behavior of FederationClient, as it can't extract
  # tenant id from certificate.
  class CustomFederationClient < OCI::Auth::FederationClient
    # exact same as FederationClient.refresh_security_token_inner except
    # this disabled updating tenancy id
    def refresh_security_token_inner
      @refresh_lock.lock

      @session_key_supplier.refresh
      @leaf_certificate_supplier.refresh

      @intermediate_certificate_suppliers.each(&:refresh)

      leaf_certificate_pem = @leaf_certificate_supplier.certificate_pem
      request_payload = {
        'purpose': 'SERVICE_PRINCIPAL',
        'certificate': OCI::Auth::Util.sanitize_certificate_string(leaf_certificate_pem),
        'publicKey': OCI::Auth::Util.sanitize_certificate_string(@session_key_supplier.key_pair[:public_key].to_pem)
      }

      unless @intermediate_certificate_suppliers.empty?
        retrieved_certs = []
        @intermediate_certificate_suppliers.each do |supplier|
          retrieved_certs << OCI::Auth::Util.sanitize_certificate_string(supplier.certificate_pem)
        end
        request_payload['intermediateCertificates'] = retrieved_certs
      end

      fingerprint = OCI::Auth::Util.colon_separate_fingerprint(
        OpenSSL::Digest::SHA1.new(@leaf_certificate_supplier.certificate.to_der).to_s
      )
      signer = OCI::Auth::Internal::AuthTokenRequestSigner.new(@tenancy_id,
                                                               fingerprint,
                                                               @leaf_certificate_supplier.private_key_pem)

      request = ::Net::HTTP::Post.new(@federation_endpoint)
      request.body = request_payload.to_json

      header_params = {}
      header_params[:'content-type'] = 'application/json'
      signer.sign(:post, @federation_endpoint, header_params, request.body)
      header_params.each { |key, value| request[key.to_s] = value }

      # Additional header info to aid in debugging issues
      request[:'opc-client-info'] = OCI::ApiClient.build_user_info
      request[:'opc-request-id'] ||= OCI::ApiClient.build_request_id
      request[:'User-Agent'] = OCI::ApiClient.build_user_agent

      raw_body = nil
      @federation_http_client.start do
        @federation_http_client.request(request) do |response|
          raw_body = response.body
        end
      end

      begin
        parsed_response = JSON.parse(raw_body)
        raise "No token received in the response from auth service: #{raw_body}" unless parsed_response.key?('token')

        @security_token = OCI::Auth::SecurityTokenContainer.new(parsed_response['token'])
      rescue JSON::ParserError => e
        raise "Unable to parse response from Auth Service [#{e}]: #{raw_body}"
      end

      @security_token.security_token
    ensure
      @refresh_lock.unlock if @refresh_lock.locked? && @refresh_lock.owned?
    end
  end
end
