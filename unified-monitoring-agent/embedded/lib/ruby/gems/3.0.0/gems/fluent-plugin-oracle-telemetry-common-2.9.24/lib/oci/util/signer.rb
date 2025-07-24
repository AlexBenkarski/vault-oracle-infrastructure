require 'oci/auth/signers/resource_principals_signer'
require 'oci/auth/signers/instance_principals_security_token_signer'
require 'oci/auth/signers/resource_principal_token_path_provider/rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/default_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/env_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/imds_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/string_rpt_path_provider'
module OCI::Util
  module Signer

    RESOURCE_PRINCIPAL_ENV_FILE = "/etc/resource_principal_env"
    DEFAULT_CERT_BUNDLE_PATH = '/etc/oci-pki/ca-bundle.pem'
    ONSR_REALMS = ['oc5', 'oc6', 'oc7', 'oc11', 'oc12']

    def logger
      @log ||= Logger.new(STDOUT)
    end

    def create_resource_principal_signer
      begin
        logger.info 'creating resource principal'
        add_rp_env_override
        OCI::Auth::Signers.resource_principals_signer
      rescue => e
        logger.info("resource principal is not set up because #{e}")
        return nil
      end
    end

    def create_instance_principal_signer(federation_endpoint_override, federation_client_cert_bundle_override, realm = nil)
      # Most servers (linux) handle this by default for SSL, but windows doesn't and we have to explicitly specify
      # the ca-bundle that validates the SSL connection to the public auth endpoint. The check is to not pass in
      # anything if not specified

      logger.info("federation endpoint override = #{federation_endpoint_override}") unless federation_endpoint_override.nil?
      logger.info("ca-bundle override = #{federation_client_cert_bundle_override}") unless federation_client_cert_bundle_override.nil?

      federation_client_cert_bundle_override = federation_client_cert_bundle_override || DEFAULT_CERT_BUNDLE_PATH

      if !(ONSR_REALMS.include? realm) && federation_client_cert_bundle_override == DEFAULT_CERT_BUNDLE_PATH
        logger.info "create instance principal with system default ca bundle"
        ::OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner.new(
            federation_endpoint: federation_endpoint_override)
      else
        logger.info "ca-bundle #{federation_client_cert_bundle_override} will be used for instance principal"
        ::OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner.new(
            federation_endpoint: federation_endpoint_override,  federation_client_cert_bundle: federation_client_cert_bundle_override)
      end
    end

    def add_rp_env_override
      if ENV['LOCAL_TEST']
        # Will set resource principal in env variable for unit test
        logger.info "skip adding rp env from file in unit test"
        return
      end

      resource_principal_env = {}
      unless File.exist? RESOURCE_PRINCIPAL_ENV_FILE
        raise "resource principal env file is not exist"
      end

      file = File.readlines(RESOURCE_PRINCIPAL_ENV_FILE)
      file.each do |env|
        a = env.split("=")
        resource_principal_env[a[0]] = a[1].chomp
      end

      logger.info("resource principal env is set up with #{resource_principal_env}")
      ENV.update resource_principal_env
    end

  end
end
