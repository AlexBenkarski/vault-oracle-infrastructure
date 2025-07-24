# frozen_string_literal: true

require 'fluent/plugin/parser'
require 'bindata'
require 'yaml'

# Cisco NetFlow Export Datagram Format
# http://www.cisco.com/c/en/us/td/docs/net_mgmt/netflow_collection_engine/3-6/user/guide/format.html
# Cisco NetFlow Version 9 Flow-Record Format
# http://www.cisco.com/en/US/technologies/tk648/tk362/technologies_white_paper09186a00800a3db9.html

module Fluent
  module Plugin
    class NetflowipfixInput < Fluent::Plugin::Input
      class ParserNetflowIpfix < ParserNetflowBase

        def configure(cache_ttl, definitions)
          @cache_ttl = cache_ttl
          @switched_times_from_uptime = false # , :bool, default: false
          @definitions = definitions
          @missingTemplates = {}
          @skipUnsupportedField = {}
        end # def configure

          private

        def ipfix_field_for(type, enterprise, length)
          if @fields10.include?(enterprise)
            if @fields10[enterprise].include?(type)
              field = @fields10[enterprise][type].clone
            else
              $log.warn('Unsupported enterprise field', type: type, enterprise: enterprise, length: length)
            end
          else
            $log.warn('Unsupported enterprise', enterprise: enterprise)
          end

          return nil unless field

          if field.is_a?(Array)
            case field[0]
            when :skip
              field = skip_field(field, type, length.to_i)
            when :string
              field = string_field(field, type, length.to_i)
            when :octetarray
              field[0] = :OctetArray
              field += [{ initial_length: length.to_i }]
            when :uint64
              field[0] = uint_field(length, 8)
            when :uint32
              field[0] = uint_field(length, 4)
            when :uint16
              field[0] = uint_field(length, 2)
            end

            $log.debug('Definition complete', field: field)
            [field]
          else
            $log.warn('Definition should be an array', field: field)
          end
        end

        FIELDS_FOR_COPY_v9_10 = %w[version flow_seq_num].freeze

        def handle_flowset_data(host, packet, flowset, block, templates)
          template_key = "#{host}|#{packet.source_id}|#{flowset.flowset_id}"
          $log.debug 'handle_flowset_data template:', template_key
          template = templates[template_key]
          unless template
            # FIXED: repeating error message adds no value, added a count of missing packet until template is received
            if @missingTemplates[template_key].nil? || @missingTemplates[template_key] == 0
              @missingTemplates[template_key] = 1
              $log.debug 'No matching template for', host: host, source_id: packet.source_id, flowset_id: flowset.flowset_id
            else
              @missingTemplates[template_key] = @missingTemplates[template_key] + 1
            end

            return
          end # if !template

          array = BinData::Array.new(type: template, read_until: :eof)

          fields = array.read(flowset.flowset_data)
          fields.each do |r|
            time = packet.unix_sec
            event = {}

            # Fewer fields in the v9 header
            FIELDS_FOR_COPY_v9_10.each do |f|
              event[f] = packet[f]
            end

            event['flowset_id'] = flowset.flowset_id
            $log.debug 'event: ', event
            r.each_pair { |k, v| event[k.to_s] = v }
            block.call(time, event, host)
          end # fields = array.read
          $log.debug 'Succesfully parsed flowset data'
         end # def handle_flowset_data

        # covers Netflow v9 and v10 (a.k.a IPFIX)
        def is_sampler?(record)
          record['flow_sampler_id'] && record['flow_sampler_mode'] && record['flow_sampler_random_interval']
         end # def is_sampler?(record)

        def uint_field(length, default)
          # If length is 4, return :uint32, etc. and use default if length is 0
          # $log.warn        ("uint" + (((length > 0) ? length : default) * 8).to_s)
          ('uint' + ((length > 0 ? length : default) * 8).to_s).to_sym
         end # def uint_field

        def octetArray(length)
          ('OctetArray' + length.to_s).to_sym
          case length
          when 1, '1'
            'OctetArray1'.to_sym
          when 2, '2'
            'OctetArray2'.to_sym
          else
            $log.error "No octet array of #{length} bytes"
          end
         end # def octetArray
        end # class ParserNetflowIpfix

      class ParserIPfixv10 < ParserNetflowIpfix
        def configure(cache_ttl, definitions)
          super(cache_ttl, definitions)
          @templates10 = Vash.new
          @samplers_v10 = Vash.new

          # Path to default Netflow v10 field definitions
          filename10 = File.expand_path('ipfix_fields.yaml', __dir__)

          begin
            @fields10 = YAML.load_file(filename10)
            # $log.info @fields10
          rescue StandardError => e
            raise ConfigError, "Bad syntax in definitions file #{filename10}, error_class = #{e.class.name}, error = #{e.message}"
          end

          # Allow the user to augment/override/rename the supported Netflow fields
          if @definitions
            raise ConfigError, "definitions file #{@definitions} doesn't exist" unless File.exist?(@definitions)

            begin
              @fields10['option'].merge!(YAML.load_file(@definitions))
            rescue StandardError => e
              raise ConfigError, "Bad syntax in definitions file #{@definitions}, error_class = #{e.class.name}, error = #{e.message}"
            end
          end
        end # def configure

        def handle_v10(host, pdu, block)
          pdu.records.each do |flowset|
            case flowset.flowset_id
            when 2..3
              flowset.flowset_data.templates.each do |template|
                catch (:field) do
                  fields = []
                  template_fields = flowset.flowset_id == 2 ? template.template_fields : (template.scope_fields.to_ary + template.option_fields.to_ary)
                  template_fields.each do |field|
                    field_type = field.field_type
                    field_length = field.field_length
                    enterprise_id = field.enterprise ? field.enterprise_id : 0
                    entry = ipfix_field_for(field_type, enterprise_id, field_length)
                    throw :field unless entry
                    fields += entry
                  end
                  key = "#{host}|#{pdu.source_id}|#{template.template_id}"

                  @templates10[key, @cache_ttl] = BinData::Struct.new(endian: :big, fields: fields)
                  @templates10.cleanup!
                end
              end
            when 256..65_535
              handle_flowset_data(host, pdu, flowset, block, @templates10)
            else
              $log.warn 'v10 Unsupported set', set_id: flowset.set_id
            end # case
          end # do
          end # def handle_v10
      end # class ParserIPfixv10
    end # class NetflowipfixInput
  end # module Plugin
end # module Fluent
