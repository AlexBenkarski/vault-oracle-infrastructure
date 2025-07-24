# file adapted from the audit parser library here: https://github.com/winebarrel/fluent-plugin-filter-parse-audit-log

require 'fluent/plugin/parser'
require 'fluent/plugin_helper/event_emitter'
require 'fluent/plugin_helper/timer'
require 'fluent/plugin_id'
require 'strscan'
require 'date'
require 'etc'
require 'oci/environment'
require 'oci/auth/url_based_certificate_retriever'
require 'oci/auth/signers/instance_principals_security_token_signer'
require 'oci/auth/util'
require 'json'
require 'net/http'

module Fluent::Plugin

  class AuditdLogParser < ::Fluent::Plugin::Parser
    include Fluent::PluginHelper::Timer
    include Fluent::PluginHelper::EventEmitter
    include Fluent::PluginId
    class Error < StandardError; end
    Fluent::Plugin.register_parser('auditdlog', self)

    desc "Boolean value to determine if multiline audit logs will merge per unique audit message"
    config_param :mergeMultilineRecordsForAudit, :bool, default: false
    desc "Number of audit lines merged before written to buffer"
    config_param :lineLimit, :integer, default: 100
    desc "Maximum time(in seconds) to wait for an audit log before committing a merged line"
    config_param :maxCommitTime, :time, default: 60
    desc "Boolean value to determine if PROCTILE field is converted from hex to ASCII"
    config_param :convertProctitleToAsciiForAudit, :bool, default: false

    ENRICHED_FIELD_PREFIX = "enriched_".freeze
    SOCKADDR_FAMILY_KEY = "b_saddr_family".freeze
    SOCKADDR_IP_KEY = "b_saddr".freeze
    SOCKADDR_PORT_KEY = "b_saddr_lport".freeze
    SOCKADDR_TYPE = 'SOCKADDR'.freeze
    SPACE_CHARACTER = ' '.freeze

    class TimeoutError < StandardError
    end

    @@metadata =  nil

    def self.get_instance_details
      env = OCI::Environment.new
      instance_ocid = env['id']
      ip_address = env['ipAddress']
      compartment_ocid = env['compartmentId']
      tenancy_ocid = env['tenancyId']
      if tenancy_ocid.nil?
        if env['is_service_enclave']
          begin
            ad = env['availabilityDomain']
            region = env['region']
            endpoint = "https://authservice.svc.#{ad}.#{region}/v1/compartments/#{compartment_ocid}/tenant"
            uri = URI(endpoint)
            resp = Net::HTTP.get_response(uri)
            tenancy_details = JSON.parse(resp.body)
            tenancy_ocid = tenancy_details['id']
          rescue => e
            log.info("An error occurred: #{e.message}")
          end
        else
          begin
            leaf_certificate_retriever = OCI::Auth::UrlBasedCertificateRetriever.new(
              OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner::LEAF_CERTIFICATE_URL,
              private_key_url: OCI::Auth::Signers::InstancePrincipalsSecurityTokenSigner::LEAF_CERTIFICATE_PRIVATE_KEY_URL
            )
            tenancy_ocid = OCI::Auth::Util.get_tenancy_id_from_certificate(
              leaf_certificate_retriever.certificate
            )
          rescue => e
            log.info("An error occurred: #{e.message}")
          end
        end
      end
      @@metadata = {'m_resId' => instance_ocid == '' ? ip_address : instance_ocid, 'm_cptId' => compartment_ocid, 'm_tenancyId' => tenancy_ocid || ''}
    end

    def initialize
      super
      @log = $log # use the global logger
      if @@metadata.nil?
        self.class.get_instance_details
      end
    end

    def configure(conf)
      super
      @idData=Hash.new {}
      if @mergeMultilineRecordsForAudit && @lineLimit.negative?()
        log.error("lineLimit must be a positive value")
        raise Fluent::ConfigError, "lineLimit must be a positive value"
      end
      if @mergeMultilineRecordsForAudit && maxCommitTime.negative?()
        log.error("maxCommitTime must be a positive value")
        raise Fluent::ConfigError, "maxCommitTime must be a positive value"
      end
      if @mergeMultilineRecordsForAudit
        #buffer will have following structure
        # {"node-'node_name'" => {"audit_id"=>[[datetime, {log_body}], [datetime, {log_body}],
        #                         "audit_id-header"=> [{header key:value pairs}]}
        #example {"node-scaqan11celadm09" => {"1646792401.700:1141167"=>[
        # [2022-03-09 07:50:01.000000000 +0530, {"pid"=>"2040", "uid"=>"0", "auid"=>"0",  "msg"=>{"op"=>"PAM:setcred", "grantors"=>"pam_env,pam_faillock,pam_unix"}}]
        # ],
        #  "1646792401.700:1141167-header"=>[{"node"=>"scaqan11celadm09", "type"=>"CRED_REFR", "msg"=>"audit(1646792401.700:1141167)"}]}}
        @buffer = Hash.new

        @timeout_map_mutex = Thread::Mutex.new
        @timeout_map_mutex.synchronize do
          @timeout_map = Hash.new do |outer_hash, node|
            outer_hash[node] = Hash.new do |inner_hash, k|
              inner_hash[k] = Fluent::Engine.now
            end
          end
        end
      end
    end

    def start
      super
      @finished = false

      timer_execute(:audit_parser_timer, @maxCommitTime, &method(:on_timer)) if @mergeMultilineRecordsForAudit
    end

    def shutdown
      @finished = true
      flush_remaining_buffer if @mergeMultilineRecordsForAudit
      super
    end

    def parse_saddr(body)
      #Body is a hash of key values
      return body if (body.size == 1 and body.each_key.first == 'saddr')

      # If it contains 2 keys with same string saddr, then it is an enriched line. In this case discard the key with
      # hex value
      if body["SADDR"].nil? or body["SADDR"].size !=3
        raise Error, "Invalid log of type SADDR. The body contains lesser than 3 key value pairs: #{body}"
      end
      result = {}
      saddr_source = body["SADDR"]
      result[SOCKADDR_FAMILY_KEY] = saddr_source["fam"]
      result[SOCKADDR_IP_KEY] = saddr_source["laddr"]
      result[SOCKADDR_PORT_KEY] = saddr_source["lport"]
      result[ENRICHED_FIELD_PREFIX + SOCKADDR_IP_KEY] = saddr_source["laddr"]

      result
    end

    def parse(line, flatten: false)
      es = ::Fluent::MultiEventStream.new
      line = line.strip

      if line !~ /(?:node=\w+ )*type=\w+ msg=audit\([\d.:]+\): */
        raise Error, "Invalid audit log header: #{line.inspect}"
      end
      log.debug "parsing new line: #{line}"
      body, header = splitAuditLogLine(line)

      # extract the unix epoch seconds timestamp from the 'msg' header
        # %s needs to be used to add the seconds from 1/1/1970, if %Q is used then
        # all the dates will be in the 1970's
      time = getTimeFromHeader(header)

      body = parse_saddr(body) if header["type"].casecmp(SOCKADDR_TYPE) == 0

      if @mergeMultilineRecordsForAudit
        time, new_header, body = mergeMultiLinesForAudit(header, body, time)
        unless body.nil?
          # merging values of same field
          body = merge_same_field_for_audit(body) if @mergeMultilineRecordsForAudit
          # converting the hexadecimal value to Ascii in proctitle identity in body
          convert_array_to_ascii(body, 'proctitle') if @convertProctitleToAsciiForAudit
          # converting the hexadecimal value to Ascii in USER_CMD type logs
          convert_array_to_ascii(body, 'cmd') if @convertProctitleToAsciiForAudit
          # converting the id  value to user name  in logs
          convert_ids_to_username(body)

        end
      end
      record = {'header' => new_header || header, 'body' => body, 'metadata' => @@metadata}
      flatten ? flatten_hash(record) : record
      if time.nil? && body.nil?
        return {}
      end
      #check to see if we can yield the data if in a block or create an event stream
      if block_given?
        yield time, record
      else
        es.add(time, record)
        return es
      end
    end

    def splitAuditLogLine(line)
      header, body = line.split(/\): */, 2)
      header << ')'
      header.sub!(/: *\z/, '')
      header = parse_header(header)
      body = parse_body(body.strip)
      return body, header
    end

    def getTimeFromHeader(header)
      raw_time = header['msg'].match(/\d+\.\d+:\d+/).to_s
      Fluent::EventTime.from_time(DateTime.strptime(raw_time, '%s').to_time)
    end

    def mergeMultiLinesForAudit(header, body, time)
      flushed_time = nil
      flushed_header = nil
      flushed_record = nil

      node =  "node"
      node += "-" + header["node"] if header.key?("node") && !header["node"].nil?
      #get the audit ID
      auditId = header["msg"].slice(/audit\((.*?)\)/,1)
      log.debug "auditId is #{auditId}"
          header = get_header_hash_with_value_as_array(header)
      if @buffer[node].nil?
        log.debug "creating new buffer for node: #{node}"
        @buffer[node] = Hash.new
      end
      if !@buffer[node].empty? && !@buffer[node].key?(auditId)
        # Different audit ID, so flush the buffer
        log.debug "got new auditId: #{auditId}, flushing buffer"
        flushed_time, flushed_header, flushed_record = flush_buffer(node, true, true)
      end
      if @buffer[node].empty?
        log.debug "creating new buffer for auditId: #{auditId} of node #{node}"
        @buffer[node] = {auditId => [[time, body]]}
        @buffer[node][auditId + "-header"] = [header]
        add_timeout_map(node,auditId)
      elsif @buffer[node].key?(auditId)
        #This line contains same audit ID as the previous line, therefore add to buffer
        log.debug "found existing buffer for auditId: #{auditId} of node #{node}"
        @buffer[node][auditId] << [time, body]
        @buffer[node][auditId + "-header"] << header
        add_timeout_map(node, auditId)
        if @buffer[node][auditId].size >= @lineLimit
          log.debug "buffer size for node: #{node} and auditId: #{auditId} greater than lineLimit: #{@lineLimit}, flushing"
          curr_time, curr_header, curr_record = flush_buffer(node, false, true)
          return curr_time, curr_header, curr_record
        end
      end
      if header["type"][0] == "PROCTITLE" && @buffer[node][auditId + "-header"].size != 1
        log.debug "header.type is PROCTITLE, flushing the buffer"
        flushed_time, flushed_header, flushed_record = flush_buffer(node, false, true)
      end
      return flushed_time, flushed_header, flushed_record
    end

    def flush_buffer(node, new_element, delete_timeout_entry)
      begin
        return if @buffer[node].empty?
        log.debug "flushing buffer #{@buffer[node]}"
        audit_id = @buffer[node].keys.first
        log.info("Flushing auditid:#{audit_id} of node:#{node}")
        header_str = audit_id + "-header"
        lines = @buffer[node].fetch(audit_id).map {|_time, line| line }
        time = @buffer[node].fetch(audit_id).first[0]
        header = @buffer[node].fetch(header_str).each_with_object({}) {
          |el, h| el.each { |k, v| h[k] = h[k] ? ([*h[k]] << v).flatten.uniq : v } }

      rescue KeyError, NoMethodError => e
        log.error "error occurred accessing buffer, exception class:#{e.class},#{e.message}"
        log.info("Buffer entries for #{node} - #{@buffer[node]}")
        raise Error, "Error #{e.message}. Invalid entries found in buffer."
      rescue StandardError => se
        raise Error, "Error #{e.message}. Invalid entries found in buffer."
      ensure
        if delete_timeout_entry
          delete_timeout_map(node, @buffer[node].keys.first)
        end
        # clear all buffer[node] contents
        @buffer[node].clear
        unless new_element
          log.debug "No new log for node: #{node}, deleting buffer for #{node}"
          @buffer.delete(node)
        end
      end

      [time, header, lines]
    end

    def add_timeout_map(node, auditId)
      @timeout_map_mutex.synchronize do
        @timeout_map[node] ||= Hash.new
        @timeout_map[node][auditId] = Fluent::Engine.now
      end
    end

    def delete_timeout_map(node, auditId)
      @timeout_map[node].delete(auditId)
    end

    def convert_array_to_ascii(body, fieldName)
      original_val = body[fieldName] || (body.dig("msg").is_a?(Array) ? body.dig("msg").map { |h| h.dig(fieldName)}.compact
                                           : body.dig("msg", fieldName))
      if original_val
        return if original_val.is_a?(Array) && original_val.empty?
        if original_val.is_a?(Array)
          ascii_array = []
          original_val.each { |x| ascii_array.append(convert_hex_to_ascii(x)) }
          if body[fieldName]
            body[fieldName] = ascii_array
          else
            body.dig("msg").each_with_index { |h, index| h[fieldName] = ascii_array[index]}
          end
        else
          converted_val = convert_hex_to_ascii(original_val)
          if body.dig(fieldName)
            body[fieldName] = converted_val
          elsif body.dig("msg", fieldName)
            body["msg"][fieldName] = converted_val
          end
        end
      end
    end

    def convert_hex_to_ascii(hex_value)
      hex_value.strip.chars.each_slice(2).map(&:join).map do |hex|
        ascii = hex.to_i(16)
        raise "#{hex} is Not a Hexadecimal value" if ascii > 127 || hex != '00' && ascii == 0

        if hex != '00'
          ascii.chr
        else
          SPACE_CHARACTER
        end
      end.join
    rescue StandardError => e
      log.debug(e.full_message)
      hex_value
    end

    def convert_ids_to_username(body)
      h =["uid", "euid", "auid", "oauid", "ouid", "suid", "sauid"]
      h.each {|value|
        fetch_ids_to_change(body,value)
      }
    end

    def fetch_ids_to_change(body,fieldName)
      log_data=body[fieldName] || (body.dig("msg").is_a?(Array) ? body.dig("msg").map { |h| h.dig(fieldName)}.compact: body.dig("msg", fieldName))
      return if  log_data.nil?    || log_data.empty?
      change_user_name(body,log_data,fieldName)
      return
    end

    def change_user_name(body,ids,fieldName)
      if ids.is_a?(Array)
        temp_id_arr = []
        ids.each { |x| temp_id_arr.append(get_user_name(x)) }
        if body[fieldName]
          body[fieldName] = temp_id_arr
        else
          body.dig("msg").each_with_index { |h, index| h[fieldName] = temp_id_arr[index]}
        end
      else
        userName = get_user_name(ids)
        if body.dig(fieldName)
          body[fieldName] = userName
        elsif body.dig("msg", fieldName)
          body["msg"][fieldName] = userName
        end
      end
    end

    def get_user_name(id_log)
      if(id_log == "4294967295" || id_log == "-1")
        username=id_log;
      else
        if @idData.has_key?(id_log)
          username = @idData[id_log]
        else
          begin
            username = Etc.getpwuid(id_log.to_i).name
          rescue ArgumentError
            username=id_log
          else
            @idData[id_log] = username
          end
        end
      end
      return username
    end

    def merge_same_field_for_audit(body)
      return body unless body.is_a?(Array)

      hash = {}
      body.each do |obj|
        obj&.each do |key, value|
          key = key.downcase
          hash[key] = if hash[key].nil?
                        [value]
                      else
                        if hash[key].is_a?(Array)
                          hash[key].append(value)
                        else
                          [hash[key], value]
                        end
                      end
        end
      end
      hash
    end

    def get_header_hash_with_value_as_array(header)
      hash = {}       # hash{} will contain key value pair where value will be of array type (Takes key:value pair from header)
      header.each do |key, value|
            hash[key] = if !(hash[key].nil?) && (hash[key].is_a?(Array))
                          hash[key].append(value)
                        else
                            [value]
                        end
        end
      return hash
    end


    def parse_header(header)
      result = {}

      header.split(' ').each do |kv|
        key, value = kv.split('=', 2)
        result[key] = value
      end

      result
    end

    def parse_body(body)
      if body.empty?
        return {}
      elsif !body.include?('=')
        raise Error, "Invalid audit log body: #{body.inspect}"
      end

      result = {}
      ss = StringScanner.new(body)

      while key = ss.scan_until(/=/)
        if key.include?(', ')
          msg, key = key.split(', ', 2)
          result['_message'] = msg.strip
        end

        key.chomp!('=').strip!
        value = ss.getch

        case value
        when nil
          break
        when ' '
            next
        when '"'
          value << ss.scan_until(/"/)
        when "'"
          nest = ss.scan_until(/'/)
          nest.chomp!("'")
          value = parse_body(nest)
        when "{"
          nest = ss.scan_until(/}/)
          nest = nest.chomp("}")
          nest.strip
          value = parse_body(nest)
        else
          value << ss.scan_until(/( |\z)/)
          value.chomp!(' ')
        end

        if value.length > 1 and value[0] == '"' and value[value.length - 1] == '"'
          value = value[1..(value.length-2)]
          value.strip
        end
        result[key] = value
      end

      unless ss.rest.empty?
        raise "must not happen: #{body}"
      end

      result
    end

    def flatten_hash(h)
      h.flat_map { |key, value|
        if value.is_a?(Hash)
          flatten_hash(value).map do |sub_key, sub_value|
            ["#{key}_#{sub_key}", sub_value]
          end
        else
          [[key, value]]
        end
      }.to_h
    end

    def on_timer
      return if @maxCommitTime <= 0
      return if @finished
      flush_timeout_buffer
    rescue => e
      log.error "failed to flush timeout buffer", error: e
    end

    def flush_timeout_buffer
      now = Fluent::Engine.now
      timeout_audit_identities = []

      @timeout_map_mutex.synchronize do
        @timeout_map.each do |node, audit_identity_hash|
          audit_identity_hash.each do |audit_identity, previous_timestamp|
          next if @maxCommitTime > (now - previous_timestamp)
          next if @buffer[node][audit_identity].empty?
          time, flushed_header, flushed_body = flush_buffer(node,false, false)
          timeout_audit_identities << [node, audit_identity]
          flushed_record = {'header' => flushed_header, 'body' => flushed_body, 'metadata' => @@metadata}
          message = "Timeout flushed record: #{node} #{audit_identity}"
          log.info(message)
          log.debug("#{flushed_record}")
          handle_timeout_error(nil, time, flushed_record, message)
          end
        end
        @timeout_map.each do |node, audit_identity_hash|
          audit_identity_hash.reject! do |audit_identity, _|
          timeout_audit_identities.include?([node, audit_identity])
          end
          end
      end
    end

    def flush_remaining_buffer
      return if @buffer.empty?
      # clear out any remaining items in buffer during shutdown
      @buffer.each_key do |node|
      time, flushed_header, flushed_body = flush_buffer(node,false, true)
      flushed_record = {'header' => flushed_header, 'body' => flushed_body, 'metadata' => @@metadata}
      handle_timeout_error(nil,  time, flushed_record, "Flushed remaining buffer")
      end
      return
    end

    def handle_timeout_error(tag, time, record, message)
        #on shutdown/timeout, the leftover events in buffer are emitted to error stream with tag "timeout"
        router.emit_error_event("timeout", time, record, TimeoutError.new(message));
    end
  end
end
