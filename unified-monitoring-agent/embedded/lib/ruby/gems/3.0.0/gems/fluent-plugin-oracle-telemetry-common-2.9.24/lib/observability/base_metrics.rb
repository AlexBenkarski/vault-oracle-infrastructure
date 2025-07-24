# Copyright (c) 2024, Oracle and/or its affiliates.  All rights reserved.

module AgentObservability
    module BaseMetrics

        # frozen_string_literal: true

        # Setting symbols as constant- used in key in the hash in metrics and other places.
        DIMENSIONS = :dimensions
        RESOURCE_GROUP = :resourceGroup
        NAME = :name
        AVAILABILITY_DOMAIN = :ad
        INSTANCE_ID = :instance_id
        INSTANCE_NAME = :instance_name
        K8S_NAMESPACE = :k8s_namespace
        POD_NAME = :pod_name
        REGION = :region
        OS_VERSION = :osVersion
        UMA_VERSION = :uma_version
        ARCHITECTURE = :arch
        NAMESPACE = :namespace
        CONFIG_TAG = :config_tag
        TYPE = :plugin_type
        EMPTY_STRING = ''
        AGENT_VERSION = :agent_version
        HOSTCLASS = :hostclass
        COMPARTMENT_ID = :compartment_id
        TENANCY_ID = :tenancy_id
        AGENT_TYPE = :agentType

        # setting keys in environment variable hash as constants
        ENV_INSTANCE_ID = "id"
        ENV_REGION = "region"
        ENV_AVAILABILITY_DOMAIN ="availabilityDomain"
        ENV_HOSTCLASS = "hostclass"
        ENV_COMPARTMENT_ID = "compartmentId"
        ENV_TENANCY_ID = "tenancyId"

        DEFAULT_HOSTCLASS = "NO_HOSTCLASS"
        OCI_MONITORING_PLUGIN_TYPE = "oci_monitoring"
        AGENT_TYPE_NAME = "fluentd"
        INSTANCE_LEVEL_METRIC_NAME_SUFFIX = ".instanceLevel"

        # Symbols that will be keeping values. These will be set in the configure section.
        attr_accessor :availabilityDomain
        attr_accessor :instanceId
        attr_accessor :env     #  environment variable (metadata of the instance)
        attr_accessor :agentVersion
        attr_accessor :hostClass
        attr_accessor :architecture
        attr_accessor :os_Version
        attr_accessor :compartmentId
        attr_accessor :tenancyId
        attr_accessor :region
        attr_accessor :principal
        attr_accessor :host_name
        attr_accessor :oci_config
        attr_accessor :is_uma_metrics
        attr_accessor :supervisor_pid
        attr_accessor :worker_pid_array
        attr_accessor :monitoring_plugin_tag

        def require_dependencies
            require 'oci/environment'
        end

        def get_host_name
            if @host_name.nil?
                begin
                    @host_name = Socket.gethostname
                rescue
                    ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
                    @host_name = ip ? ip.ip_address : 'UNKNOWN'
                end
            end
            return @host_name
        end

        def set_availabilityDomain()
            if is_user_principal
                # If user principal is used, the we are setting ad1 as the default ad. The idea is that we will be using user principal for non-oci
                # instances and they don't have imds accessibility - so unable to find ad for those instances.
                @availabilityDomain = "ad1"
            else
                require_dependencies
                @availabilityDomain = "ad#{@env[ENV_AVAILABILITY_DOMAIN][-1]}"
            end
            log.info "Fetched Availability domain is #{@availabilityDomain}"
        end

        def set_region()
            if is_user_principal
                @oci_config = create_oci_config
                @region = @oci_config.region
            else
                require_dependencies
                @region = @env[ENV_REGION]
            end
            log.info "Fetched region is #{@region}"
        end

        def set_compartment
            @compartmentId = (@env[ENV_COMPARTMENT_ID].nil?) ? "" : @env[ENV_COMPARTMENT_ID]
            log.info "Fetched compartmentId is #{compartmentId}"
        end

        def set_tenancy
            @tenancyId = (@env[ENV_TENANCY_ID].nil?) ? @compartmentId : @env[ENV_TENANCY_ID]
            log.info "Fetched tenancyId is #{@tenancyId}"
        end

        def set_hostClass
            @hostClass = (@env[ENV_HOSTCLASS].nil?) ? DEFAULT_HOSTCLASS : @env[ENV_HOSTCLASS]
            log.info "Fetched hostclass is #{@hostClass}"
        end

        def set_instanceId()
            if is_user_principal
                @instanceId = get_host_name
            else
                require_dependencies
                @instanceId = @env[ENV_INSTANCE_ID]
            end
            log.info "Fetched Instance id is #{@instanceId} Host : #{get_host_name}"
        end

        def set_architecture
            begin
                unless OS.windows?
                    @architecture = `echo -n $(uname -m)`
                else
                    arch = `systeminfo | findstr /B /C:"System Type"`
                    arch = arch.sub("System Type:", "")
                    arch = arch.strip()
                    if arch.include? "x64"
                        @architecture = "x86_64"
                    else
                        @architecture = "aarch64"
                    end
                end
                log.info "Fetched architecture is #{@architecture}"
            rescue => error
                log.error "Error while fetching Arch #{error.message}"
            end
        end

        def set_os_Version
            begin
                unless OS.windows?
                    @os_Version = `echo -n $(cat /etc/os-release | grep "PRETTY_NAME"  | cut -d "=" -f2- | sed 's/\"//g')`
                else
                    @os_Version = `systeminfo | findstr /B /C:"OS Name"`
                    @os_Version = @os_Version.sub("OS Name:", "")
                    @os_Version = @os_Version.strip()
                end
                log.info "Fetched OS Version is #{@os_Version}"
            rescue => error
                log.error "Error while fetching OS Version #{error.message}"
            end
        end

        def base_record
            # populate base info into the record (resourceGroup, namespace, dimensions)
            rec = Marshal.load(Marshal.dump(@map))
            rec
        end

        ## Generate a datapoint (that will later be pushed to a metrics endpoint)
        #
        # @param time [Fluent::EventTime] A nanosecond granularity timestamp
        # @param val [Numeric] The value of the datapoint
        #
        # @return [Hash] Hash with values 'value', 'timestamp', 'count'.
        #                Count is always 1.
        #
        def datapoint(time, val)
            dpoint = {}
            dpoint[:value] = val
            dpoint[:timestamp] = time.to_time.utc.to_datetime.rfc3339(3)
            dpoint[:count] = 1
            dpoint
        end

        def populate_k8s_dims(dims)
          unless ENV['K8S_NAMESPACE'] == nil
            dims[K8S_NAMESPACE] = ENV['K8S_NAMESPACE']
          end
          unless ENV['POD_NAME'] == nil
            dims[POD_NAME] = ENV['POD_NAME']
          end
        end

        def populate_default_dims(dims)
            if @is_uma_metrics == false
                unless @agentVersion == nil
                    dims[AGENT_VERSION] = @agentVersion
                end
                unless @hostClass == nil
                    dims[HOSTCLASS] = @hostClass
                end
                unless @tenancyId == nil
                    dims[TENANCY_ID] = @tenancyId
                end
            else
                @is_k8s_env = (ENV['WORKLOAD_SIGNER'] || ENV['K8S_NAMESPACE']) || false
                if @is_k8s_env
                  populate_k8s_dims(dims)
                end
                unless @agentVersion == nil
                    dims[UMA_VERSION] = @agentVersion
                end
                unless @region == nil
                    dims[REGION] = @region
                end
            end

            unless @availabilityDomain == nil
                dims[AVAILABILITY_DOMAIN] = @availabilityDomain
            end
            unless @architecture == nil
                dims[ARCHITECTURE] = @architecture
            end
            unless @os_Version == nil
                dims[OS_VERSION] = @os_Version
            end
            dims[AGENT_TYPE] = AGENT_TYPE_NAME
        end

        def populate_default_dims_instanceLevel(dims)
            if @is_uma_metrics == true
                @is_k8s_env = (ENV['WORKLOAD_SIGNER'] || ENV['K8S_NAMESPACE']) || false
                if @is_k8s_env
                    populate_k8s_dims(dims)
                end
            end
            unless @instanceId == nil
                dims[INSTANCE_ID] = @instanceId
            end
            unless @host_name == nil
                dims[INSTANCE_NAME] = @host_name
            end
        end
    end
end
