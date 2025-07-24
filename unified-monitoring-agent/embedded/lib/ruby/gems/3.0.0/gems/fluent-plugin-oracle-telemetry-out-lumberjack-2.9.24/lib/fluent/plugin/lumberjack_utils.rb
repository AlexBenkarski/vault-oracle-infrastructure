# encoding: UTF-8

# Copyright 2019- Oracle
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
require 'fluent/config/error'
require 'uri'

module Fluent
  module Plugin
    ##
    # Module containing utility functions required elsewere in this plugin.
    module LumberjackUtils
      ##
      # Wrapper for GETting http data from a URL as a string.
      #
      # @param [String] url_str A string url.
      # @param [Int] timeout Integer http request timeout. Defaults to 30 secs.
      # @param [Int] size The maximum read size. Defaults to 102400 bytes.
      #
      # @return [String] The http response as a string.
      def http_get(url, path, timeout = 30, size = 102400)
        begin
          #data = URI.parse(Net::HTTP.get(url, path))
          data = URI.parse("#{url}#{path}").open(read_timeout: timeout).read(size)
        rescue Exception => exc
          msg = "Caught exception while GET-ting #{url}#{path}: #{exc}."\
          "Data received: #{data}."
          raise Fluent::ConfigError, msg
        else
          data
        end
      end

      ##
      # Flatten the keys of a hash.
      #
      # @param [Hash] record The hash object to flatten.
      #
      # @return [Hash] h The updated, flattened, hash.
      def flatten_hash(record)
        record.each_with_object({}) do |(k, v), h|
          if v.is_a? Hash
            flatten_hash(v).map { |h_k, h_v| h["#{k}.#{h_k}"] = h_v }
          elsif k == 'log'
            h['msg'] = v
          else
            h[k] = v
          end
        end
      end

    end
  end
end
