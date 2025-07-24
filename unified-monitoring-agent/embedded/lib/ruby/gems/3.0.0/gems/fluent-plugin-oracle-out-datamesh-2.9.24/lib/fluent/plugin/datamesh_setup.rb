# frozen_string_literal: true

require 'retriable'
require 'oci/common'
require 'oci/regions'
require 'oci/config_file_loader'
require 'oci/config'
require 'oci/signer'
require 'oci/auth/signers/resource_principals_signer'
require 'oci/auth/signers/instance_principals_security_token_signer'
require 'oci/auth/signers/resource_principals_federation_signer'
require 'oci/auth/signers/ephemeral_resource_principals_signer'
require 'oci/api_client'
require 'oci/auth/federation_client'
require 'oci/auth/security_token_container'
require 'oci/retry/retry'
require 'oci/errors'
require 'oci/internal/internal'
require 'oci/response_headers'
require 'oci/object_storage/object_storage'

require_relative 'os'
require_relative 'datamesh_utils'

module OCI
  class << self
    attr_accessor :sdk_name
    # Defines the logger used for debugging for the OCI module.
    # For example, log to STDOUT by setting this to Logger.new($stdout).
    #
    # @return [Logger]
    attr_accessor :logger
  end
end

module Fluent
  module Plugin
    # Setup code for OCI Datamesh
    module DatameshSetup
      RETRIES = 3
      USER_SIGNER_TYPE = 'user'
      AUTO_SIGNER_TYPE = 'auto'

      USER_CONFIG_PROFILE_NAME = "UNIFIED_MONITORING_AGENT"
      LINUX_OCI_CONFIG_DIR = "/etc/unified-monitoring-agent/.oci/config"
      WINDOWS_OCI_CONFIG_DIR = "C:\\oracle_unified_agent\\.oci\\config"
      PUBLIC_RESOURCE_PRINCIPAL_ENV_FILE = "/etc/resource_principal_env"

      R1_CA_PATH='/etc/pki/tls/certs/ca-bundle.crt'
      PUBLIC_DEFAULT_LINUX_CA_PATH = "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem"
      PUBLIC_DEFAULT_WINDOWS_CA_PATH = "C:\\oracle_unified_agent\\unified-monitoring-agent\\embedded\\ssl\\certs\\cacert.pem"
      PUBLIC_DEFAULT_UBUNTU_CA_PATH = '/etc/ssl/certs/ca-certificates.crt'
      PUBLIC_DEFAULT_DEBIAN_CA_PATH = PUBLIC_DEFAULT_UBUNTU_CA_PATH

      OCI_DATAMESH_FE_ENV_VAR = 'OCI_DATAMESH_FRONTEND'

      def logger
        @log ||= OS.windows? ? Logger.new(WINDOWS_UPLOADER_OUTPUT_LOG) : Logger.new($stdout)
      end

      ##
      # Calculate federation endpoints based on metadata and optional inputs
      #
      # @param [String] region the region identifier
      #
      # @return [String] the federation endpoint that will be used
      def federation_endpoint_for(region)
        if region == 'r1'
          endpoint = ENV['FEDERATION_ENDPOINT'] || 'https://auth.r1.oracleiaas.com/v1/x509'
        else
          if @realm_domain.nil?
            logger.warn('realm domain is null, fall back to OCI Regions')
            @realm_domain = OCI::Regions.get_second_level_domain(region)
          end

          endpoint = ENV['FEDERATION_ENDPOINT'] || "https://auth.#{region}.#{@realm_domain}/v1/x509"
        end

        logger.info("endpoint is #{endpoint} in region #{region}")
        endpoint
      end

      def retry_instance_md(retries = RETRIES)
        Retriable.retriable(tries: retries, on: StandardError, timeout: 12) do
          return imds_md("instance")
        end
      end

      def retry_vnics_md(retries = RETRIES)
        Retriable.retriable(tries: retries, on: StandardError, timeout: 12) do
          return imds_md("vnics")
        end
      end

      def imds_md(path)
        # v2 of IMDS requires an authorization header
        md = idms_md_with_url("http://169.254.169.254/opc/v2/#{path}")

        if md.nil?
          raise StandardError,
                "Failure fetching #{path} metadata, possible reason is network issue or host is not OCI instance"
        end
        logger.info("Successfully fetch #{path} metadata for hosts in overlay #{md}")
        md
      end

      def idms_md_with_url(uri_link)
        uri = URI.parse(uri_link)
        http = ::Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = 2 # in seconds
        http.read_timeout = 2 # in seconds
        request = ::Net::HTTP::Get.new(uri.request_uri)
        request.add_field('Authorization', 'Bearer Oracle') if uri_link.include?('v2')
        resp = http.request(request)

        JSON.parse(resp.body)
      rescue StandardError
        logger.warn("failed to get instance metadata with link #{uri_link}")
        nil
      end

      def get_platform_metadata(md, vnics)
        platform = {}
        platform[:'platform_type'] = "Oci"
        platform[:'hostname'] = md['hostname'] if md['hostname']
        first_vnic = vnics.first
        platform[:'ip'] = first_vnic["privateIp"] if first_vnic
        platform[:'instance_id'] = md['id'] if md['id']
        platform[:'compartment_id'] = md['compartmentId'] if md['compartmentId']
        platform[:'hostname_display'] = md['displayName'] if md['displayName']
        platform[:'physical_availability_domain'] = md['availabilityDomain'] if md['availabilityDomain']
        platform[:'availability_domain'] = md['ociAdName'] if md['ociAdName']
        platform[:'region_short_code'] = md['regionInfo']['regionKey'] if md['regionInfo']
        platform[:'region_canonical_name'] = md['canonicalRegionName'] if md['canonicalRegionName']
        platform[:'fault_domain'] = md['faultDomain'] if md['faultDomain']
        platform[:'image_id'] = md['image'] if md['image']

        # Tenancy id should be extracted in some other way maybe looking at the certs
        # certDataCurl=$(curl -sL --connect-timeout 10 --max-time 10 -H "Authorization: Bearer Oracle" http://169.254.169.254/opc/v2/identity/cert.pem || true)
        # OCI_TENANT_ID=$(echo "$certDataCurl" | openssl x509 -noout -subject | sed 's/^.*OU\s*=\s*opc-tenant:\([^\/]*\).*$/\1/')
        # For the time being, if running in a faaas host it is exposed via fa.user_data properties.

        md_metadata = md['metadata'] if md['metadata']
        md_metadata_userdata = md_metadata['userdata'] if md_metadata && md_metadata['userdata']
        platform[:'tenancy_id'] = md_metadata_userdata['tenancy_id'] if md_metadata_userdata && md_metadata_userdata['tenancy_id']
        platform
      end 

      def get_faaas_context(md)
        isFaaas = false
        md_metadata = md['metadata'] if md['metadata']
        if md_metadata
          isFaaas = md_metadata['isFAAAS'] if md_metadata['isFAAAS']
          if isFaaas
            md_metadata_userdata = md_metadata['userdata'] if md_metadata['userdata']
            md_metadata_servers = md_metadata['servers'] if md_metadata['servers']
            faaas = {}
            faaas[:'context_type'] = "FAaaS"
            faaas[:'service_type'] = md_metadata['service_type'] if md_metadata['service_type']
            faaas[:'fusion_id'] = md_metadata['fusion_id'] if md_metadata['fusion_id']

            if md_metadata_userdata
              faaas[:'release'] = md_metadata_userdata['fa_release'] if md_metadata_userdata['fa_release']
              faaas[:'pod_name'] = md_metadata_userdata['logical_pod_name'] if md_metadata_userdata['logical_pod_name']
              faaas[:'env'] = md_metadata_userdata['oci_fusion_environment_family'] if md_metadata_userdata['oci_fusion_environment_family']
              faaas[:'customer_tenancy_id'] = md_metadata_userdata['customer_tenancy_id'] if md_metadata_userdata['customer_tenancy_id']
              faaas[:'customer_tenancy_name'] = md_metadata_userdata['customer_tenancy_name'] if md_metadata_userdata['customer_tenancy_name']
            end

            faaas[:'shape'] = md['shape'] if md['shape']
            if md_metadata_servers
              faaas[:'server_type_0'] = md_metadata_servers['0']['type'] if md_metadata_servers['0'] && md_metadata_servers['0']['type']
            end

            faaas
          else 
            nil
          end
        else
          nil
        end
      end 

      def get_origin(md, vnics)
        origin = DM::DMLoggingingestion::Models::LogOrigin.new({})
        origin.platform = get_platform_metadata(md, vnics)
        ctx = get_faaas_context(md)
        origin.context = ctx if ctx
        origin
      end 

      ##
      # Calculate logging endpoint from environment or metadata.
      # Preference is given to the environment variable 'OCI_DATAMESH_FRONTEND'.
      #
      # @param [String] region the region identifier
      #
      # @return [String] The logging endpoint that will be used.
      def oci_datamesh_endpoint(oci_datamesh_endpoint_override: nil)
        unless oci_datamesh_endpoint_override.nil?
          logger.info "using oci datamesh frontend endpoint override #{oci_datamesh_endpoint_override} for testing"
          return oci_datamesh_endpoint_override
        end

        unless ENV[OCI_DATAMESH_FE_ENV_VAR].nil?
          logger.info "using oci datamesh frontend endpoint env var override #{ENV[OCI_DATAMESH_FE_ENV_VAR]}"
          return ENV[OCI_DATAMESH_FE_ENV_VAR]
        end

        logger.info("endpoint will be decided by the client based on the region as there is no override in config or env variables")
        return nil
      end

      def auto_signer_type
        [OCI::Config.new, AUTO_SIGNER_TYPE]
      end

      def config_and_signer_type(principal_override: nil, config_dir: nil)
        config_dir ||= OS.windows? ? WINDOWS_OCI_CONFIG_DIR : LINUX_OCI_CONFIG_DIR

        if (File.file?(config_dir) && principal_override != AUTO_SIGNER_TYPE) || principal_override == USER_SIGNER_TYPE
          begin
            logger.info("using #{USER_SIGNER_TYPE} signer type with config dir #{config_dir}")
            [
              OCI::ConfigFileLoader.load_config(config_file_location: config_dir, profile_name: USER_CONFIG_PROFILE_NAME),
              USER_SIGNER_TYPE
            ]
          rescue StandardError => e
            unless e.full_message.include? 'Profile not found in the given config file.'
              raise "User api-keys not setup correctly: #{e}"
            end

            logger.warn("Profile #{USER_CONFIG_PROFILE_NAME} not configured in user api-key cli using other principal "\
                        "instead: #{e}")
            auto_signer_type
          end
        else # if user api-keys is not setup in the expected format we expect instance principal
          logger.info("using #{AUTO_SIGNER_TYPE} signer type")
          auto_signer_type
        end
      end

      def hostname
        if @hostname.nil?
          begin
            @hostname = Socket.gethostname
          rescue StandardError
            ip = Socket.ip_address_list.detect(&:ipv4_private?)
            @hostname = ip ? ip.ip_address : 'UNKNOWN'
          end
        end
        @hostname
      end

      ##
      # Configure the signer for the hydra client call
      #
      # @param [String] signer_type the type of signer that should be returned
      #
      # @return [OCI::Signer] a signer that is representative of the signer type
      def signer(oci_config, signer_type, md)
        case signer_type
        when USER_SIGNER_TYPE
          host_info_for_non_oci_instance(oci_config)
          set_default_ca_file
          OCI::Signer.new(
            oci_config.user,
            oci_config.fingerprint,
            oci_config.tenancy,
            oci_config.key_file,
            pass_phrase: oci_config.pass_phrase
          )
        when AUTO_SIGNER_TYPE
          logger.info('signer type is \'auto\', creating signer based on system setup')
          host_info_for_oci_instance(md)
          set_default_ca_file
          signer = resource_principal_signer
          if signer.nil?
            logger.info('resource principal is not set up, use instance principal instead')
            signer = instance_principal_signer
          else
            logger.info('use resource principal')
          end

          signer
        else
          raise StandardError,
                "Principal type #{signer_type} not supported, use 'instance', 'resource' or 'user' instead"
        end
      end

      def host_info_for_non_oci_instance(oci_config)
        # set needed properties
        @region = oci_config.region
        # for non-OCI instances we can't get the display_name or hostname from IMDS and the fallback is the ip address
        # of the machine
        begin
          @hostname = Socket.gethostname
        rescue StandardError
          ip = Socket.ip_address_list.detect(&:ipv4_private?)
          @hostname = ip ? ip.ip_address : 'UNKNOWN'
        end

        # No metadata service support for non-OCI instances
        @realm_domain = OCI::Regions.get_second_level_domain(@region)

        logger.info("For this non-OCI instance, region is #{@region}, " \
                    " hostname is #{@hostname}, realm is #{@realm_domain}")
      end

      def host_info_for_oci_instance(md)
        @region = md['canonicalRegionName'] == 'us-seattle-1' ? 'r1' : md['canonicalRegionName']
        @hostname = md.fetch('displayName', '')
        @realm_domain = md.fetch('regionInfo', {}).fetch('realmDomainComponent',
                                                         OCI::Regions.get_second_level_domain(@region))
        logger.info("For this OCI instance, region is #{@region}, "\
                    " hostname is #{@hostname}, realm is #{@realm_domain}")
      end

      ##
      # Since r1 overlay has a different default make sure to update this
      #
      def set_default_ca_file
        @ca_file = PUBLIC_DEFAULT_LINUX_CA_PATH if @ca_file.nil?
        if OS.windows?
          @ca_file = @ca_file == PUBLIC_DEFAULT_LINUX_CA_PATH ? PUBLIC_DEFAULT_WINDOWS_CA_PATH : @ca_file
        elsif OS.ubuntu?
          @ca_file = @ca_file == PUBLIC_DEFAULT_LINUX_CA_PATH ? PUBLIC_DEFAULT_UBUNTU_CA_PATH : @ca_file
        elsif OS.debian?
          @ca_file = @ca_file == PUBLIC_DEFAULT_LINUX_CA_PATH ? PUBLIC_DEFAULT_DEBIAN_CA_PATH : @ca_file
        else
          @ca_file = @region == 'r1' && @ca_file == PUBLIC_DEFAULT_LINUX_CA_PATH ? R1_CA_PATH : @ca_file
        end

        if @ca_file.nil?
          msg = 'ca_file is not specified'
          logger.error(msg)
          raise StandardError, msg
        end

        # verify the ssl bundle actually exists
        unless File.file? @ca_file
          msg = "Does not exist or cannot open ca file: #{@ca_file}"
          logger.error(msg)
          raise StandardError, msg
        end

        # setting the cert_bundle_path
        logger.info("using cert_bundle_path #{@ca_file}")
      end

      def resource_principal_signer
        logger.info('creating resource principal')
        add_resource_principal_overrides_to_environment!
        OCI::Auth::Signers.resource_principals_signer
      rescue StandardError => e
        logger.info("resource principal is not set up because #{e}")
        nil
      end

      def add_resource_principal_overrides_to_environment!
        env_file = ENV['LOCAL_TEST_ENV_FILE'] || PUBLIC_RESOURCE_PRINCIPAL_ENV_FILE

        raise StandardError, 'resource principal env file does not exist' unless File.exist? env_file

        f = File.open(env_file)
        resource_principal_env = {}
        f.each_line do |env|
          a = env.split('=')
          resource_principal_env[a[0]] = a[1].chomp
        end
        f.close

        logger.info("resource principal env is set up with #{resource_principal_env}")
        ENV.update resource_principal_env
      end

      def instance_principal_signer
        endpoint = @federation_endpoint_override || federation_endpoint_for(@region)

        unless endpoint.nil?
          logger.info("create instance principal with federation_endpoint = #{endpoint}, cert_bundle #{@ca_file}")
        end

        ::OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner.new(
          federation_endpoint: endpoint, federation_client_cert_bundle: @ca_file
        )
      end
    end
  end
end
