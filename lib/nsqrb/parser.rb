module Nsqrb
  class Parser

    # Frame types
    FRAME_TYPES = {
      0 => Frame::Response,
      1 => Frame::Error,
      2 => Frame::Message
    }

    FRAME_TYPE_SIZE = 4
    INFO_SIZE = 8

    def initialize
      @buffer = []
    end

    def add(bytes)
      bytes = bytes.split('') if bytes.is_a?(String)
      @buffer += bytes
    end

    # Parse all frames from current buffer
    # @return Array [Frame]
    def parse
      frames = []
      loop do
        break if @buffer.length < INFO_SIZE
        size, type = @buffer[0, INFO_SIZE].join.unpack('l>l>')
        frame = { size: size - FRAME_TYPE_SIZE, type: type.to_i }

        break if @buffer.length < frame[:size] + INFO_SIZE
        frame[:data] = @buffer[INFO_SIZE, frame[:size]].join
        frames << build_frame(frame)
        @buffer.shift(INFO_SIZE + frame[:size])
      end
      frames
    end

    private

      def build_frame(frame)
        raise "Unknown frame type: #{frame[:type]}" unless FRAME_TYPES.has_key?(frame[:type])
        FRAME_TYPES[frame[:type]].new frame
      end
  end
end
