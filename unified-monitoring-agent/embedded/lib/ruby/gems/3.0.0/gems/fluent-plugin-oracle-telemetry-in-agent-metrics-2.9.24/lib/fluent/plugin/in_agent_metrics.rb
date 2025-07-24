# frozen_string_literal: true

require 'fluent/plugin/input'
require 'fluent/event'
require 'net/http'
require 'time'
require 'uri'
require 'oci/environment'
require_relative '../../os'
require 'observability/output_response_metrics'
require 'observability/tail_metrics'
require 'observability/plugin_metrics'
require 'observability/resource_usage_metrics'

# frozen_string_literal: true

module Fluent
  module Plugin
    # fluentd input plugin for generating agent / plugin metrics
    class AgentMetricsInput < Fluent::Plugin::Input
      Fluent::Plugin.register_input('agent_metrics', self)

      include AgentObservability::BaseMetrics
      include AgentObservability::TailMetrics
      include AgentObservability::PluginMetrics
      include AgentObservability::OutputPluginResponseMetrics
      include AgentObservability::ResourceUsageMetrics

      helpers :timer

      # Metric names and the default values of some variables
      AUDITD_DROP_METRIC_NAME = "auditd_drop_count"
      AUDITD_EMIT_METRIC_NAME = "auditd_emit_count"
      AGENT_HEARTBEAT_METRIC_NAME = "agent_heartbeat"

      config_param :tag, :string

      config_section :record do
        config_param NAMESPACE, :string
        config_param RESOURCE_GROUP, :string, default: nil
        config_param DIMENSIONS, :hash, default: {}
      end

      # Setting scrape interval parameter with a default value of 60 seconds
      config_param :scrape_interval, :time, default: 60

      def set_agentVersion
        begin
          unless OS.windows?
            version = `rpm -qa | grep -E 'griffin-[0-9]|griffin-fips'`
            if version == ""
              # Evergreen host
              version = `podman ps --format {{.Image}} | grep agent-siem`
            end
            @agentVersion = get_agent_version_number(version)
            log.info "Fetched Agent Version #{version}. Version number is #{@agentVersion}"
          end
        rescue => error
          log.error "Error while fetching Agent Version #{error.message}"
        end
      end

      def get_agent_version_number(version)
        if version.include? "fips"
          return version.split('-', 7)[5]
        elsif version.include? "griffin"
          return version.split('-', 6)[4]
        else
          return version.split(':')[-1]
        end
      end

      def configure(conf)
        super
        # let is_uma_metrics = false at start. It is used at other places to determine if uma metrics / griffin metrics
        @is_uma_metrics = false # to distinguish from UMA
        @env = OCI::Environment.new

        set_agentVersion()
        set_availabilityDomain()
        set_instanceId()
        set_hostClass()
        set_architecture()
        set_os_Version()
        set_compartment()
        set_tenancy()
        set_process_ids()

        @monitoring_plugin_tag = conf['tag']
        @map = {}
        @tail_plugins = get_tail_plugins()

        record = conf.elements('record').first # <record></record> directive
        record = Fluent::Config::Element.new('record', '', {}, []) if record.nil?

        # converting string keys into symbols
        record = record.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

        log.debug "Using record configuration: #{record}"

        # need to convert to hash, in case fluentd ignores hash type config_param directive
        if record[DIMENSIONS].is_a?(String)
          record[DIMENSIONS] = JSON.parse(record.fetch(DIMENSIONS, '{}').gsub('=>', ':'))
        end
        log.info "Using custom dimensions: #{record[DIMENSIONS]}"

        record.each_pair do |k, v|
          record.has_key?(k) # to suppress unread configuration warning
          @map[k] = v
        end

        @metrics_map = {}
        set_metrics_map(@metrics_map)
      end

      def is_user_principal
        false
      end

      def start
        super
        timer_execute(:agent_metrics_scan, @scrape_interval, &method(:on_timer))
      end

      def on_timer
        @output_plugins = get_output_plugins()

        time = Fluent::Engine.now
        es = Fluent::MultiEventStream.new

        emit_heartbeat(es, time)
        emit_heartbeat_instance_level(es, time)
        emit_tail_metrics(es, time)
        emit_plugin_metrics(es, time)
        emit_output_response_metric(es,time)
        emit_resource_usage_metric(es, time)

        @output_plugins.map do |pe|
          generate_monitor_info(pe, es, time) if pe.respond_to?(:statistics)
        end

        router.emit_stream(@tag, es)
      end

      ## Add a heartbeat metric to an event stream (value always 1).
      #
      # @param es [Fluent::MultiEventStream] A fluentd event stream (that will later be emitted)
      # @param time [Fluent::EventTime] A nanosecond granularity timestamp
      def emit_heartbeat(es, time)
        rec = base_record()
        rec[NAME] = AGENT_HEARTBEAT_METRIC_NAME
        rec[:datapoints] = [datapoint(time, 1)]
        dims = rec.fetch(DIMENSIONS, {})

        populate_default_dims(dims)
        rec[DIMENSIONS] = dims
        es.add(time, rec)
      end

      ## Add a instance level heartbeat metric to an event stream (value always 1).
      # This metric will be emitted to separate fleet with hostclass of the instance as the fleetname. In case hostclass does not exist, the fleet name will be NO_HOSTCLASS(by default).
      # @param es [Fluent::MultiEventStream] A fluentd event stream (that will later be emitted)
      # @param time [Fluent::EventTime] A nanosecond granularity timestamp
      def emit_heartbeat_instance_level(es, time)
        rec = base_record()
        rec[NAME] = @hostClass + "." + AGENT_HEARTBEAT_METRIC_NAME + INSTANCE_LEVEL_METRIC_NAME_SUFFIX
        rec[RESOURCE_GROUP] = @hostClass
        rec[:datapoints] = [datapoint(time, 1)]
        dims = rec.fetch(DIMENSIONS, {})
        populate_default_dims(dims)
        populate_default_dims_instanceLevel(dims)
        rec[DIMENSIONS] = dims
        es.add(time, rec)
      end

      ## Extract usage statistics for given plugins
      #
      # @param pe [Fluent::Plugin] A fluentd output plugin
      # @param es [Fluent::MultiEventStream] A fluentd event stream (that will later be emitted)
      # @param time [Fluent::EventTime] A nanosecond granularity timestamp
      #
      def generate_monitor_info(pe, es, time)
        stats = pe.statistics['output']
        if pe.respond_to?(:filter_statistics)
          filter_stats = pe.filter_statistics['output']
          if filter_stats.has_key?(:total)
            # adding oci_lumberjack filter statistics
            stats[AUDITD_DROP_METRIC_NAME] = filter_stats[:total][:auditd_drop_count]
            stats[AUDITD_EMIT_METRIC_NAME] = filter_stats[:total][:auditd_emit_count]
          end
        end

        stats.each do |key, val|
          if key.eql?(AUDITD_DROP_METRIC_NAME)
            rec = base_record()
            rec[NAME] = AUDITD_DROP_METRIC_NAME
          elsif key.eql?(AUDITD_EMIT_METRIC_NAME)
            rec = base_record()
            rec[NAME] = AUDITD_EMIT_METRIC_NAME
          else
            next
          end

          dims = rec.fetch(DIMENSIONS, {})

          #tag for each output plugin, example parsed.aide is added here
          match_line  = pe.config.to_s.lines.first.chomp.split[1]
          match_tag = match_line.nil? ? EMPTY_STRING : match_line[0...-1]
          log.debug "Tag for the output plugin: #{match_tag}"
          dims[CONFIG_TAG] = match_tag
          unless @agentVersion == nil
            dims[AGENT_VERSION] = @agentVersion
          end
          unless @hostClass == nil
            dims[HOSTCLASS] = @hostClass
          end
          unless @tenancyId == nil
            dims[TENANCY_ID] = @tenancyId
          end
          dims[AGENT_TYPE] = AGENT_TYPE_NAME
          rec[DIMENSIONS] = dims

          unless val.is_a?(Numeric)
            log.warn("Ignoring non numeric value for '#{key}': #{val}")
            continue
          end

          dps = rec.fetch(:datapoints, [])
          dps << datapoint(time, val)
          rec[:datapoints] = dps
          es.add(time, rec)
        end
      end
    end
  end
end
