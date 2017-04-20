require "socket"
require "json"

module LegacyOfMan
  class Server
    def initialize
      raise "Config file not found" unless File.exists?(CONFIG_PATH)
      json_file = File.read(CONFIG_PATH)
      raise "Cannot read config file" unless json_file.is_a? String
      @config = Config.from_json(json_file)
      logger.info("Server Started")
    end
  end
end
