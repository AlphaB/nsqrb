module Nsqrb
  class Frame::Message < Frame

    def initialize(frame)
      unpacked = frame[:data].unpack("Q>s>a16a#{frame[:size]}")
      super(Hash[*([:timestamp, :attempts, :id, :content].zip(unpacked).flatten)])
    end

  end
end
