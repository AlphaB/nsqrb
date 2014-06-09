module Nsqrb
  class Consumer
    attr_reader :options, :messages, :errors, :responses

    TCP_BUFFER = 64.kilobytes
    PROTOCOL_VERSION = "v2"

    def initialize(options = {})
      @options = options
      @messages = []
      @errors = []
      @responses = []
      @parser = Parser.new
    end

    def receive
      begin
        buffer = @socket.recv(TCP_BUFFER)
        @parser.add(buffer)
        frames = @parser.parse
        frames.each { |frame| handle(frame) }
      rescue => e
        close!
        raise e
      end
    end

    def confirm(message)
      @socket.write Command::Fin.new(message_id: message.id).to_line
    end

    def requeue(message, timeout = 0)
      @socket.write Command::Req.new(message_id: message.id, timeout: timeout).to_line
    end

    def touch(message)
      @socket.write Command::Touch.new(message_id: message.id).to_line
    end

    def close!
      return if @socket.nil? || @socket.closed?
      @socket.write Command::Cls.new.to_line
      @socket.close
      @socket = nil
    end

    def connect!
      close! if @socket && !@socket.closed?
      @socket = TCPSocket.open(options[:host], options[:port])
      @socket.write PROTOCOL_VERSION.rjust(4).upcase
      @socket.write Command::Identify.new(identify_defaults.merge(options[:features] || {})).to_line
      @socket.write Command::Sub.new(topic_name: options[:topic], channel_name: options[:channel]).to_line
      @socket.write Command::Rdy.new(count: 1).to_line
      puts 'Ready to receive!'
    end

    private

      def identify_defaults
        return @identify_defaults if @identify_defaults
        @identify_defaults = {
          short_id: Socket.gethostname,
          long_id: Socket.gethostbyname(Socket.gethostname).flatten.compact.first,
          user_agent: "nsqrb/#{Nsqrb::VERSION}",
          feature_negotiation: true
        }
      end

      def handle(frame)
        if(frame.is_a?(Frame::Response) && frame.content == '_heartbeat_')
          @socket.write Command::Nop.new.to_line
        elsif frame.is_a?(Frame::Message)
          @messages << frame
        elsif frame.is_a?(Frame::Response)
          @responses << frame
        elsif frame.is_a?(Frame::Error)
          @errors << frame
        end
      end
  end
end
