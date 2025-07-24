# frozen_string_literal: true

require 'socket'
require 'fluent/plugin/input'

require_relative 'netflow_base'
require_relative 'parser_ipfix'
require_relative 'netflowipfix_records'
require_relative 'vash'

module Fluent
  module Plugin
    class NetflowipfixInput < Fluent::Plugin::Input
      Fluent::Plugin.register_input('netflowipfix', self)
      include DetachMultiProcessMixin

      class PortConnection
        def initialize(bind, port, tag, cache_ttl, definitions, queuesleep, log)
          @bind = bind
          @port = port
          @tag = tag
          @cache_ttl = cache_ttl
          @definitions = definitions
          @eventQueue = Queue.new
          @udpQueue = Queue.new
          @queuesleep = queuesleep
          @log = log
        end

        attr_reader :bind

        attr_reader :port

        attr_reader :tag

        def start
          @thread_udp = UdpListenerThread.new(@bind, @port, @udpQueue, @tag, @log)
          @thread_parser = ParserThread.new(@udpQueue, @queuesleep, @eventQueue, @cache_ttl, @definitions, @log)
          @thread_udp.start
          @thread_parser.start
        end # def start

        def stop
          @thread_udp.close
          @thread_parser.close
        end # def stop

        def restartParser
          unless @thread_parser.nil?
            @thread_parser.close
            @thread_parser = nil
          end
          @thread_parser = ParserThread.new(@udpQueue, @queuesleep, @eventQueue, @cache_ttl, @definitions, @log)
          @thread_parser.start
        end

        def event_pop
          @eventQueue.pop
        end

        def event_queue_length
          @eventQueue.length
        end
      end # class PortConnection

      config_param :tag, :string
      config_param :port, :integer, default: nil
      config_param :bind, :string, default: '0.0.0.0'
      config_param :queuesleep, :integer, default: 10

      def configure(conf)
        super
        $log.debug "NetflowipfixInput::configure: #{@bind}:#{@port}"
        @connections ||= {}
        @events_thread = nil
        if @connections.nil?
        end
        @connections[@port] = PortConnection.new(@bind, @port, @tag, @cache_ttl, @definitions, @queuesleep, log)
        log.debug "NetflowipfixInput::configure NB=#{@connections.length}"
        @total = 0
      end


      def start
        super
        @events_thread = EventsThread.new(@connections, router)
        @events_thread.start
      end

      def shutdown
        super
        $log.info "NetflowipfixInput::shutdown NB=#{@connections.length}"
        if @connections.nil?
        else
          @connections.each do |port, conn|
            $log.info "shutdown listening UDP on #{conn.bind}:#{conn.port}"
            conn.stop
          end
          @events_thread.stop
          @events_thread = nil
          @connections = nil
        end
      end

      class EventsThread
        def initialize(connections, router)
          @connections = connections
          @queuesleep = 10
          @router = router
        end

        def start
          $log.info "NetflowipfixInput::start NB=#{@connections.length}"
          if @connections.nil?
          else
            @connections.each do |port, conn|
              $log.info "start listening UDP on #{conn.bind}:#{conn.port}"
              conn.start
            end
          end
          @thread = Thread.new(&method(:run))
          $log.info 'EventsThread::start'
        end

        def join
          @thread.join
        end

        def get
          @thread
        end

        def stop
          GC.start
        end

        def run
          timeStart = Time.now.getutc.to_i
          nb = 0
          loop do
            @connections.each do |port, conn|
              next unless conn.event_queue_length > 0
              $log.info "waitForEvents: #{conn.bind}:#{conn.port} queue has #{conn.event_queue_length} elements"
              nbq = conn.event_queue_length
              loop do
                ar = conn.event_pop
                time = ar[0]
                record = ar[1]
                @router.emit(conn.tag, EventTime.new(time.to_i), record)
                # Free up variables for garbage collection
                ar = nil
                time = nil
                record = nil
                nb += 1
                nbq -= 1
                break if nbq == 0
              end
            end
            if Time.now.getutc.to_i - timeStart > 600 # 300 = 5 min
              restartConnections
              timeStart = Time.now.getutc.to_i
            end

            # Garbage collection
            nb = 0 if nb >= 20
            before = GC.stat(:total_freed_objects)
            GC.start
            after = GC.stat(:total_freed_objects)
            $log.info "waitForEvents: sleep #{@queuesleep}"
            sleep(@queuesleep)
          end
        end

        def restartConnections
          @connections.each do |port, conn|
            $log.info "restart parser #{conn.bind}:#{conn.port}"
            conn.restartParser
          end
          $log.info 'restart successful'
          before = GC.stat(:total_freed_objects)
          GC.start
          after = GC.stat(:total_freed_objects)
        end
      end


      private

      class UdpListenerThread
        def initialize(bind, port, udpQueue, tag, log)
          @port = port
          @udpQueue = udpQueue
          @udp_socket = UDPSocket.new
          @udp_socket.bind(bind, port)
          @total = 0
          @tag = tag
          @log = log
        end

        def start
          @thread = Thread.new(&method(:run))
          @log.trace 'UdpListenerThread::start'
        end

        def close
          @udp_socket.close
        end

        def join
          @thread.join
        end

        def run
          nb = 0
          loop do
            msg, sender = @udp_socket.recvfrom(4739)
            @total += msg.length
            @log.trace "UdpListenerThread::recvfrom #{msg.length} bytes for #{@total} total on UDP/#{@port}"
            record = {}
            record['message'] = msg
            record['length'] = msg.length
            record['total'] = @total
            record['sender'] = sender
            record['port'] = @port
            #				time = EventTime.new()
            time = Time.now.getutc
            @udpQueue << [time, record]
            # Garbage collection
            msg = nil
            sender = nil
            nb += 1
            if nb > 100
              GC.start
              nb = 0
            end
          end
        end
      end # class UdpListenerThread

      class ParserThread
        def initialize(udpQueue, queuesleep, eventQueue, cache_ttl, definitions, log)
          @udpQueue = udpQueue
          @queuesleep = queuesleep
          @eventQueue = eventQueue
          @log = log

          @parser_v10 = NetflowipfixInput::ParserIPfixv10.new
          @parser_v10.configure(cache_ttl, definitions)
        end

        def start
          @thread = Thread.new(&method(:run))
          @log.debug 'ParserThread::start'
        end

        def close
          # Garbage collection
          @parser_v5 = nil
          GC.start
        end

        def join
          @thread.join
        end

        def run
          loop do
            if @udpQueue.empty?
              sleep(@queuesleep)

            else
              block = method(:emit)
              ar = @udpQueue.pop
              time = ar[0]
              msg = ar[1]
              payload = msg['message']
              host = msg['sender']

              version, = payload[0, 2].unpack('n')
              @log.trace "ParserThread::pop #{@udpQueue.length} v#{version}"

              case version
              when 10
                packet = NetflowipfixInput::Netflow10Packet.read(payload)
                # $log.info 'packet: ', packet
                @parser_v10.handle_v10(host, packet, block)
              else
                $log.warn "Unsupported Netflow version v#{version}: #{version.class}"
              end # case

              # Free up variables for garbage collection
              version = nil
              time = nil
              msg = nil
              payload = nil
              host = nil

            end
          end # loop do
        end # def run

        def emit(time, event, host = nil)
          event['host'] = host unless host.nil?
          @eventQueue << [time, event]
          @log.trace "ParserThread::emit #{@eventQueue.length}"
        end # def emit
      end # class ParserThread
    end # class DnsCacheOuput
  end # module Plugin
end # module Fluent