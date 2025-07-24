# frozen_string_literal: true

require 'fluent/plugin/output'
require 'fluent/env'
require 'net/http'
require 'uri'

require 'oci/environment'

module Fluent
  module Plugin
    # Output Plugin for Telemetry (Service Enclave Only)
    class TelemetryOutput < Fluent::Plugin::Output
      Fluent::Plugin.register_output('oci_telemetry', self)
      helpers :formatter

      # endpoint override
      config_param :endpoint_url, :string, default: nil
      config_param :dimensions, :array, default: []

      config_section :buffer do
        config_set_default :@type, 'memory'
        config_set_default :flush_interval, 5
        config_set_default :chunk_limit_size, 4 * 1024 * 1024 # 4 MB
        config_set_default :chunk_limit_records, 1000
        config_set_default :retry_type, :periodic
        config_set_default :retry_wait, 5
        config_set_default :flush_thread_burst_interval, 0
      end

      config_section :format do
        config_set_default :@type, 'metrics'
      end

      def configure(conf)
        ensure_config_section(conf, 'buffer')
        ensure_config_section(conf, 'format')

        @env = OCI::Environment.new
        @env.region_override = conf['region']
        log.info "OCI environment: #{@env.inspect}"

        # default setup
        super

        @formatter = formatter_create

        # create default dimensions
        @uri = resolve_endpoint(conf['endpoint_url'])
        log.info "using endpoint #{@uri}"
        @http = ::Net::HTTP.new(@uri.host, @uri.port)
        @http.use_ssl = true
        @header = { 'Content-Type' => 'application/json' }
      end

      def ensure_config_section(conf, kind)
        if conf.elements(name: kind).empty?
          e = Fluent::Config::Element.new(kind, '', {}, [])
          conf.elements << e
        end
      end

      def resolve_endpoint(url)
        if url
          URI.parse(url + '/v2/metrics')
        else
          env = OCI::Environment.new
          URI.parse(env.endpoint('telemetry-api') + '/v2/metrics')
        end
      end

      def multi_workers_ready?
        true
      end

      def write(chunk)
        metrics = []
        chunk.each do |_, record|
          metrics.push(record)
        end
        send_metrics(metrics)
      end

      def send_metrics(metrics)
        res = nil
        begin
          req = ::Net::HTTP::Post.new(@uri.path, @header)
          req.body = @formatter.format(nil, nil, metrics)
          log.trace "payload: #{req.body}"
          res = @http.request(req)
        rescue StandardError => e # rescue all StandardErrors
          log.warn "Http raises exception: #{e.class}, '#{e.message}'"
          raise e
        else
          unless res&.is_a?(::Net::HTTPSuccess)
            res_summary = if res
                            "#{res.code} #{res.message} #{res.body} / #{res.header['opc-request-id']}"
                          else
                            'res=nil'
                          end

            # for server error and 429, raise an error so that it can retry
            raise res_summary if res&.is_a?(::Net::HTTPServerError) ||
                res&.is_a?(::Net::HTTPTooManyRequests)

            log.warn "Http failed to #{req.method} #{@uri} (#{res_summary})"
          end
        end
      end

    end
  end
end
