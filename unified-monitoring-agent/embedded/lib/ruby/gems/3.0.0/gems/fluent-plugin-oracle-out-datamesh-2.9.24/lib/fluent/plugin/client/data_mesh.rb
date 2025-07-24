module DM
  class << self
    # Defines the logger used for debugging for the OCI module.
    # For example, log to STDOUT by setting this to Logger.new(STDOUT).
    #
    # @return [Logger]
    attr_accessor :logger
  end

  module DMLoggingingestion
    module Endpoint
      def Endpoint.get_endpoint(region)
        dynamic_region_filepath = ENV['OCI_DATAMESH_DYNAMIC_CORE_REGION_FILEPATH'] || DM::DynamicRegions::DEFAULT_FILE_LOCATION
        iaas_region_domain = DM::DynamicRegions.get_iaas_domain_for_region(region, dynamic_region_filepath)

        # fallback
        iaas_region_domain ||= DM::OciRegions.get_iaas_domain_for_region(region)

        raise "Unknown domain for region #{iaas_region_domain}, can't build endpoint url" if iaas_region_domain.nil?

        url = "https://ingestion.datamesh.#{iaas_region_domain}"

        DM.logger.info("Datamesh ingestion endpoint for region #{region} that will be used is #{url}") if DM.logger
        url
      end
    end

    # Module containing models for requests made to, and responses received from,
    # OCI Loggingingestion services
    module Models
    end
    module Version
      CURRENT = 'v0'
    end
  end
end

# Require models
require_relative 'models/log_entry'
require_relative 'models/log_origin'
require_relative 'models/log_entry_batch'
require_relative 'models/post_log_batches'

# Require clients
require_relative 'http_client'
require_relative 'cookies_support'
require_relative 'regions'