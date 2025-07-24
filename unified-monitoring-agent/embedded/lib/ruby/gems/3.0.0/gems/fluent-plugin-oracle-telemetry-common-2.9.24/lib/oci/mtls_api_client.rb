require 'oci/api_client'
require 'oci/internal/internal'
require 'oci/response_headers'
require 'oci/object_storage/object_storage'
require 'net/http'

# Net::HTTP has an outstanding bug that excludes the extra_chain_cert parameter,
# which needs to be passed to OpenSSL to handle our intermediate CA certificate.
# We'll patch Net::HTTP to make that attribute available.
# Ref: https://bugs.ruby-lang.org/issues/9758
class Net::HTTP
  SSL_IVNAMES << :@extra_chain_cert unless SSL_IVNAMES.include?(:@extra_chain_cert)
  SSL_ATTRIBUTES << :extra_chain_cert unless SSL_ATTRIBUTES.include?(:extra_chain_cert)

  attr_accessor :extra_chain_cert
end


module OCI
  class MTLSApiClient < OCI::ApiClient

    CA_BUNDLE_FILE = "/etc/oci-pki/ca-bundle.pem"
    PKI_NODE_CERT_FILE = "/var/certs/static/sparta/node-instance-cert/cert.pem"
    PKI_NODE_KEY_FILE = "/var/certs/static/sparta/node-instance-cert/key.pem"
    PKI_NODE_INTERMEDIATES_FILE = "/var/certs/static/sparta/node-instance-cert/intermediates.pem"

    # Override method in OCI::ApiClient
    # Remove signer from parent class as MTLS does not involve signing process for api call
    def initialize(config, proxy_settings: nil)
      raise "Missing the required parameter 'config' when initializing ApiClient." if config.nil?

      @config = config
      @default_headers = {}
      @request_option_overrides = {}
      @proxy_settings = proxy_settings
    end

    # Override method in OCI::ApiClient
    #
    # Call an API with given options.
    #
    # @param [Symbol] http_method HTTP method/verb (e.g. :post, :get)
    # @param [String] path URL path (e.g. /volumeAttachments/)
    # @param [String] endpoint URL of the endpoint (e.g https://iaas.us-phoenix-1.oraclecloud.com/20160918)
    # @option opts [Hash] :header_params Header parameters
    # @option opts [Hash] :query_params Query parameters
    # @option opts [Hash] :form_params Form parameters
    # @option opts [Object] :body HTTP body in JSON
    # @option [Block] block Allow to receive data from http body as streaming
    #
    # @return [Array<(Object, Fixnum, Hash)>] an array of 3 elements:
    #   the data deserialized from response body (could be nil), response status code,
    #   and response headers.
    def call_api(http_method, path, endpoint, opts, &block)
      http_method = http_method.to_sym.downcase

      call_api_inner(http_method, path, endpoint, opts, &block)
    end

    # Override method in OCI::ApiClient
    def call_api_inner(http_method, path, endpoint, opts, &block)
      query_params = opts[:query_params] || {}
      header_params = @default_headers.merge(opts[:header_params] || {})
      form_params = opts[:form_params] || {}
      body = opts[:body] || nil

      url = ApiClient.append_query_params(build_request_url(path, endpoint), query_params)
      uri = URI(url)

      request = nil

      if http_method == :get
        request = Net::HTTP::Get.new(uri)
      elsif http_method == :post
        request = Net::HTTP::Post.new(uri)
      else
        raise "new http method (#{http_method}) needs to be supported!"
      end

      if body.respond_to?(:read) && body.respond_to?(:write)
        request.body_stream = body
      else
        body = build_request_body(header_params, form_params, body) if %i[post].include?(http_method)
        request.body = body
      end

      @config.logger.debug "HTTP request body param ~BEGIN~\n#{body}\n~END~\n" if @config.logger

      header_params.each do |key, value|
        request[key.to_s] = value
      end

      request['opc-client-info'] = self.class.build_user_info
      request['opc-request-id'] ||= self.class.build_request_id
      request['User-Agent'] = build_user_agent

      http = get_http_object(uri.hostname, uri.port)

      http.use_ssl = (uri.scheme == 'https')
      http.set_debug_output(@config.log_requests ? $stdout : nil)
      http.open_timeout = @config.connection_timeout
      http.read_timeout = @config.timeout.zero? ? 31_536_000 : @config.timeout # 31536000 means 365 days

      # Http Config used for MTLS
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.cert = get_pki_node_cert
      http.key = get_pki_node_key
      http.ca_file = CA_BUNDLE_FILE
      http.extra_chain_cert = get_pki_node_intermediate_list

      response_ref = nil
      begin
        http.start do
          http.request(request) do |response|
            response_ref = response

            # process headers for opc-meta- key
            replace_keys_in_response_headers_with_non_prefixed_equivalents(response, 'opc-meta-')

            # Either stream the body through a block (if we have one) and return, or read the body so that it can be accessed
            # again later and jump out of the http.start block
            #
            # The idea is to terminate the HTTP connection as early as possible. There are two main reasons for
            # this:
            #
            #   1. Net::HTTP can throw a lot of exceptions, both from itself and what bubbles up from the underlying OS
            #      via Errno:: so we have a very broad rescue block. This isn't great because the more work we do inside the
            #      http.start block the more gaps we leave for non-Net::HTTP related errors. This makes it hard to throw
            #      a meaningful error back to the customer (i.e. we leave ourselves gaps where Errors::NetworkError does not apply
            #      and could throw something disingenuous if we mask everything as a NetworkError)
            #
            #   2. Release resources sooner/don't hold connections open longer than necessary (e.g. we don't need the
            #      connection open while we're deserialising)
            return process_response_block(response, &block) if success?(response) && !block.nil?

            response.body
          end
        end
      rescue StandardError => e
        # Unfortunately, catching StandardError is the surest way to capture all the errors originating from Net::HTTP
        code_from_response = if !response_ref.nil?
                               response_ref.code.to_i
                             else
                               0
                             end

        raise Errors::NetworkError.new(
            e.message,
            code_from_response,
            request_made: request,
            response_received: response_ref
        )
      end

      # If the response is a timeout (HTTP 408), it does not make sense to parse the http body because a partial
      # response may be returned. We should skip JSON parsing and raise an error immediately
      handle_timeout_response(request, response_ref)

      @config.logger.debug("HTTP response body ~BEGIN~\n#{response_ref.body}\n~END~\n") if @config.logger

      return handle_success_response(request, response_ref, opts[:return_type]) if success?(response_ref)

      handle_non_success_response(request, response_ref)
    end

    def get_pki_node_cert
      OpenSSL::X509::Certificate.new(File.read(PKI_NODE_CERT_FILE))
    end

    def get_pki_node_key
      OpenSSL::PKey::RSA.new(File.read(PKI_NODE_KEY_FILE))
    end

    def get_pki_node_intermediate_list
      [OpenSSL::X509::Certificate.new(File.read(PKI_NODE_INTERMEDIATES_FILE))]
    end

  end
end
