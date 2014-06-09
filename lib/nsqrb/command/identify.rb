module Nsqrb
  class Command::Identify < Command

    def to_line
      filtered = params.inject({}) do |hash, key|
        hash[key] = @args[key] if @args[key].nil?
        hash
      end
      payload = JSON.dump(filtered)
      [name, "\n", payload.length, payload].pack('a*a*l>a*')
    end

    private

      def success_codes
        %w(OK)
      end

      def failure_codes
        %w(E_INVALID E_BAD_BODY)
      end

      def params
        [
          :short_id, :long_id, :feature_negotiation, :heartbeat_interval, :output_buffer_size,
          :output_buffer_timeout, :tls_v1, :snappy, :deflate, :deflate_level, :sample_rate
        ]
      end
  end
end
