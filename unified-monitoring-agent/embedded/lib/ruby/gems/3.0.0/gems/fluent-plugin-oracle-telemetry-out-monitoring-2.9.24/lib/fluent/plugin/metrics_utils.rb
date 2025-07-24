# Copyright (c) 20[0-9][0-9], Oracle and/or its affiliates. All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License
# (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License
# 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
# either license.

# frozen_string_literal: true

require 'retriable'
require 'oci/config_file_loader'
require 'oci/config'
require 'oci/signer'
require 'oci/auth/signers/instance_principals_security_token_signer'
require 'oci/auth/signers/resource_principals_signer'
require 'oci/regions'
require 'oci/auth/signers/ephemeral_resource_principals_signer'
require 'oci/auth/signers/service_account_token_provider/sa_token_provider'
require 'oci/auth/signers/oke_workload_identity_resource_principal_signer'
require 'oci/auth/signers/resource_principals_federation_signer'
require 'oci/auth/signers/security_token_signer'
require 'oci/auth/signers/instance_principals_delegation_token_signer'
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
require 'oci/retry/retry'
require 'oci/errors'
require 'oci/internal/internal'
require 'oci/response_headers'
require 'oci/object_storage/object_storage'
require 'proxy_file_loader'
require 'oci/os'
require 'oci/util/sa_token_provider'
# rubocop: disable Metrics/ModuleLength (TODO: split away)


module Fluent
  module Plugin
    # Helper functions for PublicMetricsOutput
    module PublicMetricsUtils
      COMPARTMENTS = { # this is used to send to internal telemetry compartment
        'region1': 'ocid1.compartment.region1..aaaaaaaasfm6ym4xn4o7bk27vwt6mswiibyqwqxo654hkf4l27whzlhcbvka',
        'oc1': 'ocid1.compartment.oc1..aaaaaaaagixeyxsjv643gwx5vf6dkuwmvvf4dlf7k6sobwzbjrtce4lvndwq',
        'oc2': 'ocid1.compartment.oc2..aaaaaaaaxdh2pzeumdaqc4oukomeqzqnuwvdgyqg524k536ifbhiicmdt6aa',
        'oc3': 'ocid1.compartment.oc3..aaaaaaaapa74z64fu5zpjwntqbmfp6mh7vgeboswqd4wo6prnkgancwpkaoq',
        'oc4': 'ocid1.compartment.oc4..aaaaaaaazhf44ssrbzgrz4plybe2q6mzsdyafjb3bwc67jgkimhaldwurpva'
      }.freeze

      BASE_OPTS = {
        operation_signing_strategy: :standard,
        header_params: {
          accept: 'application/json',
          'content-type': 'application/json'
        }
      }.freeze

      EMPTY_INSTANCE_METADATA = {
        'is_service_enclave' => nil,
        'region' => nil,
        'realmDomainComponent' => nil,
        'availabilityDomain' => nil,
        'faultDomain' => nil,
        'hostname' => nil,
        'shape' => nil,
        'metadata' => nil,
        'ipAddress' => nil,
        'id' => nil,
        'compartmentId' => nil,
        'freeformTags' => nil,
        'displayName' => nil
      }.freeze

      SUPPORTED_PRINCIPALS = %w[instance user resource workload].freeze

      WORKLOAD_SIDECAR_SA = 'sidecar'

      PUBLIC_RESOURCE_PRINCIPAL_ENV_FILE = '/etc/resource_principal_env'

      R1_CA_PATH = '/etc/pki/tls/certs/ca-bundle.crt'

      LINUX_DEFAULT_CA_PATH = '/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem'

      WIN_DEFAULT_CA_PATH = 'C:\\oracle_unified_agent\\unified-monitoring-agent\\embedded\\ssl\\certs\\cacert.pem'

      PUBLIC_DEFAULT_UBUNTU_CA_PATH = '/etc/ssl/certs/ca-certificates.crt'

      PUBLIC_DEFAULT_DEBIAN_CA_PATH = PUBLIC_DEFAULT_UBUNTU_CA_PATH

      LINUX_OCI_CONFIG_DIR = "/etc/unified-monitoring-agent/.oci/config"
      WINDOWS_OCI_CONFIG_DIR = "C:\\oracle_unified_agent\\.oci\\config"

      USER_CONFIG_PROFILE_NAME = "UNIFIED_MONITORING_AGENT"

      RETRIES = 20

      IMDS_V2 = 'http://169.254.169.254/opc/v2/instance/'

      IMDS_SUBSTRATE_INSTANCE = 'http://instance-metadata.svc/opc/se20170311/instance'

      R1_FEDERATION_ENDPOINT = 'https://auth.r1.oracleiaas.com/v1/x509'

      R1_CERTS_PATH = '/etc/pki/tls/certs/ca-bundle.crt'

      R1_T2_OVERLAY_ENDPOINT = 'https://telemetry-ingestion.r1.oracleiaas.com'

      SCCP_METADATA_PATH = '/etc/sccp-instance.json'.freeze
      CCCP_METADATA_PATH = '/etc/cccp_instance.json'.freeze

      INITIAL_DELAY = 1

      GOV_OR_ONSR_REALMS = ["oc2","oc3","oc5","oc6","oc7","oc11","oc12"]

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
        'oc18': 'oraclecloud18.com'.freeze,
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

      def require_dependencies
        require 'oci/environment'
      end

      ## Post process OCI API call response
      #
      # @param resp [OCI::Response] The api response
      def handle_response(resp)
        return unless resp.data && resp.data.failed_metrics_count

        failures = resp.data.failed_metrics_count
        return unless failures > 0 && resp.data.failed_metrics

        @log.warn "#{failures} metric(s) failed"
        @log.debug(resp.data.failed_metrics.map { |m| "#{m.message} : #{m.metric_data}" }.join("\n\t"))
      end

      ## Set the default ca file used for setting up signing
      # Since r1 overlay has a different default make sure to update this
      #
      # @raises [StandardError] if the provided file does not exist
      def set_default_ca_file
        ca_file = LINUX_DEFAULT_CA_PATH if ca_file.nil?
        if OS.windows?
          ca_file = WIN_DEFAULT_CA_PATH
        elsif OS.ubuntu?
          ca_file = PUBLIC_DEFAULT_UBUNTU_CA_PATH
        elsif OS.debian?
          ca_file = PUBLIC_DEFAULT_DEBIAN_CA_PATH
        else
          ca_file = @region == 'r1' && ca_file == LINUX_DEFAULT_CA_PATH ? R1_CA_PATH : ca_file
        end

        raise StandardError, 'ca_file is not specified' if ca_file.nil?
        raise StandardError, "Does not exist or cannot open ca file: #{ca_file}" unless File.file?(ca_file)
        ca_file
      end

      ## Create and configure the OCI SDK Configuration object.
      #  The calculation is based on the configured principal type
      #
      # @return [OCI::Config] the oci config generated
      #
      # @raises [StandardError] in case of unknown principal configuration
      def create_oci_config
        case @principal['@type']
        when 'user'
          @log.info("principal type is 'user', reading oci config "\
                    "#{@principal['oci_config_path']} profile #{@principal['oci_config_profile']}")
          oci_config = OCI::ConfigFileLoader.load_config(
            config_file_location: @principal['oci_config_path'],
            profile_name: @principal['oci_config_profile']
          )
        when 'auto', 'instance', 'resource', 'workload'
          oci_config = OCI::Config.new
        else
          raise StandardError, "Unsupported principal type (#{@principal['@type']}) to create oci config"
        end

        # Running fluentd with -vv will enable the OCI SDK to log all requests to the backend.
        # make sure to limit nr of metric samples per poll cycle, otherwise you'll surely clog your terminal...
        oci_config.log_requests = true if @log.level == Fluent::Log::LEVEL_TRACE

        oci_config
      end

      ## Create and configure the OCI SDK ApiClientProxySettings object.
      #  The calculation is based on the configured principal type
      #
      # @return [OCI::ApiClientProxySettings] the oci proxy generated
      #
      # @raises [StandardError] in case of unknown principal configuration
      def create_proxy_settings
        case @principal['@type']
        when 'user'
          @log.info("principal type is 'user', reading oci proxy settings "\
                    "#{@principal['oci_config_path']} profile 'UMA_PROXY'")
          config_file = @principal['oci_config_path']
          proxy_settings = OCI::ProxyFileLoader.load_proxy_settings(config_dir: config_file, log: @log)
        when 'auto', 'instance', 'resource', 'workload'
          proxy_settings = nil
          @log.info('Use instance, resource or workload principal. Run without proxy.')
        else
          raise StandardError, "Unsupported principal type (#{@principal['@type']}) to create proxy settings"
        end

        proxy_settings
      end

      def fetch_instance_md_details
        #Add initial jitter
        sleep_seconds = INITIAL_DELAY * (0.5 * (1 + rand()))
        sleep sleep_seconds
        fetch_instance_md_with_retry do |md, is_service_enclave|
          md_region = get_region(md, is_service_enclave)
          md_realm = get_realm(md)
          md_availabilityDomain = md['availabilityDomain']
          if md['regionInfo'].is_a?(Hash) && ['realmKey', 'realmDomainComponent', 'regionKey', 'regionIdentifier'].all? {|key| md['regionInfo'].key?(key)}
            OCI::Regions.update_regions_map(md['regionInfo'], md_region)
          end
          if is_service_enclave
            metadata = {
              'is_service_enclave' => is_service_enclave,
              'ad' => (md_availabilityDomain.include? 'pop')? "ad1" : "ad#{md_availabilityDomain[-1]}",
              'region' => md_region,
              'realm' => md_realm
            }
            return metadata
          else
            md['is_service_enclave'] = is_service_enclave
            return md
          end
        end
      end

      def is_gov_or_onsr_realm(realm)
        return GOV_OR_ONSR_REALMS.include?(realm)? true : false
      end

      def get_realm(metadata)
        realm = metadata["regionInfo"]["realmKey"]
        if realm.nil?
          raise "realm '#{metadata["regionInfo"]["realmKey"]}' is not a valid realm"
        end
        return realm
      end

      def get_region(metadata, is_service_enclave)
        if is_service_enclave
          map_region_to_canonical(metadata)
        elsif metadata['canonicalRegionName'] == "us-seattle-1"
          # for SEA in overlay it always has 'r1' regardless of canonical naming
          "r1"
        else
          # customer enclave always uses the canonicalRegionName
          metadata['canonicalRegionName']
        end
      end

      # this is used in service enclave
      def map_region_to_canonical(metadata)
        # for service enclave SEA and PHX always have r1 and r2 for their canonical name
        if metadata["region"].upcase == "SEA"
          return "r1"
        end
        if metadata["region"].upcase == "PHX"
          return "r2"
        end

        canonical_region_name = metadata["regionInfo"]["regionIdentifier"]

        if canonical_region_name.nil?
          raise "region variable '#{metadata["regionInfo"]["regionIdentifier"]}' is not a valid region"
        end
        return canonical_region_name
      end

      ## Retrying wrapper for fetching instance metadata in OCI and non-OCI hosts
      #  See also https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/gettingmetadata.htm
      #
      # @param retries [Integer] The max times to try, defaults to 3
      #
      # @return [Hash] the instance metadata
      def fetch_instance_md_with_retry(retries = RETRIES)
        begin # rubocop:disable Style/RedundantBegin: (this is how retriable works)
          #The first retry interval is 15s and increases by factor of 1.5 each time until max interval of 60s
          Retriable.retriable(base_interval:15, tries: retries, on: StandardError, timeout: 15, rand_factor: 0.5) do
            yield fetch_instance_md
          end
        rescue StandardError # Return empty values for non-OCI instance usage
          @log.info('Unable to fetch instance metadata. Either the metadata '\
                    'service is not working or this is a non-OCI host. Returning '\
                    'empty instance metadata.')
          EMPTY_INSTANCE_METADATA
        end
      end

      ## Wrapper for fetching v1 and v2 instance metadata
      #
      # @return [Hash] the instance metadata
      def fetch_instance_md
        workload_signer = ENV['WORKLOAD_SIGNER'] || false
        is_service_enclave = true
        begin
          # read flat file on instance before calling API
          if (File.exist? SCCP_METADATA_PATH)
            @log.info("Reading from #{SCCP_METADATA_PATH}")
            md = read_file(SCCP_METADATA_PATH)
            return [JSON.parse(md), is_service_enclave]
          elsif (File.exist? CCCP_METADATA_PATH)
            @log.info("Reading from #{CCCP_METADATA_PATH}")
            md = read_file(CCCP_METADATA_PATH)
            return [JSON.parse(md), false] if !md.nil?
          elsif (workload_signer)
              is_service_enclave = false
              # We expect /etc files to have been mounted
              realm = read_file('/etc/identity-realm')
              region = read_file('/etc/region')
              ad = read_file('/etc/physical-availability-domain') || read_file('/etc/availability-domain')
              fd = read_file('/etc/fault-domain')
              metadata = {
                'is_service_enclave' => is_service_enclave,
                'availabilityDomain' => ad,
                'faultDomain' => fd,
                'region' => region,
                'realm' => realm,
                'regionInfo' => {'regionIdentifier' => region,
                                 'realmKey' => realm }
              }
              return [metadata, is_service_enclave]
          end
        rescue StandardError
          @log.debug("Invalid instance metadata json files, fallback to IMDS")
        end
        @log.warn("Did not get metadata info from metadata files")
        # v2 of IMDS requires an authorization header
        md = fetch_instance_md_with_url(IMDS_V2)
        # check for substrate instance metadata
        if md.nil?
          @log.info('IMDS v2 is not available, trying substrate')
          md = fetch_instance_md_with_url(IMDS_SUBSTRATE_INSTANCE)
          if md.nil?
            raise StandardError, 'Failed fetching metadata from /etc/sccp-instance'
          else
            @log.info 'Successfully fetch instance metadata for hosts in substrate'
            [md, is_service_enclave]
          end
        else
          @log.info 'Successfully fetch instance metadata for hosts in overlay'
          [md, !is_service_enclave]
        end
      end

      def read_file(file)
        File.read(file).chomp()
      rescue StandardError
        nil
      end

      ## Fetch instance metadata from a specific url
      #
      # @param url [String] Metadata endpoint
      #
      # @return [Hash] the instance metadata
      def fetch_instance_md_with_url(url)
        uri = URI.parse(url)
        http = ::Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = 2 # in seconds
        http.read_timeout = 3 # in seconds
        request = ::Net::HTTP::Get.new(uri.request_uri)
        request.add_field('Authorization', 'Bearer Oracle') if url.include? 'v2'

        resp = http.request(request)

        JSON.parse(resp.body)
      rescue StandardError
        @log.warn("failed to get instance metadata with link #{url}")
        nil
      end

      def get_signer_type
        config_dir = OS.windows? ?  WINDOWS_OCI_CONFIG_DIR : LINUX_OCI_CONFIG_DIR
        if File.file?(config_dir)
          begin
            @log.info("Using user signer type with config dir #{config_dir}")
            OCI::ConfigFileLoader.load_config(config_file_location: config_dir, profile_name: USER_CONFIG_PROFILE_NAME)
            signer_type = 'user'
            additional_parameters = {
              'oci_config_path' => config_dir,
              'oci_config_profile' => USER_CONFIG_PROFILE_NAME
            }
            return signer_type, additional_parameters
          rescue => not_found_error
            if not_found_error.full_message.include?("Profile not found in the given config file.")
              @log.warn("Profile #{USER_CONFIG_PROFILE_NAME} not configured in user api-key cli using other principal instead: #{not_found_error}")
            else
              raise "User api-keys not setup correctly: #{not_found_error}"
            end
          end
        end
        @log.info("Using Auto signer type")
        signer_type = 'auto'
        additional_parameters = nil
        return signer_type, additional_parameters
      end

      ## Create a signer used for sending API requests to OCI endpoints.
      #  The calculation is based on the configured principal type
      #
      # @return one of [OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner],
      #         [OCI::Signer], [OCI::Auth::Signers::SecurityTokenSigner], based
      #         on the configured principal type
      #
      # @raises [StandardError] in case of unknown principal configuration
      def create_signer # rubocop:disable Metrics/AbcSize (this is as simple as it gets)
        @log.info("Creating signer for principal type: #{@principal['@type']}")

        case @principal['@type']
        when 'user'
          @log.debug('Creating user signer.')
          OCI::Signer.new(
            @oci_config.user,
            @oci_config.fingerprint,
            @oci_config.tenancy,
            @oci_config.key_file,
            pass_phrase: @oci_config.pass_phrase
          )
        when 'instance'
          @log.debug('Creating instance signer.')
          if @instance_metadata['region'] == 'r1' or @instance_metadata['region'] == 'sea'
            @principal['federation_endpoint'] = R1_FEDERATION_ENDPOINT
            @principal['cert_bundle_path'] = R1_CERTS_PATH
          else
            @principal['federation_endpoint'] = get_federation_endpoint(@instance_metadata['canonicalRegionName'])
          end
          create_instance_principal_signer(@principal['federation_endpoint'],
                                           @principal['cert_bundle_path'])
        when 'resource'
          @log.debug('Creating resource signer.')
          create_resource_principal_signer

        when 'workload'
          @log.debug('Creating workload signer.')
          create_workload_principal_signer

        when 'auto'
          @principal['@type'] = 'resource'
          signer = create_signer
          unless signer
            @principal['@type'] = 'instance'
            signer = create_signer
          end
          return signer
        else
          raise StandardError, "Unsupported principal type (#{@principal['@type']}) to create signer"
        end
      end

      def get_federation_endpoint(region)
        require_dependencies
        if region == 'r1'
          endpoint = ENV['FEDERATION_ENDPOINT'] || 'https://auth.r1.oracleiaas.com/v1/x509'
        else
          if @realm_domain_component.nil?
            @realm_domain_component = OCI::Regions.get_second_level_domain(region) if @realm_domain_component.nil?
          end

          endpoint = ENV['FEDERATION_ENDPOINT'] || "https://auth.#{region}.#{@realm_domain_component}" + '/v1/x509'
        end

        endpoint
      end

      ## Create an instance principal signer
      # Most servers (linux) handle this by default for SSL, but windows doesn't
      # and we have to explicitly specify the ca-bundle that validates the SSL
      # connection to the public auth endpoint. The check is to not pass in
      # anything if not specified.
      #
      # @param federation_endpoint_override [String] The url to override the federation endpoint
      # @param federation_client_cert_bundle_override [String] The path to cert bundle override for the fed. endpoing
      #
      # @return [OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner] The generated signer
      def create_instance_principal_signer(federation_endpoint_override, federation_client_cert_bundle_override)
        unless federation_endpoint_override.nil?
          @log.info("federation endpoint override = #{federation_endpoint_override}")
        end
        unless federation_client_cert_bundle_override.nil?
          @log.info("ca-bundle override = #{federation_client_cert_bundle_override}")
        end

        if federation_client_cert_bundle_override == @ca_file
          @log.info('creating instance principal with system default ca bundle')
          OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner.new(
            federation_endpoint: federation_endpoint_override
          )
        else
          federation_client_cert_bundle_override = federation_client_cert_bundle_override || @ca_file
          @log.info("ca-bundle #{federation_client_cert_bundle_override} will be used for instance principal")
          OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner.new(
            federation_endpoint: federation_endpoint_override,
            federation_client_cert_bundle: federation_client_cert_bundle_override
          )
        end
      end

      ## Create a resource principal signer
      #  The calculation is based on the configured principal type
      #
      # @param conf [Fluent::Config] the fluentd configuration
      #
      # @return [String] the region to be used
      #
      # @raises [StandardError] when the RP env file does not exist
      def create_resource_principal_signer # rubocop:disable Metrics/AbcSize (this is as simple as it gets)
        @log.info 'creating resource principal'

        env_file = ENV['LOCAL_TEST_ENV_FILE'] || PUBLIC_RESOURCE_PRINCIPAL_ENV_FILE

        resource_principal_env = {}

        raise "resource principal env file #{env_file} does not exist" unless File.exist? env_file

        file = File.readlines(env_file)
        file.each do |env|
          a = env.split('=')
          resource_principal_env[a[0]] = a[1].chomp
        end

        @log.info("resource principal env is setup with #{resource_principal_env}")
        ENV.update resource_principal_env

        push_missing_regions_to_region_map
        OCI::Auth::Signers.resource_principals_signer
      rescue StandardError => e
        @log.info("resource principal is not set up because #{e}")
        nil
      end

      ## Create a workload principal signer
      #
      def create_workload_principal_signer # rubocop:disable Metrics/AbcSize (this is as simple as it gets)
        @log.info 'creating workload principal'

        ns = ENV["WORKLOAD_NAMESPACE"] || nil
        sa = ENV["WORKLOAD_SERVICE_ACCOUNT"] || "oci-observability-client"

        # Sidecar logic use the mounted service account
        if sa == WORKLOAD_SIDECAR_SA
          signer = OCI::Auth::Signers.oke_workload_resource_principal_signer()
        else
          raise "workload principal namespace does not exist" if ns.nil?

          sa_token_provider = OCI::Auth::Signers::ServiceAccountTokenProvider::SuppliedServiceAccountProvider.new(ns, sa)
          signer = OCI::Auth::Signers.oke_workload_resource_principal_signer_with_provider(service_account_token_provider: sa_token_provider)
        end

        signer

      rescue StandardError => e
        @log.info("workload principal is not set up because #{e}")
        nil
      end

      ## Determine the compartment to be used for pushing the metrics
      #
      # @param conf [Fluent::Config] the fluentd configuration
      #
      # @return [String] the compartment to be used
      #
      # @raises [Fluent::ConfigError] when compartment isn't defined when
      #                               configured as "auto"
      def resolve_compartment(conf)
        # solve the peculiarity of accessing configuration via '@' but not via conf
        conf['compartment'] = @compartment if conf['compartment'].nil? || conf['compartment'].empty?

        case conf['compartment']
        when 'internal'
          region = @instance_metadata.fetch('canonicalRegionName', nil)
          msg = 'compartment=internal, but instance metadata incomplete or not available'
          raise Fluent::ConfigError, msg if region.nil? || region.empty?

          compartment = if region == 'r1'
                          COMPARTMENTS['region1']
                        else
                            COMPARTMENTS[OCI::Regions::REGION_REALM_MAPPING[region.to_sym].to_sym]
                        end
        when 'auto'
          compartment = @instance_metadata.fetch('compartmentId', nil)
          msg = 'compartment=auto, but instance metadata incomplete or not available'
          raise Fluent::ConfigError, msg unless compartment
        when nil, ''
          #   @compartment unless @compartment.nil? || @compartment.empty?
          raise Fluent::ConfigError, 'Empty or missing compartment' unless compartment
        else
          compartment = conf['compartment']
        end
        compartment
      end

      ## Calculate the region in which you run
      #  The calculation is based on the configured principal type
      #
      # @return [String] the region to be used
      #
      # @raises [StandardError] in case of unknown principal configuration
      # @raises [Fluent::ConfigError] when region is unspecified when using
      #                               'instance' principals
      def resolve_region
        case @principal['@type']
        when 'user'
          region = @oci_config.region
        when 'auto', 'instance', 'resource'
          if @is_service_enclave
            return @instance_metadata['region']
          else
            # In case of Customer Enclave Instances
            region = @instance_metadata.fetch('canonicalRegionName', nil)
            msg = "principal = #{@principal['@type']}, but instance metadata incomplete or not available"
            region == nil ? (raise Fluent::ConfigError, msg) : (return region)
          end
        when 'workload'
            region = ENV["OCI_RESOURCE_PRINCIPAL_REGION"] || nil
        else
          raise StandardError, "Unsupported principal type (#{@principal['@type']}) to resolve region"
        end
        region
      end

      ## Calculate the realm domain component for service URL in a region
      #  The calculation is based on the configured principal type. The
      #  default is taken from the SDK OCI::Regions.get_second_level_domain
      #  for the resolved region.
      #
      # @return [String] the realm domain component to be used
      #
      # @raises [StandardError] in case of unknown principal configuration
      def resolve_realm_domain_component
          require_dependencies
          @instance_metadata.fetch('regionInfo', {}).fetch(
            'realmDomainComponent', OCI::Regions.get_second_level_domain(@region)
          )
      end

      ##
      # Calculate logging endpoint from environment or metadata.
      # Preference is given to the environment variable 'METRICS_FRONTEND'.
      #
      # @param metrics_endpoint_override [String] endpoint override, defaults to nil
      #
      # @return [String] The metrics endpoint that will be used.
      def resolve_endpoint(metrics_endpoint_override = nil)

        return resolve_endpoint_for_substrate(metrics_endpoint_override) if @is_service_enclave

        unless metrics_endpoint_override.nil?
          @log.info "using metrics endpoint override #{metrics_endpoint_override}"
          return metrics_endpoint_override
        end

        if @region == 'r1' or @region == 'sea' or @region == 'us-seattle-1'
          endpoint = ENV['METRICS_FRONTEND'] || R1_T2_OVERLAY_ENDPOINT
        else
          if @realm_domain_component.nil?
            @log.warn('realm domain is null, fall back to OCI Regions')
            @realm_domain_component = OCI::Regions.get_second_level_domain(@region) if @realm_domain_component.nil?
          end

          endpoint = ENV['METRICS_FRONTEND'] || "https://telemetry-ingestion.#{@region}.#{@realm_domain_component}"
        end
        endpoint
      end

      def resolve_endpoint_for_substrate(url)
        @log.info "Fetching endpoint for substrate #{url}"
        return URI.parse("#{url}/v2/metrics") unless url.nil?

        ad = @instance_metadata['ad']
        region = @instance_metadata['region']
        realm = @instance_metadata['realm']
        realm_is_gov_or_onsr = is_gov_or_onsr_realm(realm)

        if realm_is_gov_or_onsr
          URI.parse("https://telemetry-api.svc.#{ad}.#{region}:443/v2/metrics")
        else
          URI.parse("http://telemetry-api.svc.#{ad}.#{region}:80/v2/metrics")
        end
      end

      ## Add mandatory configuration sections to a fluentd config file dynamically.
      #  This is used to provide sane defaults for common cases.
      #
      # @param conf [Fluent::Config] the fluentd configuration
      # @param kind [String] the fluentd configuration section to add
      # @param attributes [Hash] the fluentd key-value pairs to add to the configuration
      #                          defaults to empty hash
      def ensure_config_section(conf, kind, attributes={})
        return unless conf.elements(name: kind).empty?

        e = Fluent::Config::Element.new(kind, '', attributes, [])
        conf.elements << e
      end

      def get_metadata
        case @principal['@type']
        when 'user'
          @log.info "user principal used for getting metadata"
          @instance_metadata = @metadata_override || {'is_service_enclave'=>false}
        when 'auto', 'instance', 'resource', 'workload'
          require_dependencies
          @instance_metadata = @metadata_override || fetch_instance_md_details
        else
          raise StandardError, "Unsupported principal type (#{@principal['@type']}) to get metadata"
        end
        return @instance_metadata

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

      def set_realm_domain_component
        case @principal['@type']
        when 'user'
          @log.info "user principal used for calculating realm domain component"
          @realm_domain_component = getLocalRealmDomainComponent(@region)
          if @realm_domain_component.nil?
            #OCI library in turn uses metadata and will default to OC1 realm if no metadata is found
            @realm_domain_component = OCI::Regions.get_second_level_domain(@region)
          end
          @log.info("in non oci instance, region is #{@region}, "\
                        " hostname is #{@hostname}, realm is #{@realm_domain_component}")
        when 'workload'
          require_dependencies
          @log.info "workload principal used for calculating realm domain component"
          @realm_domain_component = OCI::Environment.getLocalRealmDomainComponent(@region)
        when 'auto', 'instance', 'resource'
          @realm_domain_component = resolve_realm_domain_component
        else
          raise StandardError, "Unsupported principal type (#{@principal['@type']}) to set realm domain component"
        end
        return @realm_domain_component

      end

      def push_missing_regions_to_region_map
        region = ENV["OCI_RESOURCE_PRINCIPAL_REGION"] || nil
        # populating  region info to Region Enum and REGION_REALM_MAPPING
        REGION_MAPS.each do |region_map|
          OCI::Regions.update_regions_map(region_map, region)
        end
      end

      def add_compartmentId_to_metadata_if_user_principal(compartment)
        case @principal['@type']
        when 'user'
          @instance_metadata["compartmentId"]=compartment
        end
      end
    end
  end
end
# rubocop: enable Metrics/ModuleLength
