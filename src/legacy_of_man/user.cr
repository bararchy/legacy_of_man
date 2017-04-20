module LegacyOfMan
  class User
    def initialize(client : TCPSocket, logger : Logger, username : String)
      @client = client
      @logger = logger
      @username = username
    end

    def name : String
      @username
    end
  end
end
