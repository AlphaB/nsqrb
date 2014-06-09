module Nsqrb
  class Command::Sub < Command

    private

      def success_codes
        %w(OK)
      end

      def failure_codes
        %(E_INVALID E_BAD_TOPIC E_BAD_CHANNEL)
      end

      def params
        [:topic_name, :channel_name]
      end

  end
end
