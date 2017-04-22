module LegacyOfMan
  class Tutorial
    def initialize(user : User, logger : Logger)
      @logger = logger
      @room = Map::Room.new(5, 10, [0, 0])
      @user = user
    end

    def start
      @logger.info("Starting tutorial for first time user #{@user.name}")
      @user.socket << <<-EOF
        Welcome to the world of Legacy Of Man, because this is your first time playing we will start off with a tutorial
        to help your get started and have a little feel of the game.
        We created a small room for you to move around in, it's perfectly safe .... we promise :)
      EOF
      @user.socket << @room.gen_map
    end
  end
end
