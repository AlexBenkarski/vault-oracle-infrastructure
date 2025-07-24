# frozen_string_literal: true

require 'fluent/plugin/output'
require 'oci/config'
require_relative '../service_principals_security_token_signer'
require_relative '../service_principal_oci_config'
require_relative '../util/signer'

module Fluent::Plugin
  module MetricsRelay
    # Base Output Plugin for OCI services
    class OciServiceOutput < Fluent::Plugin::Output
      include ::OCI::Util::Signer
      helpers :formatter

      config_section :format do
        config_set_default :@type, 'metrics'
      end

      config_section :principal do
        # 'instance' / 'service' / 'user / 'mtls' / 'auto'
        config_param :@type, :string, default: 'instance'
        # when @type=='user', either specify a .oci/config profile:
        config_param :oci_config_profile, :string, default: nil
        # or provide the details individually
        config_param :user, :string, default: nil
        config_param :fingerprint, :string, default: nil
        config_param :key_path, :string, default: nil
        config_param :cert_path, :string, default: nil
        config_param :intermediate_cert_path, :string, default: nil
        config_param :tenancy, :string, default: nil
        config_param :federation_endpoint, :string, default: nil
        config_param :pass_phrase, :string, default: nil
      end

      def configure(conf)
        ensure_config_section(conf, 'format')
        ensure_config_section(conf, 'principal')

        super
        @env = OCI::Environment.new
        @env.region_override = conf['region']
        @oci_config = create_oci_config
        @formatter = formatter_create
      end

      def multi_workers_ready?
        true
      end

      def create_signer(principal)
        principal_type = principal['@type']
        log.info "Principal Type: #{principal_type}"

        default_cert_bundle_path = '/etc/oci-pki/ca-bundle.pem'

        case principal_type
        when 'user'
          ::OCI::Signer.new(
                @oci_config.user,
                @oci_config.fingerprint,
                @oci_config.tenancy,
                @oci_config.key_file,
                pass_phrase: @oci_config.pass_phrase)
        when 'service'
          endpoint = principal['federation_endpoint']
          key_path = principal['key_path']
          cert_path = principal['cert_path']
          intermediate_cert_path = principal['intermediate_cert_path']
          cert_bundle_path = principal['cert_bundle_path'] || default_cert_bundle_path

          log.info "federation_endpoint = #{endpoint}" unless endpoint.nil?
          log.info "cert_bundle_path = #{cert_bundle_path}"

          ::OCI::ServicePrincipalsSecurityTokenSigner.new(
              cert_path, key_path, intermediate_cert_path, cert_bundle_path, federation_endpoint: endpoint)
        when 'instance'
          log.info "principal type is 'instance', creating instance signer"
          create_instance_principal_signer(principal['federation_endpoint'], principal['cert_bundle_path'], @env['realm'])
        when 'resource'
          log.info "principal type is 'resource', creating resource signer"
          create_resource_principal_signer
        when 'auto'
          log.info "principal type is 'auto', creating signer based on system setup"
          signer = create_resource_principal_signer
          if signer == nil
            log.info("resource principal is not supported, use instance principal instead")
            signer = create_instance_principal_signer(principal['federation_endpoint'], principal['cert_bundle_path'], @env['realm'])
          else
            log.info("use resource principal")
          end

          return signer
        else
          raise "Unsupported principal type: #{principal_type}"
        end
      end

      def ensure_config_section(conf, kind)
        if conf.elements(name: kind).empty?
          e = Fluent::Config::Element.new(kind, '', {}, [])
          conf.elements << e
        end
      end

      # Create and configure the OCI SDK Configuration object. This can be either
      # - an existing config profile in ~/.oci/config
      # - a dynamic profile created from FluentD config param values (under <principal>)
      def create_oci_config
        # only the 1st <principal> block is evaluated
        principal = @principal[0]
        case principal['@type']
        when 'user'
          if principal['oci_config_profile']
            @oci_config = OCI::ConfigFileLoader.load_config(
                profile_name: principal['oci_config_profile'])
          else
            log.info 'Using OCI config from fluentd config params'
            @oci_config = OCI::Config.new
            @oci_config.user        = principal['user']
            @oci_config.region      = @env.resolve_region
            @oci_config.tenancy     = principal['tenancy']
            @oci_config.key_file    = principal['key_path']
            @oci_config.pass_phrase = principal['pass_phrase']
            @oci_config.fingerprint = principal['fingerprint']
          end
        when 'service'
          @oci_config = ServicePrincipalOciConfig.new
        else
          # possibly add timeout config here
          @oci_config = OCI::Config.new
        end
        # Running fluentd with -vv will enable the OCI SDK to log all requests to the backend.
        # make sure to limit nr of metric samples per poll cycle, otherwise you'll surely clog your terminal...
        @oci_config.log_requests = true if log.level == Fluent::Log::LEVEL_TRACE
        @oci_config
      end

      def set_default_ca_file
        if @ca_file.nil?
          if @env['region'] == 'r1' && !@env['is_service_enclave']
            @ca_file = '/etc/pki/tls/certs/ca-bundle.crt'
          else
            @ca_file = '/etc/oci-pki/ca-bundle.pem'
          end
        end
      end
    end

  end
end
