# frozen_string_literal: true
require 'oci/config_file_loader'

require 'logger'

module OCI
  # Module for loading proxy from a file
  module UmaSourceLoader
    class ConfigFileNotFoundError < RuntimeError; end

    class ProfileNotFoundError < RuntimeError; end

    class DefaultProfileDoesNotExistError < RuntimeError; end

    class InvalidConfigError < RuntimeError; end

    # Name of the default profile to load from a config file
    DEFAULT_PROFILE = 'UMA_SOURCE'.freeze
    # Default config file name and location
    DEFAULT_CONFIG_FILE = ConfigFileLoader::DEFAULT_CONFIG_FILE
    FALLBACK_DEFAULT_CONFIG_FILE = ConfigFileLoader::FALLBACK_DEFAULT_CONFIG_FILE
    OCI_CONFIG_FILE_ENV_VAR_NAME = ConfigFileLoader::OCI_CONFIG_FILE_ENV_VAR_NAME

    @logger = Logger.new(STDOUT)

    # rubocop:disable Metrics/CyclomaticComplexity
    # Loads the uma_source from the specified file and profile.
    #
    # @param [String] config_file_location Filename and path of the config file.
    # Defaults to "~/.oci/config" (on windows "C:\Users\{user}\.oci\config") with a fallback to
    # "~/.oraclebmc/config" (on windows "C:\Users\{user}\.oraclebmc\config")
    # If all the above fallbacks failed, it will use ENV VAR "OCI_CONFIG_FILE" to retrieve the path
    # @param [String] profile_name Name of the uma_source from the file. Defaults to "UMA_SOURCE".
    # @param [Logger] log Logger for logs
    # @return [UmaSourceConfig] A proxy
    def self.load_uma_source_config(config_dir: DEFAULT_CONFIG_FILE, profile_name: DEFAULT_PROFILE, log: nil)
      begin
        log&.info("file DEFAULT_CONFIG_FILE, #{config_dir}")
        uma_source_config = load_uma_source_by_profile(config_file_location: config_dir, profile_name: profile_name)
        if uma_source_config.nil?
          log&.info('Uma Source is not present in the config.')
        else
          log&.info("Using UMA source : #{uma_source_config.source_id_label}  #{uma_source_config.source_id_value}")
        end
      rescue ConfigFileNotFoundError => e
        log&.error("#{e.message} No UmaSource found.")
        uma_source_config = nil
      rescue => e
        log&.error(e.message)
        log&.error(e.backtrace.join("\n"))
        raise StandardError, 'Got error when processing uma_source settings.'
      end
      uma_source_config
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    # Loads the proxy from the specified file and profile.
    #
    # @param [String] config_file_location Filename and path of the config file.
    # Defaults to "~/.oci/config" (on windows "C:\Users\{user}\.oci\config") with a fallback to
    # "~/.oraclebmc/config" (on windows "C:\Users\{user}\.oraclebmc\config")
    # If all the above fallbacks failed, it will use ENV VAR "OCI_CONFIG_FILE" to retrieve the path
    # @param [String] profile_name Name of the uma source  from the file. Defaults to "UMA_SOURCE".
    # @return [UmaSourceConfig] A uma source
    def self.load_uma_source_by_profile(config_file_location: DEFAULT_CONFIG_FILE, profile_name: DEFAULT_PROFILE)
      env_var_config_path = ENV[OCI_CONFIG_FILE_ENV_VAR_NAME]
      if config_file_location == DEFAULT_CONFIG_FILE
        if File.exist?(File.expand_path(config_file_location))
          filter_profile_and_load_uma_source(config_file_location, profile_name)
        elsif File.exist?(File.expand_path(FALLBACK_DEFAULT_CONFIG_FILE))
          filter_profile_and_load_uma_source(FALLBACK_DEFAULT_CONFIG_FILE, profile_name)
        elsif !env_var_config_path.nil? && File.exist?(File.expand_path(env_var_config_path))
          filter_profile_and_load_uma_source(env_var_config_path, profile_name)
        else
          raise ConfigFileNotFoundError, 'Config file does not exist.'
        end
      else
        filter_profile_and_load_uma_source(config_file_location, profile_name)
      end
    end

    # rubocop:enable Metrics/CyclomaticComplexity
    # Loads proxy_settings matching profile_name
    #
    # @param [String] config_file_location Filename and path of the config file.
    # @param [String] profile_name Name of the proxy from the file.
    # @return [OCI::UmaSourceLoader::UmaSourceConfig] a proxy with profile_name found in given file
    def self.filter_profile_and_load_uma_source(config_file_location, profile_name)
      config_file_location = File.expand_path(config_file_location)
      raise ConfigFileNotFoundError, 'Config file does not exist.' unless File.file?(config_file_location)

      config_file = IniFile.load(config_file_location)

      uma_source_config = nil
      return uma_source_config if config_file.nil?

      config_file.each_section do |section|
        next if section != profile_name

        uma_source_config_tmp = UmaSourceConfig.new
        load_uma_source(config_file[section], uma_source_config_tmp)
        uma_source_config_tmp.validate

        unless uma_source_config_tmp.source_id_label.nil?
          uma_source_config = uma_source_config_tmp
        end

        break
      end

      return uma_source_config
    end

    # @param [Object] section
    # @param [Object] config
    def self.load_uma_source(section, config)
      section.each_key do |key|
        value = section[key]
        config.instance_variable_set("@#{key}", value) if config.respond_to?("#{key}=") && config.respond_to?(key)
      end
    end

    private_class_method :load_uma_source
    private_class_method :load_uma_source_by_profile
    private_class_method :filter_profile_and_load_uma_source
  end

  class UmaSourceConfig

    attr_accessor :source_id_label, :source_id_value

    def initialize
      @source_id_label = nil
      @source_id_value = nil
    end

    def validate
      if @source_id_label.nil? && @source_id_value.nil?
        raise OCI::UmaSourceLoader::InvalidConfigError, 'The source_id_label and source_id_value not provided'
      end
      if !@source_id_label.nil? && @source_id_label.empty? && (!@source_id_value.nil? && @source_id_value.empty?)
        raise OCI::UmaSourceLoader::InvalidConfigError, 'The source_id_label and source_id_label provided but empty value'
      end
      if !@source_id_label.nil? && !@source_id_label.empty? && (@source_id_value.nil? || @source_id_label.empty?)
        raise OCI::UmaSourceLoader::InvalidConfigError, 'The source_id_label is provided but the source_id_value is null'
      end
      if !@source_id_value.nil? && !@source_id_value.empty? && (@source_id_label.nil? || @source_id_label.empty?)
        raise OCI::UmaSourceLoader::InvalidConfigError, 'The source_id_value is provided but the source_id_label is null'
      end
    end
  end
end
