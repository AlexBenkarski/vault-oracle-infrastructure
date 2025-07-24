require_relative 'k8s_scrape_job'

module Fluent::Plugin::OpenMetrics::Input

  class InputK8s < Base

    def job_class; K8sScrapeJob; end

    Fluent::Plugin.register_input('openmetrics_k8s', self)

    # --------------------------------------
    # ------- Kubernetes targets -----------
    # --------------------------------------

    # only need to provide kubeconfig file when accessing a K8s cluster from the outside
    # when the KUBERNETES_SERVICE_HOST is defined, this isn't used
    config_param :kubeconfig, :string, default: '~/.kube/config'

    # used to scrape a node and its pods outside of a k8s cluster, or to disable
    # pod name autodiscovery when running inside a k8s cluster
    config_param :node_name, :string, default: nil

    # used to scrape a service in the k8s cluster
    config_param :service_name, :string, default: nil

    # the K8s namespace that contains the resources we want to scrape.
    # nil == discover resources in ALL K8s namespaces
    config_param :k8s_namespace, :string, default: nil

    # the K8s resource type to use for the watch API
    config_param :resource_type, :enum, list: [:pods, :nodes, :services, :endpoints], default: :pods

    # authentication related fields
    config_param :auth_type, :enum, list: [:basic_auth, :token, :tls], default: nil
    config_param :secret_name, :string, default: nil

    # parameters for Kubernetes scrape targets. Use target_type to hint which parameter applies to which matched resource
    config_section :param, multi: true, required: false do
        config_param :name,   :string
        config_param :values, :array
        config_param :target_type, :enum, list: [:node_exporter, :pod, :cadvisor], default: :node_exporter
    end

    config_param :open_timeout,  :time, default: 1
    config_param :read_timeout,  :time, default: 14
    config_param :interval, :time, default: 60
  end
end
