module LegacyOfMan
  class ClientHandler
    def initialize(client : TCPSocket, logger : Logger)
      @client = client
      @logger = logger
    end

    def handle
      welcome
      @client.close
    end

    def welcome
      @client << welcome_message
      username = read(1024)
      user = User.new(@client, @logger, username)
      @logger.info("The user #{user.name} has identifed")
    end

    def welcome_message : String
      <<-EOF
      Welcome to Legacy of Man\r\n
      Current server version is: #{LegacyOfMan::VERSION}\r\n
      Please Enter your username: 
      EOF
    end

    def read(bytes : Int32) : String
      data = Bytes.new(bytes)
      bytes_read = @client.read(data)
      String.new(data[0, bytes_read])
    end
  end
end
