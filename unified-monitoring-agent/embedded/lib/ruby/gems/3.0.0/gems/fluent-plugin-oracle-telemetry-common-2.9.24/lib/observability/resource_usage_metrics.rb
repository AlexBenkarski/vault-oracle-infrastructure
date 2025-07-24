# Copyright (c) 2024, Oracle and/or its affiliates.  All rights reserved.
require 'observability/base_metrics'

module AgentObservability
  module ResourceUsageMetrics
    include AgentObservability::BaseMetrics

    CPU_METRIC_NAME = "AgentCpu"
    MEMORY_METRIC_NAME = "AgentMemory"
    MEMORY_MB_METRIC_NAME = "AgentMemoryMB"

    def set_process_ids
      unless OS.windows?
        agent = "unified-monitoring-agent"
        if @is_uma_metrics == false
          agent = "griffin"
        end

        @supervisor_pid = `ps -ef | grep [f]luentd | grep #{agent} | grep -v grep | grep -v under-supervisor | awk '{print $2}'`
        @worker_pids=`ps -ef | grep [f]luentd | grep #{agent} | grep under-supervisor | grep -v grep | awk '{print $2}'`
        @supervisor_pid = @supervisor_pid.chomp if @supervisor_pid
        log.info "#{agent} supervisor process pid = #{@supervisor_pid}"
        @worker_pid_array = @worker_pids.split("\n").map(&:strip) if @worker_pids
        log.info "#{agent} worker process pid array = #{@worker_pid_array}"
      else
        if @is_uma_metrics == false
          return    # return in case its griffin in windows
        end
        process_id_cmd = %{$(Get-WmiObject -Query "SELECT ProcessId FROM Win32_Service WHERE Name='unified-monitoring-agent'").ProcessId}
        @uma_window_service_pid= execute_powershell_command(process_id_cmd).split("\n")[0]
        log.info "uma window service pid = #{@uma_window_service_pid}"

        if @uma_window_service_pid != nil and @uma_window_service_pid != "" && @uma_window_service_pid != "0"
          uma_supervisor_pid_cmd = %{$(Get-WmiObject -Query "SELECT * FROM Win32_Process WHERE ParentProcessId=#{@uma_window_service_pid}").ProcessId}
          @supervisor_pid = execute_powershell_command(uma_supervisor_pid_cmd).split("\n")[0]
          log.info "uma supervisor process pid = #{@supervisor_pid}"

          uma_worker_pid_cmd = %{$(Get-WmiObject -Query "SELECT * FROM Win32_Process WHERE ParentProcessId=#{@supervisor_pid}").ProcessId}
          @worker_pid_array = execute_powershell_command(uma_worker_pid_cmd).split("\n")
          log.info "uma worker process pid array = #{@worker_pid_array}"
        end
      end
    end

    def get_resource_usage
      unless OS.windows?
        if @supervisor_pid != nil && @supervisor_pid != "" && !@worker_pid_array.empty?
          cpu_hash = {}
          memory_hash = {}
          supervisor_cpu = `ps -p #{@supervisor_pid} -o %cpu | awk 'NR==2 {print $1}'`.to_f.round(2)

          cpu_hash[@supervisor_pid] = {"cpu":supervisor_cpu, "tag":"supervisor"}
          supervisor_memory_percent = `ps -p #{@supervisor_pid} -o %mem | awk 'NR==2 {print $1}'`.to_f.round(2)
          supervisor_memory_kb = `ps -p #{@supervisor_pid} -o rss | awk 'NR==2 {print $1}'`.to_f.round(2)
          supervisor_memory_mb = supervisor_memory_kb /  1024
          memory_hash[@supervisor_pid] = { "memory": supervisor_memory_percent, "memory_mb": supervisor_memory_mb, "tag": "supervisor" }

          worker_idx = 0
          @worker_pid_array.each do |worker_id|
            worker_cpu = `ps -p #{worker_id} -o %cpu | awk 'NR==2 {print $1}'`.to_f.round(2)
            worker_memory_percent = `ps -p #{worker_id} -o %mem | awk 'NR==2 {print $1}'`.to_f.round(2)
            worker_memory_kb = `ps -p #{worker_id} -o rss | awk 'NR==2 {print $1}'`.to_f.round(2)
            worker_memory_mb = worker_memory_kb /  1024

            cpu_hash[worker_id] = { "cpu": worker_cpu, "tag": "worker#{worker_idx}" }
            memory_hash[worker_id] = { "memory": worker_memory_percent, "memory_mb": worker_memory_mb, "tag": "worker#{worker_idx}" }

            worker_idx += 1
          end

          return cpu_hash, memory_hash
        end
        return nil, nil
      else
        if @is_uma_metrics == false
          return nil, nil
        end
        if (@supervisor_pid == nil || @supervisor_pid == "" || @supervisor_pid == "0") &&  (@uma_window_service_pid == nil || @uma_window_service_pid == "" || @uma_window_service_pid == "0")
          return nil, nil
        end
        cpu_hash = {}
        memory_hash = {}
        total_time_cmd = %{(New-TimeSpan -Start (Get-Process -Id #{@uma_window_service_pid}).StartTime).TotalSeconds}
        total_process_time = execute_powershell_command(total_time_cmd).to_f
        log.info "Total time process is running = #{total_process_time}"
        if @uma_window_service_pid != nil && @uma_window_service_pid != "" && @uma_window_service_pid != "0"
          uma_windows_service_cpu = getCPU(@uma_window_service_pid)* 100.00 / total_process_time
          uma_windows_service_memory = getMemory(@uma_window_service_pid)* 100.00 / total_process_time
          cpu_hash[@uma_window_service_pid] = {"cpu":uma_windows_service_cpu, "tag":"uma_windows_service"}
          memory_hash[@uma_window_service_pid] = {"memory":uma_windows_service_memory, "tag":"uma_windows_service"}
        end
        if @supervisor_pid != nil && @supervisor_pid != "" && @supervisor_pid != "0"
          supervisor_cpu = getCPU(@supervisor_pid)* 100.00 / total_process_time
          supervisor_memory = getMemory(@supervisor_pid)* 100.00 / total_process_time
          cpu_hash[@supervisor_pid] = {"cpu":supervisor_cpu, "tag":"supervisor"}
          memory_hash[@supervisor_pid] = {"memory":supervisor_memory, "tag":"supervisor"}
        end

        worker_idx = 0
        @worker_pid_array.each do |worker_id|
          if @worker_pid_array != nil  && worker_id != nil &&  worker_id != "" &&  worker_id != "0"
            worker_cpu = getCPU(worker_id)* 100.00 / total_process_time
            worker_memory = getMemory(worker_id)* 100.00 / total_process_time
            cpu_hash[worker_id] = {"cpu":worker_cpu, "tag":"worker"+worker_idx.to_s}
            memory_hash[worker_id] = {"memory":worker_memory, "tag":"worker"+worker_idx.to_s}
            worker_idx = worker_idx + 1
          end
        end

        return cpu_hash, memory_hash
      end
      return nil, nil
    end

    def emit_resource_usage_metric(es, time)
      cpu_usage_hash, memory_usage_hash = get_resource_usage()
      cpu_usage_hash.each_pair do |process_id, process_details|
        unless process_details[:cpu] == nil
          if (@is_uma_metrics == true && @metrics.include?(CPU_METRIC_NAME)) || @is_uma_metrics == false
            rec = base_record()
            rec[NAME] = CPU_METRIC_NAME
            dims = rec.fetch(DIMENSIONS, {})
            populate_default_dims(dims)
            if is_uma_metrics == true
              dims["process"] = process_details[:tag]
              dims["process_id"] = process_id
              populate_default_dims_instanceLevel(dims)
            end
            rec[DIMENSIONS] = dims
            rec[:datapoints] = [datapoint(time, process_details[:cpu])]

            es.add(time, rec)
          end
          if @is_uma_metrics == false
            rec_instance_level = base_record()
            rec_instance_level[NAME] = @hostClass + "." + CPU_METRIC_NAME + INSTANCE_LEVEL_METRIC_NAME_SUFFIX
            rec_instance_level[RESOURCE_GROUP] = @hostClass
            dims_instanceLevel = Marshal.load(Marshal.dump(dims))
            dims_instanceLevel.delete(HOSTCLASS) if dims_instanceLevel.key?(HOSTCLASS)
            dims_instanceLevel["process"] = process_details[:tag]
            dims_instanceLevel["process_id"] = process_id
            populate_default_dims_instanceLevel(dims_instanceLevel)
            rec_instance_level[DIMENSIONS] = dims_instanceLevel
            rec_instance_level[:datapoints] = [datapoint(time, process_details[:cpu])]
            es.add(time, rec_instance_level)
          end
        end
      end

      memory_usage_hash.each_pair do |process_id, process_details|
        unless process_details[:memory] == nil
          if (@is_uma_metrics == true && @metrics.include?(MEMORY_METRIC_NAME)) || @is_uma_metrics == false
            memory_rec = base_record()
            memory_rec[NAME] = MEMORY_METRIC_NAME
            dims = memory_rec.fetch(DIMENSIONS, {})
            populate_default_dims(dims)
            if is_uma_metrics == true
              dims["process"] = process_details[:tag]
              dims["process_id"] = process_id
              populate_default_dims_instanceLevel(dims)
            end
            memory_rec[DIMENSIONS] = dims
            memory_rec[:datapoints] = [datapoint(time, process_details[:memory])]
            es.add(time, memory_rec)
          end
          if @is_uma_metrics == false
            memory_rec_instance_level = base_record()
            memory_rec_instance_level[NAME] = @hostClass + "." + MEMORY_METRIC_NAME + INSTANCE_LEVEL_METRIC_NAME_SUFFIX
            memory_rec_instance_level[RESOURCE_GROUP] = @hostClass
            dims_instanceLevel = Marshal.load(Marshal.dump(dims))
            dims_instanceLevel.delete(HOSTCLASS) if dims_instanceLevel.key?(HOSTCLASS)
            dims_instanceLevel["process"] = process_details[:tag]
            dims_instanceLevel["process_id"] = process_id
            populate_default_dims_instanceLevel(dims_instanceLevel)
            memory_rec_instance_level[DIMENSIONS] = dims_instanceLevel
            memory_rec_instance_level[:datapoints] = [datapoint(time, process_details[:memory])]
            es.add(time, memory_rec_instance_level)
          end
        end
        unless process_details[:memory_mb] == nil
          if (@is_uma_metrics == true && @metrics.include?(MEMORY_MB_METRIC_NAME)) || @is_uma_metrics == false
            memory_rec = base_record()
            memory_rec[NAME] = MEMORY_MB_METRIC_NAME
            dims = memory_rec.fetch(DIMENSIONS, {})
            populate_default_dims(dims)
            if is_uma_metrics == true
              dims["process"] = process_details[:tag]
              dims["process_id"] = process_id
              populate_default_dims_instanceLevel(dims)
            end
            memory_rec[DIMENSIONS] = dims
            memory_rec[:datapoints] = [datapoint(time, process_details[:memory_mb])]
            es.add(time, memory_rec)
          end
          if @is_uma_metrics == false
            memory_rec_instance_level = base_record()
            memory_rec_instance_level[NAME] = @hostClass + "." + MEMORY_MB_METRIC_NAME + INSTANCE_LEVEL_METRIC_NAME_SUFFIX
            memory_rec_instance_level[RESOURCE_GROUP] = @hostClass
            dims_instanceLevel = Marshal.load(Marshal.dump(dims))
            dims_instanceLevel.delete(HOSTCLASS) if dims_instanceLevel.key?(HOSTCLASS)
            dims_instanceLevel["process"] = process_details[:tag]
            dims_instanceLevel["process_id"] = process_id
            populate_default_dims_instanceLevel(dims_instanceLevel)
            memory_rec_instance_level[DIMENSIONS] = dims_instanceLevel
            memory_rec_instance_level[:datapoints] = [datapoint(time, process_details[:memory_mb])]
            es.add(time, memory_rec_instance_level)
          end
        end
      end
    end
  end
end