# frozen_string_literal: true

#
# Fluentd Kubernetes Metadata Filter Plugin - Enrich Fluentd events with
# Kubernetes metadata
#
# Copyright 2017 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative 'kubernetes_metadata_cache_strategy'
require_relative 'kubernetes_metadata_common'
require_relative 'kubernetes_metadata_stats'
require_relative 'kubernetes_metadata_util'
require_relative 'kubernetes_metadata_watch_namespaces'
require_relative 'kubernetes_metadata_watch_pods'
require_relative 'kubernetes_metadata_watch_nodes'

require 'fluent/plugin/filter'
require 'resolv'
require 'objspace'

module Fluent::Plugin
  class KubernetesMetadataFilter < Fluent::Plugin::Filter
    K8_POD_CA_CERT = 'ca.crt'
    K8_POD_TOKEN = 'token'

    include KubernetesMetadata::CacheStrategy
    include KubernetesMetadata::Common
    include KubernetesMetadata::WatchNamespaces
    include KubernetesMetadata::WatchPods
    include KubernetesMetadata::WatchNodes

    Fluent::Plugin.register_filter('kubernetes_metadata', self)

    # see README for description and usage of config params
    config_param :kubernetes_url, :string, default: nil
    config_param :apiVersion, :string, default: 'v1'
    config_param :verify_ssl, :bool, default: false
    config_param :ssl_partial_chain, :bool, default: false
    config_param :client_cert, :string, default: nil
    config_param :client_key, :string, default: nil
    config_param :ca_file, :string, default: nil
    config_param :secret_dir, :string, default: '/var/run/secrets/kubernetes.io/serviceaccount'
    config_param :bearer_token_file, :string, default: nil
    config_param :open_timeout, :integer, default: 3
    config_param :read_timeout, :integer, default: 10

    config_param :watch, :bool, default: true
    config_param :watch_retry_interval, :integer, default: 1
    config_param :watch_retry_exponential_backoff_base, :integer, default: 2
    config_param :watch_retry_max_times, :integer, default: 10
    config_param :cache_size, :integer, default: 1000
    config_param :cache_ttl, :integer, default: 60 * 60
    config_param :stats_interval, :integer, default: 30
    config_param :test_api_adapter, :string, default: nil

    # metadata specific

    # tag matching
    REGEX_VAR_LOG_CONTAINERS = '(var\.log\.containers)\.(?<pod_name>[^_]+)_(?<namespace>[^_]+)_(?<container_name>.+)-(?<container_id>[a-z0-9]{64})\.log$'
    REGEX_VAR_LOG_PODS = '(var\.log\.pods)\.(?<namespace>[^_]+)_(?<pod_name>[^_]+)_(?<pod_uuid>[a-z0-9-]+)\.(?<container_name>.+)\..*\.log$'

    config_param :tag_to_kubernetes_name_regexp, :string, default: "#{REGEX_VAR_LOG_PODS}|#{REGEX_VAR_LOG_CONTAINERS}"

    # record matching
    config_param :from_record_field, :string, default: nil

    # log streams
    config_param :log_caching, :bool, default: true
    config_param :annotation_match, :array, default: []
    config_param :skip_pod_labels, :bool, default: false
    config_param :skip_namespace_labels, :bool, default: false
    config_param :skip_node_labels, :bool, default: false
    config_param :skip_namespace_metadata, :bool, default: false
    config_param :skip_node_metadata, :bool, default: false
    config_param :skip_container_metadata, :bool, default: false

    # metric streams
    config_param :pod_label_match, :array, default: []
    config_param :namespace_label_match, :array, default: []
    config_param :node_label_match, :array, default: []
    config_param :skip_namespace_metadata_for_metrics, :bool, default: true
    config_param :skip_node_metadata_for_metrics, :bool, default: true
    config_param :to_record_field, :string, default: nil

    def initialize
      super
      @prev_time = Time.now
      @ssl_options = {}
      @auth_options = {}
      @node_agent = ENV['NODE_NAME'] ? true : false
    end

    def configure(conf)
      super

      require 'kubeclient'
      require 'lru_redux'

      @stats = KubernetesMetadata::Stats.new
      if @stats_interval <= 0
        @stats = KubernetesMetadata::NoOpStats.new
        self.define_singleton_method(:dump_stats) {}
      end

      if @cache_ttl < 0
        log.info 'Setting the cache TTL to :none because it was <= 0'
        @cache_ttl = :none
      end

      # Use the namespace + pods name as the key to fetch a hash containing pod metadata
      @pod_cache = LruRedux::TTL::ThreadSafeCache.new(@cache_size, @cache_ttl)

      # Use the namespace as the key to fetch a hash containing namespace metadata
      @namespace_cache = LruRedux::TTL::ThreadSafeCache.new(@cache_size, @cache_ttl)

      # Use the node name as the key to fetch a hash containing node metadata
      @node_cache = LruRedux::TTL::ThreadSafeCache.new(@cache_size, @cache_ttl)

      @tag_to_kubernetes_name_regexp_compiled = Regexp.compile(@tag_to_kubernetes_name_regexp)

      unless @log_caching
        @skip_namespace_metadata = true
        @skip_node_metadata = true
        @skip_container_metadata = true
      end

      @annotations_regexps = []
      @annotation_match.each do |regexp|
        @annotations_regexps << Regexp.compile(regexp)
      rescue RegexpError => e
        log.error "Error: skipping invalid regular expression in annotation_match: #{e}"
        next
      end

      # Use Kubernetes default service account if we're in a pod.
      if @kubernetes_url.nil?
        log.debug 'Kubernetes URL is not set - inspecting environ'

        env_host = ENV['KUBERNETES_SERVICE_HOST']
        env_port = ENV['KUBERNETES_SERVICE_PORT']
        if present?(env_host) && present?(env_port)
          if env_host =~ Resolv::IPv6::Regex
            # Brackets are needed around IPv6 addresses
            env_host = "[#{env_host}]"
          end
          @kubernetes_url = "https://#{env_host}:#{env_port}/api"
          log.debug "Kubernetes URL is now '#{@kubernetes_url}'"
        else
          log.debug 'No Kubernetes URL could be found in config or environ'
        end
      end


      if present?(@kubernetes_url)
        # Use SSL certificate and bearer token from Kubernetes service account.
        if Dir.exist?(@secret_dir)
          log.debug "Found directory with secrets: #{@secret_dir}"
          ca_cert = File.join(@secret_dir, K8_POD_CA_CERT)
          pod_token = File.join(@secret_dir, K8_POD_TOKEN)

          if !present?(@ca_file) && File.exist?(ca_cert)
            log.debug "Found CA certificate: #{ca_cert}"
            @ca_file = ca_cert
          end

          if !present?(@bearer_token_file) && File.exist?(pod_token)
            log.debug "Found pod token: #{pod_token}"
            @bearer_token_file = pod_token
          end
        end

        @ssl_options = {
          client_cert: present?(@client_cert) ? OpenSSL::X509::Certificate.new(File.read(@client_cert)) : nil,
          client_key: present?(@client_key) ? OpenSSL::PKey::RSA.new(File.read(@client_key)) : nil,
          ca_file: @ca_file,
          verify_ssl: @verify_ssl ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
        }

        if @ssl_partial_chain
          # taken from the ssl.rb OpenSSL::SSL::SSLContext code for DEFAULT_CERT_STORE
          require 'openssl'
          ssl_store = OpenSSL::X509::Store.new
          ssl_store.set_default_paths
          flagval = if defined? OpenSSL::X509::V_FLAG_PARTIAL_CHAIN
                      OpenSSL::X509::V_FLAG_PARTIAL_CHAIN
                    else
                      # this version of ruby does not define OpenSSL::X509::V_FLAG_PARTIAL_CHAIN
                      0x80000
                    end
          ssl_store.flags = OpenSSL::X509::V_FLAG_CRL_CHECK_ALL | flagval
          @ssl_options[:cert_store] = ssl_store
        end

        if present?(@bearer_token_file)
          @auth_options[:bearer_token_file] = @bearer_token_file
        end
      end
    end

    def start()
      unless present?(@kubernetes_url)
        return
      end

      create_client()

      if @test_api_adapter
        log.info "Extending client with test api adaper #{@test_api_adapter}"
        require_relative @test_api_adapter.underscore
        @client.extend(@test_api_adapter.constantize)
      end

      begin
        @client.api_valid?
      rescue KubeException => e
        raise Fluent::ConfigError, "Invalid Kubernetes API #{@apiVersion} endpoint #{@kubernetes_url}: #{e.message}"
      end

      # don't cache namespace or node metadata for node agent unless requested
      need_namespace_cache = (not @node_agent or not @skip_namespace_metadata or not @skip_namespace_metadata_for_metrics)
      need_node_cache = (not @node_agent or not @skip_node_metadata or not @skip_node_metadata_for_metrics)
      if @watch
        pod_thread = Thread.new(self, &:set_up_pod_thread)
        pod_thread.abort_on_exception = true

        if need_namespace_cache
          namespace_thread = Thread.new(self, &:set_up_namespace_thread)
          namespace_thread.abort_on_exception = true
        end

        if need_node_cache
          node_thread = Thread.new(self, &:set_up_node_thread)
          node_thread.abort_on_exception = true
        end
      else
        get_pods
        get_namespaces if need_namespace_cache
        get_nodes if need_node_cache
      end
    end

    def create_client()
      log.debug 'Creating K8S client'
      @client = nil
      @client = Kubeclient::Client.new(
        @kubernetes_url,
        @apiVersion,
        ssl_options: @ssl_options,
        auth_options: @auth_options,
        timeouts: {
          open: @open_timeout,
          read: @read_timeout
        },
        as: :parsed_symbolized
      )
    end

    def filter(tag, time, record)
      unless present?(@kubernetes_url)
        return record
      end

      log.info("filter: tag: #{tag}")

      # check tag_match_data first, then @from_record_field
      tag_match_data = tag.match(@tag_to_kubernetes_name_regexp_compiled)
      if tag_match_data
        tag_match_data = tag_match_data.named_captures
      else
        obj = if @from_record_field and record[@from_record_field]
          record[@from_record_field]
        else
          record
        end

        tag_match_data = {}
        # set to nil if non-existent
        tag_match_data['namespace'] = obj['namespace']
        tag_match_data['pod_name'] = obj['pod']
        tag_match_data['node_name'] = obj['node']
      end

      log.info("filter: tag_match_data: #{tag_match_data.inspect}")

      metadata = {}

      if tag.end_with?(".log")
        if tag_match_data['pod_name'] and tag_match_data['namespace']
          metadata.merge!(get_pod_metadata(tag_match_data['pod_name'], tag_match_data['namespace']))
          metadata.merge!(get_ns_metadata(tag_match_data['namespace'])) unless @skip_namespace_metadata
          metadata.merge!(get_node_metadata(metadata['host'])) unless @skip_node_metadata
          # if log is for a specific container, just add that container
          if tag_match_data['container_name']
            metadata['container_name'] = tag_match_data['container_name']
            if not @skip_container_metadata and metadata['containers'][tag_match_data['container_name']]
              metadata.merge!(metadata['containers'][tag_match_data['container_name']])
            end
            metadata.delete('containers')
          end
        end
      else
        # assume metric stream, only merge the requested labels (and pod_ip if node agent)
        # KSM cache TTL maybe > filter cache TTL so always verify each get_<resource>_metadata returns something
        if tag_match_data['namespace']
          if tag_match_data['pod_name']
            # pod metrics
            pod_meta = get_pod_metadata(tag_match_data['pod_name'], tag_match_data['namespace'])
            if pod_meta
              metadata['pod_ip'] = pod_meta['pod_ip'] if @node_agent

              # extract keys in @<resource>_label_match from the array of labels

              metadata.merge!(filter_metrics_metadata(pod_meta['labels'], @pod_label_match)) if pod_meta['labels']

              unless @skip_namespace_metadata_for_metrics
                ns_metadata = get_ns_metadata(tag_match_data['namespace'])
                if ns_metadata and ns_metadata['namespace_labels']
                  metadata['namespace_labels'] = filter_metrics_metadata(ns_metadata['namespace_labels'], @namespace_label_match)
                end
              end

              unless @skip_node_metadata_for_metrics
                node_metadata = get_node_metadata(pod_meta['host'])
                if node_metadata and node_metadata['node_labels']
                  metadata['node_labels'] = filter_metrics_metadata(node_metadata['node_labels'], @node_label_match)
                end
              end
            end
          elsif not @node_agent # TODO: BUG - some cAdvisor metrics missing container and pod names, only allow for cluster agent
            # namespace only (KSM)
            ns_metadata = get_ns_metadata(tag_match_data['namespace'])
            if ns_metadata and ns_metadata['namespace_labels']
             metadata.merge!(filter_metrics_metadata(ns_metadata['namespace_labels'], @namespace_label_match))
            end
          end
        elsif tag_match_data['node_name'] and not @node_agent
          # node only (KSM)
          node_metadata = get_node_metadata(tag_match_data['node_name'])
          if node_metadata and node_metadata["node_labels"]
             metadata.merge!(filter_metrics_metadata(node_metadata['node_labels'], @node_label_match))
          end
        end
      end

      unless metadata.empty?
        metadata.tap do |kube|
          kube.each_pair do |k,v|
            kube[k.dup] = v.dup
          end
        end

        if tag.end_with?(".log")
          record['kubernetes'] = metadata
        else
          if @to_record_field
            record[@to_record_field] = {} if not record[@to_record_field]
            record[@to_record_field].merge!(metadata)
          else
            record.merge!(metadata)
          end
          log.info("filter: metadata: #{metadata.inspect}")
        end
      end

      dump_stats
      log.info("filter: #{record.inspect}")
      record
    end

    def filter_metrics_metadata(metadata, match_array)
      return filter_metadata(metadata, match_array) if @log_caching
      # if not @log_caching, metadata already filtered by match_array in cache
      metadata
    end

    def dump_stats
      @curr_time = Time.now
      return if @curr_time.to_i - @prev_time.to_i < @stats_interval

      @prev_time = @curr_time
      @stats.set(:pod_cache_count, @pod_cache.count)
      @stats.set(:namespace_cache_count, @namespace_cache.count) if @namespace_cache
      @stats.set(:node_cache_count, @node_cache.count) if @node_cache
      @stats.set(:pod_cache_size, ObjectSpace.memsize_of(@pod_cache.instance_variable_get(:@data_lru)))
      @stats.set(:namespace_cache_size, ObjectSpace.memsize_of(@namespace_cache.instance_variable_get(:@data_lru))) if @namespace_cache
      @stats.set(:node_cache_size, ObjectSpace.memsize_of(@node_cache.instance_variable_get(:@data_lru))) if @node_cache

      log.info(@stats)
      if log.level == Fluent::Log::LEVEL_TRACE
        log.trace("      pod cache: #{@pod_cache.to_a}")
        log.trace("namespace cache: #{@namespace_cache.to_a}")
        log.trace("     node cache: #{@node_cache.to_a}")
      end
    end

    # copied from activesupport
    def present?(object)
      object.respond_to?(:empty?) ? !object.empty? : !!object
    end
  end
end
