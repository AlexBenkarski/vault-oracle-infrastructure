# frozen_string_literal: true

require 'fluent/plugin/input'
require 'fluent/event'
require 'time'
require 'uri'

require_relative 'record_expander'

require 'fluent/plugin/out_oci_monitoring'
include Fluent::Plugin::PublicMetricsUtils

module Fluent::Plugin::OpenMetrics
  module Input
    require_relative 'scrape_job'

    # Base fluentd input plugin for http scrape which returns standard metrics
    # this class must NOT be registered in FluentD
    class Base < Fluent::Plugin::Input

      KNOWN_KEYS = Set['namespace', 'resourceGroup', 'compartmentId',
        'name', 'datapoints', 'dimensions', 'metadata']

      MAX_NO_OF_LABELS = 7

      helpers :parser

      attr_reader :scrape_jobs
      # the FluentD tag for the scraped metric records
      config_param :tag, :string
      config_param :name_pattern, :regexp, default: nil

      def multi_workers_ready?
        true
      end

      def configure(conf)
        # make sure there's a parser config, that defaults to openmetrics
        ensure_config_section(conf, 'parse')
        conf.elements('parse').each { |parser|
          parser['@type'] ||= 'openmetrics'
          # ensure default for record fields for routing
          ensure_config_section(parser, 'record')
          parser.elements('record').each { |r|
            r['namespace']     ||= 'telemetry'
            r['resourceGroup'] ||= 'default'
          }
        }
        super
        @parser = parser_create(conf: conf.elements('parse').first)
        @map = {}
        fetch_instance_md_with_retry(3) { |md, is_service_enclave| @instance_md = md }

        # <record></record> directive
        if (record = conf.elements('parse')&.first.elements('record')&.first)
          record.each_pair do |k, v|
            record.has_key?(k) # to suppress unread configuration warning
            @map[k] =  RecordExpander.new(k, v)
          end
        end
        @scrape_jobs = []
        conf.elements('scrape').each do |scrapeconfig|
          log.info "Initialising #{job_class.name}..."
          @scrape_jobs << job_class.new(self, scrapeconfig).configure()
        end
      end

      def start
        super
        @scrape_jobs.each do |job|
          log.info "Starting scrape job #{job}..."
          job.start
        end
      end

      def stop
        @scrape_jobs.each do |job|
          log.info "Stopping scrape job #{job}..."
          job.stop
        end
        super
      end

      def ensure_config_section(conf, kind)
        if conf.elements(name: kind).empty?
          conf.elements << Fluent::Config::Element.new(kind, '', {}, [])
        end
      end

      def hostdims
        # static dimensions and config dimensions that apply to this host are precomputed
        dims = {}
        # Add the nodename as dimension, like what Prometheus does with the 'instance' label
        dims['host']       = ENV['MY_NODE_NAME'] || Socket.gethostname
        dims['region']     = @instance_md['region']
        dims['resourceId'] = @instance_md['id']
        # Add some OKE metadata, if present
        if md = @instance_md['metadata']
          ['oke-compartment-name','oke-cluster-label'].each do |key|
            camelKey = key.split('-').map(&:capitalize).join
            dims[camelKey] = md[key] if md[key]
          end
        end
        dims
      end

      def process(body, target_dimensions, scrape_resource_group, resource_metadata={})
        es = Fluent::MultiEventStream.new
        dims = hostdims
        count = 0
        @parser.parse(body) do |ts, record|
          count += 1
          next unless record
          next unless @name_pattern.nil? || @name_pattern.match(record['name'])
          record['dimensions'] ||= {}
          # merge host dimensions
          # needs to have the merge! instead of merge because it modifies the original hash instead of
          # assigning a new one and not setting it
          record['dimensions'].merge!(dims)
          # merge target dimensions.  These are dimensions which are fixed per target, but not per
          # host such as pod name.
          record['dimensions'].merge!(target_dimensions)
          record['dimensions'].delete_if { |_, value| value.nil? || value == "" }
          @map.each_pair do |k, v|
            # add all elements in <parse>/<record> config
            if k == 'dimensions'
              conf_dimensions = JSON.parse(v.expand(tag, ts, record).gsub('=>', ':'))
              record[k].merge!(conf_dimensions)
            elsif k == 'resourceGroup' &&  !scrape_resource_group.nil? && !scrape_resource_group.empty?
              record['resourceGroup'] = scrape_resource_group
            elsif k == 'k8s_dimensions'
              resource_labels = resource_metadata[:'labels'].to_h  || {}
              conf_labels = JSON.parse(v.expand(tag, ts, record))
              conf_labels[0..MAX_NO_OF_LABELS-1].each do |conf_label|
                if conf_label['type'] == "label" && resource_labels.has_key?(conf_label['name'].to_sym)
                  record['dimensions'][conf_label['dimension_name']] = resource_labels[conf_label['name'].to_sym]
                end
              end
            else
              record[k] = v.expand(tag, ts, record)
            end
          end
          # remove everything except for the known set
          record.delete_if { |key, _| !KNOWN_KEYS.include?(key) }
          raise 'name is required' unless record.key?('name')
          raise 'namespace is required' unless record.key?('namespace')
          raise 'datapoints is required' unless record.key?('datapoints')
          es.add(ts, record)
        end
        log.info "Parsed #{count} metrics."

        begin
            retries ||= 1
            router.emit_stream(@tag, es)
        rescue Fluent::Plugin::Buffer::BufferOverflowError => e
            log.info "Retry #{retries} out of 3 to emit metrics due to: #{e}"
            sleep 0.5
            retry if (retries += 1) <= 3
        end
      end
    end

     # a FluentD plugin that scrapes metrics from a static set of targets (no service discovery)
    class Static < Base

      def job_class; StaticScrapeJob; end

      Fluent::Plugin.register_input('openmetrics', self)
      config_section :scrape, multi: true, required: true do
        # --------------------------------------
        # --------- Static targets -------------
        # --------------------------------------
        config_section :target, multi: true, required: false do
          config_param :name,        :string, default: 'node_exporter'
          config_param :url,         :string, default: 'http://localhost:9100/metrics'
          config_param :open_timeout,:time, default: 1
          config_param :read_timeout,:time, default: 14
          config_param :interval,    :time, default: 60
          # static targets parameters
          config_section :param, multi: true, required: false do
            config_param :name,      :string
            config_param :values,    :array
          end
        end
        #auth sections
        config_param :auth_type, :enum, list: [:basic_auth, :token, :tls], default: nil
        config_param :secret_name, :string, default: nil

        config_param :open_timeout,  :time, default: 1
        config_param :read_timeout,  :time, default: 14
        config_param :interval, :time, default: 60
      end
    end

  end
end
