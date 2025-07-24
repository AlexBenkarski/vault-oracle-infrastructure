# frozen_string_literal: true

require 'oci/base_signer'
require 'oci/auth/util'
require 'oci/auth/session_key_supplier'
require 'oci/auth/federation_client'
require 'oci/auth/security_token_container'
require 'oci/auth/signers/x509_federation_client_based_security_token_signer'
require 'oci/api_client'
require 'net/http'
require_relative 'environment'
require_relative 'file_based_certificate_supplier'

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

    def initialize(
      cert_path,
      private_key_path,
      intermediate_cert_path,
      cert_bundle_path,
      federation_endpoint: nil
      )

      env = OCI::Environment.new
      cert = FileBasedCertificateSupplier.new(cert_path, private_key_path: private_key_path)

      @federation_client = CustomFederationClient.new(
        federation_endpoint || env.endpoint('auth') + '/v1/x509',
        extract_tenant_id(cert.certificate),
        OCI::Auth::SessionKeySupplier.new,
        cert,
        intermediate_certificate_suppliers: [
          FileBasedCertificateSupplier.new(intermediate_cert_path)
        ],
        cert_bundle_path: cert_bundle_path
      )

      super(
        @federation_client,
        signing_strategy: OCI::BaseSigner::STANDARD,
        headers_to_sign_in_all_requests: %i[date (request-target) host x-cross-tenancy-request],
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
