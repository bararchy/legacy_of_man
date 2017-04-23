require "crypto/bcrypt"

module LegacyOfMan
  class ClientHandler
    def initialize(socket : TCPSocket, logger : Logger, config : Config)
      @socket = socket
      @logger = logger
      @config = config
      @salt = File.read(".salt.secret")
    end

    def handle
      begin
        welcome
      rescue e : Exception
        @logger.error("Error in client ClientHandler: #{e}")
      ensure
        @socket.close
      end
    end

    def welcome
      @socket << welcome_message
      username = read_s(@socket)
      unless user_exists?(username)
        create_user(username)
        return
      end
      unless verify_user(username)
        @socket << "\r\nWrong password for username #{username} !"
        raise "Incorrect login from #{username}"
      end
      user = User.new(@socket, @logger, username, @config)
      @socket << user.char_sheet
      if user.data.firstime
        @logger.info("#{user.name} is a first-timer, sending to tutorial")
        t = Tutorial.new(user, @logger)
        t.start
      else
        @logger.info("#{user.name} is an old player, sending to game")
        # Send to game
      end
      @logger.info("The user #{user.name} has identified")
    end

    def welcome_message : String
      <<-EOF
      #{"\r\n" * 50}Welcome to Legacy of Man\r\n
      Current server version is: #{LegacyOfMan::VERSION}\r\n
      Please Enter your username: 
      EOF
    end

    def user_exists?(username : String) : Bool
      rows = true
      DB.open "mysql://#{@config.db_user}@#{@config.db_ip}/#{@config.db_name}" do |db|
        @logger.info("Looking for user #{username}")
        rows = db.scalar "select username from users where username = '#{username}';" rescue false
        @logger.info("return: #{rows}")
        return false if rows == false
        rows = true
      end
      rows
    end

    def verify_user(username : String) : Bool
      @socket << "\r\nPlease enter your password: "
      password = read_s(@socket)
      hashed = Crypto::Bcrypt.new(password, @salt, cost = 11)
      rows = true
      DB.open "mysql://#{@config.db_user}@#{@config.db_ip}/#{@config.db_name}" do |db|
        rows = db.scalar "select username from users where username = '#{username}' and password = '#{hashed}';" rescue false
      end
      return rows == false ? false : true
    end

    def create_user(username : String)
      @logger.info("A new user has been detected, registering now")
      @socket << "\r\nAs we cannot find your username we presume you are a new user\r\n"
      @socket << "Please enter the password that you would like to use: "
      user_password = read_s(@socket)
      @socket << "\r\nplease verify your password again: "
      user_password_two = read_s(@socket)
      unless user_password_two == user_password && !user_password.to_s.empty?
        @socket << "Passwords doesn't match !"
        raise "Error creating new user: Password doesn't match"
      end
      @socket << "\r\nPlease enter your email address (only will be used for password recovery): "
      email = read_s(@socket)
      if email.to_s.empty?
        @socket << "Cannot accept empty email !"
        raise "Error creating new user: empty email"
      end
      @logger.info("Creating new user in DB")
      DB.open "mysql://#{@config.db_user}@#{@config.db_ip}/#{@config.db_name}" do |db|
        db.exec "INSERT INTO users (username, password, email, data) VALUES ('#{username}', '#{Crypto::Bcrypt.new(user_password, @salt, cost = 11)}', '#{email}', '#{genereate_new_char_data}');"
      end
      @logger.info("New user #{username} has been created")
      @socket << "User created, please relogin with your new user and password"
    end

    def genereate_new_char_data : String
      <<-EOF
      {
        "firstime": true,
        "level": 1,
        "items": {},
        "skills": {"basic_attack": 1},
        "equipment": {"worn clothes": "body"},
        "stats": {
          "intelligence": 5,
          "strength": 5,
          "agility": 5
        }
      }
      EOF
    end
  end
end
