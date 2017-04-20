require "./legacy_of_man/*"
require "logger"
CONFIG_PATH = "config.json"

log_file = File.open("logs/legacy_of_man.log", "a")
raise "Cannot open log file" unless log_file && log_file.is_a? IO
logger = Logger.new(log_file)

server = LegacyOfMan::Server.new(logger)
server.serve
