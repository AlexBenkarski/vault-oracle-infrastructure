
require "fluent/plugin/input"
require 'fluent/event'
require 'net/http'
require 'time'
require 'date'
require 'uri'
require 'oci/os'
require 'oci/config_file_loader'
require 'oci/config'
require 'observability/input_metrics'
require 'oci/util/sa_token_provider'
require 'observability/output_response_metrics'
require 'observability/plugin_metrics'
require 'observability/resource_usage_metrics'
require 'observability/tail_metrics'
require 'observability/base_metrics'
# frozen_string_literal: true

module Fluent
  module Plugin
    class UMAMetricsInput < Fluent::Plugin::Input
      include AgentObservability::BaseMetrics
      include AgentObservability::TailMetrics
      include AgentObservability::PluginMetrics
      include AgentObservability::InputPluginMetrics
      include AgentObservability::OutputPluginResponseMetrics
      include AgentObservability::ResourceUsageMetrics

      Fluent::Plugin.register_input(UMA_METRICS_PLUGIN_TYPE, self)

      helpers :timer

      # Metric names and the default values of some variables
      HEARTBEAT_METRIC_NAME = "Heartbeat"
      RESTART_METRIC_NAME = "RestartMetric"

      CONFIG_DOWNLOADER_HEARTBEAT_METRIC_NAME = "ConfigDownloaderHeartBeat"
      CONFIG_DOWNLOADER_VALIDITY_METRIC_NAME  = "ConfigDownloaderValidity"
      UNIFIED_MONITORING_STATUS_FILE = "/etc/unified-monitoring-agent/unified_monitoring.json"
      LAST_CP_REFRESH_STATUS = "LAST_CP_REFRESH_STATUS"
      LAST_CP_REFRESH_TIMESTAMP = "LAST_CP_REFRESH_TIMESTAMP"

      OCI_LOGGING_PLUGIN_TYPE = "oci_logging"
      DATAMESH_PLUGIN_TYPE = "oci_datamesh"
      WORKLOAD_SIGNER_TYPE = "workload"

      LINUX_OCI_CONFIG_DIR = "/etc/unified-monitoring-agent/.oci/config"
      WINDOWS_OCI_CONFIG_DIR = "C:\\oracle_unified_agent\\.oci\\config"

      USER_CONFIG_PROFILE_NAME = "UNIFIED_MONITORING_AGENT"

      attr_accessor :principal
      attr_accessor :host_name
      attr_accessor :oci_config

      if OS.windows?
        attr_accessor :uma_window_service_pid   # useful for uma windows service pid
      end

      # Setting scrape interval parameter with a default value of 60 seconds
      config_param :scrape_interval, :time, default: 60

      config_param :tag, :string
      config_param :metrics, :array, default: [], value_type: :string

      config_section :record do
        config_param NAMESPACE, :string
        config_param RESOURCE_GROUP, :string, default: nil
      end

      def configure(conf)
        super
        # let is_uma_metrics = true at start. It can be used at other places to determine if uma metrics / griffin metrics
        @is_uma_metrics = true

        workload_signer = ENV['WORKLOAD_SIGNER'] || false
        if workload_signer
          log.info("using #{WORKLOAD_SIGNER_TYPE} signer type")
          signer_type = WORKLOAD_SIGNER_TYPE
          oci_config = OCI::Config.new
          require 'oci/environment'
          @env = OCI::Environment.new
        else
          @principal = conf.elements('principal').first

          if !is_user_principal
            require 'oci/environment'
            @env = OCI::Environment.new
          end
        end

        set_umaVersion()
        set_availabilityDomain()
        set_instanceId()
        set_region()
        set_architecture()
        set_os_Version()
        set_process_ids()

        @monitoring_plugin_tag = conf['tag']
        if @monitoring_plugin_tag
          # The monitoring plugin tag has unique number at end for e.g. metrics_tag.736471 . So this regex will replace all after last dot (including dot) with empty character.
          # So metrics_tag.736471 will become metrics_tag
          @monitoring_plugin_tag = @monitoring_plugin_tag.sub(/\.([^.]*)\z/, '')
        end

        @restart_metric_flag = false
        @map = {}
        record = conf.elements('record').first # <record></record> directive
        record = Fluent::Config::Element.new('record', '', {}, []) if record.nil?

        # converting string keys into symbols
        record = record.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

        log.debug "Using record configuration: #{record}"

        record.each_pair do |k, v|
          record.has_key?(k) # to suppress unread configuration warning
          @map[k] = v
        end
        if !@map.has_key?(RESOURCE_GROUP) || @map[RESOURCE_GROUP] == ""
          @map[RESOURCE_GROUP] = "default"
        end
        @output_plugins = get_output_plugins()
        @tail_plugins = get_tail_plugins()

        @metrics_map = {}
        set_metrics_map(@metrics_map)
      end

      def is_user_principal
        if ENV['WORKLOAD_SIGNER']
          return false
        end
        if @principal.nil? || @principal.empty?
          config_dir = OS.windows? ?  WINDOWS_OCI_CONFIG_DIR : LINUX_OCI_CONFIG_DIR
          return false unless File.file?(config_dir)
            begin
              OCI::ConfigFileLoader.load_config(config_file_location: config_dir, profile_name: USER_CONFIG_PROFILE_NAME)
              @principal = {
                '@type' => 'user',
                'oci_config_path' => config_dir,
                'oci_config_profile' => USER_CONFIG_PROFILE_NAME
              }
              return true
            rescue
              return false
            end
        end
        @principal['@type'] == 'user'
      end

      def create_oci_config
        log.info "principal type is 'user', reading oci config "\
                   "#{@principal['oci_config_path']} profile #{@principal['oci_config_profile']}"
        oci_config = OCI::ConfigFileLoader.load_config(
          config_file_location: @principal['oci_config_path'],
          profile_name: @principal['oci_config_profile']
        )

        # Running fluentd with -vv will enable the OCI SDK to log all requests to the backend.
        # make sure to limit nr of metric samples per poll cycle, otherwise you'll surely clog your terminal...
        oci_config.log_requests = true if log.level == Fluent::Log::LEVEL_TRACE

        oci_config
      end

      def set_umaVersion
        begin
            if OS.debian? || OS.ubuntu?
                @agentVersion = `dpkg -s unified-monitoring-agent | grep Version | cut -d : -f 2 | cut -d - -f 1 | tr -d ' ' | tr -d '\n'`
            elsif !OS.windows?
                version = `rpm -qa | grep -E 'unified-monitoring-agent-[0-9]|unified-monitoring-agent-fips'`
                @agentVersion = get_uma_version_number(version)
                log.info "Fetched UMA Version #{version}. Version number is #{@agentVersion}"
            else
                cmd = '%{Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like “Unified-monitoring-agent*” } | Format-List -Property Version}'
                encoded_cmd = Base64.strict_encode64(cmd.encode('utf-16le'))
                @agentVersion = `powershell.exe -encodedCommand #{encoded_cmd}`
                @agentVersion = @agentVersion.sub("Version :", "")
                @agentVersion = @agentVersion.delete("\s\t\n")
            end
            log.info "Agent Version is #{@agentVersion}"
        rescue => error
            log.error "Error while fetching Agent Version #{error.message}"
        end
      end

      def get_uma_version_number(version)
        if version.include? "fips"
          return version.split('-', 6)[4]
        else
          return version.split('-', 6)[3]
        end
      end

      def execute_powershell_command(cmd)
        begin
          encoded_cmd = Base64.strict_encode64(cmd.encode('utf-16le'))
          output = `powershell.exe -encodedCommand #{encoded_cmd}`
          return output
        rescue StandardError => e
          log.error "An error occurred: #{e.message}"
        end
      end

      def getCPU(pid)
        begin
          cpu_cmd = %{(Get-Process -Id #{pid}).CPU}
          cpu = execute_powershell_command(cpu_cmd).split("\n")[0]
          return cpu.to_f.round(2)
        rescue StandardError => e
          log.error "An error occurred: #{e.message}"
        end
      end

      def getMemory(pid)
        begin
          memory_cmd = %{($(Get-Process -Id #{pid}).WorkingSet / (Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory) * 100}
          memory = execute_powershell_command(memory_cmd).split("\n")[0]
          return memory.to_f
        rescue StandardError => e
          log.error "An error occurred: #{e.message}"
        end
      end

      def populate_k8s_dims(dims)
        unless ENV['K8S_NAMESPACE'] == nil
          dims[K8S_NAMESPACE] = ENV['K8S_NAMESPACE']
        end
        unless ENV['POD_NAME'] == nil
          dims[POD_NAME] = ENV['POD_NAME']
        end
      end

      def start
        super
        timer_execute(:uma_metrics_scan, @scrape_interval, &method(:emit_metrics))
      end

      ## emit_metrics will be call periodically (1 min)
      # Heartbeat metrics will be sent when operational metrics are enabled
      # for other metrics there is a flag which when enabled that metric will be sent
      #
      def emit_metrics
        time = Fluent::Engine.now
        es = Fluent::MultiEventStream.new

        emit_heartbeat(es, time)

        emit_tail_metrics(es, time)

        emit_plugin_metrics(es, time)

        emit_output_response_metric(es,time)

        emit_resource_usage_metric(es, time)

        # @metrics contains the list of metrics which are enabled by the user including Heartbeat and RestartMetric.
        # RestartMetric requires different handling since it is sent only once when the UMA is restarted, not otherwise.
        # For other output metrics, we get the value from the respective plugin statistics.
        @metrics.each do |metric|
          unless @metrics_map.key?(metric)
            if metric == RESTART_METRIC_NAME && !@restart_metric_flag
              emit_restart_metric(es, time)
              @restart_metric_flag = true
            elsif metric.start_with?("ConfigDownloader")
              emit_config_downloader_metric(es, metric, time)
            end
            next
          end
        end

        emit_input_plugin_metrics(es, time)

        router.emit_stream(@tag, es)
      end

      def emit_heartbeat(es, time)
        rec = base_record()
        rec[NAME] = HEARTBEAT_METRIC_NAME
        rec[:datapoints] = [datapoint(time, 1)]
        dims = rec.fetch(DIMENSIONS, {})
        populate_default_dims(dims)
        populate_default_dims_instanceLevel(dims)
        rec[DIMENSIONS] = dims
        es.add(time, rec)
      end

      def emit_restart_metric(es, time)
        rec = base_record()
        rec[NAME] = RESTART_METRIC_NAME
        rec[:datapoints] = [datapoint(time, 1)]
        dims = rec.fetch(DIMENSIONS, {})
        @is_k8s_env = ENV['WORKLOAD_SIGNER'] || false
        if @is_k8s_env
          populate_k8s_dims(dims)
        else
          unless @instanceId == nil
            dims[INSTANCE_ID] = @instanceId
          end
          unless @host_name == nil
            dims[INSTANCE_NAME] = @host_name
          end
        end
        rec[DIMENSIONS] = dims
        es.add(time, rec)
      end

      def emit_config_downloader_metric(es, metric, time)
        if !File.exist?(UNIFIED_MONITORING_STATUS_FILE)
          return
        end

        file = File.read(UNIFIED_MONITORING_STATUS_FILE)
        data_hash = JSON.parse(file)

        rec = base_record()
        rec[NAME] = metric
        if metric != CONFIG_DOWNLOADER_HEARTBEAT_METRIC_NAME
          val = ((Time.now.to_i - DateTime.parse(data_hash[LAST_CP_REFRESH_TIMESTAMP]).to_time.to_i) < 1800)
        else
          val = (data_hash[LAST_CP_REFRESH_STATUS] != "FAIL")
        end
        rec[:datapoints] = [datapoint(time, val && 1 || 0 )]
        dims = rec.fetch(DIMENSIONS, {})
        unless @instanceId == nil
          dims[INSTANCE_ID] = @instanceId
        end
        rec[DIMENSIONS] = dims
        es.add(time, rec)
      end
    end
  end
end
