# frozen_string_literal: true

require 'fluent/plugin/input'
require 'fluent/plugin/in_tail'
require 'time'

module Fluent
  module Plugin
    GC_PAUSE_EXPR = /(GC pause|Full GC) (\((?<cause>[^)]+)\))?( \((?<type>[^)]+)\))?( \((?<extra>[^)]+)\))?/.freeze
    GC_START_EXPR = /^(?<datetime>[0-9]+-[0-9T\-:.+]+)?[ ]?(?<time>[0-9.]+)?: /.freeze
    GC_HEAP_EXPR =  /(?<type>[^\[ ]+): (?<sn1>[0-9.]+)(?<su1>[BKMG])(\([0-9.MKBG]+\))?->(?<sn2>[0-9.]+)(?<su2>[BKMG])(\([0-9.MKBG]+\))?/.freeze

    # Input plugin for G1GC log, convert g1gc information into metrics.
    class G1GCLogInput < TailInput
      Fluent::Plugin.register_input('g1gc', self)

      config_param :namespace, :string
      config_param :resource_group, :string, default: nil
      config_param :compartment_id, :string, default: nil

      def configure(conf)
        log.warn 'format is not supported for g1gc' unless conf['format'].nil?
        conf['format'] = 'none'
        super
        @receive_handler = method(:parse_lines)
      end

      def multi_workers_ready?
        true
      end

      def configure_parser(_)
        # ignore
      end

      def parse_lines(lines, tail_watcher)
        lb = tail_watcher.line_buffer
        ts = Fluent::Engine.now
        es = Fluent::MultiEventStream.new
        last_time = nil

        # copied from TailInput, not sure what this does.
        tail_watcher.line_buffer_timer_flusher&.reset_timer
        lines.each do |line|
          line.chomp!
          if lb
            if lb.include?('[') && !line.match(/^[^\[\]*, [0-9.]+ secs]$/)
              next
            else
              line = lb + line
              lb = nil
            end
          end

          entries = nil
          if line[/^\s*\[/]
            if last_time && line.include?('[Eden:')
              entries = handle_heap(line, last_time)
            end
          elsif match = line.match(GC_START_EXPR)
            # anything after timestamp
            body = match.post_match
            # some situation causes this nested situation (concurrent activity)
            inner = body.match(match.regexp)
            if inner
              # back up anything up to the inner, then handle inner block
              lb = match.to_s + inner.pre_match
              entries = process_match(inner)
            elsif (entries = process_match(match)).nil?
              # open entry, put it back to lb
              lb = line
            end
          end

          entries&.each do |entry|
            last_time = entry['time']
            es.add(ts, entry)
          end
        end

        tail_watcher.line_buffer = lb
        es
      end

      def handle_heap(line, time)
        res = []
        line.scan(GC_HEAP_EXPR) do |m|
          res << metric("G1GC.#{m[0]}.Before", time, to_megabyte(m[1], m[2]))
          res << metric("G1GC.#{m[0]}.After", time, to_megabyte(m[3], m[4]))
        end
        res
      end

      def process_match(match)
        body = match.post_match
        time = extract_time(match['datetime'])
        value = extract_value(body.match(/([0-9.]+) sec/))
        # code here
        if body.include? 'Total time for which application threads were stopped'
          [metric('G1GC.AppPauseTime.Total', time, value)]
        elsif inner = body.match(/^\[(?<content>[^\[]+)?\]$/)
          handle_content(inner['content'], time, value)
        end
      end

      def handle_content(content, time, value)
        res = []
        return res if value.nil?

        # some situation, size info is in this line
        if m = content.match(/(?<sn1>[0-9.]+)(?<su1>[BKMG])->(?<sn2>[0-9.]+)(?<su2>[BKMG])/)
          res << metric('G1GC.Heap.Before', time, to_megabyte(m['sn1'], m['su1']))
          res << metric('G1GC.Heap.After', time, to_megabyte(m['sn2'], m['su2']))
        end

        if m = content.match(GC_PAUSE_EXPR)
          res += process_gc_content(m, time, value)
        else
          # some extra non-gc activity (concurrent)
          str = content[3..(content.index(',') - 1)]
          res << metric('G1GC.' + str.split('-').collect(&:capitalize).join, time, value)
        end
        res
      end

      def process_gc_content(match, time, value)
        cause = match['cause']
        type = match['type']
        extra = match['extra']
        res = [metric('G1GC.Duration', time, value)]
        # per type metric
        res << if match.string.start_with?('Full GC (System.gc())')
                 metric('G1GC.AppGC', time, value)
               elsif match.string.start_with?('Full GC')
                 metric('G1GC.FullGC', time, value)
               else
                 metric(type_metric_name(type), time, value)
               end

        # cause
        if cause != 'G1 Evacuation Pause'
          res << metric('G1GC.Cause.' + cause.delete(' '), time, value)
        end

        # extra metric
        if extra == 'to-space exhausted'
          res << metric('G1GC.Counter.ToSpaceExhausted', time, 1)
        elsif extra == 'to-space overflow'
          res << metric('G1GC.Counter.ToSpaceOverflow', time, 1)
        elsif !extra.nil? && extra != 'initial-mark'
          res << metric('G1GC.Counter' + extra, time, 1)
        end

        res
      end

      def extract_time(str)
        str[0..-2] if str
      end

      def extract_value(match)
        match[0].to_f * 1_000 if match
      end

      def metric(name, time, value)
        rec = {}
        rec['namespace'] = @namespace
        rec['resourceGroup'] = @resource_group unless @resource_group.nil?
        rec['compartmentId'] = @compartment_id unless @compartment_id.nil?
        rec['name'] = name
        rec['datapoints'] = [{ 'timestamp' => time, 'value' => value }]
        rec
      end

      def to_megabyte(number, unit)
        case unit
        when 'G' then number.to_f * 1024
        when 'K' then number.to_f / 1024
        when 'B' then number.to_f / 1024 / 1024
        else number.to_f
        end
      end

      def type_metric_name(type)
        case type
        when 'young' then 'G1GC.YoungGC'
        when 'mixed' then 'G1GC.MixedGC'
        else 'G1GC.' + type
        end
      end

    end
  end
end
