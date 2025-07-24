require_relative 'scrape_target'
require 'concurrent'

module Fluent::Plugin::OpenMetrics
  module Input

    class ScrapeResponse
      attr_reader :response, :dimensions, :resourceGroup
      def initialize(response, dimensions, resourceGroup)
        @response = response
        @dimensions = dimensions
        @resourceGroup = resourceGroup
      end
    end

    # a ScrapeTargetGroup is defined by a <scrape> config block
    # and contains at least one ScrapeTarget
    class ScrapeJob

      attr_reader :config, :targets, :name, :resourceGroup, :pool, :auth_type, :secret_name, :tag

      def configure(conf)
        raise "Do not instantiate a ScrapeJob, use a proper subclass instead"
      end

      def initialize(plugin, config)
        @plugin, @config = plugin, config
        @name = config['name'] || "#{config['mode']}/#{object_id}"
        @targets = {}
        @resourceGroup = config['resourceGroup'] || ""
        @auth_type = @config['auth_type']
        @secret_name = @config['secret_name']
        @tag = plugin.tag
      end

        # proxy for logging
      def log(*args)
        @plugin.log(*args)
      end

      Thread.abort_on_exception = true

      def start
        log.debug "Starting poller thread"
        @pool = Concurrent::ThreadPoolExecutor.new(max_queue: 0)
        log.debug "Starting scrapers"
        start_targets
      end

      def stop
        log.info "Stopping #{@targets.size} targets"
          @targets.each { |id,tgt|
            log.info "stopping target #{id}"
              tgt.stop
          }
          log.info "Stopping poller thread"
      end

        # called by scrape targets timer threads, therefore we need to pass response data in a thread-safe container
      def process(response, dimensions, resource_metadata={})
        r = ScrapeResponse.new(response, dimensions, @resourceGroup)
        future = Concurrent::Future.execute(:executor => @pool) do
          @plugin.process(r.response, r.dimensions, r.resourceGroup, resource_metadata)
        end
        log.debug "waiting: #{@pool.queue_length}, completed: #{@pool.completed_task_count}, no. of threads: #{@pool.length}"
      end
    end

    # static scrape job module
    class StaticScrapeJob <  ScrapeJob
      def configure()
        @config.elements(name: 'target').each do |tgtcfg|
          id = tgtcfg['url'] || 'default'
          @targets[id] = StaticScrapeTarget.new(id, self, tgtcfg)
        end
        self
      end

      def start_targets
        @config.elements('target').each { |targetcfg|
          id = targetcfg['url'] || 'default'
          @targets[id].start
        }
      end
    end
  end
end
