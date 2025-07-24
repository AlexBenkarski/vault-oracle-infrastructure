# frozen_string_literal: false
# the reason to make this false is that the OCI::Regions module fails if we send frozen strings
require 'json'
require 'net/http'
require 'oci/regions'
require 'oci/regions_definitions'
require 'retriable'

module OCI
  # this is used for x-tenancy-header
  TENANT_IDS = {
    'region1': 'ocid1.tenancy.oc1..aaaaaaaahxmrfifxtvc66mdmwrd6loob6u5ud5vc7ct2q4si2j3iqbzbgglq',
    'oc1': 'ocid1.tenancy.oc1..aaaaaaaarezxy4xq7jaujylzy7ron3biubdnlvagxeoz6kx7gykcr4brbypq',
    'oc2': 'ocid1.tenancy.oc2..aaaaaaaabpvme7qlr76hgs5k7xulyltg3xuoqwzmuyfakacmi62ap3ffdjia',
    'oc3': 'ocid1.tenancy.oc3..aaaaaaaac4ovtiub7ujsvnlacbgyvbmg5tihlsp7ogywifd5gykl3lwlxwoa',
    'oc4': 'ocid1.tenancy.oc4..aaaaaaaaiqvz4ix4ag2dmn3qnv6zrvegukzc3fjnemdxbtd7u2cgwq6fvnha'
  }.freeze

  COMPARTMENTS = {
    'region1': 'ocid1.compartment.region1..aaaaaaaasfm6ym4xn4o7bk27vwt6mswiibyqwqxo654hkf4l27whzlhcbvka',
    'oc1': 'ocid1.compartment.oc1..aaaaaaaagixeyxsjv643gwx5vf6dkuwmvvf4dlf7k6sobwzbjrtce4lvndwq',
    'oc2': 'ocid1.compartment.oc2..aaaaaaaaxdh2pzeumdaqc4oukomeqzqnuwvdgyqg524k536ifbhiicmdt6aa',
    'oc3': 'ocid1.compartment.oc3..aaaaaaaapa74z64fu5zpjwntqbmfp6mh7vgeboswqd4wo6prnkgancwpkaoq',
    'oc4': 'ocid1.compartment.oc4..aaaaaaaazhf44ssrbzgrz4plybe2q6mzsdyafjb3bwc67jgkimhaldwurpva'
  }.freeze

  # Lumberjack Frontend endpoint info can be found in
  # https://confluence.oci.oraclecorp.com/pages/viewpage.action?spaceKey=LUM&title=Region+Availability+Info
  IAAS_SUFFIX = {
      'rb1': 'oraclerealmrb1.com',
      'rb2': 'oraclerealmrb2.com',
      'oc0': 'oraclerealm0.com',
      'oc1': 'oracleiaas.com',
      'oc2': 'oci.oraclegoviaas.com',
      'oc3': 'oci.oraclegoviaas.com',
      'oc4': 'oci.oraclegoviaas.uk',
      'oc5': 'oci.oraclerealm5.com',
      'oc6': 'oci.oraclerealm.ic.gov',
      'oc7': 'oci.oci.ic.gov',
      'oc8': 'oci.oraclerealm8.com',
      'oc9': 'oraclerealm9.com',
      'oc10': 'oraclerealm10.com',
      'oc11': 'oraclerealm.smil.mil',
      'oc12': 'oracledodrealm.ic.gov',
      'oc13': 'oraclerealm13.com',
      'oc14': 'oraclerealm14.com',
      'oc15': 'oraclerealm15.com',
      'oc16': 'oraclerealm16.com',
      'oc17': 'oraclerealm17.com',
      'oc18': 'oraclerealm18.com',
      'oc19': 'oraclerealm.eu',
      'oc20': 'oraclerealm20.com',
  }.freeze

  SCCP_METADATA_PATH = '/etc/sccp-instance.json'.freeze
  CCCP_METADATA_PATH = '/etc/cccp_instance.json'.freeze
  INITIAL_DELAY = 1

  GOV_OR_ONSR_REALMS = ["oc2","oc3","oc5","oc6","oc7","oc11","oc12"]

  REGION_REALM_MAPPING = {
    'us-tacoma-1': 'oc5'.freeze,
    'us-gov-fortworth-1': 'oc6'.freeze,
    'us-gov-sterling-2': 'oc6'.freeze,
    'us-gov-sterling-1': 'oc7'.freeze,
    'ap-dcc-canberra-1': 'oc10'.freeze,
    'us-gov-fortworth-3': 'oc11'.freeze,
    'us-gov-boyers-1': 'oc11'.freeze,
    'us-gov-phoenix-3': 'oc11'.freeze,
    'us-gov-sterling-3': 'oc11'.freeze,
    'us-gov-ashburn-2': 'oc12'.freeze,
    'us-gov-phoenix-2': 'oc12'.freeze,
    'us-gov-saltlake-1': 'oc12'.freeze,
    'us-gov-manassas-1': 'oc12'.freeze,
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
    'us-dcc-phoenix-3': 'oc18'.freeze,
    'us-phoenix-1': 'oc1'.freeze
  }

  REALM_DOMAIN_MAPPING = {
    'oc1': 'oraclecloud.com'.freeze,
    'oc5': 'oraclecloud5.com'.freeze,
    'oc6': 'oraclecloud.ic.gov'.freeze,
    'oc7': 'oc.ic.gov'.freeze,
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
  }

  # handles environment variables such as region and ad.
  class Environment
    class << self

      RETRIES = 20

      def resolve_environment
        #Add initial jitter
        sleep_seconds = INITIAL_DELAY * (0.5 * (1 + rand()))
        sleep sleep_seconds
        # OCI service enclave ONLY => might need to move elsewhere if we're going public
        realm = read_file('/etc/identity-realm')
        region = read_file('/etc/region')
        ad = read_file('/etc/physical-availability-domain') || read_file('/etc/availability-domain')
        fd = read_file('/etc/fault-domain')
        host = read_file('/etc/hostname')
        hostclass = read_file('/etc/hostclass')
        tenancyId = read_file('/etc/tenancy-ocid')

        workload_signer = ENV['WORKLOAD_SIGNER'] || false
        # for local testing override
        md_override = read_file('test/oci/sccp-instance.json')
        in_service_enclave = true
        # read flat file on instance before calling API
        if  md_override.nil? && (File.exist? SCCP_METADATA_PATH)
          md_override = read_file(SCCP_METADATA_PATH)
        elsif md_override.nil? && (File.exist? CCCP_METADATA_PATH)
          md_override = read_file(CCCP_METADATA_PATH)
          in_service_enclave = false
        elsif md_override.nil? && (workload_signer)
            # We expect /etc files to have been mounted
            metadata = {
              'is_service_enclave' => in_service_enclave,
              'availabilityDomain' => ad,
              'faultDomain' => fd,
              'region' => region,
              'realm' => realm,
              'regionInfo' => {'regionIdentifier' => region,
                               'realmKey' => realm }
            }
            return metadata
        end

        if md_override
          begin
            md_json = JSON.parse(md_override)
            validate_metadata(md_json)
            md_region = get_region(md_json, in_service_enclave) || region
            metadata = {
              'is_service_enclave' => in_service_enclave,
              'region' => md_region,
              'realm' => md_json.fetch('regionInfo', Hash.new).fetch('realmKey', 'oc1'),
              'realmDomainComponent' => get_realmDomainComponent(md_json, md_region),
              'availabilityDomain' => get_availability_domain(md_json, in_service_enclave) || ad,
              'faultDomain' => md_json['faultDomain'],
              'hostname' => md_json.key?('hostname') ? md_json['hostname'] : host&.chomp,
              'shape' => md_json.key?('shape') ? md_json['shape'] : '',
              'metadata' => md_json.key?('metadata') ? md_json['metadata'] : '',
              'ipAddress' => md_json.key?('ipAddress') ? md_json['ipAddress'] : '',
              'id' => md_json.key?('id') ? md_json['id'] : '',
              'compartmentId' => md_json.key?('compartmentId') ? md_json['compartmentId'] : '',
              'freeformTags' => md_json.key?('freeformTags') ? md_json['freeformTags'] : {},
              'displayName' => md_json.key?('displayName') ? md_json['displayName'] : '',
              'hostclass' => get_hostclass(md_json, in_service_enclave) || hostclass,
              'tenancyId' => tenancyId
            }.freeze

            return metadata
          rescue StandardError
            logger.info("Invalid instance metadata json files, fallback to IMDS")
          end
        end

        get_instance_md_with_retry do |md, is_service_enclave|
          validate_metadata(md)
          md_region = get_region(md, is_service_enclave) || region
          # list of supported metadata
          metadata = {
            'is_service_enclave' => is_service_enclave,
            'region' => md_region,
            'realm' => md.fetch('regionInfo', Hash.new).fetch('realmKey', 'oc1'),
            'realmDomainComponent' => get_realmDomainComponent(md, md_region),
            'availabilityDomain' => get_availability_domain(md, is_service_enclave) || ad,
            'faultDomain' => md['faultDomain'] || fd,
            'hostname' => md.key?('hostname') ? md['hostname'] : host&.chomp,
            'shape' => md.key?('shape') ? md['shape'] : '',
            'metadata' => md.key?('metadata') ? md['metadata'] : '',
            'ipAddress' => md.key?('ipAddress') ? md['ipAddress'] : '',
            'id' => md.key?('id') ? md['id'] : '',
            'compartmentId' => md.key?('compartmentId') ? md['compartmentId'] : '',
            'freeformTags' => md.key?('freeformTags') ? md['freeformTags'] : {},
            'displayName' => md.key?('displayName') ? md['displayName'] : '',
            'hostclass' => get_hostclass(md, is_service_enclave) || hostclass,
            'tenancyId' => tenancyId
          }.freeze
          return metadata
        end
      end

      def is_gov_or_onsr_realm(realm)
        return GOV_OR_ONSR_REALMS.include?(realm)? true : false
      end

      def get_instance_md_with_retry(retries=RETRIES)
        #The first retry interval is 15s and increases by factor of 1.5 each time until max interval of 60s
        Retriable.retriable(base_interval:15, tries: retries, on: StandardError, timeout: 15, rand_factor: 0.5) do
          yield get_instance_md
        end
      end

      def get_instance_md
        is_service_enclave = true
        is_customer_enclave = false

        # v2 of IMDS requires an authorization header
        md = get_instance_md_with_url("http://169.254.169.254/opc/v2/instance/")

        if !md.nil?
          logger.info "Successfully fetch instance metadata for hosts in overlay"
          return md, is_customer_enclave
        else
          md = get_instance_md_with_url("http://instance-metadata.svc/opc/se20170311/instance")
          if !md.nil?
            logger.info 'Successfully fetch instance metadata for hosts in substrate'
            return md, is_service_enclave
          else
            raise StandardError.new("Failure fetching instance metadata, possible reason is network issue or host is not OCI instance")
          end
        end
      end

      def get_instance_md_with_url(uri_link)
        uri = URI.parse(uri_link)
        http = ::Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = 2 # in seconds
        http.read_timeout = 3 # in seconds
        request = ::Net::HTTP::Get.new(uri.request_uri)
        if uri_link.include? "v2"
          request.add_field('Authorization', "Bearer Oracle")
        end
        resp = http.request(request)
        return JSON.parse(resp.body)
      rescue
        return nil
      end

      def getIAASSuffix(retries=RETRIES, metadata)
        md = nil
        suffix = nil
        Retriable.retriable(tries: retries, on: StandardError, timeout: 15, rand_factor: 0.5) do
          md = get_instance_md_with_url("http://169.254.169.254/opc/v2/iaasInfo/")
          unless md.nil?
            suffix = md.fetch('realm', Hash.new).fetch('iaasDomainName', nil)
            if !suffix.nil?
              unless suffix[0,4] == "oci."
              suffix = "oci." + suffix
              end
            end
          end
          if suffix.nil?
            logger.info ("Not able to fetch domain name from iaasInfo Api ")
            suffix = IAAS_SUFFIX.fetch(metadata.fetch('realm', 'oc1').to_sym, nil)
          end
          raise StandardError.new("realm is not recognized for region: '#{metadata['region']}', realm: '#{metadata['realm']}") if suffix.nil?
        end
        return suffix
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

      # Returns a second level domain for the given region.
      #
      # @param [hash] Metadata as returned by the metadata service. Defaults to nil.
      #               If nil, will be fetched again.
      # @param [String] region name as a string, used for falling back to
      #                 OCI::Regions.get_second_level_domain in case of missing metadata
      #
      # @return [String] A second level domain for given region, default to oraclecloud.com
      def get_realm(metadata)
        realm = metadata["regionInfo"]["realmKey"]
        if realm.nil?
          raise "realm '#{metadata["regionInfo"]["realmKey"]}' is not a valid realm"
        end
        return realm
      end

      def get_realmDomainComponent(metadata, region)
        region = '' if region.nil?  # required for testing

        if metadata.nil?
          metadata = begin
            get_instance_md_with_retry
            rescue StandardError
              Hash.new
          end
        end
        return metadata.fetch('regionInfo', Hash.new).fetch('realmDomainComponent',
          OCI::Regions.get_second_level_domain(region))
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

      def get_availability_domain(metadata, is_service_enclave)
        # service enclave always has the same physical and logical AD
        if is_service_enclave == true
          md_availabilityDomain = metadata['availabilityDomain']
          (md_availabilityDomain.include? 'pop')? "ad1" : "ad#{md_availabilityDomain[-1]}"
        else
          # for customer enclave availabilityDomain contains the logical AD, but we need the physical AD which is in the
          # variable ociAdName
          "ad#{metadata['ociAdName'][-1]}"
        end
      end

      def get_hostclass(md, is_service_enclave)
        if is_service_enclave == true
          if md.key?('metadata') and md['metadata'].key?('hostclass')
            return md['metadata']['hostclass']
          end
        else
          if md.key?('hostclass')
            return md['hostclass']
          end
        end

        logger.info "Failed to read hostclass from metadata service, fall back to read from file"
        nil
      end

      def read_file(file)
        File.read(file).chomp()
      rescue StandardError
        nil
      end

      def validate_metadata(metadata)
        required_field = %w(region availabilityDomain)
        required_field.each do |field|
          unless metadata.key?(field)
            raise "metadata must have field #{field}"
          end
        end
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end
    end

    @@instance = Environment.resolve_environment

    attr_accessor :region_override
    attr_accessor :instance_metadata

    def initialize
      super
      @instance_metadata = @@instance
      @region_override = nil
    end

    def [](key)
      @instance_metadata[key]
    end

    def telemetry_compartment
      region = resolve_region
      region == "r1" ? COMPARTMENTS[:'region1'] : COMPARTMENTS[OCI::Regions::REGION_REALM_MAPPING[region.to_sym].to_sym]
    end

    def telemetry_tenant
      region = resolve_region
      region == "r1" ? TENANT_IDS[:'region1'] : TENANT_IDS[OCI::Regions::REGION_REALM_MAPPING[region.to_sym].to_sym]
    end

    def endpoint(service)
      region = resolve_region
      # no instance-id means it couldn't access metadata service
      # and existence of region tells that there's /etc/region
      # considering that as substrate env.
      if @instance_metadata['is_service_enclave']
        ad = Environment.get_availability_domain(@instance_metadata, @instance_metadata['is_service_enclave'])
        realm = Environment.get_realm(@instance_metadata)
        realm_is_gov_or_onsr = Environment.is_gov_or_onsr_realm(realm)

        if realm_is_gov_or_onsr
          "https://#{service}.svc.#{ad}.#{region}"
        else
          "http://#{service}.svc.#{ad}.#{region}"
        end
      elsif region == "r1"
        "https://#{service}.#{region}.oracleiaas.com"
      else
        "https://#{service}.#{region}.#{@instance_metadata['realmDomainComponent']}"
      end
    end

    def resolve_region
      @region_override || @instance_metadata['region']
    end

    ##
    # Calculate federation endpoints based on metadata and optional inputs
    # @return [String] the federation endpoint that will be used
    def get_federation_endpoint
      region = resolve_region
      if @instance_metadata['is_service_enclave']
        ENV['FEDERATION_ENDPOINT'] || "https://authservice.svc.#{@instance_metadata['availabilityDomain']}.#{@instance_metadata['region']}/v1/x509"
      elsif region == "r1"
        ENV['FEDERATION_ENDPOINT'] || "https://auth.r1.oracleiaas.com/v1/x509"
      else
        ENV['FEDERATION_ENDPOINT'] || "https://auth.#{region}.#{@instance_metadata['realmDomainComponent']}" + "/v1/x509"
      end
    end

    ##
    # Calculate logging endpoint from environment or metadata.
    # Preference is given to the environment variable 'LOGGING_FRONTEND'.
    #
    # @return [String] host The logging endpoint that will be used.
    def get_logging_endpoint(metadata, customer_envclave_only=false)
      unless ENV['LOGGING_FRONTEND'].nil?
        ENV['LOGGING_FRONTEND']
      else
        md_availabilityDomain = metadata['availabilityDomain']
        md_region = metadata['region']
        md_realm = metadata['realm']

        if metadata['is_service_enclave'] && !customer_envclave_only
          "https://hydra-pika-frontend.svc.#{(md_availabilityDomain.include? 'pop')? 'ad1' : md_availabilityDomain}.#{md_region}"
        elsif md_region == "r1"
          "https://frontend.logging.#{md_availabilityDomain}.#{md_region}.oracleiaas.com"
        else
          suffix = Environment.getIAASSuffix(metadata)
          if suffix.nil?
            raise "realm is not recognized for region: '#{md_region}', realm: '#{md_realm}'"
          end
          "https://frontend.logging.#{(md_availabilityDomain.include? 'pop')? 'ad1' : md_availabilityDomain}.#{md_region}.#{suffix}"
        end
      end
    end
  end
end
