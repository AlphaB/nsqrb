module Nsqrb
  class Frame::Response < Frame

    def initialize(frame)
      super(content: frame[:data])
    end

  end
end
