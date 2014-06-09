module Nsqrb
  class Command::Touch < Command

    private

      def params
        [:message_id]
      end

      def failure_codes
        %w(E_INVALID E_TOUCH_FAILED)
      end
  end
end
