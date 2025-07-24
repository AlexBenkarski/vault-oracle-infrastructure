# frozen_string_literal: true

require 'fluent/plugin/parser'
require 'date'

module Fluent::Plugin::OpenMetrics
  # parser for open metrics format
  # https://openmetrics.io
  # https://prometheus.io/docs/instrumenting/exposition_formats/#text-based-format
  class OpenMetricsParser < ::Fluent::Plugin::Parser
    Fluent::Plugin.register_parser('openmetrics', self)

    # https://prometheus.io/docs/concepts/data_model/#metric-names-and-labels
    ANNOTATION_RE = /^#\s+(?<type>HELP|TYPE)\s+(?<name>[a-zA-Z0-9:_]*)\s+(?<info>.*)$/.freeze
    SAMPLE_RE     = /^(?<name>[a-zA-Z0-9:_]+)(\{(?<labels>.+)\})?\s+(?<value>[0-9.eE\+\-|NaN]+)(\s+(?<timestamp>[0-9.]+))?/.freeze
    # # , -> Split on comma
    # (?= -> Followed
    # (?: -> Start a non-capture group
    # [^"]* -> 0 or more non-quote characters
    # " -> 1 quote
    # [^"]* -> 0 or more non-quote characters
    # " -> 1 quote
    # )* -> 0 or more repetition of non-capture group
    # [^"]* -> Finally 0 or more non-quotes
    # $ -> Till the end [This is needed otherwise every comma will satisfy the condition]
    # )
    COMMA_RE      = /,(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)/.freeze
    EQUAL_RE      = /=/.freeze
    METADATA = {
        'HELP' => 'displayName',
        'TYPE' => 'type'
    }
    def configure(conf)
      super

      record = conf.elements('record').first # <record></record> directive
      @custom_dimensions = JSON.parse(record.fetch('dimensions', '{}').gsub('=>', ':'))
      @name_space = record.fetch('namespace',"telemetry")
      @resource_group = record.fetch('resourceGroup',"default")
    end

    # take a Prometheus scrape response body and parse it, returning a MultiEventStream
    def parse(body)
      log.debug("Parsing openmetrics input:\n#{body}") if ENV.fetch('OCI_OPENMETRICS_PARSER_TRACE', false)

      metadata = {}
      eventstream = ::Fluent::MultiEventStream.new
      body.each_line { |line|
        if line.start_with?('#')
          if md = ANNOTATION_RE.match(line)
            metadata[md['name']] ||= {}
            metadata[md['name']][md['type']] = md['info']
          end
        else
          if md = SAMPLE_RE.match(line)
            record, datapoint = {}, {}
            record['name'] = md['name']
            record['dimensions'] = @custom_dimensions.clone
            record['namespace'] =  @name_space
            record['resourceGroup'] = @resource_group
            # add dimensions from labels
            if labels = md['labels']&.split(COMMA_RE)
              # in rare case that there is a leading comma remove the first space otherwise ignore
              if(labels[0] == "")
                labels.shift
              end

              split_labels = []
              labels.each do |label|  # labels[i] will be something like this uri="/api/v1/k8s/authorize?timeout=30s"
                # undump automatically added ruby escaping of double quotes, if present
                begin
                  label_array = label&.split(EQUAL_RE, 2)
                  label_parts = label_array.map { |s| s.start_with?('"') ? s.undump : s }
                rescue StandardError => e  # print error in case of bad metric and continue
                  label_name = label_array[0]
                  label_value = label_array[1]
                  log.error "Skipping label #{label_name} for dimension with unparseable value: #{label_value} due to: #{e.message}"
                  next
                else
                  split_labels << label_parts
                end
              end
              record['dimensions'].merge!(split_labels.to_h.delete_if { |_, value| value.nil? || value.strip == "" })
            end
            # add value and timestamp
            ts = (md['timestamp'] ? DateTime.strptime(md['timestamp'], '%Q') : DateTime.now)
            datapoint['value']     = md['value'].to_f
            datapoint['timestamp'] = ts.rfc3339(3)
            record['datapoints']   = [datapoint]
            # collect OpenMetrics metadata, if any
            if ommd = metadata[md['name']]
              t2md = METADATA.map { |om, t2| [t2, ommd[om]] if ommd.has_key?(om) }.compact.to_h
              record['metadata'] = t2md if t2md
            end
            if block_given?
              yield Fluent::EventTime.from_time(ts.to_time), record
            else
              eventstream.add(Fluent::EventTime.from_time(ts.to_time), record)
            end
          end
        end
      }
      return eventstream unless block_given?
    end
  end
end
