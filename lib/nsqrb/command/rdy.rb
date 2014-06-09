module Nsqrb
  class Command::Rdy < Command

    private

      def failure_codes
        %w(E_INVALID)
      end

      def params
        [:count]
      end

  end
end
