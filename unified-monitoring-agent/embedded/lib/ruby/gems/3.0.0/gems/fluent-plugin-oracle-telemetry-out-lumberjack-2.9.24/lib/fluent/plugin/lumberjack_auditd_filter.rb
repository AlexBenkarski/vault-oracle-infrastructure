# encoding: UTF-8

# Copyright 2023- Oracle
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This module emit metrics which can be retrieved using following configuration
#
# <system>
#   log_level debug
# </system>
# <source>
#   @type monitor_agent
#   bind 0.0.0.0
#   port 24220
# </source>
#
#  curl 'http://localhost:24220/api/plugins.json?@type=oci_lumberjack&with_ivars=filter_metrics'|jq '.'

module Fluent
  module Plugin
    module LumberjackAuditdFilter

      # The hostclass for which this filter is enabled


      # Regexp to find event type, exe and auditd env in each record
      AUDITD_REGEXP_EVENT_TYPE = Regexp.compile(/^\S*\s?type=(\S+)/).freeze
      AUDITD_REGEXP_EVENT_SYSCALL = Regexp.compile(/exe=\"(\S+)\"/).freeze
      # Catch auditd eventid of following format
      # "msg=audit(1694514683.530:508245): pid=28492"
      # Sometimes ":" is missing but we don't catch them as it's not expected
      # by griffin-parser
      # "msg=audit(1694514683.530:508245) op=reconfigure"
      #AUDITD_REGEXP_EVENT_ID = Regexp.compile(/msg=audit\((\S+)\):? /).freeze
      AUDITD_REGEXP_EVENT_ID = Regexp.compile(/msg=audit\((\S+)\): /).freeze

      # List of exe for which we can drop all SYSCALL events
      # We need an exact match for performance and also to limit the
      # event we drop to well known internal application
      # ! Do not modify without approval from SOC/RSOC
      AUDITD_DROP_SYSCALL = [
                          # Chef
                          "/opt/orc/embedded/bin/ruby",
                          # Griffin OL7/8
                          "/opt/griffin/embedded/bin/ruby",
                          # Griffin on Evergreen
                          "/opt/fluentbit_griffin/bin/fluent-bit",
                          "/opt/fluentbit_griffin/bin/config-updater",
                          # Unified Monitoring Agent
                          "/opt/unified-monitoring-agent/embedded/bin/ruby",
                          # ACE access updater on OL7/8
                          "/opt/cerberus/access-updater/bin/access-updater.linux_amd64",
                          "/opt/cerberus/access-updater/bin/access-updater.linux_arm64",
                          # ACE access updater on Evergreen. We can only match basename
                          "access-updater.linux_amd64",
                          "access-updater.linux_arm64",
                          "access-updater.linux_mips64",
                          # OS updater on OL7/8
                          "/opt/os-updater/bin/os-updater",
                          # WLP agent
                          "/opt/wlp-agent/extensions/wlp-agent.ext",
                          "wlp-agent.ext",
                          # Hostmetrics
                          "/opt/hostmetrics/bin/hm_collector_entrypoint"
                      ].freeze

      # List of auditd event type we keep
      # ! Do not modify without approval from SOC/RSOC
      AUDITD_KEEP_TYPE = [
                          "SYSCALL",
                          "PATH",
                          "PROCTITLE",
                          "SOCKADDR",
                          "CWD",
                          "EXECVE",
                          "USER_CMD",
                          "USER_END",
                          "USER_START",
                          "USER_ACCT",
                          "USER_AUTH",
                          "USER_AVC",
                          "USER_LOGIN",
                          "USER_MGMT",
                          "SECCOMP",
                          "ACCT_LOCK",
                          "ACCT_UNLOCK",
                          "ADD_GROUP",
                          "ADD_USER",
                          "ANOM_ABEND1",
                          "ANOM_LOGIN_TIME",
                          "ANOM_RBAC_FAIL",
                          "ANOM_RBAC_INTEGRITY_FAIL",
                          "AVC",
                          "AVC_PATH",
                          "CONFIG_CHANGE",
                          "FEATURE_CHANGE",
                          "GRP_MGMT",
                          "KERNEL",
                          "KERNEL_OTHER",
                          "LABEL_LEVEL_CHANGE",
                          "LABEL_OVERRIDE",
                          "LOGIN",
                          "MAC_CONFIG_CHANGE",
                          "MAC_POLICY_LOAD",
                          "MAC_STATUS",
                          "MMAP",
                          "NETFILTER_CFG",
                          "NETFILTER_PKT",
                          "SERVICE_START",
                          "SERVICE_STOP",
                          "SYSTEM_BOOT",
                          "SYSTEM_SHUTDOWN",
                          "USER_LOGOUT",
                          "RESP_ACCT_LOCK",
                          "RESP_ACCT_LOCK_TIMED",
                          "RESP_ACCT_REMOTE",
                          "RESP_ACCT_UNLOCK_TIMED",
                          "RESP_SEBOOL",
                          "DAEMON_ABORT",
                          "DAEMON_ACCEPT",
                          "DAEMON_CLOSE",
                          "DAEMON_CONFIG",
                          "DAEMON_END",
                          "DAEMON_RESUME",
                          "DAEMON_ROTATE",
                          "DAEMON_START",
                          "ROLE_ASSIGN",
                          "ROLE_MODIFY",
                          "ROLE_REMOVE",
                          "SELINUX_ERR",
                          "USER_LABELED_EXPORT",
                          "USER_MAC_POLICY_LOAD",
                          "USER_ROLE_CHANGE",
                          "USER_SELINUX_ERR",
                          "USER_UNLABELED_EXPORT"
                        ].freeze

      # Base metric hash
      METRICS = {
        :auditd_record_count => 0,
        :auditd_invalid_drop_count => 0,
        :auditd_type_drop_count => 0,
        :auditd_syscall_drop_count => 0,
        :auditd_id_drop_count => 0,
        :auditd_drop_count => 0,
        :auditd_emit_count => 0
      }

      # Setup class filter structures
      #
      # param: hostclass, the hostclass of the system
      def setup_auditd_filter(hostclass)
        @filter_config =  {
          :enabled => true,
          :name => :auditd,
          :validate_function => -> (record) { drop_auditd_record?(record) },
          :setup_metrics_function => -> () { setup_auditd_metrics() },
          :update_metrics_function => -> () { update_auditd_metrics() }
        }
        # @id_hash is map where key is the path of the record,
        # value is the auditd event id used to drop all event with same id
        #
        # @question: on relay server this hash will grow
        # constantly. We need to evaluate the need to use an hash or just
        # keep the event id in a variable with the assumption that all
        # record will be in order
        @filter_data =  {
          :lock => Monitor.new,
          :id_hash => {},
        }
        @filter_metrics = {
          :tag => @tag,
          :lock => Monitor.new,
          :total => METRICS.clone(),
          :thread => {}
        }
        log.info("auditd filter enabled")
      end

      # Setup the metric structure specific to each flush thread
      def setup_auditd_metrics()
        @filter_metrics[:thread][Thread.current.object_id] = METRICS.clone()
      end

      # Entry function to filter auditd event
      # param: record, an fluentd record
      #
      def drop_auditd_record?(record)
        increment_filter_counter(:auditd_record_count)
        # Convert record msg from hash to string
        line = record["msg"].to_s
        path = record["tailed_path"].to_s

        # Ensure we have a valid auditd raw line which contains the type
        m_event_type = line.match(AUDITD_REGEXP_EVENT_TYPE)
        if m_event_type.nil?
          log.warn "dropping record, no auditd event type found: #{line}"
          increment_filter_counter(:auditd_invalid_drop_count)
          return true
        end

        event_type = m_event_type[1]
        unless AUDITD_KEEP_TYPE.include?(event_type)
          # Drop the event based on type not in the list of type we have to keep
          log.debug("dropping record, match on type: #{path}, #{event_type}")
          increment_filter_counter(:auditd_type_drop_count)
          return true
        else
          if drop_auditd_syscall_event?(line, path, event_type)
            # Drop event related to specific syscall
            return true
          end
        end

        # Keep track of the record we will emit
        increment_filter_counter(:auditd_emit_count)
        # Return false for test unit
        return false

      end

      # Drop auditd event based on exe or event id
      # param: line, the string containing the auditd event
      # param: path, the path of the file the record belongs to
      # param: event_type, the type of auditd event
      #
      def drop_auditd_syscall_event?(line, path, event_type)
        # We must always have an auditd event id
        m_event_id = line.match(AUDITD_REGEXP_EVENT_ID)
        if m_event_id.nil?
          log.warn "dropping record, no auditd event id found : #{line}"
          increment_filter_counter(:auditd_invalid_drop_count)
          return true
        end

        event_id = m_event_id[1]
        if event_type == "SYSCALL"
          # Check if we drop new multiline SYSCALL event
          m_event_exe = line.match(AUDITD_REGEXP_EVENT_SYSCALL)
          if m_event_exe.nil?
            log.warn "Event id found but no auditd event exe found : #{line}"
            return  false
          else
            event_exe = m_event_exe[1]
            event_exe_basename = File.basename(event_exe)
            if AUDITD_DROP_SYSCALL.include?(event_exe) || AUDITD_DROP_SYSCALL.include?(event_exe_basename)
              log.debug("dropping record, match on exe: #{path}, #{event_exe}, #{event_id}")
              increment_filter_counter(:auditd_syscall_drop_count)
              # Track subsequent record with same event id
              add_auditd_event_id(path, event_id)
              return true
            end
          end
        elsif auditd_event_id_match?(path, event_id)
          # The event id match previously dropped event id
          log.debug("dropping record, match on event id: #{line}")
          increment_filter_counter(:auditd_id_drop_count)
          return true
        end

      end

      # Keep track of the path and event id if we want to drop all event with
      # same event id
      # param: path, the name of the tailed path
      # param: event_id, the auditd event id
      def add_auditd_event_id(path, event_id)
        @filter_data[:lock].synchronize { @filter_data[:id_hash][path] = event_id }
      end

      # Check if we already have a matching event id
      # param: path, the name of the tailed path
      # param: event_id, the auditd event id
      def auditd_event_id_match?(path, event_id)
        return (@filter_data[:id_hash].has_key?(path) && @filter_data[:id_hash][path] == event_id)
      end

      # Update plugin class metrics
      # Use Monitor to syncrhonize update
      def update_auditd_metrics()
        @filter_metrics[:lock].synchronize {
          @filter_metrics[:thread][Thread.current.object_id].each do |key, val|
            @filter_metrics[:total][key] += val
          end
          @filter_metrics[:total][:auditd_drop_count] = @filter_metrics[:total][:auditd_invalid_drop_count]
          @filter_metrics[:total][:auditd_drop_count] += @filter_metrics[:total][:auditd_type_drop_count]
          @filter_metrics[:total][:auditd_drop_count] += @filter_metrics[:total][:auditd_id_drop_count]
          @filter_metrics[:total][:auditd_drop_count] += @filter_metrics[:total][:auditd_syscall_drop_count]
        }
      end

      # Increment thread filter counter
      # param: name, the name of the counter to increment
      def increment_filter_counter(name)
        @filter_metrics[:thread][Thread.current.object_id][name] += 1
      end
    end
  end
end