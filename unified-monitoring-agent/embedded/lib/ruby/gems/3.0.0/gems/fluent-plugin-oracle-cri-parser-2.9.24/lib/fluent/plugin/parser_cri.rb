
require "fluent/plugin/parser"
# The implementation is based on Masahiro Nakagawa's fluent-plugin-parser-cri
# See https://github.com/fluent/fluent-plugin-parser-cri

module Fluent
  module Plugin
    class ParseCri < Fluent::Plugin::Parser
      Fluent::Plugin.register_parser("cri", self)

      config_param :merge_cri_fields, :bool, default: true


      def configure(conf)
        super

        @sub_parser = nil
        if parser_config = conf.elements('parse').first
          type = parser_config['@type']
          @sub_parser = Fluent::Plugin.new_parser(type, parent: self.owner)
          @sub_parser.configure(parser_config)
        end
      end

      def parse(text)
        elems = text.split(/\s/.freeze, 4)
        return yield nil if elems.size != 4

        if @sub_parser
          time = record = nil
          @sub_parser.parse(elems[3]) { |t, r|
            time = t
            record = r
          }
          if @merge_cri_fields && record
            record['stream'] = elems[1]
            record['logtag'] = elems[2]
          end
        else
          record = {
            "stream" => elems[1],
            "logtag" => elems[2],
            "message" => elems[3]
          }
          t = elems[0]
          time = @time_parser.parse(t)
          if @keep_time_key
            record[@time_key] = t
          end
        end

        yield time, record
      end
    end
  end
end