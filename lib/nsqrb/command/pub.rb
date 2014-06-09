module Nsqrb
  class Command::Pub < Command

    def to_line
      msg = @args[:message].to_s
      [name, ' ', @args[:topic_name], "\n", msg.length, msg].pack('a*a*a*a*l>a*')
    end

    private

      def success_codes
        %w(OK)
      end

      def failure_codes
        %w(E_INVALID E_BAD_TOPIC E_BAD_MESSAGE E_PUB_FAILED)
      end

      def params
        [:topic_name, :message]
      end
  end
end
