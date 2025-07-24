
module DM
  module OciRegions
    @has_read_dynamic_regions = false

    # Taken from https://bitbucket.oci.oraclecorp.com/projects/SHEP/repos/core-regions/browse/src/main/java/com/oracle/pic/commons/util/Realm.java
    # I couldn't find an equivalent mapping for Ruby that was available
    REALM_DOMAIN_IAAS_MAPPING = {
      'dev': nil,
      'desktop': nil,
      'integ-next': nil,
      'integ-stable': nil,
      'region1': 'oracleiaas.com'.freeze,
      'rb1': 'oraclerealmrb1.com'.freeze,
      'rb2': 'oraclerealmrb2.com'.freeze,
      'rb3': 'oraclerealmrb3.com'.freeze,
      'rb4': 'oraclerealmrb4.com'.freeze,
      'rb5': 'oraclerealmrb5.com'.freeze,
      'rb6': 'oraclerealmrb6.com'.freeze,
      'rb7': 'oraclerealmrb7.com'.freeze,
      'rb8': 'oraclerealmrb8.com'.freeze,
      'rb9': 'oraclerealmrb9.com'.freeze,
      'rb13': 'oraclerealmrb13.com'.freeze,
      'rb14': 'oraclerealmrb14.com'.freeze,
      'rb15': 'oraclerealmrb15.com'.freeze,
      'rb16': 'oraclerealmrb16.com'.freeze,
      'rb17': 'oraclerealmrb17.com'.freeze,
      'rb18': 'oraclerealmrb18.com'.freeze,
      'oc0': 'oraclerealm0.com'.freeze,
      'oc1': 'oracleiaas.com'.freeze,
      'oc2': 'oraclegoviaas.com'.freeze,
      'oc3': 'oraclegoviaas.com'.freeze,
      'oc4': 'oraclegoviaas.uk'.freeze,
      'oc5': 'oraclerealm5.com'.freeze,
      'oc6': 'oraclerealm.ic.gov'.freeze,
      'oc7': 'oci.ic.gov'.freeze,
      'oc8': 'oraclerealm8.com'.freeze,
      'oc9': 'oraclerealm9.com'.freeze,
      'oc10': 'oraclerealm10.com'.freeze,
      'oc11': 'oraclerealm.smil.mil'.freeze,
      'oc12': 'oracledodrealm.ic.gov'.freeze,
      'oc13': 'oraclerealm13.com'.freeze,
      'oc14': 'oraclerealm14.com'.freeze,
      'oc15': 'oraclerealm15.com'.freeze,
      'oc16': 'oraclerealm16.com'.freeze,
      'oc17': 'oraclerealm17.com'.freeze,
      'oc18': 'oraclerealm18.com'.freeze,
      'oc19': 'oraclerealm.eu'.freeze,
      'oc20': 'oraclerealm20.com'.freeze,
      'oc21': 'oraclerealm21.com'.freeze,
      'oc22': 'psn-pc-realm.it'.freeze,
      'oc24': 'oraclerealm24.com'.freeze,
      'oc25': 'nricloud-realm.jp'.freeze
    }

    EXTRA_REGIONS_REALM_MAPPING = {
      'us-tacoma-1': 'oc5'.freeze,
      'us-gov-fortworth-1': 'oc6'.freeze,
      'us-gov-sterling-2': 'oc6'.freeze,
      'us-gov-sterling-1': 'oc7'.freeze,
      'us-gov-fortworth-2': 'oc7'.freeze,
      'ap-ibaraki-1': 'oc8'.freeze,
      'ap-chiyoda-1': 'oc8'.freeze,
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
      'us-dcc-phoenix-4': 'oc17'.freeze,
      'us-dcc-phoenix-3': 'oc18'.freeze,
      'us-phoenix-1': 'oc1'.freeze,
      'me-duqm-1': 'oc9'.freeze,
      'me-dcc-muscat-1': 'oc9'.freeze,
      'me-dcc-doha-1': 'oc21'.freeze,
      'eu-madrid-2': 'oc19'.freeze,
      'eu-frankfurt-2': 'oc19'.freeze,
      'eu-jovanovac-1': 'oc20'.freeze,
      'eu-dcc-rome-1': 'oc22'.freeze,
      'eu-dcc-zurich-1': 'oc24'.freeze,
      'ap-dcc-tokyo-1': 'oc25'.freeze,
    }

    def self.get_iaas_domain_for_region(region)
      OCI::Regions::check_and_add_region_metadata(region)
      region_symbol = region.to_sym
      realm = OCI::Regions::REGION_REALM_MAPPING[region_symbol]
      realm ||= EXTRA_REGIONS_REALM_MAPPING[region_symbol]

      if realm.nil?
        DM.logger.info('Cant find realm for region ' + region) if DM.logger
        return nil
      end

      iaas_domain = REALM_DOMAIN_IAAS_MAPPING[realm.to_sym]
      if iaas_domain.nil?
        DM.logger.info('Not available iaas domain for realm ' + realm) if DM.logger
        return nil
      end

      return "#{region}.oci.#{iaas_domain}"
    end
  end
  
  module DynamicRegions
    @has_read_dynamic_regions = false
    DEFAULT_FILE_LOCATION = '/etc/rbcp_core_regions_artifacts/rbcp_core_regions_metadata.json'

    REGIONS_TO_IAAS_DOMAIN_MAPPING = {}

    def self.load_from_dynamic_regions_file(filepath = DEFAULT_FILE_LOCATION)
      return if @has_read_dynamic_regions
      @has_read_dynamic_regions = true

      unless File.file?(filepath) 
        DM.logger.info('Missing rbcp core regions file to load dynamic files in ' + filepath) if DM.logger
        return
      end

      begin
        file_hash = File.read(filepath)
        metadata = JSON::parse(file_hash)
      rescue JSON::ParserError
        DM.logger.info('Failed to parse json file ' + filepath) if DM.logger
        return
      end

      regions_array = metadata['regions'] || []
      regions_array.each { |region| 
        next unless region['name'] && region['ociIaasDomainName']
        region_name = region['name']
        REGIONS_TO_IAAS_DOMAIN_MAPPING[region_name.to_sym] ||= region['ociIaasDomainName']
      }

      return
     end

     def self.get_iaas_domain_for_region(region, filepath = DEFAULT_FILE_LOCATION)
      load_from_dynamic_regions_file(filepath) 
      return REGIONS_TO_IAAS_DOMAIN_MAPPING[region.to_sym]
     end
  end
end 