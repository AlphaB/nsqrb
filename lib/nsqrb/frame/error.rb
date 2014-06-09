module Nsqrb
  class Frame::Error < Frame

    def initialize(frame)
      super(content: frame[:data])
    end

  end
end
