require "securerandom"
require "socket"
require "json"

module Vertx
  module Eventbus
    VERSION = "0.1.0"
    class << self
      attr_reader :hostname
      attr_reader :port

      def new(hostname, port, options = nil)
        self.hostname = hostname
        self.port = port
        client = TCPSocket.open(self.hostname, self.port)
        client.send("something", 0)
        client.close
      end
    end
  end
end
