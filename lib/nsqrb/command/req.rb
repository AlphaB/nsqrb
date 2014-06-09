module Nsqrb
  class Command::Req < Command

    private

      def failure_codes
        %w(E_INVALID E_REQ_FAILED)
      end

      def params
        [:message_id, :timeout]
      end

  end
end
