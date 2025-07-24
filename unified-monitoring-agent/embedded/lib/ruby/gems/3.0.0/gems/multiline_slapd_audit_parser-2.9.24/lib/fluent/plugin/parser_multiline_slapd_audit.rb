require 'fluent/plugin/parser'
require 'strscan'
require 'date'

module Fluent::Plugin

  class MultilineSlapdAuditParser < Fluent::Plugin::Parser

    # The parser name has to start with "multiline" to turn on multiline mode in in_tail plugin,
    # to get started, check if line matches firstline regex, and all logs after the firstline will be
    # buffered until it hits next firstline, then buffered logs will flush into parse()
    Fluent::Plugin.register_parser('multiline_slapd_audit', self)

    desc 'Specify supported changetype by OpenLdap with format (type1|type2|type3)'
    config_param :changetype, :string, default: "(modify|add)"
    desc 'Enable an option returning line as unmatched_line'
    config_param :unmatched_lines, :bool, default: true

    def configure(conf)
      super

      check_format(@changetype, 'changetype')
      @format_firstline = Regexp.new( "^# #{@changetype}")
      @changetype_regex = Regexp.new(@changetype)
    end


    # @param [String]
    #
    # expected input
    #   # add 1585768726 global cn=ldapupdater  conn=-1
    #   dn: cn=bstigler
    #   changetype: add
    #   objectClass: inetOrgPerson
    #   modifyTimestamp: 20200401191846Z
    #   # end add 1585768726
    #
    # expected output
    # {
    #   changetype: add,
    #   cn: ldapupdater,
    #   conn: -1,
    #   dn.cn:  bstigler,
    #   timestamp:  1585768726,
    #   objectClass:  inetOrgPerson,
    #   modifyTimestamp:  20200401191846Z
    # }
    #
    # @return Time, Hash
    def parse(text)
      @output = {}
      time = Fluent::EventTime.now

      begin
        if text.nil?
          raise Fluent::ConfigError.new "unparsed text is nil"
        end
        text = text.strip

        parse_line(text)
        time = Fluent::EventTime.from_time(DateTime.strptime(@output['timestamp'], '%s').to_time)

      rescue => e
        log.error "error message #{e.message}"
        if @unmatched_lines
          @output = {}
          @output['unmatched_line'] = text
        else
          log.warn "invalid slapd message: #{text.dump}"
        end
      ensure
        yield time, @output
      end
     end

    # It is required function called in in_tail plugin for parser with multiline mode.
    def has_firstline?
      !!@format_firstline
    end

    # It is required function called in in_tail plugin for parser with multiline mode.
    def firstline?(text)
      @format_firstline.match(text)
    end

    private

    def parse_line(input_str)
      input_array = input_str.split(/\n/)
      if input_array.size < 4
        raise Fluent::ConfigError.new "Invalid Slapd Audit log with incorrect number of lines"
      end

      # First line starts with '# modify/add <timestamp> .....'
      parse_firstline(input_array[0])

      # Second line starts with "dn:", e.g "dn: cn=user, etc."
      parse_secondline(input_array[1])

      parse_body_based_on_changetype(input_str)

      @output
    end

    # @param [String]
    #
    # expected input
    #   # add 1585768726 global cn=ldapupdater  conn=-1
    #
    # expected output
    #   {
    #     changetype: add,
    #     cn: ldapupdater,
    #     conn: -1,
    #     timestamp: 1585768726
    #   }
    def parse_firstline(line)
      elements = line.split(/\s+/)
      if line.match(@changetype_regex).nil?
        raise Fluent::ConfigError.new "Invalid Slapd log with unknown changetype"
      end
      if line.match(/\d{10}/).nil?
        raise Fluent::ConfigError.new "Invalid Slapd log with incorrect timestamp format"
      end
      @output["changetype"] = line.match(@changetype_regex)[0]
      @output["timestamp"] = line.match(/\d{10}/)[0]

      elements.each do |element|
        if element.match(/=/)
          parse_kv(element)
        end
      end
    end

    # @param [String]
    #
    # expected input
    #   dn: cn=bstigler
    #
    # expected output
    #   {
    #     dn.cn: bstigler
    #   }
    def parse_secondline(line)
      dn_info = line.split(':')[1]
      unless dn_info.nil?
        parse_kv(dn_info, prefix:'dn.')
      end
    end

    def parse_body_based_on_changetype(input_str)
      if @output["changetype"] == "modify"
        parse_modify_type(input_str)
      elsif @output["changetype"] == "add"
        parse_add_type(input_str)
      else
        raise Fluent::ConfigError.new "Unsupported changetype in SLAPD log - verify SLAPD configuration"
      end
    end

    # @param [String]
    #
    # expected input
    #
    #   changetype: modify
    #   replace: webadmData
    #   webadmData: OpenOTP.RejectCount=Mg==
    #   -
    #   replace: entryCSN
    #   entryCSN: 20200228230205.050267Z#000000#001#000000
    #   -
    #   # end modify 1582930925
    #
    # expected output
    #
    # {
    #   changetype: modify,
    #   webadmData.OpenOTP.RejectCount: Mg==
    # }
    #
    def parse_modify_type(input_str)
      webadm_data = get_target_substring("webadmData:", "\n-", input_str)
      if webadm_data != ""
        webadm_data = webadm_data.gsub(/\s+|\n/, "")
        webadm_info = webadm_data.split(':')[1]
        parse_kv(webadm_info, prefix: 'webadmData.')
      end
    end

    # @param [String]
    #
    # expected input
    #
    #   changetype: add
    #   objectClass: inetOrgPerson
    #   modifyTimestamp: 20200401191846Z
    #   # end add 1585768726
    #
    # expected output
    # {
    #   changetype: add,
    #   objectClass:  inetOrgPerson,
    #   modifyTimestamp:  20200401191846Z
    # }
    def parse_add_type(input_str)
      data = get_target_substring("objectClass:", "# end", input_str)
      if data != ""
        data = data.gsub(/ +/, "")
        parse_kv(data, delimiter: "\n", label_delimiter: ":")
      else
        raise Fluent::ConfigError.new "Failed to get objectClass field for add changetype, malformed log"
      end
    end

    def get_target_substring(start_str, end_str, input_str)
      start_index = input_str.index(start_str)
      unless start_index.nil?
        end_index = input_str.index(end_str, start_index)
        unless end_index.nil?
          input_str[start_index..end_index-1]
        else
          raise Fluent::ConfigError.new "Malformed log"
        end
      else
        ""
      end
    end

    def parse_kv(line, delimiter:',', label_delimiter:'=', prefix:'')
      line.split(delimiter).each do |kv|
        key, value = kv.split(label_delimiter, 2)
        key_name = "#{prefix}#{key.strip}"
        if @output.key? key_name
          resolve_conflict(key_name, value.strip)
        else
          @output[key_name] = value.strip
        end
      end
    end

    # It is possible to have duplicate field,
    # @example: More than one 'ou' in dn_info like 'dn: cn=bstigler, ou=service-accounts, ou=people,o=r1'
    # To resolve conflict, the output will be dn.cn, dn.ou, dn.ou1, dn.ou2, etc.
    def resolve_conflict(origin_key, value)
      count = 1
      new_key = origin_key
      while @output.key? new_key
        new_key = "#{origin_key}#{count}"
        count += 1
      end
      @output[new_key] = value
    end

    def check_format(format, key)
      if format[0] != '(' || format[-1] != ')'
        raise Fluent::ConfigError.new "Invalid #{key}, correct format is '(modify|add)'"
      end
    end

  end
end

