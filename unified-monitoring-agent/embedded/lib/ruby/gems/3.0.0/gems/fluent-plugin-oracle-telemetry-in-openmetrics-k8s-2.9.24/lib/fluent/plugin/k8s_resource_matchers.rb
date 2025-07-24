require_relative 'k8s_constants'

module Fluent::Plugin::OpenMetrics::Input

    module K8sResourceMatchers

      module_function
      def in_cluster; @in_cluster end
      def in_cluster= v; @in_cluster = v end

      def self.get_container_ports(resource)
        container_ports = []
        if resource.metadata.annotations[:'prometheus.io/port']
          container_port = resource.metadata.annotations[:'prometheus.io/port']
          container_port = container_port.chomp('/')
          Integer(container_port) rescue raise  StandardError.new "Bad port annotation: #{container_port}. Use Integer for port"
          container_ports << container_port
        elsif  resource.spec.containers
          containers = resource.spec.containers
          containers.each do |container|
            ports = container.ports
            ports.each do |port|
              container_ports <<  port.containerPort
            end
          end
        end
        container_ports
      end

        MATCHERS = Hash.new

        # K8s resource matcher for node exporters
        MATCHERS['node_exporter'] = Proc.new do |resource|
            if resource.kind == K8S_RESOURCE_KIND_POD &&
                resource.metadata.labels &&
                resource.metadata.labels[:'component'] == 'node-exporter' &&
                (node_exporter_container = resource.spec.containers.find { |c| c.image.include?('prom/node-exporter') }) &&
                (node_exporter_port = node_exporter_container.ports.find { |p| p[:'name'] == 'metrics' })
            then
                # TODO: could node_exporter use ssl?
                url_list = []
                url_list << "http://#{resource.status.podIP}:#{node_exporter_port[:'hostPort']}/metrics"
                url_list
            end
        end

        # K8s resource matcher for annotation-based pod exporters
        # Note that the podIP won't be available initially, as the pod will be in pending or creating
        MATCHERS['pod'] = Proc.new do |resource|
          if resource.kind == K8S_RESOURCE_KIND_POD &&
            resource.metadata.annotations &&
            resource.metadata.annotations[:"prometheus.io/scrape"] == "true" &&
            resource.status.podIP
          then
            scheme = resource.metadata.annotations[:"prometheus.io/scheme"] || 'http'
            path = resource.metadata.annotations[:"prometheus.io/path"] || '/metrics'
            path = path.reverse.chomp('/').reverse
            container_ports = get_container_ports(resource)
            url_list = []
            if @in_cluster
              # TODO: discover service port for pods hosting services that share the same HTTP listener
              container_ports.each do |port|
                url_list << "#{scheme}://#{resource.status.podIP}:#{port}/#{path}"
              end
            else
              container_ports.each do |port|
                final_path = "#{resource.metadata.namespace}/pods/#{resource.metadata.name}:#{port}/proxy/#{path}"
                url_list << Proc.new { |client| client.api(API_VERSION).resource('namespaces').get(final_path) }
              end
            end
            url_list
          end
        end

        # K8s resource matcher for service discovery.
      MATCHERS['service'] = Proc.new do |resource|
        if resource.kind == K8S_RESOURCE_KIND_SERVICE &&
          resource.metadata.annotations &&
          resource.metadata.annotations[:"prometheus.io/scrape"] == "true"
        then
          scheme = resource.metadata.annotations[:"prometheus.io/scheme"] || 'http'
          path = resource.metadata.annotations[:"prometheus.io/path"] || '/metrics'
          path = path.reverse.chomp('/').reverse
          container_ports = get_container_ports(resource)
          url_list = []

          if @in_cluster
            container_ports.each do |port|
              url_list << "#{scheme}://#{resource.metadata.name}.#{resource.metadata.namespace}:#{port}/#{path}"
            end
          else
            container_ports.each do |port|
              final_path = "#{resource.metadata.namespace}/services/#{resource.metadata.name}:#{port}/proxy/#{path}"
              url_list << Proc.new { |client| client.api(API_VERSION).resource('namespaces').get(final_path) }
            end
          end
          url_list
        end
      end

        # cAdvisor
        MATCHERS['cadvisor'] = Proc.new do |resource|
            if resource.kind == K8S_RESOURCE_KIND_NODE
            then
                url_list = []
                # TODO: implement timeout, cadvisor scrape takes ages!
                url_list << Proc.new { |client| client.api(API_VERSION).resource('nodes').get("#{resource.metadata.name}/proxy/metrics/cadvisor") }
                url_list
            end
        end

        # run a K8s resource across all available matchers to get metrics scrape endpoints
        # returns a (possibly empty) array of tuples of 1) matcher_ids and 2) the metrics URLs they produced
        def match(resource)
            # run k8s resource through all matchers, then select only those that yield a URL
            Hash[MATCHERS.
                map{ |type, matcher_proc| [type, matcher_proc.call(resource)] } ].
                select { |_, url| !url.nil? }
        end

    end

end
