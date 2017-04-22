module LegacyOfMan
  module Map
    class EnvironmentHandler
      def initialize(user : User, room : Map::Room)
        @user = user
        @room = room
      end

      def handle
        loop do
          command = @user.get_command
          status = @room.move(command)
          if @room.at_exit?
            @user << "\r\nyou exit the room"
            break
          elsif status == :ok
            @user << "\r\nNew position: #{@room.placement}\r\n"
          elsif status == :wrong_direction
            @user << "\r\nOnly 'n', 's', 'e', 'w'\r\n"
          elsif status == :max_direction
            @user << "\r\nYou cannot go #{command}, you are at the end of the room"
          end
        end
      end
    end
  end
end
