module LegacyOfMan
  class Tutorial
    def initialize(user : User, logger : Logger)
      @logger = logger
      @room = Map::Room.new(5, 10, [0, 0], [4, 5])
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
      @user << "\r\nYour place in it is marked as [X] and the room Exit is marked with [E]"
      @user << "When you move to the Exit ([E]) block you will exit the room"
      @user << "to move around you just need to type 'n' for north, 's' for south, 'e' for east and 'w' for west"
      eh = Map::EnvironmentHandler.new(@user, @room)
      eh.handle
    end
  end
end
