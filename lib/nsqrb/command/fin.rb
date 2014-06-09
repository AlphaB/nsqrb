module Nsqrb
  class Command::Fin < Command

    private

      def failure_codes
        %w(E_INVALID E_FIN_FAILED)
      end

      def params
        [:message_id]
      end

  end
end
