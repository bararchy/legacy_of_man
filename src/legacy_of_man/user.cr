module LegacyOfMan
  class User
    def initialize(socket : TCPSocket, logger : Logger, username : String)
      @socket = socket
      @logger = logger
      @username = username
    end

    def name : String
      @username
    end

    def autenticated?
      @authenticated
    end

    def check_password
    end
  end
end
