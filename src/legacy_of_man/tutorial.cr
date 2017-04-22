module LegacyOfMan
  class Tutorial
    def initialize(user : User, logger : Logger)
      @logger = logger
      @room = Map::Room.new(5, 10, [0, 0], [5, 5])
      @user = user
    end

    def start
      @logger.info("Starting tutorial for first time user #{@user.name}")
      @user.socket << <<-EOF
        Welcome to the world of Legacy Of Man, because this is your first time playing we will start off with a tutorial
        to help your get started and have a little feel of the game.
        We created a small room for you to move around in, it's perfectly safe .... we promise :)\r\n
      EOF
      @logger.info("Room Map: #{@room.gen_map}")
      @user << "Here is a map of the room you are in: \r\n"
      @user << @room.gen_map
      @user << "\r\nAnd your place in it is: #{@room.placement}\r\n"
      @user << "The place or placement is an X/Y axis, so [0,0] means you are on the x=0 and y=0 'block' in the room\r\n"
      @user << "Or more intuativly, you are on the most southeast part of the room\r\n"
      @user << "to move around you just need to type 'n' for north, 's' for south, 'e' for east and 'w' for west"
      eh = Map::EnvironmentHandler.new(@user, @room)
      eh.handle
    end
  end
end
