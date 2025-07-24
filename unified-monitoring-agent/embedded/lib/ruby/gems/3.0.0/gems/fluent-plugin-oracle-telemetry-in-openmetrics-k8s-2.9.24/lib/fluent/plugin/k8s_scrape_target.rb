require_relative 'k8s_constants'
require 'observability/input_metrics'

module Fluent::Plugin::OpenMetrics::Input

    CADVISOR_MINIMUM_INTERVAL = 60

    # a ScrapeTarget is uniquely identified by a URL
    class K8sScrapeTarget < ScrapeTarget
        include AgentObservability::InputPluginMetrics

        def param_matcher(pa)
            pa['target_type'] == @matcher_type
        end

        # param: id  (string) => an identifier for this target eg 'pod/<namespace>/<name>'
        # param: job (ScrapeJob)  => our father and owner
        # param: tgtcfg (Fluentd::Config::Element) => scrape configuration block (<scrape> or <target>)
        # param: sd_match (k-v tuple): Set by K8s service discovery when a pod is bound to a resource_matcher
        #         key   => matcher_type(eg. 'node_exporter')
        #         value => list of target URL or Proc to invoke for scraping
        # param: dimensions (k-v tuple): Any dimensions to be set for all metrics
        def initialize(id, job, tgtcfg, sd_match, dimensions, resource_metadata={})
            raise "Kubernetes Scrape target: must belong to a K8sScrapeJob" unless job.is_a?(K8sScrapeJob)
            raise "Kubernetes Scrape target: missing service discovery metadata" unless sd_match
            @matcher_type, @url_list = sd_match
            super(id, job, tgtcfg)

            # enforce a minimum interval for cAdvisor because it is resource intensive and slow
            if @matcher_type == 'cadvisor' && @interval < CADVISOR_MINIMUM_INTERVAL then
                log.warn "Enforcing #{CADVISOR_MINIMUM_INTERVAL} seconds interval on cAdvisor scrapes"
                @interval = CADVISOR_MINIMUM_INTERVAL
            end
            @dimensions = dimensions
            @resource_metadata = resource_metadata
        end

        # periodically scrape the endpoints
        def scrape
            log.debug "scraping #{@id}"
            #a matcher can optionally return a Proc to call the K8s API
            # client to get metrics through service proxies (eg. cAdvisor)
            # retry is required to refresh stale auth token
            if @proc_list.size > 0
                @proc_list.each do |url|
                    begin
                        retries ||= 0
                        metrics = url.call(@job.k8s_client)
                        log.debug "#{@id}: scraped #{(metrics.bytesize/1024).round} kilobytes"
                        @job.process(metrics, @dimensions, @resource_metadata)
                    rescue K8s::Error::Unauthorized
                        log.info "Refreshing k8s client token"
                        @job.k8s_client = @job.create_k8s_client
                        retry if (retries += 1) < 3
                    end
                end
            end

            if @http_uri_map.size > 0
                @http_uri_map.map do |http, req|
                    begin
                        resp = http.request(req)
                        if resp.is_a?(Net::HTTPResponse)
                            @last_scrape = Time.now
                            @last_msg = "#{resp.code} #{resp.message}"
                            log.debug "#{@id}: scraped #{resp.body.size} bytes: HTTP #{@last_msg}"
                            #process only successful scrape
                            if resp.code == SUCCESS_RESPONSE
                                update_target_status_map("openmetrics-k8s", @id, @job.tag, 1)
                                @job.process(resp.body, @dimensions, @resource_metadata)
                            else
                                update_target_status_map("openmetrics-k8s", @id, @job.tag, 0)
                            end
                        else
                            update_target_status_map("openmetrics-k8s", @id, @job.tag, 0)
                        end
                    rescue => e
                        update_target_status_map("openmetrics-k8s", @id, @job.tag, 0)
                        @last_msg = resp.is_a?(Net::HTTPResponse) ? "#{resp.code} #{resp.message} #{resp.body}" : e
                        log.warn "#{@id}: failed to get #{req.path}: #{@last_msg}"
                        log.debug e.full_message
                    end
                end
            end
        end
    end
end
