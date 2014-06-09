module Nsqrb
  class Producer
    def initialize(host, port, topic)
      @http = ::Net::HTTP.new(host, port)
      @topic = topic
    end

    def post!(obj)
      res = @http.post("/pub?topic=" + @topic, obj.to_json)
      return if res.code == "200"
      res.error!
    end
  end
end
