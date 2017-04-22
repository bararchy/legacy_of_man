module LegacyOfMan
  module Map
    class Room
      setter :placement
      getter :placement

      def initialize(size_x : Int32, size_y : Int32, placement : Array(Int32), exit_p : Array(Int32))
        @y = Array(Int32).new
        @x = Array(Int32).new
        num = 0
        size_x.times do
          @x << num
          num += 1
        end
        num = 0
        size_y.times do
          @y << num
          num += 1
        end
        @exit_p = exit_p
        @placement = placement
      end

      def gen_map : String
        x = "[#]" * @x.size
        room = ""
        @y.size.times do
          room += "#{x}\r\n"
        end
        room
      end

      def move(to : String) : Symbol
        begin
          case to.downcase
          when /(s|south)/
            @y[@placement[1] - 1]
            @placement[1] -= 1
          when /(n|north)/
            @y[@placement[1] + 1]
            @placement[1] += 1
          when /(e|east)/
            @x[@placement[0] - 1]
            @placement[0] -= 1
          when /(w|west)/
            @x[@placement[0] + 1]
            @placement[0] += 1
          else
            :wrong_direction
          end
          :ok
        rescue Exception
          :max_direction
        end
      end

      def at_exit? : Bool
        @placement == @exit_p
      end
    end
  end
end
