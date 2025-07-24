# frozen_string_literal: true

require 'bindata'

module Fluent
  module Plugin
    class NetflowipfixInput < Fluent::Plugin::Input
      class IP4Addr < BinData::Primitive
        endian :big
        uint32 :storage

        def set(val)
          ip = IPAddr.new(val)
          raise ArgumentError, "invalid IPv4 address '#{val}'" unless ip.ipv4?

          self.storage = ip.to_i
        end # set

        def get
          IPAddr.new_ntoh([storage].pack('N')).to_s
        end # get
      end # class

      class IP6Addr < BinData::Primitive
        endian  :big
        uint128 :storage

        def set(val)
          ip = IPAddr.new(val)
          raise ArgumentError, "invalid IPv6 address `#{val}'" unless ip.ipv6?

          self.storage = ip.to_i
        end

        def get
          IPAddr.new_ntoh((0..7).map do |i|
                            (storage >> (112 - 16 * i)) & 0xffff
                          end.pack('n8')).to_s
        end
      end

      class MacAddr < BinData::Primitive
        endian :big
        array :bytes, type: :uint8, initial_length: 6

        def set(val)
          ints = val.split(/:/).collect { |int| int.to_i(16) }
          self.bytes = ints
        end

        def get
          bytes.collect { |byte| byte.value.to_s(16).rjust(2, '0') }.join(':')
        end
      end

      class MplsLabel < BinData::Primitive
        endian :big
        bit20 :label
        bit3  :exp
        bit1  :bottom
        def set(val)
          self.label = val >> 4
          self.exp = (val & 0b1111) >> 1
          self.bottom = val & 0b1
        end

        def get
          label
        end
      end

      class Header < BinData::Record
        endian :big
        uint16 :version
      end

      class Template10 < BinData::Record
        endian :big
        array  :templates, read_until: -> { array.num_bytes == flowset_length - 4 } do
          uint16 :template_id
          uint16 :field_count
          array :template_fields, initial_length: :field_count do
            bit1   :enterprise
            bit15  :field_type
            uint16 :field_length
            uint32 :enterprise_id, onlyif: -> { enterprise != 0 }
          end # array fields
        end # array templates
      end # class

      class Option10 < BinData::Record
        endian :big
        array  :templates, read_until: -> { flowset_length - 4 - array.num_bytes <= 2 } do
          uint16 :template_id
          uint16 :field_count
          uint16 :scope_field_count
          array  :scope_fields, initial_length: :scope_field_count do
            bit1 :enterprise
            bit15 :field_type
            uint16 :field_length
            # TODO: if upperbit (enterprise_bit) is set, then we have an enterprise # of 4 bytes (uint32)
            uint32 :enterprise_id, onlyif: -> { field_type >= 0x8000 }
          end # array scope_fields
          array :option_fields, initial_length: -> { field_count - scope_field_count } do
            bit1 :enterprise
            bit15 :field_type
            uint16 :field_length
            # TODO: if upperbit (enterprise_bit) is set, then we have an enterprise # of 4 bytes (uint32)
            uint32 :enterprise_id, onlyif: -> { field_type >= 0x8000 }
          end # array option_fields
        end # array templates
      end # class

      class Netflow10Packet < BinData::Record
        endian :big
        uint16 :version
        uint16 :ipfix_length # flow_records
        uint32 :unix_sec # export_time #uptime
        # uint32 :
        uint32 :flow_seq_num # seq_num
        uint32 :source_id # observation_domain_id
        array  :records, read_until: :eof do
          # set header
          uint16 :flowset_id # 2 = template, 3 = options, >= 256 = data sets
          uint16 :flowset_length # in octets
          # record
          choice :flowset_data, selection: :flowset_id do
            template10 2
            option10 3
            string :default, read_length: -> { flowset_length - 4 }
          end # choice
        end # array
      end # class

      class OctetArray1 < BinData::Array
        endian :big
        uint8 :storage
      end

      class OctetArray2 < BinData::Primitive
        array :bytes, type: :uint8, initial_length: 2

        def set(val)
          ints = val.split(/:/).collect { |int| int.to_i(16) }
          self.bytes = ints
        end

        def get
          bytes.collect { |byte| byte.value.to_s(16).rjust(2, '0') }.join(':')
        end
      end
    end # class NetflowipfixInput
  end # module Plugin
end # module Fluent
