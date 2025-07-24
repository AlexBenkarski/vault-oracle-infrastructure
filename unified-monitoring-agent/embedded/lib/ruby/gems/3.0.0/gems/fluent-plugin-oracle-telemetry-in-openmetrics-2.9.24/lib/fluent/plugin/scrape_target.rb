require 'resolv-replace'
require 'net/http'
require 'fluent/plugin/metrics_utils.rb'
require 'observability/input_metrics'

module Fluent::Plugin::OpenMetrics
  module Input
    HTTP_SUCCESS_RESPONSE = "200"
    DEFAULT_SCRAPE_INTERVAL = 10
    DEFAULT_OPEN_TIMEOUT = 1
    DEFAULT_READ_TIMEOUT = 9
    UMA_SECRETS_ROOT="/etc/uma-secrets"
    # a ScrapeTarget is uniquely identified by a URL
    class ScrapeTarget
        include Fluent::Plugin::PublicMetricsUtils
        include AgentObservability::InputPluginMetrics

        # the last time a successful scrape took place
        attr_reader :last_scrape, :last_msg
        attr_reader :interval
        attr_reader :url_list, :matcher_type
        attr_accessor :http_uri_map
        attr_accessor :proc_list


        # param: id  (string) => an identifier for this target eg 'pod/<namespace>/<name>' or a url
        # param: job (ScrapeJob)  => our father and owner
        # param: tgtcfg (optional) (Fluentd::Config::Element) => scrape configuration block (<target>)
        # param: sd_match (k-v tuple): Set by K8s service discovery when a pod is bound to a resource_matcher
        def initialize(id, job, tgtcfg, sd_match=nil)
            raise Fluent::ConfigError, "Scrape target must belong to a job" unless job
            @id, @job = id, job
            # scrape target config params can be specified in the job (<scrape>),
            # but can also be overridden in each <target>
            ['interval', 'open_timeout', 'read_timeout'].each do |overridable|
                tgtcfg[overridable] ||= job.config[overridable]
            end
            @cfg = tgtcfg
            @url_list ||= [@cfg["url"]]
            @interval = (@cfg['interval'] || DEFAULT_SCRAPE_INTERVAL).to_f
            @http_uri_map = {}
            @proc_list = []
            init_params()
            @url_list.each do |url|
                if url.is_a?(String)
                    init_http(url)
                elsif url.is_a?(Proc)
                    proc_list << url
                end
            end
        end

        def start
            # set up timer
            @timer = Thread.new do
                sleep rand(@interval)
                while @interval
                    scrape
                    sleep @interval || 0
                end
                log.debug "timer stopped for #{@id}"
            end
        end

        def stop
            log.debug "stopping timer for #{@id}"
            @interval = nil
        end

        # proxy for logging
        def log(*args)
            @job.log(*args)
        end

        # append params to the @url
        def init_params
            if @cfg.elements(name:'param').size > 0
                param_maps = @cfg.elements(name:'param')
                param_maps = param_maps.select {|pm| param_matcher(pm) }
                if param_maps.size > 0
                    param_values = "?" + param_maps.map { |pa|
                        URI.encode_www_form({pa['name'] => pa['values'].split(',').map(&:strip)})
                    }.join('&')
                    updated_url_list = []
                    @url_list.each do |url|
                        updated_url_list << "#{url}#{param_values}"
                    end
                    @url_list = updated_url_list
                end
            end
        end

        def init_http(url)
            raise "Scrape target doesn't define a URL!" unless url
            uri = URI.parse(url)
            http = ::Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = url.start_with?('https')
            # TODO: pass in client certificate and/or CA cert as optional argument
            if url.start_with?('https')
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            end
            http.open_timeout = (@cfg['open_timeout'] || DEFAULT_OPEN_TIMEOUT).to_f # in seconds
            http.read_timeout = (@cfg['read_timeout'] || DEFAULT_READ_TIMEOUT).to_f # in seconds
            req = Net::HTTP::Get.new(uri.request_uri)

            if @job.auth_type == "basic_auth"
                if @job.secret_name.nil? || @job.secret_name.empty?
                    log.error("secret_name is nil or empty. Invalid configuration")
                end
                username, password = get_basic_auth_creds(@job.secret_name.to_s)
                req.basic_auth username, password
            elsif @job.auth_type == "token"
                if @job.secret_name.nil? || @job.secret_name.empty?
                    log.error("secret_name is nil or empty. Invalid configuration")
                end
                token = get_bearer_token(@job.secret_name.to_s)
                req['Authorization'] = "Bearer " + token
            elsif @job.auth_type == "tls"
                http.verify_mode = OpenSSL::SSL::VERIFY_PEER
                begin
                    http.ca_file = set_default_ca_file
                rescue => e
                    log.error(e.message)
                end
            elsif @job.auth_type != nil
                log.error("Invalid auth_type [#{@job.auth_type}]")
            end

            log.debug "Set up scraper to poll every #{@interval} seconds (timeouts open:#{http.open_timeout}, read:#{http.read_timeout}) for #{uri}"
            @http_uri_map[http] = req
        end

        def get_basic_auth_creds(secret_name)
            username_file = UMA_SECRETS_ROOT+"/"+secret_name+"/username"
            begin
                username = File.open(username_file, &:readline).chomp
            rescue => e
                log.error(e.message)
                username = ""
            end
            password_file = UMA_SECRETS_ROOT+"/"+secret_name+"/password"
            begin
                password = File.open(password_file, &:readline).chomp
            rescue => e
                log.error(e.message)
                password = ""
            end
            [username, password]
        end

        def get_bearer_token(secret_name)
            token_file = UMA_SECRETS_ROOT+"/"+secret_name+"/bearer-token"
            begin
                token = File.open(token_file, &:readline).chomp
            rescue => e
                log.error(e.message)
                token = ""
            end
            token
        end
    end

    class StaticScrapeTarget < ScrapeTarget
        # for static targets, match <param>/target_type based on id (==url), if provided
        def param_matcher(pa)
            pa['target_type'].nil? || (pa['target_type'] == @id)
        end
        def scrape
            log.debug "scraping static target #{@id}"
            @http_uri_map.map do |http, req|
                resp = http.request(req)
                if resp.is_a?(Net::HTTPResponse)
                    @last_scrape = Time.now
                    @last_msg = "#{resp.code} #{resp.message}"
                    log.debug "scraped #{resp.body.size} bytes: HTTP #{@last_msg} from #{@id}"
                    log.debug "Fetched #{resp.body.lines.reject {|x| x[0] == '#'}.length} metrics."
                    if resp.code == HTTP_SUCCESS_RESPONSE
                        update_target_status_map("openmetrics", @id, @job.tag, 1)
                        @job.process(resp.body, {})
                    else
                        update_target_status_map("openmetrics", @id, @job.tag, 0)
                    end
                else
                    update_target_status_map("openmetrics", @id, @job.tag, 0)
                end
            rescue => e
                update_target_status_map("openmetrics", @id, @job.tag, 0)
                @last_msg = resp.is_a?(Net::HTTPResponse) ? "#{resp.code} #{resp.message} #{resp.body}" : e
                log.warn "#{@id}: failed to get #{req.path}: #{@last_msg}"
                log.debug e.backtrace
            end
        end
    end
  end
end
