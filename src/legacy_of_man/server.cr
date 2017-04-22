require "socket"
require "json"
require "mysql"
require "secure_random"

module LegacyOfMan
  class Server
    def initialize(logger : Logger)
      logger.info("initialize server Legacy Of Man version #{VERSION}") if logger.is_a? Logger
      raise "Config file not found" unless File.exists?(CONFIG_PATH)
      json_file = File.read(CONFIG_PATH)
      raise "Cannot read config file" unless json_file.is_a? String
      @config = Config.from_json(json_file)
      logger.info("Server Started using configs: #{@config.to_json}")
      @logger = logger
      init_salt
      init_db
    end

    def create_listiner : TCPServer
      begin
        TCPServer.new(@config.port)
      rescue e : Exception
        @logger.error("Error starting listiner: #{e}")
        exit 1
      end
    end

    def init_salt
      unless File.exists?(".salt.secret")
        @logger.info("Creating secret salt for password hashing")
        salt = SecureRandom.hex(50)
        File.write(".salt.secret", salt)
      end
    end

    def init_db
      begin
        DB.open "mysql://#{@config.db_user}@#{@config.db_ip}/#{@config.db_name}" do |db|
          @logger.info("Initialzing database")
          db.exec "CREATE TABLE IF NOT EXISTS users (
          username varchar(50) DEFAULT NULL,
          password varchar(100) DEFAULT NULL,
          email varchar(50) DEFAULT NULL,
          data varchar(5000) DEFAULT NULL
          );"
          @logger.info("database initialization completed")
        end
      rescue e : Exception
        raise "Cannot initialize Database: #{e}"
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
              ch = ClientHandler.new(client, @logger, @config)
              ch.handle
            end
          end
        rescue e : Exception
          @logger.error("Error handeling client: #{e}")
        end
      end
    end
  end
end
