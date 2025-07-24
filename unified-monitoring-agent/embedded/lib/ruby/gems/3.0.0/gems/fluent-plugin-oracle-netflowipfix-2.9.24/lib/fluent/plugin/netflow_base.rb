# frozen_string_literal: true

require "fluent/plugin/parser"
require "bindata"
require 'yaml'

module Fluent
  module Plugin
    class NetflowipfixInput < Fluent::Plugin::Input
      class ParserNetflowBase
        private

        def ipv4_addr_to_string(uint32)
          "#{(uint32 & 0xff000000) >> 24}.#{(uint32 & 0x00ff0000) >> 16}.#{(uint32 & 0x0000ff00) >> 8}.#{uint32 & 0x000000ff}"
        end

        def msec_from_boot_to_time(msec, uptime, current_unix_time, current_nsec)
          millis = uptime - msec
          seconds = current_unix_time - (millis / 1000)
          micros = (current_nsec / 1000) - ((millis % 1000) * 1000)
          if micros < 0
            seconds -= 1
            micros += 1000000
          end
          Time.at(seconds, micros)
        end # def msec_from_boot_to_time

        def format_for_switched(time)
          time.utc.strftime("%Y-%m-%dT%H:%M:%S.%3NZ".freeze)
        end # def format_for_switched(time)

        def format_for_flowSeconds(time)
          time.utc.strftime("%Y-%m-%dT%H:%M:%S".freeze)
        end # def format_for_flowSeconds(time)

        def format_for_flowMilliSeconds(time)
          time.utc.strftime("%Y-%m-%dT%H:%M:%S.%3NZ".freeze)
        end # def format_for_flowMilliSeconds(time)

        def format_for_flowMicroSeconds(time)
          time.utc.strftime("%Y-%m-%dT%H:%M:%S.%6NZ".freeze)
        end # def format_for_flowMicroSeconds(time)

        def format_for_flowNanoSeconds(time)
          time.utc.strftime("%Y-%m-%dT%H:%M:%S.%9NZ".freeze)
        end # def format_for_flowNanoSeconds(time)
      end # class ParserNetflow
  end # class NetflowipfixInput
  end # module Plugin
end # module Fluent
