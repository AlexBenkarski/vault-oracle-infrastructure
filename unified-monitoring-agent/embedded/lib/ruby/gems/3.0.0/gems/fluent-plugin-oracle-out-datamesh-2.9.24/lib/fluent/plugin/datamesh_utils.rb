# frozen_string_literal: true

require 'securerandom'

module Fluent
  module Plugin
    # Common utility methods
    module DatameshUtils
      OCI_DATAMESH_PREFIX = 'dm_'
      UTF_8 = 'UTF-8'

      ##
      # Build the requests to be sent to the DM endpoint.
      #
      # @param [Time] time Fluentd event time (may be different from event's timestamp)
      # @param [String] contents The fluentd record.
      # @param [String] tagpath The fluentd path if populated.
      # @param [Hash] log_batches_map List of pre-existing log batch.
      # @param [String] subject The fluentd contianing the source path.
      #
      # @return [Array] requests List of requests for Lumberjack's backend.
      def build_request(time, content, tagpath, log_batches_map, subject)
        log = @log || Logger.new($stdout)

        # create lumberjack request records
        logentry = ::DM::DMLoggingingestion::Models::LogEntry.new
        logentry.time = Time.at(time).strftime('%FT%T.%LZ')
        logentry.data = content
        logentry.id = SecureRandom.uuid

        requestkey = tagpath + subject

        unless log_batches_map.key?(requestkey)
          batch = DM::DMLoggingingestion::Models::LogEntryBatch.new
          batch.type = tagpath
          batch.subject = subject
          batch.default_time = Time.at(time).strftime('%FT%T.%LZ')
          batch.entries = []

          log_batches_map[requestkey] = batch
        end

        log_batches_map[requestkey].entries << logentry
      end

      ##
      # Send prebuilt requests to the Datamesh endpoint.
      #
      # @param [Hash] log_batches_map
      # @param [Hash] origin
      def send_requests(log_batches_map, origin)
        log = @log || Logger.new($stdout) # for testing

        request_id = SecureRandom.uuid.delete!('-').upcase

        batches = log_batches_map.values
        begin
          log.info("[req-id: #{request_id}] post_logs request with log_object_id #{@log_object_id}")
          batches.each_with_index do |batch, idx|
            log.info("[req-id: #{request_id}] batch ##{idx} " \
                     "type: #{batch.type}, " \
                     "subject: #{batch.subject}, " \
                     "default_time: #{batch.default_time}, " \
                     "entries: #{batch.entries.size}")
          end

          resp = @client.post_logs(@log_object_id, batches, origin, { opc_request_id: request_id })
          log.info("[req-id: #{request_id}] Response #{resp.status} response-id: #{resp.request_id}")
          resp
        rescue OCI::Errors::ServiceError => e
          if e.status_code == 400
            log.info("[req-id: #{request_id}] Service error received (Eating it is caused by Bad Request[400]): #{e}")
          else
            log.error("[req-id: #{request_id}] Service error received (Throwing for status code:#{e.status_code} as we want fluentd to retry): #{e}")
            raise
          end
        rescue OCI::Errors::NetworkError => e
          if e.code == 400
            log.info("[req-id: #{request_id}] Network error received (Eating it is caused by Bad Request[400]): #{e}")
          else
            log.error("[req-id: #{request_id}] Network error received (Throwing for code:#{e.code} as we want fluentd to retry): #{e}")
            raise
          end
        rescue StandardError => e
          log.error("[req-id: #{request_id}] Standard Error received sending request: #{e}")
          raise
        end

      end

      # content can be anything
      def sanitized_content_str(content)
        if content.respond_to?(:key) # Means it's a Hash
          begin
            return content.to_json
          rescue StandardError
            begin
              log.warn('log line contains Non-ASCII characters, which is not accepted by agent, re-encode into UTF-8')
              # Fluentd treats logs as ASCII encoding by default, it cannot deal with Non-ASCII char, need to re-encode
              # them into UTF-8 encoding and send backend
              return encode_to_utf8(content).to_json
            rescue StandardError
              log.warn('unexpected encoding in the log request, will send log as a string instead of json')
              # instead of loosing data because of an unknown encoding issue send the data as a string
              return content.to_s.encode!(UTF_8, UTF_8)
            end
          end
        else
          return content.to_s.encode!(UTF_8, UTF_8)
        end 
      end

      ##
      # Re-encode characters to UTF-8
      #
      # @param [Hash] record the flattened hash needing to have the encoding changes
      #
      # @return [Hash] The updated hash.
      def encode_to_utf8(record)
        record.transform_values({}) do |(k, v), h|
          h[k] = v.to_s.encode!(UTF_8, UTF_8)
        end
      end

      ##
      # Parse out the log_type from the chunk metadata tag
      #
      # @param [String] rawtag the string of the chunk metadata tag that needs to be parsed
      #
      # @return [String] take out the tag after the first '.' character or return the whole tag if there is no '.'. if it's a datamesh tag, replace all '_' with '.'.
      def get_modified_tag(rawtag)
        tag = rawtag || '__untagged__'
        if tag.start_with?(OCI_DATAMESH_PREFIX) 
          return tag.gsub('_', '.')
        else 
          partitioned = tag.partition('.')
          if partitioned[2].start_with?(OCI_DATAMESH_PREFIX)
            return partitioned[2].gsub('_', '.')
          end

          return partitioned[2] != "" ? partitioned[2] : tag
        end
      end
    end
  end
end
