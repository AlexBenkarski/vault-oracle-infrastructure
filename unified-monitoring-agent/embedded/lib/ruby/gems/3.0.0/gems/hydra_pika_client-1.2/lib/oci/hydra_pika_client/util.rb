
module OCI
  class HydraPikaClient::Util
    def getHost(instance_metadata, external=true)

      availability_domain = instance_metadata["availabilityDomain"]
      canonical_region_name = instance_metadata["canonicalRegionName"]
      ad_name = "ad" + availability_domain[-1]
      if external
        "https://frontend.logging.#{ad_name}.#{canonical_region_name}.oracleiaas.com"
      else
        "http://hydra-pika-frontend.svc.#{ad_name}.#{canonical_region_name}"
      end

    end
  end
end