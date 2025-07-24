#
# Copyright 2020- zhenyao
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

require "fluent/plugin/parser"

module Fluent
  module Plugin
    class ParserNestedJson < Fluent::Plugin::Parser
      Fluent::Plugin.register_parser("nested_json", self)

      config_param :separator, :string, default: "."

      def configure(conf)
        super
      end

      def parse(text)
        _, is_valid = get_parsed_json_from(text)
        unless is_valid
          raise "input is not valid json"
        end

        record = flatten_record(text, [])
        time, res = parse_time(record), record

        yield time, res
      end

      # All methods declared below are private
      private

      def flatten_record(record, prefix)
        ret = {}
        json_record, _ = get_parsed_json_from(record)
        if json_record.is_a? Hash
          json_record.each { |key, value|
            ret.merge! flatten_record(value, prefix + [key.to_s])
          }
        else
          return {prefix.join(@separator) => record}
        end

        ret
      end

      def get_parsed_json_from(input)
        out = JSON.parse(input)
        return out, true
      rescue
        return input, false
      end
    end
  end
end
