module Nsqrb
  class Command

    def initialize(args = {})
      @args = args
    end

    def to_line
      "#{command}\n"
    end

    # Is response OK
    def ok?(response)
      response = response.content if response.is_a?(FrameType)
      self.class.ok.include?(response)
    end

    # Is response ERROR
    def error?(response)
      response = response.content if response.is_a?(FrameType)
      self.class.error.include?(response)
    end

    private

      def command
        values.unshift(name).join(' ')
      end

      def success_codes
        []
      end

      def failure_codes
        []
      end

      def params
        []
      end

      def values
        params.map { |param| @args[param] }
      end

      def name
        self.class.name.split('::').last.upcase
      end
  end
end
