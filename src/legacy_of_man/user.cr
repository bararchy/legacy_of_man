require "json"

module LegacyOfMan
  class User
    def initialize(socket : TCPSocket, logger : Logger, username : String, config : Config)
      @socket = socket
      @logger = logger
      @username = username
      @config = config
      @user_data = load_data.as CharData
    end

    def char_sheet
      <<-EOF
        Name: #{@username}
        Level: #{@user_data.level}
        Items: #{@user_data.items}
        Skills: #{@user_data.skills}
        Equipment: #{@user_data.equipment}
        Stats: #{@user_data.stats}
      EOF
    end

    def name : String
      @username
    end

    def data : CharData
      @user_data
    end

    def socket : TCPSocket
      @socket
    end

    def <<(data : String)
      @socket << data
    end

    def load_data : CharData
      @logger.info("Loading char data for user: #{@username}")
      user_data = false
      DB.open "mysql://#{@config.db_user}@#{@config.db_ip}/#{@config.db_name}" do |db|
        user_data = db.scalar "select data from users where username = '#{@username}';" rescue false
      end
      if user_data.is_a? String
        CharData.from_json(user_data)
      else
        raise "Cannot load user data for: #{@username}"
      end
    end
  end
end
