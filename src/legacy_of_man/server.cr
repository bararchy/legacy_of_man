require "socket"
require "json"

module LegacyOfMan
  class Server
    def initialize(logger : Logger)
      logger.info("initialize server") if logger.is_a? Logger
      raise "Config file not found" unless File.exists?(CONFIG_PATH)
      json_file = File.read(CONFIG_PATH)
      raise "Cannot read config file" unless json_file.is_a? String
      @config = Config.from_json(json_file)
      logger.info("Server Started using configs: #{@config.to_json}")
      @logger = logger
    end

    def create_listiner : TCPServer
      begin
        TCPServer.new(@config.port)
      rescue e : Exception
        @logger.error("Error starting listiner: #{e}")
        exit 1
      end
    end

    def serve
      server = create_listiner
      loop do
        begin
          client = server.accept
          spawn do
            if client.is_a? TCPSocket
              @logger.info("New client connected from: #{client.remote_address.address}:#{client.remote_address.port}")
              client << "Welcome to Legacy Of Man\n"
              client.close
            end
          end
        rescue e : Exception
          @logger.error("Error accepting new client: #{e}")
        end
      end
    end
  end
end
