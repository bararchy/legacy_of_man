module LegacyOfMan
  module Map
    class Room
      setter :placement
      getter :placement

      def initialize(size_x : Int32, size_y : Int32, placement : Array(Int32), exit_p : Array(Int32))
        @y = Array(String).new
        @x = Array(String).new
        block = "[#]"
        size_x.times do
          @x << block
        end
        size_y.times do
          @y << block
        end
        begin
          @x[exit_p[0]]
          @y[exit_p[1]]
        rescue
          raise "Exit is out of bounds of room"
        end
        @exit_p = exit_p
        @placement = placement
      end

      def gen_map : String
        matrix = [] of Array(String)
        @y.size.times do
          matrix << @x.clone
        end
        # matrix 'y' is matrix[y]
        # matrix 'x' is matrix[y][x]
        x, y = @placement
        x2, y2 = @exit_p
        matrix[y][x] = "[X]"
        puts "Exit is at #{@exit_p} matrix is \r\n#{matrix}"
        matrix[y2][x2] = "[E]"
        matrix.reverse
        map = ""
        matrix.each do |line|
          map += "#{line.join}\r\n"
        end
        map
      end

      def move(to : String) : Symbol
        begin
          case to.downcase
          when /(s|south)/
            @y[@placement[1] - 1]
            return :max_direction if @placement[1] - 1 < 0
            @placement[1] -= 1
          when /(n|north)/
            @y[@placement[1] + 1]
            @placement[1] += 1
          when /(e|east)/
            @x[@placement[0] - 1]
            return :max_direction if @placement[0] - 1 < 0
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
