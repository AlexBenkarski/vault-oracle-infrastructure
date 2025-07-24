require 'optparse'
require 'logger'
require 'set'
require 'zip'
require 'fileutils'
require 'open-uri'
require 'openssl'
require 'proxy_file_loader'
require 'json'
require 'fluent/config'

require_relative 'os'
require_relative 'public_cp_requests'

if OS.windows?
  require 'win32/service'
end

class FluentConfigUpdater
  class FluentPublicConfigUpdaterError < StandardError; end
  include OS
  include PublicCPRequests

  # Local test paths
  LOCAL_TEMP_DIR = "/tmp"

  # Windows Paths
  LOG_PATH_WINDOWS = "C:\\oracle_unified_agent\\unified-monitoring-agent.log"
  PROD_TEMP_DIR_WINDOWS = "C:\\oracle_unified_agent\\unified-monitoring-agent"
  WINDOWS_UPLOADER_OUTPUT_LOG = "C:\\oracle_unified_agent\\unified-monitoring-agent\\unified-agent-config-updater.log"
  CONFIG_NAME_WINDOWS = "unified-monitoring-agent.conf"
  CONFIG_VALIDITY_DIR_WINDOWS = "C:\\oracle_unified_agent\\unified-monitoring-agent"

  # Linux Paths
  LOG_PATH = "/var/log/unified-monitoring-agent/unified-monitoring-agent.log"
  PROD_TEMP_DIR = "/etc/unified-monitoring-agenttmp"
  CONFIG_NAME = "fluentd.conf"
  FLUENTD_CONFIG_FOLDER = "fluentd_config"
  CONFIG_VALIDITY_DIR = "/etc/unified-monitoring-agent"
  OMK_OVERRIDE_DIR = "/etc/unified-monitoring-agent/omkoverrides"

  # Linux Paths with Read-Only root filesystem (base dir comes from ENV variable)
  RO_LOG_PATH = "log/unified-monitoring-agent/unified-monitoring-agent.log"
  RO_PROD_TEMP_DIR = "unified-monitoring-agenttmp"
  RO_CONFIG_VALIDITY_DIR = "unified-monitoring-agent"
  RO_OMK_OVERRIDE_DIR = "unified-monitoring-agent/omkoverrides"

  CONFIG_VALIDITY_NAME = "config_validity.txt"
  
  VALID_KEY = "valid"
  INVALID_KEY = "invalid"
  SUCCESS_KEY = "SUCCESS"
  FAIL_KEY = "FAIL"
  CREATION_TIMESTAMP = "CREATION_TIMESTAMP"
  LAST_CP_REFRESH_STATUS = "LAST_CP_REFRESH_STATUS"
  LAST_CP_DOWNLOAD_BYTES = "LAST_CP_DOWNLOAD_BYTES"
  LAST_CP_REFRESH_TIMESTAMP = "LAST_CP_REFRESH_TIMESTAMP"
  UNIFIED_COMPLIANCE_MONITORING_FILE_NAME = 'unified_monitoring.json'

  LINUX_SOURCE_INFO_TENANCYID = "/etc/unified-monitoring-agent/source_info/tenancyid_info"
  LINUX_SOURCE_INFO_SUBJECTID = "/etc/unified-monitoring-agent/source_info/subjectid_info"
  LINUX_SOURCE_INFO_COMPARTMENTID = "/etc/unified-monitoring-agent/source_info/compartmentid_info"

  WINDOWS_SOURCE_INFO_TENANCYID = "C:\\oracle_unified_agent\\source_info\\tenancyid_info"
  WINDOWS_SOURCE_INFO_SUBJECTID = "C:\\oracle_unified_agent\\source_info\\subjectid_info"
  WINDOWS_SOURCE_INFO_COMPARTMENTID = "C:\\oracle_unified_agent\\source_info\\compartmentid_info"

  WINEVT_POS_PATH = "C:/oracle_unified_agent/unified-monitoring-agent/winevt.pos"

  # copy of backup files by default, customers can change it by specifying --back-up <num>
  NUM_BACKUP_BY_DEFAULT = 1

  #config downloader sleep interval in mins
  SLEEP_INTERVAL = 15

  attr_accessor :origin_config_dir, :is_last_cp_refresh_successful, :unified_compliance_monitoring_dir

  def initialize
    @logger = OS.windows? ? Logger.new(WINDOWS_UPLOADER_OUTPUT_LOG) : ENV['CONFIG_DOWNLOADER_LOG']? Logger.new(ENV['CONFIG_DOWNLOADER_LOG']): Logger.new(STDOUT)

    # if RUN_CONFIG_DOWNLOADER env variable is set it means config downloader is loaded in runit
    @is_runit = ENV['RUN_CONFIG_DOWNLOADER'] || false
    @sleep_interval = Integer(ENV['CONFIG_DOWNLOADER_SLEEP'] || SLEEP_INTERVAL)
    @adjust_for_omk = ENV['USE_OMK_FRIENDLY'] || false

    if ENV['LOCAL_TEST']
      # For local test, prod temp directory is not setup, and Ruby doesn't have permission to create this directory under /etc
      @tmp_dir = LOCAL_TEMP_DIR
      @config_validity_dir = LOCAL_TEMP_DIR
      @unified_compliance_monitoring_dir = LOCAL_TEMP_DIR
      @log_path = LOG_PATH
      @omk_override_dir = OMK_OVERRIDE_DIR
    else
      # The tmp dir has been created by omnibus, which can be access by Ruby
      if OS.windows?
        @tmp_dir = PROD_TEMP_DIR_WINDOWS
        @log_path = LOG_PATH_WINDOWS
        @config_validity_dir = CONFIG_VALIDITY_DIR_WINDOWS
        @unified_compliance_monitoring_dir = ENV['UNIFIED_COMPLIANCE_MONITORING_DIR'] || CONFIG_VALIDITY_DIR_WINDOWS
      else
        @is_ro_root = ENV['RO_ROOT_FILESYSTEM'] || false
        if @is_ro_root
          ro_base_dir = ENV['RO_ROOT_FILESYSTEM']
          @tmp_dir = File.join(ro_base_dir, RO_PROD_TEMP_DIR)
          @log_path = ENV['FLUENT_LOG_DESTINATION']? ENV['FLUENT_LOG_DESTNIATION']: File.join(ro_base_dir, RO_LOG_PATH)
          @config_validity_dir = File.join(ro_base_dir, RO_CONFIG_VALIDITY_DIR)
          @unified_compliance_monitoring_dir = ENV['UNIFIED_COMPLIANCE_MONITORING_DIR'] || @config_validity_dir
          @omk_override_dir = File.join(ro_base_dir, RO_OMK_OVERRIDE_DIR)
        else
          @tmp_dir = PROD_TEMP_DIR
          @log_path = ENV['FLUENT_LOG_DESTINATION']? ENV['FLUENT_LOG_DESTNIATION']: LOG_PATH
          @config_validity_dir = CONFIG_VALIDITY_DIR
          @unified_compliance_monitoring_dir = ENV['UNIFIED_COMPLIANCE_MONITORING_DIR'] || CONFIG_VALIDITY_DIR
          @omk_override_dir = OMK_OVERRIDE_DIR
        end
      end
    end

    set_ca_file
    set_source_info_files

    @backup_num = NUM_BACKUP_BY_DEFAULT

    unless File.exist? @config_validity_dir
      @logger.info("creating dir at #{@config_validity_dir}")
      FileUtils.mkdir_p @config_validity_dir
    end
    @config_validity_path = OS.windows? ? @config_validity_dir + "\\" + CONFIG_VALIDITY_NAME : File.join(@config_validity_dir, CONFIG_VALIDITY_NAME)
    unless File.exist?(@config_validity_path) && !File.zero?(@config_validity_path)
      @logger.info("Creating file at #{@config_validity_path}")
      File.open(@config_validity_path, 'w') {|file| file.write("valid")}
    end
    @logger.info("config validity file created at #{@config_validity_path}")

    begin
      parse_argument(ARGV)
    rescue => e
      @logger.error(e.message)
      @logger.debug(e.backtrace.join("\n"))
      exit(1)
    end

    @origin_config_path = OS.windows? ? @origin_config_dir + "\\" + CONFIG_NAME_WINDOWS : File.join(@origin_config_dir, CONFIG_NAME)
    @new_config_path = OS.windows? ? @tmp_dir + "\\" + CONFIG_NAME_WINDOWS : File.join(@tmp_dir, CONFIG_NAME)
    @last_dry_run_config_dir = OS.windows? ? "C:\\oracle_unified_agent\\last_dry_run" : File.join(@config_validity_dir, "last_dry_run")
    @last_dry_run_config_path = OS.windows? ? @last_dry_run_config_dir + "\\" + CONFIG_NAME_WINDOWS : File.join(@last_dry_run_config_dir, CONFIG_NAME)
  end

  def set_ca_file
    if OS.windows?
      @ca_file = PUBLIC_DEFAULT_WINDOWS_CA_PATH
    elsif OS.debian?
      @ca_file = PUBLIC_DEFAULT_DEBIAN_CA_PATH
    else
      PUBLIC_DEFAULT_LINUX_CA_PATH
    end
  end

  def set_source_info_files
    if OS.windows?
      @tenancyid_file = WINDOWS_SOURCE_INFO_TENANCYID
      @subjectid_file = WINDOWS_SOURCE_INFO_SUBJECTID
      @compartmentid_file = WINDOWS_SOURCE_INFO_COMPARTMENTID
    else
      @tenancyid_file = LINUX_SOURCE_INFO_TENANCYID
      @subjectid_file = LINUX_SOURCE_INFO_SUBJECTID
      @compartmentid_file = LINUX_SOURCE_INFO_COMPARTMENTID
    end
  end

  def parse_argument(args)
    @logger.info("Start parsing input argument")
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: Fluentd config updater"

      opts.on('-c', '--config-dir DIR', 'Current fluentd config dir') do |dir|
        @origin_config_dir = OS.windows? ? dir : File.join(dir, FLUENTD_CONFIG_FOLDER)
        unless File.exist? @origin_config_dir
          @logger.info("folder #{@origin_config_dir} does not exist, create folder")
          FileUtils.mkdir_p @origin_config_dir
        end
      end

      # Optional parameter
      opts.on('-f', '--ca-file f', String, 'CA cert bundle path') do |file|
        @ca_file = file
      end

      # Optional parameter
      opts.on('-b', '--back-up n', Integer, 'Number of backup') do |num|
        @backup_num = num
      end
    end

    opts.parse!(args)

    # OptionParser doesn't provide way for required argument, has to manually check it
    raise FluentPublicConfigUpdaterError.new("Missing config dir") if @origin_config_dir.nil?
    @logger.info("Finish parsing argument with origin config dir #{@origin_config_dir}")

  end

  def create_dir_and_file(filename, contents)
    dirname = File.dirname(filename)
    unless File.directory?(dirname)
      @logger.info("#{dirname} DOES NOT EXIST...creating...")
      FileUtils.mkdir_p(dirname)
    end
    File.open(filename, "w") {|file| file.write(contents)}
  end

  def update_source_info
    begin
      tenancy_id, subject_id, compartment_id = get_source_info
    rescue => e
      if e.full_message.include?("Unsupported principal: resource principal")
        @logger.info(e.message)
      else
        @logger.error(e.message)
      end
      return nil
    end

    begin
      create_dir_and_file(@tenancyid_file, tenancy_id)
    rescue => e
      @logger.error(e.message)
    end

    begin
      create_dir_and_file(@subjectid_file, subject_id)
    rescue => e
      @logger.error(e.message)
    end

    begin
      create_dir_and_file(@compartmentid_file, compartment_id)
    rescue => e
      @logger.error(e.message)
    end
  end

  # Perform the config downloader actions
  def perform_actions
    begin
      @logger.info("Host is in #{@region}, start running updater")

      @logger.info('Loading proxy settings')
      config_dir ||= OS.windows? ? WINDOWS_OCI_CONFIG_DIR : LINUX_OCI_CONFIG_DIR
      proxy_settings = OCI::ProxyFileLoader.load_proxy_settings(config_dir: config_dir, log: @logger)

      update_source_info if !@is_runit
      @is_last_cp_refresh_successful = true
      initialize_public_cp_client(proxy_settings)
      data_size = download_config_from_cp
      adjust_download_for_omk if @adjust_for_omk && OS.linux?
      verify_and_reload_config
    rescue StandardError => e
      @is_last_cp_refresh_successful = false
      @logger.error("Error in run method: #{e.message}")
      @logger.debug(e.backtrace.join("\n"))
    ensure
      cleanup
      restart_agent_if_hung if !@is_runit
      publish_unified_monitoring_info(data_size)
    end
  end

  # Run config updater, it is enter point
  def run
    if @is_runit
      # In the absence of systemctl timer we need run to config downloader in a loop.
      while true
        perform_actions
        sleep_interval_in_mins = @sleep_interval + rand(1..10)
        @logger.info("Sleeping for #{sleep_interval_in_mins}")
        sleep(sleep_interval_in_mins*60)
      end
    else
      perform_actions
    end
  end

  def publish_unified_monitoring_info(data_size_in_bytes)
    if data_size_in_bytes.nil?
      data_size_in_bytes = 0
    end
    unified_compliance_monitoring_file_name = ENV['UNIFIED_COMPLIANCE_MONITORING_FILE_NAME'] || UNIFIED_COMPLIANCE_MONITORING_FILE_NAME
    @unified_compliance_monitoring_file_path = File.join(@unified_compliance_monitoring_dir, unified_compliance_monitoring_file_name)
    config_path = File.join(@origin_config_dir, "fluentd.conf")
    last_cp_refresh_timestamp = Time.now
    unified_monitoring_info_json_hash = {CREATION_TIMESTAMP => get_file_creation_time(config_path),
                LAST_CP_REFRESH_TIMESTAMP => Time.now,
                 LAST_CP_REFRESH_STATUS => @is_last_cp_refresh_successful ? SUCCESS_KEY : FAIL_KEY,
                 LAST_CP_DOWNLOAD_BYTES => data_size_in_bytes
                }
    @logger.info("Writing metadata to : #{@unified_compliance_monitoring_file_path}")
    File.open(@unified_compliance_monitoring_file_path, 'w') do |file|
      file.write(JSON.pretty_generate(unified_monitoring_info_json_hash))
    end
  end
  
  def get_file_creation_time(file_path)
    # Returns time when file was first created, else returns ''
    creation_time = ''
    if File.exist?(file_path)
      begin
        creation_time = File.birthtime(file_path)
      rescue StandardError, NotImplementedError => e
        @logger.info("Using ctime() function to retrieve creation time of file")
        creation_time = File.ctime(file_path)
      end
    end
    creation_time
  end

  # Download fluentd config from ControlPlane, and store it in tmp file
  def download_config_from_cp
    begin
      opts = {}
      data_size = 0
      config_valid = false
      config_result = File.readlines(@config_validity_path, chomp: true)[0]
      if !config_result.nil? && config_result.casecmp("valid") == 0
        config_valid = true
        @logger.info("config_valid flag is true")
      end
      opts[:is_config_valid] = config_valid
      result = get_generated_conf(opts)
      resp = result[:response]
      data_size = result[:data_size]
      if resp.status == 200
        write_config_to_tmp_file(resp.data.configuration)
        @logger.info("Downloaded #{data_size} bytes")
      else
        @logger.error("Failed to download config with status #{resp.status}, request id #{resp.request_id}")
        raise "Failed to download config with status #{resp.status}, request id #{resp.request_id}"
      end
      return data_size
    rescue StandardError => e
      @logger.error("Failed to download config from public cp due to exception: #{e.message}")
      raise
    end
  end

  def write_config_to_tmp_file(config)
    File.open(@new_config_path, 'w') { |file| file.write(config) }

    @logger.info("Finish writing config into file #{@new_config_path}")
  end

  # Adjust the downloaded configuration for OMK
  def adjust_download_for_omk
    begin
      # Load new config using Fluent Config
      config = Fluent::Config.build(config_path:@new_config_path)

      # Find SOURCE entries and adjust as needed
      find_and_adjust_source(config)

      # Replace all referenced to OMK_WORKLOAD_NAMESPACE
      replace_namespace(config)

      # Save the adjusted config (remove root stanzas)
      save_config = config.to_s.gsub(/\A<ROOT>\n/, "").gsub(/<\/ROOT>\n\z/, "").gsub(/^ {2}/, "")
      File.open(@new_config_path, 'w') { |file| file.write(save_config) }

      logger.info("Successfully adjusted generated config for OMK\n ====================\n#{save_config} \n=====================\n")

    end
  end

  def find_and_adjust_source(parent)
    # Are there any source elements in this layer
    parent.elements.each_with_index do |child,index|
      child_name = child.name
      if child_name == 'source'
        adjust_source(parent, index)
      # Worker and Label stanzas may include SOURCE
      elsif child_name == 'worker' or child_name == 'label'
        find_and_adjust_source(child)
      end
    end
  end

  def adjust_source(parent, index)
    # Adjust the source element of this item
    source = parent.elements[index]
    # Is this in_tail plugin?
    if source['@type'] == 'tail'
      adjust_tail_source(parent, index)
    # Is this metrics plugin?
    # XXX: Future?
    #elsif source['@type'] == 'openmetrics_k8s'
    #  adjust_openmetrics_source(parent, index)
    # Else ignore and move on
    else
      @logger.info("Do not adjust source: #{source[@type]}.")
    end
  end

  def adjust_tail_source(parent,index)
    # Read the replacement for omk source
    sourceoverride = "#{@omk_override_dir}/omksource.conf"

    # If there is a source override file
    if File.exist?(sourceoverride)
      # We need to alter this source for OMK
      # preserve some of the existing source (tag/pos)
      @logger.info("Update for omk friendly filters for in_tail plugin")
      source = parent.elements[index]
      # grab the tag
      sourcetag = source['tag']
      # grab the pos
      sourceposfile = source['pos_file']
      sourcetagprefix = sourcetag.sub(/(.*)\..*/, '\1')
      parser = nil
      if source.elements.length() > 0
        # Sources can have a parse element
        source_element = source.elements[0]
        # Check if this has a CRI parser?
        if source_element.name == 'parse'
          if source_element['@type'] == 'cri'
            parser = source.elements
          end
        end
      end

      oso = Fluent::Config.build(config_path:sourceoverride)
      # Loop over elements backwards and insert
      oso.elements.reverse.each do |addon|
        child_name = addon.name
        if child_name == 'source'
          addon['tag'] = sourcetag
          addon['pos_file'] = sourceposfile
          addon.elements = parser if parser
          parent.elements[index] = addon
          next
        end
        addon.arg = "#{sourcetagprefix}.**"
        # Insert the 2 filters after the source
        parent.elements.insert(index+1,addon)
      end
    else
      @logger.warn("#{sourceoverride} file does not exist")
    end
  end

  def adjust_openmetrics_source(parent,index)
    # We need to alter this source for OMK
    @logger.info("Update for omk friendly filters for metrics plugin")
    source = parent.elements[index]
    sourcetag = source['tag']
    sourcetagprefix = sourcetag.sub(/(.*)\..*/, '\1')
    # Read the replacement for omk metrics
    metricoverride = "#{@omk_override_dir}/omkmetric.conf"
    if File.exist?(metricoverride)
      omo = Fluent::Config.build(config_path:metricoverride)
      # Loop over elements backwards and insert
      omo.elements.reverse.each do |addon|
        # Insert the 2 filters after the source
        addon.arg = "#{sourcetagprefix}.**"
        parent.elements.insert(index+1,addon)
      end
    else
      @logger.warn("#{metricoverride} file does not exist")
    end
  end

  def replace_namespace(parent)
    # replace OMK_WORKLOAD_NAMESPACE with env
    parent.elements.each do |child|
      child_name = child.name
      if child.elements
        replace_namespace(child)
      end
    end
    for key in parent.keys()
      if parent[key].include? 'OMK_WORKLOAD_NAMESPACE'
        repnamespace = ENV['WORKLOAD_NAMESPACE'] || 'omk-missing'
        parent[key].sub! 'OMK_WORKLOAD_NAMESPACE', repnamespace
      end
    end
  end

  def verify_and_reload_config
    if is_config_verified?
      @logger.info("config is valid and different from current config, will replace old config and reload new config")
      delete_other_confs
      rename_old
      copy_new
      if @is_runit
        reload_agent_for_runit
      else
        reload_config
      end
    else
      @logger.info("No need to reload config")
    end
  end

  def is_config_verified?

    if diff_between_new_and_old_config?
      # at this point there is a config change, so copy the config
      # for comparision and corruption detection
      copy_dry_run_config
      if is_new_config_invalid?
        @logger.error("The new config is invalid, please check config format")
        @is_last_cp_refresh_successful = false
        return false
      end
      @logger.info("There is difference between new and old config, copy new config")
      true
    else
      @logger.info("No difference between old and new config, do nothing")
      false
    end
  end

  # Copy the last dry run config to the buffer location for comparison and corruption detection
  def copy_dry_run_config
    FileUtils.mkdir_p(@last_dry_run_config_dir) unless File.exist?(@last_dry_run_config_dir)
    @logger.info("copy the dry run config from #{@new_config_path} to #{@last_dry_run_config_path}")
    FileUtils.copy_file(@new_config_path, @last_dry_run_config_path)
  end

  # Make system call by dry running with fluentd
  def is_new_config_invalid?
    output = system_call_to_validate_conf @new_config_path
    @logger.info("System call fluentd to validate new config, output is \n
                              =========beginning of fluentd output========= \n
                 #{output}
                              =========end of fluentd output=========")
    unless output # The dryrun failed if it doesn't have the mark log
      File.open(@config_validity_path, 'w') {|file| file.write("invalid")}
      @logger.error('Config downloaded is invalid')
      return true
    end

    File.open(@config_validity_path, 'w') {|file| file.write("valid")}
    @logger.info('config downloaded is valid')
    false
  end

  # Make system call by dry running with fluentd
  def is_old_config_valid?
    output = system_call_to_validate_conf @origin_config_path
    @logger.info("System call fluentd to validate new config, output is \n
                            =========beginning of fluentd output========= \n
                 #{output}
                            =========end of fluentd output=========")
    unless output # The dryrun failed if it doesn't have the mark log
      return false
    end
    true
  end
  
  def diff_between_new_and_old_config?
    unless File.exist? @last_dry_run_config_path
      @logger.info("there is diff between new and last dry run config, file #{@last_dry_run_config_path} does not exist, create file")
      #restart the very first time
      @restart_uma = true
      return true 
    end
    
    unless FileUtils.compare_file(@new_config_path, @last_dry_run_config_path)
      @logger.info("File #{@new_config_path} content is different from #{@last_dry_run_config_path}")
      if @is_runit
        #test if we need to restart or reload by checking for #workers
        old_workers = File.readlines(@last_dry_run_config_path).grep(/workers/)
        new_workers = File.readlines(@new_config_path).grep(/workers/)
        #array can be empty, but comparison still would work
        #since the config is generated from CP, no need to trim whitespaces before compare
        @restart_uma = old_workers != new_workers
      end
      return true
    end

    false
  end


  # Delete other junk configs
  def delete_other_confs
    files = Dir.glob(File.join(@origin_config_dir, '*')).sort_by { |f| File.mtime(f) }
    files.each do |f|
      File.delete(f) if f != @origin_config_path
    end
    @logger.info("delete other old configs except #{CONFIG_NAME} in #{@origin_config_dir}")
  end

  def cleanup_winevt_pos_dir(uma_config_file, winevt_pos_dir)
    begin
      if File.exist?(uma_config_file) && !File.zero?(uma_config_file) && Dir.exist?(winevt_pos_dir)
        # since winevt.pos is not found in the UMA config file it is safe to delete it
        unless File.readlines(uma_config_file).grep(/winevt.pos/).any?
          Dir.glob(File.join(winevt_pos_dir,"*"))[0..1000].each do |f|
            FileUtils.rm_rf(f)
          end
          if Dir.empty?(winevt_pos_dir)
            @logger.info("Deleting #{winevt_pos_dir}")
            FileUtils.rm_rf(winevt_pos_dir)
          end
        end
      end
    rescue => e
      @logger.error(e.message)
    end
  end

  def rename_old
    # the ':' character isn't a valid character to use in Windows, so its better just to remove it
    zipfile_name = "#{@origin_config_dir}.#{Time.now.getutc.to_s.delete(":")}.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      Dir.glob("#{@origin_config_dir}/**").each do |filename|
        zipfile.add(File.basename(filename), filename)
      end
    end
    @logger.info("zip folder #{@origin_config_dir} into #{zipfile_name}")
  end

  def copy_new
    @logger.info("copy from #{@new_config_path} to #{@origin_config_path}")
    FileUtils.copy_file(@new_config_path, @origin_config_path)
  end
  
  # Send signal https://docs.fluentd.org/deployment/signals to fluentd supervisor process to reload new config
  def reload_config
    # Keep the reload config for MacOS for local testing purpose
    if OS.mac?
      @logger.info("The os is MacOS, get pid with system call and reload fluentd config in config updater")
      reload_config_for_mac_os
    elsif OS.linux?
      @logger.info("The os is Linux, config updater does nothing, systemd will reload fluentd config later")
    elsif OS.windows?
      @logger.info("The os is Windows, config updater requests the agent service to restart gracefully")
      reload_config_for_windows
    else
      @logger.error("The os is not supported by config updater, will not reload config")
    end
  end

  def reload_config_for_mac_os
    pid_str = system_call_to_get_fluentd_pid
    if pid_str != "" # If Fluentd is running
      begin
        pid_num = pid_str.sub("\n", "").to_i
        @logger.info("Reload fluentd config with supervisor pid #{pid_num}")
        Process.kill("USR2", pid_num)
      rescue Errno::ESRCH
        @logger.error("Invalid pid, failed to reload config")
      rescue Errno::EPERM
        @logger.error("Failed to send signal due to no privilege")
      end
    else
      @logger.info("No Fluentd is running, don't reload config")
    end
  end

  def reload_config_for_windows
    # Windows doesn't have a graceful reload, it only does a hard kill of processes
    # using the service restart commands below is a safer way to restart the agent
    # and allows for logs in process to finish before the service is shutdown
    # see https://github.com/fluent/fluentd/blob/master/lib/fluent/winsvc.rb#L76

    service_name = "unified-monitoring-agent"

    FFI.raise_windows_error('reload_config_for_windows') unless Win32::Service.exists?(service_name)

    Win32::Service.stop(service_name) unless  Win32::Service.status(service_name).current_state == "stopped"
    @logger.info("Windows #{service_name} service stop command initiated")
    # windows services need to stop within 60 seconds
    max_sleep = 60
    sleep_timer = 0
    loop do
      if Win32::Service.status(service_name).current_state == "stopped"
        break
      end

      sleep_timer += 1
      if sleep_timer > max_sleep
        raise "could not stop #{service_name} service"
      end
      sleep(1)
    end
    @logger.info("Windows #{service_name} service stop completed")

    Win32::Service.start(service_name)
    @logger.info("Windows #{service_name} service started")

    true
  end

  def cleanup
    FileUtils.remove_file(@new_config_path) if File.exist?(@new_config_path)

    cleanup_agenttmp
    cleanup_newest_backup
    cleanup_winevt_pos_dir(@origin_config_path, WINEVT_POS_PATH) if OS.windows?
    @logger.info("finished cleaning up tmp config files #{@new_config_path}")
  end

  # Clean up oldest tmp files
  def cleanup_agenttmp
    if @tmp_dir == LOCAL_TEMP_DIR
      @logger.info("don't clean up tmp folder #{@tmp_dir} for local test")
      return
    end

    tmp_files = Dir.glob(File.join(@tmp_dir, "*")).sort_by { |f| File.mtime(f) }
    if tmp_files.length > 10
      tmp_files[0, tmp_files.length - 10].each do |f|
        begin
          File.delete(f)
        rescue
          @logger.warn("Could not delete tmp file #{f}")
        end
      end
    end

    @logger.info("clean up files under tmp folder #{@tmp_dir}")
  end

  # Clean up backup, basically we want to clean up the newest backup
  def cleanup_newest_backup
    backup_files = Dir.glob(File.join("#{File.dirname(@origin_config_dir)}","*.zip")).sort
    if backup_files.length > @backup_num
      @logger.info("cleaning up newest backup as exist #{backup_files.length} backup files is larger than maximum #{@backup_num}")
      FileUtils.remove(backup_files[@backup_num..backup_files.length])
    end

    @logger.info("Finish cleaning up backup under #{File.dirname(@origin_config_dir)}")
  end

  # Wrap system call into function to make test easier
  def system_call_to_get_fluentd_pid
    `ps | grep [f]luentd | grep #{@hostclass} | grep -v 'under-supervisor'| awk '{print $1}'`
  end

  def restart_agent_if_hung

    # The LOG_PATH does not exist during unit test in local
    unless File.exist? @log_path
      @logger.info("#{@log_path} does not exist, aborting restart")

      return
    end

    unless File.exist?(@origin_config_path)
      @logger.info("#{@origin_config_path} does not exist, aborting restart")
      return
    end


    if File.empty?(@origin_config_path)
      @logger.info("fluentd config in #{@origin_config_path} is empty, "\
          "no need to restart fluentd as it is expected to be hung")
      return
    end

    begin
      last_updated_time = File.mtime(@log_path)
      current_time = Time.now
      # if it hung for 50(60*50 secs) mins or more
      if(current_time.to_i - last_updated_time.to_i > 3000)
        @logger.info("restarting unified-monitoring-agent as it is frozen")
        OS.windows? ? reload_config_for_windows : `systemctl restart unified-monitoring-agent`
      end
      @logger.info("Finished running watchdog")
    rescue => e
      @logger.error(e.full_message)
    end
  end
  def reload_agent_for_runit
    @logger.info "reload_agent_for_runit #{@restart_uma}"
    if @restart_uma
      @logger.info("Ask runit to restart UMA service")
      # reload would only reload when the worker count is the same between old and new
      # restart would start/stop workers as needed.
      exec("sv -v restart uma")
    else
      @logger.info("Ask runit to reload UMA service")
      exec("sv -v reload uma")
    end
  end

  def system_call_to_validate_conf conf_name
    require 'fluent/supervisor'
    require 'fluent/version'
    @logger.info("calling fluentd to validate config file")
    opts = Fluent::Supervisor.default_options
    opts[:config_path]  = conf_name
    supervisor = Fluent::Supervisor.new(opts)
    supervisor.configure(supervisor: true)
    is_valid = false
    begin
      Fluent::Engine.init(supervisor.instance_variable_get(:@system_config))
      Fluent::Engine.run_configure(supervisor.instance_variable_get(:@conf), dry_run: true)
    rescue Fluent::ConfigParseError, Fluent::ConfigError => e
      @logger.error("Config validation error: #{e.message}")
      is_valid = false
    rescue Exception => err
      @logger.error("Other Config parsing validation error: #{err}")
      is_valid = false
    else
      @logger.info("Conf validation success")
      is_valid = true
    ensure
      return is_valid
    end
  end
end

def main
  updater = FluentConfigUpdater.new
  updater.run
end

if __FILE__ == $0
  main
end
