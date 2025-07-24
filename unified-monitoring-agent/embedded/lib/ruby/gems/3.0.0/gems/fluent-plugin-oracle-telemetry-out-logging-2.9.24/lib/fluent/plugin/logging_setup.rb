require 'retriable'
require 'oci/regions'
require 'oci/regions_definitions'
require 'oci/config_file_loader'
require 'oci/config'
require 'oci/signer'
require 'oci/api_client'
require 'oci/retry/retry'
require 'oci/errors'
require 'oci/internal/internal'
require 'oci/response_headers'
require 'oci/object_storage/object_storage'
require 'oci/auth/signers/instance_principals_security_token_signer'
require 'oci/auth/signers/instance_principals_delegation_token_signer'
require 'oci/auth/signers/resource_principals_signer'
require 'oci/auth/signers/ephemeral_resource_principals_signer'
require 'oci/auth/signers/resource_principals_federation_signer'
require 'oci/auth/signers/security_token_signer'
require 'oci/auth/signers/x509_federation_client_based_security_token_signer'
require 'oci/auth/signers/resource_principal_token_path_provider/rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/default_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/env_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/imds_rpt_path_provider'
require 'oci/auth/signers/resource_principal_token_path_provider/string_rpt_path_provider'
require 'oci/auth/auth'
require 'oci/auth/util'
require 'oci/auth/session_key_supplier'
require 'oci/auth/url_based_certificate_retriever'
require 'oci/auth/federation_client'
require 'oci/auth/security_token_container'
require 'oci/auth/internal/auth_token_request_signer'
require 'oci/util/sa_token_provider'
require_relative 'os'

unless OS.windows?
  require 'oci/auth/signers/service_account_token_provider/sa_token_provider'
  require 'oci/auth/signers/oke_workload_identity_resource_principal_signer'
end

module OCI
  class << self
    attr_accessor :sdk_name
    # Defines the logger used for debugging for the OCI module.
    # For example, log to STDOUT by setting this to Logger.new(STDOUT).
    #
    # @return [Logger]
    attr_accessor :logger
  end
end


module Fluent
  module Plugin
    module PublicLoggingSetup

      RETRIES = 3
      USER_SIGNER_TYPE = "user"
      WORKLOAD_SIGNER_TYPE = "workload"
      WORKLOAD_SIDECAR_SA = "sidecar"
      AUTO_SIGNER_TYPE = "auto"
      USER_CONFIG_PROFILE_NAME = "UNIFIED_MONITORING_AGENT"
      LINUX_OCI_CONFIG_DIR = "/etc/unified-monitoring-agent/.oci/config"
      WINDOWS_OCI_CONFIG_DIR = "C:\\oracle_unified_agent\\.oci\\config"
      PUBLIC_RESOURCE_PRINCIPAL_ENV_FILE = "/etc/resource_principal_env"

      R1_CA_PATH='/etc/pki/tls/certs/ca-bundle.crt'
      PUBLIC_DEFAULT_LINUX_CA_PATH = "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem"
      PUBLIC_DEFAULT_WINDOWS_CA_PATH = "C:\\oracle_unified_agent\\unified-monitoring-agent\\embedded\\ssl\\certs\\cacert.pem"
      PUBLIC_DEFAULT_UBUNTU_CA_PATH = '/etc/ssl/certs/ca-certificates.crt'
      PUBLIC_DEFAULT_DEBIAN_CA_PATH = PUBLIC_DEFAULT_UBUNTU_CA_PATH
      #Source - https://confluence.oci.oraclecorp.com/pages/viewpage.action?spaceKey=BOPS&title=OCI+Canonical+Names
      REGION_REALM_MAPPING = {
        'us-renton-1': 'oc0'.freeze,
        'us-scottsdale-1': 'oc0'.freeze,
        'us-langley-1': 'oc2'.freeze,
        'us-luke-1': 'oc2'.freeze,
        'us-gov-chicago-1': 'oc3'.freeze,
        'us-gov-phoenix-1': 'oc3'.freeze,
        'us-gov-ashburn-1': 'oc3'.freeze,
        'uk-gov-london-1': 'oc4'.freeze,
        'uk-gov-cardiff-1': 'oc4'.freeze,
        'us-tacoma-1': 'oc5'.freeze,
        'us-gov-fortworth-1': 'oc6'.freeze,
        'us-gov-sterling-2': 'oc6'.freeze,
        'us-gov-sterling-1': 'oc7'.freeze,
        'us-gov-fortworth-2': 'oc7'.freeze,
        'ap-ibaraki-1': 'oc8'.freeze,
        'ap-chiyoda-1': 'oc8'.freeze,
        'me-dcc-muscat-1': 'oc9'.freeze,
        'me-duqm-1': 'oc9'.freeze,
        'ap-dcc-canberra-1': 'oc10'.freeze,
        'us-gov-fortworth-3': 'oc11'.freeze,
        'us-gov-boyers-1': 'oc11'.freeze,
        'us-gov-phoenix-3': 'oc11'.freeze,
        'us-gov-sterling-3': 'oc11'.freeze,
        'us-gov-ashburn-2': 'oc12'.freeze,
        'us-gov-phoenix-2': 'oc12'.freeze,
        'us-gov-saltlake-1': 'oc12'.freeze,
        'us-gov-manassas-1': 'oc12'.freeze,
        'us-gov-saltlakecity-1': 'oc12'.freeze,
        'me-dcc-neom-1': 'oc13'.freeze,
        'eu-dcc-milan-1': 'oc14'.freeze,
        'eu-dcc-milan-2': 'oc14'.freeze,
        'eu-dcc-rating-1': 'oc14'.freeze,
        'eu-dcc-rating-2': 'oc14'.freeze,
        'eu-dcc-dublin-1': 'oc14'.freeze,
        'eu-dcc-dublin-2': 'oc14'.freeze,
        'ap-dcc-gazipur-1': 'oc15'.freeze,
        'us-westjordan-1': 'oc16'.freeze,
        'us-dcc-phoenix-1': 'oc17'.freeze,
        'us-dcc-phoenix-2': 'oc17'.freeze,
        'us-dcc-phoenix-4': 'oc17'.freeze,
        'us-dcc-phoenix-3': 'oc18'.freeze,
        'eu-frankfurt-2': 'oc19'.freeze,
        'eu-madrid-2': 'oc19'.freeze,
        'eu-jovanovac-1': 'oc20'.freeze,
        'me-dcc-doha-1': 'oc21'.freeze,
        'eu-dcc-rome-1': 'oc22'.freeze,
        'eu-milan-2': 'oc22'.freeze,
        'us-thames-1': 'oc23'.freeze,
        'us-somerset-1': 'oc23'.freeze,
        'eu-dcc-zurich-1': 'oc24'.freeze,
        'eu-crissier-1': 'oc24'.freeze,
        'ap-dcc-osaka-1': 'oc25'.freeze,
        'ap-dcc-tokyo-1': 'oc25'.freeze,
        'me-abudhabi-3': 'oc26'.freeze,
        'me-alain-1': 'oc26'.freeze,
        'us-dcc-swjordan-1': 'oc27'.freeze,
        'us-dcc-swjordan-2': 'oc28'.freeze,
        'me-abudhabi-4': 'oc29'.freeze,
        'me-abudhabi-2': 'oc29'.freeze,
        'ap-hobsonville-1': 'oc31'.freeze,
        'ap-silverdale-1': 'oc31'.freeze,
        'ap-seoul-2': 'oc35'.freeze,
        'ap-chuncheon-2': 'oc35'.freeze,
        'ap-suwon-1': 'oc35'.freeze,
        'us-tukwila-2': 'oc38'.freeze,
        'us-tukwila-3': 'oc39'.freeze,
        'ap-tatebayashi-1': 'oc40'.freeze,
        'ap-osaka-2': 'oc40'.freeze,
        'me-dubai-3': 'oc41'.freeze,
        'me-dubai-2': 'oc41'.freeze,
        'ap-pathumthani-1': 'oc43'.freeze,
        'uk-london-2': 'oc46'.freeze,
        'uk-london-3': 'oc47'.freeze,
        'us-phoenix-1': 'oc1'.freeze
      }

      REALM_DOMAIN_MAPPING = {
        'oc0': 'oraclecloud0.com'.freeze,
        'oc1': 'oraclecloud.com'.freeze,
        'oc2': 'oraclegovcloud.com'.freeze,
        'oc3': 'oraclegovcloud.com'.freeze,
        'oc4': 'oraclegovcloud.uk'.freeze,
        'oc5': 'oraclecloud5.com'.freeze,
        'oc6': 'oraclecloud.ic.gov'.freeze,
        'oc7': 'oc.ic.gov'.freeze,
        'oc8': 'oraclecloud8.com'.freeze,
        'oc9': 'oraclecloud9.com'.freeze,
        'oc10': 'oraclegovcloud.com'.freeze,
        'oc11': 'oraclecloud.smil.mil'.freeze,
        'oc12': 'oracledodcloud.ic.gov'.freeze,
        'oc13': 'oraclecloud13.com'.freeze,
        'oc14': 'oraclecloud14.com'.freeze,
        'oc15': 'oraclecloud15.com'.freeze,
        'oc16': 'oraclecloud16.com'.freeze,
        'oc17': 'oraclecloud17.com'.freeze,
        'oc18':  'oraclecloud18.com'.freeze,
        'oc19': 'oraclecloud.eu'.freeze,
        'oc20': 'oraclecloud20.com'.freeze,
        'oc21': 'oraclecloud21.com'.freeze,
        'oc22': 'psn-pco.it'.freeze,
        'oc23': 'oraclecloud23.com'.freeze,
        'oc24':'oraclecloud24.com'.freeze,
        'oc25': 'nricloud.jp'.freeze,
        'oc26': 'oraclecloud26.com'.freeze,
        'oc27': 'oraclecloud27.com'.freeze,
        'oc28': 'oraclecloud28.com'.freeze,
        'oc29': 'oraclecloud29.com'.freeze,
        'oc31': 'sovereigncloud.nz'.freeze,
        'oc35': 'oraclecloud35.com'.freeze,
        'oc38': 'oraclecloud38.com'.freeze,
        'oc39': 'oraclecloud39.com'.freeze,
        'oc40': 'jpsovereigncloud.jp'.freeze,
        'oc41': 'dutechcloud.ae'.freeze,
        'oc43': 'oraclecloud43.com'.freeze,
        'oc46': 'oraclecloud46.com'.freeze,
        'oc47': 'oraclecloud47.com'.freeze
      }

      REGION_MAPS = [
        {
          "realmKey" => "oc17",
          "realmDomainComponent" => "oraclecloud17.com",
          "regionKey" => "IFP",
          "regionIdentifier" => "us-dcc-phoenix-1"
        },
        {
          "realmKey" => "oc17",
          "realmDomainComponent" => "oraclecloud17.com",
          "regionKey" => "GCN",
          "regionIdentifier" => "us-dcc-phoenix-2"
        },
        {
          "realmKey" => "oc17",
          "realmDomainComponent" => "oraclecloud17.com",
          "regionKey" => "YUM",
          "regionIdentifier" => "us-dcc-phoenix-4"
        }
      ]


      def logger
        @log ||= OS.windows? ? Logger.new(WINDOWS_UPLOADER_OUTPUT_LOG) : Logger.new(STDOUT)
      end

      ##
      # Calculate federation endpoints based on metadata and optional inputs
      #
      # @param [String] region the region identifier
      #
      # @return [String] the federation endpoint that will be used
      def get_federation_endpoint(region)
        if region == 'r1'
          endpoint = ENV['FEDERATION_ENDPOINT'] || 'https://auth.r1.oracleiaas.com/v1/x509'
        else
          if @realmDomainComponent.nil?
            logger.info("Trying to get domain from local map for region #{region}")
            @realmDomainComponent = getLocalRealmDomainComponent(region)
          end
          if @realmDomainComponent.nil?
            logger.warn("realm domain is null, fall back to OCI Regions")
            @realmDomainComponent = OCI::Regions.get_second_level_domain(region)
          end

          endpoint = ENV['FEDERATION_ENDPOINT'] || "https://auth.#{region}.#{@realmDomainComponent}" + '/v1/x509'
        end

        logger.info("endpoint is #{endpoint} in region #{region}")
        endpoint
      end

      def get_instance_md_with_retry(retries=RETRIES)
        Retriable.retriable(tries: retries, on: StandardError, timeout: 12) do
          return get_instance_md
        end
      end

      def get_instance_md
        # v2 of IMDS requires an authorization header
        md = get_instance_md_with_url('http://169.254.169.254/opc/v2/instance/')

        if !md.nil?
          logger.info "Successfully fetch instance metadata for hosts in overlay #{md}"
          return md
        else
          raise StandardError.new('Failure fetching instance metadata, possible reason is network issue or host is not OCI instance')
        end
      end

      def get_instance_md_with_url(uri_link)
        uri = URI.parse(uri_link)
        http = ::Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = 2 # in seconds
        http.read_timeout = 2 # in seconds
        request = ::Net::HTTP::Get.new(uri.request_uri)
        if uri_link.include? 'v2'
          request.add_field('Authorization', 'Bearer Oracle')
        end
        resp = http.request(request)

        JSON.parse(resp.body)
      rescue
        logger.warn("failed to get instance metadata with link #{uri_link}")
        return nil
      end

      ##
      # Calculate logging endpoint from environment or metadata.
      # Preference is given to the environment variable 'LOGGING_FRONTEND'.
      #
      # @param [String] region the region identifier
      #
      # @return [String] The logging endpoint that will be used.
      def get_logging_endpoint(region, logging_endpoint_override: nil)
        unless logging_endpoint_override.nil?
          logger.info "using logging endpoint override #{logging_endpoint_override} for testing"
          return logging_endpoint_override
        end

        if region == 'r1'
          endpoint = ENV['LOGGING_FRONTEND'] || "https://ingestion.logging.#{region}.oci.oracleiaas.com"
        else
          if @realmDomainComponent.nil?
            @realmDomainComponent = getLocalRealmDomainComponent(region)
          end
          if @realmDomainComponent.nil?
            logger.warn("realm domain is null, fall back to OCI Regions")
            @realmDomainComponent = OCI::Regions.get_second_level_domain(region)
          end

          endpoint = ENV['LOGGING_FRONTEND'] || "https://ingestion.logging.#{region}.oci.#{@realmDomainComponent}"
        end

        logger.info("endpoint is #{endpoint} in region #{region}")
        endpoint
      end

      def get_signer_type(principal_override: nil, config_dir: nil)
        config_dir ||= OS.windows? ?  WINDOWS_OCI_CONFIG_DIR : LINUX_OCI_CONFIG_DIR

        workload_signer = ENV['WORKLOAD_SIGNER'] || false
        if workload_signer
          logger.info("using #{WORKLOAD_SIGNER_TYPE} signer type")
          signer_type = WORKLOAD_SIGNER_TYPE
          oci_config = OCI::Config.new
        elsif (File.file?(config_dir) && principal_override != AUTO_SIGNER_TYPE) || principal_override == USER_SIGNER_TYPE
          begin
            logger.info("using #{USER_SIGNER_TYPE} signer type with config dir #{config_dir}")
            oci_config = OCI::ConfigFileLoader.load_config(config_file_location: config_dir, profile_name: USER_CONFIG_PROFILE_NAME)
            signer_type = USER_SIGNER_TYPE
          rescue => not_found_error
            if not_found_error.full_message.include?("Profile not found in the given config file.")
              logger.warn("Profile #{USER_CONFIG_PROFILE_NAME} not configured in user api-key cli using other principal instead: #{not_found_error}")
              signer_type = AUTO_SIGNER_TYPE
              oci_config = OCI::Config.new
            else
              raise "User api-keys not setup correctly: #{not_found_error}"
            end
          end
        else # if user api-keys is not setup in the expected format we expect instance principal

          logger.info("using #{AUTO_SIGNER_TYPE} signer type")
          signer_type = AUTO_SIGNER_TYPE
          oci_config = OCI::Config.new
        end

        return oci_config, signer_type
      end

      def get_host_name
        if @hostname.nil?
          begin
            @hostname = Socket.gethostname
          rescue
            ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
            @hostname = ip ? ip.ip_address : 'UNKNOWN'
          end
          @hostname
        else
          @hostname
        end
      end

      ##
      # Configure the signer for the hydra client call
      #
      # @param [String] signer_type the type of signer that should be returned
      #
      # @return [OCI::Signer] a signer that is representative of the signer type
      def get_signer(oci_config, signer_type)
        @instance_metadata = { 'm_resId' => '', 'm_cptId' => '', 'm_tenancyId' => '' }
        if signer_type == USER_SIGNER_TYPE
          get_host_info_for_non_oci_instance(oci_config)
          set_default_ca_file
          OCI::Signer.new(
            oci_config.user,
            oci_config.fingerprint,
            oci_config.tenancy,
            oci_config.key_file,
            pass_phrase: oci_config.pass_phrase)
        elsif signer_type == WORKLOAD_SIGNER_TYPE
          logger.info "signer type is 'workload', creating signer based on noted service account"
          @region = ENV["OCI_RESOURCE_PRINCIPAL_REGION"] || nil
          service_account_ns = ENV["WORKLOAD_NAMESPACE"] || nil
          service_account = ENV["WORKLOAD_SERVICE_ACCOUNT"] || "oci-observability-client"
          @realmDomainComponent = getLocalRealmDomainComponent(@region)
          if @realmDomainComponent.nil?
            #OCI library in turn uses metadata and will default to OC1 realm if no metadata is found
            @realmDomainComponent = OCI::Regions.get_second_level_domain(@region)
          end

          # Sidecar logic use the mounted service account
          if service_account == WORKLOAD_SIDECAR_SA
            signer = OCI::Auth::Signers.oke_workload_resource_principal_signer()
          else
            sa_token_provider = OCI::Auth::Signers::ServiceAccountTokenProvider::SuppliedServiceAccountProvider.new(service_account_ns, service_account)
            signer = OCI::Auth::Signers.oke_workload_resource_principal_signer_with_provider(service_account_token_provider: sa_token_provider)
          end

          signer

        elsif signer_type == AUTO_SIGNER_TYPE
          logger.info "signer type is 'auto', creating signer based on system setup"
          get_host_info_for_oci_instance
          set_default_ca_file
          signer = create_resource_principal_signer
          if signer == nil
            logger.info("resource principal is not set up, use instance principal instead")
            signer = create_instance_principal_signer
          else
            logger.info("use resource principal")
          end

          signer
        else
          raise StandardError.new("Principal type #{signer_type} not supported, use 'instance', 'resource' or 'user' instead")
        end
      end

      def get_source_info
        oci_config, signer_type = get_signer_type
        if signer_type == USER_SIGNER_TYPE
          if oci_config.nil?
            raise StandardError, "Error: oci_config is nil"
          else
            tenancy_id = oci_config.tenancy
            subject_id = oci_config.user
            compartment_id = oci_config.tenancy
            return tenancy_id, subject_id, compartment_id
          end
        elsif signer_type == AUTO_SIGNER_TYPE
          md = @metadata_override || get_instance_md_with_retry
          region = md['canonicalRegionName'] == 'us-seattle-1' ? 'r1' : md['canonicalRegionName']
          if md['regionInfo'].is_a?(Hash) && ['realmKey', 'realmDomainComponent', 'regionKey', 'regionIdentifier'].all? {|key| md['regionInfo'].key?(key)}
            OCI::Regions.update_regions_map(md['regionInfo'], region)
          end
          signer = create_resource_principal_signer
          if signer.nil?
            # instance principal
            compartment_id = md['compartmentId']
            leaf_certificate_retriever = OCI::Auth::UrlBasedCertificateRetriever.new(
              OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner::LEAF_CERTIFICATE_URL,
              private_key_url: OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner::LEAF_CERTIFICATE_PRIVATE_KEY_URL
            )
            tenancy_id = OCI::Auth::Util.get_tenancy_id_from_certificate(
              leaf_certificate_retriever.certificate
            )
            subject_id = md['id']
            return tenancy_id, subject_id, compartment_id
          else
            raise StandardError, "Unsupported principal: resource principal"
          end
        end
      end

      def getLocalRealmDomainComponent(region)
        return nil if region.nil?
        symbolised_region = region.to_sym
        if REGION_REALM_MAPPING.key?(symbolised_region)
          realm = REGION_REALM_MAPPING[symbolised_region]
        else
          return nil
        end

        # return second level domain if exists
        symbolised_realm = realm.to_sym
        return REALM_DOMAIN_MAPPING[symbolised_realm] if REALM_DOMAIN_MAPPING.key?(symbolised_realm)
      end

      def get_host_info_for_non_oci_instance(oci_config)
        # set needed properties
        @region = oci_config.region
        # for non-OCI instances we can't get the display_name or hostname from IMDS and the fallback is the ip address
        # of the machine
        begin
          @hostname = Socket.gethostname
        rescue
          ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
          @hostname = ip ? ip.ip_address : 'UNKNOWN'
        end

        # No metadata service support for non-OCI instances
        logger.warn("If user principal is used, try getting domain from environment variable Or local map first")
        @realmDomainComponent = getLocalRealmDomainComponent(@region)
        if @realmDomainComponent.nil?
          #OCI library in turn uses metadata and will default to OC1 realm if no metadata is found
          @realmDomainComponent = OCI::Regions.get_second_level_domain(@region)
        end

        logger.info("in non oci instance, region is #{@region}, "\
                      " hostname is #{@hostname}, realm is #{@realmDomainComponent}")
      end

      def get_host_info_for_oci_instance
        md = @metadata_override || get_instance_md_with_retry

        @region = md['canonicalRegionName'] == 'us-seattle-1' ? 'r1' : md['canonicalRegionName']
        @hostname = md.key?('displayName') ? md['displayName'] : ''
        @realmDomainComponent = md.fetch('regionInfo', Hash.new).fetch('realmDomainComponent',
                                                                       OCI::Regions.get_second_level_domain(@region))
        logger.info("in oci instance, region is #{@region}, "\
                      " hostname is #{@hostname}, realm is #{@realmDomainComponent}")
        if md['regionInfo'].is_a?(Hash) && ['realmKey', 'realmDomainComponent', 'regionKey', 'regionIdentifier'].all? {|key| md['regionInfo'].key?(key)}
          OCI::Regions.update_regions_map(md['regionInfo'], @region)
        end
        extract_instance_metadata(md)
      end

      def read_file(file)
        File.read(file).chomp()
      rescue StandardError
        ''
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
          msg = "ca_file is not specified"
          logger.error msg
          raise StandardError, msg
        end

        # verify the ssl bundle actually exists
        unless File.file?(@ca_file)
          msg = "Does not exist or cannot open ca file: #{@ca_file}"
          logger.error msg
          raise StandardError, msg
        end

        # setting the cert_bundle_path
        logger.info "using cert_bundle_path #{@ca_file}"
      end

      def create_resource_principal_signer
        begin
          logger.info 'creating resource principal'
          add_rp_env_override
          push_missing_regions_to_region_map
          OCI::Auth::Signers.resource_principals_signer
        rescue => e
          logger.info("resource principal is not set up because #{e}")
          nil
        end
      end

      def push_missing_regions_to_region_map
        region = ENV["OCI_RESOURCE_PRINCIPAL_REGION"] || nil
        # populating  region info to Region Enum and REGION_REALM_MAPPING
        REGION_MAPS.each do |region_map|
          OCI::Regions.update_regions_map(region_map, region)
        end
      end

      def add_rp_env_override
        env_file = ENV["LOCAL_TEST_ENV_FILE"] || PUBLIC_RESOURCE_PRINCIPAL_ENV_FILE

        resource_principal_env = {}
        unless File.exist? env_file
          raise "resource principal env file is not exist"
        end

        file = File.readlines(env_file)
        file.each do |env|
          a = env.split("=")
          resource_principal_env[a[0]] = a[1].chomp
        end

        logger.info("resource principal env is set up with #{resource_principal_env}")
        ENV.update resource_principal_env
      end

      def create_instance_principal_signer
        endpoint = @federation_endpoint_override || get_federation_endpoint(@region)

        logger.info "create instance principal with  federation_endpoint = #{endpoint}, cert_bundle #{@ca_file}" unless endpoint.nil?
        ::OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner.new(
          federation_endpoint: endpoint,  federation_client_cert_bundle: @ca_file)
      end

      def extract_instance_metadata(md)
        instance_ocid    = md.key?('id') ? md['id'] : ''
        ip_address       = md.key?('ipAddress') ? md['ipAddress'] : ''
        compartment_ocid = md.key?('compartmentId') ? md['compartmentId'] : ''
        tenancy_ocid     = md.key?('tenantId') ? md['tenantId'] : ''
        tenancy_ocid     = read_file('/etc/tenancy-ocid') if tenancy_ocid.empty? && File.exist?('/etc/tenancy-ocid')
        if tenancy_ocid.empty?
          begin
            retriever = OCI::Auth::UrlBasedCertificateRetriever.new(
              OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner::LEAF_CERTIFICATE_URL,
              private_key_url: OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner::LEAF_CERTIFICATE_PRIVATE_KEY_URL
            )
            tenancy_ocid = OCI::Auth::Util.get_tenancy_id_from_certificate(retriever.certificate)
          rescue => e
            logger.info("An error occurred when fetching the tenancy OCID: #{e.message}")
          end
        end
        @instance_metadata = {
          'm_resId'     => instance_ocid.empty? ? ip_address : instance_ocid,
          'm_cptId'     => compartment_ocid,
          'm_tenancyId' => tenancy_ocid
        }
      end

      def get_instance_metadata
        @instance_metadata
      end
    end
  end
end
