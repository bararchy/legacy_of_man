module LegacyOfMan
  module Map
    class Room
      def initialize(size_x : Int32, size_y : Int32, placment : Array(Int32))
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
        @placment = placment
      end

      def gen_map : String
        x = "[#]" * @x.size
        room = ""
        @y.size.times do
          room + "#{x}\r\n"
        end
        room
      end
    end
  end
end
