module Nsqrb
  class Command::Cls < Command

    private

      def success_codes
        %w(CLOSE_WAIT)
      end

      def failure_codes
        %w(E_INVALID)
      end
  end
end
