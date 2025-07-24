require 'oci/config_file_loader'
require 'oci/api_client_proxy_settings'

require 'inifile'
require 'logger'

module OCI
  # Module for loading proxy from a file
  module ProxyFileLoader
    class ConfigFileNotFoundError < RuntimeError; end

    class ProfileNotFoundError < RuntimeError; end

    class DefaultProfileDoesNotExistError < RuntimeError; end

    class InvalidConfigError < RuntimeError; end

    # Name of the default profile to load from a config file
    DEFAULT_PROFILE = 'UMA_PROXY'.freeze
    # Default config file name and location
    DEFAULT_CONFIG_FILE = ConfigFileLoader::DEFAULT_CONFIG_FILE
    FALLBACK_DEFAULT_CONFIG_FILE = ConfigFileLoader::FALLBACK_DEFAULT_CONFIG_FILE
    OCI_CONFIG_FILE_ENV_VAR_NAME = ConfigFileLoader::OCI_CONFIG_FILE_ENV_VAR_NAME

    # rubocop:disable Metrics/CyclomaticComplexity
    # Loads the proxy from the specified file and profile.
    #
    # @param [String] config_file_location Filename and path of the config file.
    # Defaults to "~/.oci/config" (on windows "C:\Users\{user}\.oci\config") with a fallback to
    # "~/.oraclebmc/config" (on windows "C:\Users\{user}\.oraclebmc\config")
    # If all the above fallbacks failed, it will use ENV VAR "OCI_CONFIG_FILE" to retrieve the path
    # @param [String] profile_name Name of the proxy from the file. Defaults to "UMA_PROXY".
    # @param [Logger] log Logger for logs
    # @return [OCI::ApiClientProxySettings] A proxy
    def self.load_proxy_settings(config_dir: DEFAULT_CONFIG_FILE, profile_name: DEFAULT_PROFILE, log: nil)
      begin
        proxy_settings = load_proxy_by_profile(config_file_location: config_dir, profile_name: profile_name)
        if proxy_settings.nil?
          log&.info('Proxy is not set in the config file. Run without proxy.')
        else
          log&.info("Using proxy: #{proxy_settings.proxy_address}:#{proxy_settings.proxy_port}")
        end
      rescue ConfigFileNotFoundError => e
        log&.info("#{e.message} Run without proxy.")
        proxy_settings = nil
      rescue => e
        log&.error(e.message)
        log&.debug(e.backtrace.join("\n"))
        raise StandardError, 'Got error when processing proxy settings.'
      end
      proxy_settings
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    # Loads the proxy from the specified file and profile.
    #
    # @param [String] config_file_location Filename and path of the config file.
    # Defaults to "~/.oci/config" (on windows "C:\Users\{user}\.oci\config") with a fallback to
    # "~/.oraclebmc/config" (on windows "C:\Users\{user}\.oraclebmc\config")
    # If all the above fallbacks failed, it will use ENV VAR "OCI_CONFIG_FILE" to retrieve the path
    # @param [String] profile_name Name of the proxy from the file. Defaults to "UMA_PROXY".
    # @return [OCI::ApiClientProxySettings] A proxy
    def self.load_proxy_by_profile(config_file_location: DEFAULT_CONFIG_FILE, profile_name: DEFAULT_PROFILE)
      env_var_config_path = ENV[OCI_CONFIG_FILE_ENV_VAR_NAME]
      if config_file_location == DEFAULT_CONFIG_FILE
        if File.exist?(File.expand_path(config_file_location))
          filter_profile_and_load_proxy(config_file_location, profile_name)
        elsif File.exist?(File.expand_path(FALLBACK_DEFAULT_CONFIG_FILE))
          filter_profile_and_load_proxy(FALLBACK_DEFAULT_CONFIG_FILE, profile_name)
        elsif !env_var_config_path.nil? && File.exist?(File.expand_path(env_var_config_path))
          filter_profile_and_load_proxy(env_var_config_path, profile_name)
        else
          raise ConfigFileNotFoundError, 'Config file does not exist.'
        end
      else
        filter_profile_and_load_proxy(config_file_location, profile_name)
      end
    end

    # rubocop:enable Metrics/CyclomaticComplexity
    # Loads proxy_settings matching profile_name
    #
    # @param [String] config_file_location Filename and path of the config file.
    # @param [String] profile_name Name of the proxy from the file.
    # @return [OCI::ApiClientProxySettings] a proxy with profile_name found in given file
    def self.filter_profile_and_load_proxy(config_file_location, profile_name)
      config_file_location = File.expand_path(config_file_location)
      raise ConfigFileNotFoundError, 'Config file does not exist.' unless File.file?(config_file_location)

      config_file = IniFile.load(config_file_location)

      config = nil
      return config if config_file.nil?

      config_file.each_section do |section|
        next if section != profile_name

        proxy = ProxyConfig.new
        load_proxy_section(config_file[section], proxy)
        proxy.validate

        unless proxy.proxy_address.nil?
          config = ApiClientProxySettings.new(proxy.proxy_address, proxy.proxy_port, proxy.proxy_user, proxy.proxy_password)
        end

        break
      end

      config
    end

    def self.load_proxy_section(section, config)
      section.each_key do |key|
        value = section[key]

        config.instance_variable_set("@#{key}", value) if config.respond_to?("#{key}=") && config.respond_to?(key)
      end
    end

    private_class_method :load_proxy_section
    private_class_method :load_proxy_by_profile
    private_class_method :filter_profile_and_load_proxy
  end

  class ProxyConfig

    attr_accessor :proxy_address, :proxy_port, :proxy_user, :proxy_password

    def initialize
      @proxy_address = nil
      @proxy_port = nil
      @proxy_user = nil
      @proxy_password = nil
    end

    def validate
      if !@proxy_address.nil? && @proxy_port.nil?
        raise OCI::ProxyFileLoader::InvalidConfigError, 'The proxy_address is provided but the proxy_port is not'
      end
      if @proxy_address.nil? && !@proxy_port.nil?
        raise OCI::ProxyFileLoader::InvalidConfigError, 'The proxy_port is provided but the proxy_address is not'
      end
      if !@proxy_port.nil? && (!@proxy_port.is_a? Integer)
        raise OCI::ProxyFileLoader::InvalidConfigError, 'The proxy_port must be an integer'
      end
      if @proxy_address.nil? && (!@proxy_user.nil? || !@proxy_password.nil?)
        raise OCI::ProxyFileLoader::InvalidConfigError, 'The proxy_address is missing but user or password is provided'
      end
      if !@proxy_user.nil? && @proxy_password.nil?
        raise OCI::ProxyFileLoader::InvalidConfigError, 'The proxy_user is provided but the proxy_password is not'
      end
      if @proxy_user.nil? && !@proxy_password.nil?
        raise OCI::ProxyFileLoader::InvalidConfigError, 'The proxy_password is provided but the proxy_user is not'
      end
    end
  end
end
