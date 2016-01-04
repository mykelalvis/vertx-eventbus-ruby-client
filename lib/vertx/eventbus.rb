require "securerandom"
require "socket"
require "json"

module Vertx
  module Eventbus
    VERSION = "0.1.0"
    CONNECTING = 0;
    OPEN = 1;
    CLOSING = 2;
    CLOSED = 3;

    class << self
      attr_reader :hostname
      attr_reader :port
      attr_reader :state
      attr_reader :connection
      attr_reader :handlers
      attr_reader :default_headers

      def new(hostname, port, options = nil)
        self.state = Eventbus::CONNECTING
        self.hostname = hostname
        self.port = port
        self.handlers = []
        self.connection = TCPSocket.open(self.hostname, self.port)
        # client.send("something", 0)
        # client.close
 #
 #        /**
 # * EventBus
 # *
 # * @param {String} host
 # * @param {Number} port
 # * @param {Object} options
 # * @constructor
 # */
 #        var EventBus = function (host, port, options) {
 #
 #          var self = this;
 #
 #          options = options || {};
 #
 #          var pingInterval = options.vertxbus_ping_interval || 5000;
 #          var pingTimerID;
 #
 #          var sendPing = function () {
 #            send(self.transport, JSON.stringify({type: 'ping'}));
 #          };
 #
 #          // attributes
 #          this.transport = net.connect(port, host, function (err) {
 #            if (err) {
 #                self.onerror(err);
 #            }
 #
 #            // Send the first ping then send a ping every pingInterval milliseconds
 #            sendPing();
 #            pingTimerID = setInterval(sendPing, pingInterval);
 #            self.state = EventBus.OPEN;
 #            self.onopen && self.onopen();
 #            });
 #
 #            this.state = EventBus.CONNECTING;
 #            this.handlers = {};
 #            this.replyHandlers = {};
 #            this.defaultHeaders = null;
 #
 #            // default event handlers
 #            this.onerror = console.error;
 #
 #            // message buffer
 #            var buffer = new Buffer(0);
 #
 #            this.transport.on('close', function () {
 #              self.state = EventBus.CLOSED;
 #              if (pingTimerID) {
 #                  clearInterval(pingTimerID);
 #              }
 #              self.onclose && self.onclose();
 #              });
 #
 #              this.transport.on('error', self.onerror);
 #
 #              this.transport.on('data', function (chunk) {
 #                buffer = Buffer.concat([buffer, chunk]);
 #                if (buffer.length >= 4) {
 #                    var len = buffer.readInt32BE();
 #                if (buffer.length >= len + 4) {
 #                    // we have a full message
 #                var json;
 #
 #                try {
 #                  json = JSON.parse(buffer.slice(4, len + 4).toString());
 #                } catch (e) {
 #                  self.onerror(e);
 #                }
 #
 #                // define a reply function on the message itself
 #                if (json.replyAddress) {
 #                    Object.defineProperty(json, 'reply', {
 #                        value: function (message, headers, callback) {
 #                          self.send(json.replyAddress, message, headers, callback);
 #                        }
 #                    });
 #                }
 #
 #                if (self.handlers[json.address]) {
 #                    // iterate all registered handlers
 #                var handlers = self.handlers[json.address];
 #                for (var i = 0; i < handlers.length; i++) {
 #                    if (json.type === 'err') {
 #                        handlers[i]({failureCode: json.failureCode, failureType: json.failureType, message: json.message});
 #                    } else {
 #                        handlers[i](null, json);
 #                    }
 #                    }
 #                    } else if (self.replyHandlers[json.address]) {
 #                        // Might be a reply message
 #                    var handler = self.replyHandlers[json.address];
 #                    delete self.replyHandlers[json.address];
 #                    if (json.type === 'err') {
 #                        handler({failureCode: json.failureCode, failureType: json.failureType, message: json.message});
 #                    } else {
 #                        handler(null, json);
 #                    }
 #                    } else {
 #                        if (json.type === 'err') {
 #                            self.onerror(json);
 #                        } else {
 #                            console.warn('No handler found for message: ', json);
 #                        }
 #                        }
 #                        }
 #                        }
 #                        });
 #                        };
      end

      def close
        self.state = Eventbus::CLOSING
        self.connection.close
      end

      def send(address,message,headers,callback)
        # if (this.state != EventBus.OPEN) {
        #     throw new Error('INVALID_STATE_ERR');
        # }
        #
        # if (typeof headers === 'function') {
        #     callback = headers;
        # headers = {};
        # }
        #
        # var envelope = {
        #     type: 'send',
        #     address: address,
        #     headers: mergeHeaders(this.defaultHeaders, headers),
        #     body: message
        # };
        #
        # if (callback) {
        #     var replyAddress = makeUUID();
        # envelope.replyAddress = replyAddress;
        # this.replyHandlers[replyAddress] = callback;
        # }
        #
        # send(this.transport, JSON.stringify(envelope));

        end
      def publish(address,message,headers)
        # if (this.state != EventBus.OPEN) {
        #     throw new Error('INVALID_STATE_ERR');
        # }
        #
        # send(this.transport, JSON.stringify({
        #                                         type: 'publish',
        #                                         address: address,
        #                                         headers: mergeHeaders(this.defaultHeaders, headers),
        #                                         body: message
        #                                     }));

        end

      def register_handler(address,headers,callback)
        # if (this.state != EventBus.OPEN) {
        #     throw new Error('INVALID_STATE_ERR');
        # }
        #
        # if (typeof headers === 'function') {
        #     callback = headers;
        # headers = {};
        # }
        #
        # // ensure it is an array
        # if (!this.handlers[address]) {
        #     this.handlers[address] = [];
        # // First handler for this address so we should register the connection
        #                    send(this.transport, JSON.stringify({
        #                                                            type: 'register',
        #                                                            address: address,
        #                                                            headers: mergeHeaders(this.defaultHeaders, headers)
        #                                                        }));
        #                    }
        #
        #                    this.handlers[address].push(callback);

      end
      def unregister_handler(address,headers,callback)
        # if (this.state != EventBus.OPEN) {
        #     throw new Error('INVALID_STATE_ERR');
        # }
        #
        # var handlers = this.handlers[address];
        #
        # if (handlers) {
        #
        #     if (typeof headers === 'function') {
        #         callback = headers;
        #     headers = {};
        #     }
        #
        #     var idx = handlers.indexOf(callback);
        #     if (idx != -1) {
        #         handlers.splice(idx, 1);
        #     if (handlers.length === 0) {
        #         // No more local handlers so we should unregister the connection
        #     send(this.transport, JSON.stringify({
        #                                             type: 'unregister',
        #                                             address: address,
        #                                             headers: mergeHeaders(this.defaultHeaders, headers)
        #                                         }));
        #
        #     delete this.handlers[address];
        #     }
        #     }

      end

      private

      def merge_headers()

      # function mergeHeaders(defaultHeaders, headers) {
      #   if (defaultHeaders) {
      #       if(!headers) {
      #           return defaultHeaders;
      #       }
      #
      #       for (var headerName in defaultHeaders) {
      #           if (defaultHeaders.hasOwnProperty(headerName)) {
      #               // user can overwrite the default headers
      #           if (typeof headers[headerName] === 'undefined') {
      #               headers[headerName] = defaultHeaders[headerName];
      #           }
      #           }
      #           }
      #           }
      #
      #           // headers are required to be a object
      #           return headers || {};
      #           }
      #
      #
      #           end
      #
      end

      def send_wire_protocol()
        # function send(transport, message) {
        #   var buffer = new Buffer(message.length + 4);
        #   buffer.writeInt32BE(message.length, 0);
        #   buffer.write(message, 4, message.length, 'utf-8');
        #   transport.write(buffer);
        # }
        #
        #
      end

      def send_ping
        # var sendPing = function () {
        #   send(self.transport, JSON.stringify({type: 'ping'}));
        # };

      end
  end
end
