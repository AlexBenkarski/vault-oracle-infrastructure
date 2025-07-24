require 'socket'
require 'k8s-ruby'
require 'fluent/plugin/in_openmetrics'
require_relative 'k8s_resource_matchers'
require_relative 'k8s_scrape_target'
require_relative 'k8s_constants'

module Fluent::Plugin::OpenMetrics::Input

    class K8sScrapeJob < ScrapeJob

        include Fluent::Plugin::OpenMetrics::Input::K8sResourceMatchers
        attr_accessor :k8s_client

        def configure
            @in_cluster = true
            if !ENV['KUBERNETES_SERVICE_HOST']  # we're not running inside a k8s node
                @in_cluster = false
                kubeconfig = ENV['KUBECONFIG'] || @config['kubeconfig']
                raise Fluent::ConfigError, "KUBECONFIG env var or <scrape>/kubeconfig not set" unless kubeconfig
                raise Fluent::ConfigError, "K8s conf file #{@kubeconfig} does not exist" if !File.exist?(File.expand_path(kubeconfig))
                log.info "Using k8s conf file #{kubeconfig}"
            end
            Fluent::Plugin::OpenMetrics::Input::K8sResourceMatchers.in_cluster = @in_cluster
            @kube_conf_path = kubeconfig
            @k8s_client = create_k8s_client
            @resource_type = @config['resource_type'] || RESOURCE_TYPE_PODS

            if @resource_type.eql?(RESOURCE_TYPE_SERVICES) || @resource_type.eql?(RESOURCE_TYPE_ENDPOINTS)
              if @config['service_name'].nil?
                raise Fluent::ConfigError, "Service name can not be empty when resource type is services"
              end
            end

            @k8s_namespace = @config['k8s_namespace']

            @node_name = get_node_name
            raise Fluent::ConfigError, "MY_NODE_NAME env var or <scrape>/node_name not set" if @node_name.nil?
            log.info "Using node_name: #{@node_name}"

            @config.elements('param').each do |pa|
                # as k8s targets are configured after k8s_client watch() API has yielded so/me resources
                # to scrape, we merely access config params to silence FluentD alert
                ['name', 'values', 'target_type'].each {|k| pa[k]}
            end
            self
        end

        def create_k8s_client
          ENV['KUBERNETES_SERVICE_HOST'] ?
            # when running in_cluster, make sure the pod has the necessary RBAC roles
            ::K8s::Client.in_cluster_config :
            # Connect using a kubeconfig file
            ::K8s::Client.config(::K8s::Config.load_file(File.expand_path(@kube_conf_path)))
        end

        def start
            super
            # start watching for pods that export Prometheus metrics on the same K8s node...
            @resource_watcher = Thread.new do
              while true
                list_and_create_scrape_targets_for_k8s_resources
                sleep(30)
              end
            end
        end

        # targets are started by K8s discovery
        def start_targets; end

        FieldSelectorNames = {
          RESOURCE_TYPE_PODS => 'spec.nodeName',
          RESOURCE_TYPE_NODES => 'metadata.name',
          RESOURCE_TYPE_SERVICES => 'metadata.name',
          RESOURCE_TYPE_ENDPOINTS => 'metadata.name'
        }

        # Generate a hash key for a k8s resource.   This is used as the @targets hash key
        def key_from_resource(resource)
            "#{resource.kind}/#{resource.metadata.namespace}/#{resource.metadata.name}"
        end

        def list_and_create_scrape_targets_for_k8s_resources
          log.info "Creating scrape targets for #{@resource_type}"

          if @resource_type.eql?(RESOURCE_TYPE_SERVICES) || @resource_type.eql?(RESOURCE_TYPE_ENDPOINTS)
            field_selector = {FieldSelectorNames[@resource_type.downcase] => @config['service_name']}
          else
            field_selector = {FieldSelectorNames[@resource_type.downcase] => @node_name}
          end

          # Get the initial list of pods/nodes/services.   Event history can be as short as five
          # minutes, so start with the current list and monitor events from that
          # point onward.
          initial_list = @k8s_client.api(API_VERSION)
                     .resource(@resource_type, namespace: @k8s_namespace)
          resource_list = initial_list.meta_list(fieldSelector: field_selector)
          resources = initial_list.process_list(resource_list)
          resources.each do |resource|
            examine_k8s_resource_for_metrics(resource)
          end
          # For every other resource except nodes, we need to create a watcher.
          if @resource_type != RESOURCE_TYPE_NODES
            # For pods/services, we need to look out for additions and deletions. For nodes
            # there is no need as we are only monitoring cavisor on our own node.
            create_watcher(resource_list.metadata.resourceVersion, field_selector)
          end
        rescue Excon::Error::Socket => e
          # K8s client meta_list API throws other Socket errors. We should simply retry
          log.debug "Error occurred in initial list: #{e.backtrace}"
          log.error "Error occurred in initial list: #{e.message}"
          @k8s_client = create_k8s_client
          retry
        end

        def create_watcher(resource_version, field_selector)
          # Start a watcher to handle any changes since the initial list
          namespace_str = @k8s_namespace.nil? ? "all k8s namespaces" : "k8s namespace '#{@k8s_namespace}'"
          log.info "starting K8s watcher thread for #{@resource_type} from "\
                   "resourceVersion #{resource_version} for #{namespace_str}"
          @k8s_client
              .api(API_VERSION)
              .resource(@resource_type, namespace: @k8s_namespace)
              .watch(fieldSelector: field_selector, resourceVersion: resource_version) do |evt|
                return unless evt.type && evt.resource && evt.resource.metadata && evt.resource.metadata.name
                id = "#{@resource_type}/#{evt.resource.metadata.namespace || 'default'}/#{evt.resource.metadata.name}"
                log.info "#{id} #{evt.type}"
                case evt.type
                when 'ADDED', 'MODIFIED'
                  key = key_from_resource(evt.resource)
                  if @targets.has_key?(key)
                    log.info "Pod #{id} already has a watcher"
                    next
                  else
                    examine_k8s_resource_for_metrics(evt.resource)
                  end
                when 'DELETED'
                  # This has to match the key used in examine_pod_resource_for_metrics
                  key = key_from_resource(evt.resource)
                  if @targets.has_key?(key)
                    @targets[key].stop
                    @targets.delete(key)
                  else
                    log.info "No target #{key} to delete. Current targets are #{@targets.keys}"
                  end # if
                end # case
          end # watch
        rescue Excon::Error::Socket => e
          # K8s client watch API throws other Socket errors. We should simply retry
          log.debug "Error occurred in watcher: #{e.backtrace}"
          log.error "Error occurred in watcher: #{e.message}"
          log.info 'Watcher disconnected due to socket error, trying to reconnect'
          @k8s_client = create_k8s_client
          retry
        end

        def examine_k8s_resource_for_metrics(resource)
          if resource.kind == K8S_RESOURCE_TYPE_ENDPOINTS
            # We need to process endpoints differently
            log.info "Endpoint resource found."
            examine_k8s_endpoint_for_metrics(resource)
            return
          end

          if resource.kind == K8S_RESOURCE_KIND_POD
            unless resource.status.podIP
              # Muliple ADDED/MODIFIED message will be generated during pod creation
              # We don't want to start scraping until an IP address has been assigned for the pod.
              log.info "pod #{resource.metadata.name} does not have an IP address yet"
              return
            end
          end

          log.info "examining #{resource.kind.downcase} #{resource.metadata.name}"
          id = key_from_resource(resource)
          matches = match(resource)
          create_scrape_target_for_k8s_resource(resource, matches, id)
        end

        def create_scrape_target_for_k8s_resource(resource, matches, id)
          log.debug "Resource #{resource.metadata.name} with id: #{id} matches scrape targets: #{matches}"
          unless matches.empty? || matches.values.first.empty? || @targets.has_key?(id)
            # Add the name as a dimension, to be added to all metrics for this pod/node
            dimensions={resource.kind.downcase => resource.metadata.name}

            # TODO: what if a pod exposes metrics in multiple ports? (edge case..?)
            @targets[id] = K8sScrapeTarget.new(id, self, @config, matches.first, dimensions, resource.metadata.to_h)
            @targets[id].start
          end
        end

        ## Determine the node name to use for the k8s api, based on the running enviroment
        def get_node_name
          if ENV.has_key?('MY_NODE_NAME')
            log.info "Overriding node_name from MY_NODE_NAME env var."
            node_name = ENV['MY_NODE_NAME']
          else
            node_name = @config['node_name']
            if node_name.nil?
              log.info "Autodetecting node_name from pod environment."
              node_name = get_pod_node_name
            end
          end
          node_name
        end

        ## Determine a pod's current node (used for automated pod scraping)
        def get_pod_node_name
          if !ENV['KUBERNETES_SERVICE_HOST']
            log.info 'No pod environment detected.'
            return nil
          end

          ip_addresses = Socket.ip_address_list.reject( &:ipv4_loopback? ).reject( &:ipv6_loopback? ).map { |x| x.ip_address }
          raise "No ip addresses for pod" unless ip_addresses.length > 0
          pods = @k8s_client.api(API_VERSION).resource('pods').list(fieldSelector: {'status.podIP' => ip_addresses[0]})
          raise "No pods found with podIP=#{ip_addresses[0]}" unless pods.length > 0
          pods[0]['spec']['nodeName']
        rescue StandardError => e
          log.error "Unable to auto detect pod node name due to: #{e.message}"
          nil
        end

        def examine_k8s_endpoint_for_metrics(resource)
          # Endpoints can fully be scrapped only from within the cluster
          if resource.kind == K8S_RESOURCE_TYPE_ENDPOINTS && @in_cluster
            # Check if the service needs to be scraped.
            begin
              services = @k8s_client.api(API_VERSION).resource('services', namespace: @k8s_namespace).list(fieldSelector: {FieldSelectorNames[RESOURCE_TYPE_SERVICES] => resource.metadata.name})
              for service in services do
                if service.kind == K8S_RESOURCE_KIND_SERVICE &&
                  service.metadata.annotations &&
                  service.metadata.annotations[:"prometheus.io/scrape"] == "true" &&
                  service.metadata.annotations[:"prometheus.io/port"]
                then
                  scheme = service.metadata.annotations[:"prometheus.io/scheme"] || 'http'
                  path = service.metadata.annotations[:"prometheus.io/path"] || '/metrics'
                  port = service.metadata.annotations[:"prometheus.io/port"]
                  path = path.reverse.chomp('/').reverse
                  port = port.chomp('/')
                  Integer(port) rescue raise  StandardError.new "Bad port annotation: #{port}. Use Integer for port"
                else
                  log.info "Service #{service.metadata.name} annotations doesn't specify to scrape"
                  next
                end

                # Structure of an endpoint subsets is as follows
                # subsets:
                #   - addresses:
                #       - ip: 10.244.0.4
                #         nodeName: 10.0.10.103
                #         targetRef:
                #           kind: Pod
                #           namespace: kube-system
                #           name: kube-state-metrics-79cff5689d-tfvpk
                #           uid: 669078a5-1e2b-432a-b055-9d4eb2a08ce1
                #           resourceVersion: '23166326'
                #           apiVersion: v1
                #       - ip: 10.244.0.5
                #         nodeName: 10.0.10.103
                #         targetRef:
                #           kind: Pod
                #           namespace: kube-system
                #           name: kube-state-metrics-79cff5689d-mrnfl
                #           uid: d1913255-b09e-4ac3-ae6f-4a913a815dd6
                #           resourceVersion: '23166034'
                #           apiVersion: v1
                #     ports:
                #       - name: telemetry
                #         port: 8081
                #         protocol: TCP
                #       - name: http-metrics
                #         port: 8080
                #         protocol: TCP
                for subset in resource.subsets do
                  for address in subset.addresses do
                    # We will only scrape this endpoint if the pod in the backend runs on the same host, else we will have duplicates.
                    # we will only support pod backend for service endpoint in this version
                    if address.nodeName == @node_name && address.targetRef[:'kind'] == K8S_RESOURCE_KIND_POD
                      log.info "examining #{resource.kind.downcase} #{resource.metadata.name}"
                      id = key_from_resource(resource) + address.targetRef[:'name']
                      url_list = []
                      url_list << "#{scheme}://#{address.ip}:#{port}/#{path}"
                      matches = {"endpoint" => url_list}
                      create_scrape_target_for_k8s_resource(resource, matches, id)
                    end
                  end
                end
              end
            rescue K8s::Error::Unauthorized
              log.info "Refreshing k8s client token"
              @k8s_client = create_k8s_client
              retry if (retries += 1) < 3
            end
          end
        end
    end
end
