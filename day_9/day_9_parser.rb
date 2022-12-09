class Day9Parser
    def initialize
      file = File.open("day_9/input")
      @file_data = file.readlines.map(&:chomp)
      @instructions = []
      @knots = [Knot.new(Knot.new(nil))]
      8.times do |i|
        new_knot = Knot.new(@knots[i])
        @knots << new_knot
        @knots[i].tail = new_knot
      end
    end

    def process_data
      @file_data.each do |data|
        direction, distance = data.split(" ")
        @instructions << Instruction.new(direction, distance.to_i)
      end

      @instructions.each do |instruction|
        @knots.first.move_head(instruction, @knots)
        # @knots.last.visited_coordinates.each_key do |key|
        #   puts key
        # end
      end

      puts "visited spaces: #{@knots.last.visited_coordinates.keys.count}"
      
      @knots.each do |knot|
        puts "#{@knots.find_index(knot)} visited #{knot.visited_coordinates.keys.count} spaces"
      end
      # @knots.last.visited_coordinates.each_key do |key|
      #   puts key
      # end
    end
end

class Instruction
  attr_reader :direction, :distance

  def initialize(direction, distance)
    @direction = direction
    @distance = distance
  end
end

class Knot
  attr_reader :visited_coordinates, :current_coordinate, :head
  attr_accessor :tail

  def initialize(head)
    @current_coordinate = {:x => 0, :y => 0}
    starting_coordinate_id = id_for_coordinate(@current_coordinate)
    @visited_coordinates = {starting_coordinate_id => @current_coordinate}
    @head = head
  end

  def move_head(instruction, knots)
    instruction.distance.times do 
      case instruction.direction
      when "R"
        @head.current_coordinate[:x] += 1
      when "L"
        @head.current_coordinate[:x] -= 1
      when "U"
        @head.current_coordinate[:y] += 1
      when "D"
        @head.current_coordinate[:y] -= 1
      end
      update_position(instruction.direction, knots)
    end

    puts "finished instruction"
    # knots.each do |knot|
    #   puts "knot current: #{knot.current_coordinate[:x]}, #{knot.current_coordinate[:y]}"
      # puts "knot's head current: #{knot.head.current_coordinate[:x]}, #{knot.head.current_coordinate[:y]}"
      # puts "knot's tail current: #{knot.tail.current_coordinate[:x]}, #{knot.tail.current_coordinate[:y]}" if knot.tail
    # end
    puts "-----"
    puts ""
  end

  def update_position(direction, knots)
    # puts "calling update with #{direction} on #{knots.find_index(self)}.  tail is #{knots.find_index(@tail)}"
    # puts "current x: #{@current_coordinate[:x]} current y: #{@current_coordinate[:y]}"
    # puts "head x:    #{@head.current_coordinate[:x]} head y:    #{@head.current_coordinate[:y]}"
    # puts ""
    # puts ""
    puts "-----" if knots.find_index(self) == 0

    # puts "head x: #{@head.current_coordinate[:x]} head y: #{@head.current_coordinate[:y]}"

    if @head.current_coordinate[:x] == @current_coordinate[:x] + 2 &&
      @head.current_coordinate[:y] == @current_coordinate[:y] + 2
      puts "diagonal"
      @current_coordinate[:x] += 1
      @current_coordinate[:y] += 1
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      @tail.update_position(direction) if @tail
    end

    if @head.current_coordinate[:x] == @current_coordinate[:x] + 2 &&
      @head.current_coordinate[:y] == @current_coordinate[:y] - 2
      puts "diagonal"
      @current_coordinate[:x] += 1
      @current_coordinate[:y] -= 1
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      @tail.update_position(direction) if @tail
    end

    if @head.current_coordinate[:x] == @current_coordinate[:x] - 2 &&
      @head.current_coordinate[:y] == @current_coordinate[:y] - 2
      puts "diagonal"
      @current_coordinate[:x] -= 1
      @current_coordinate[:y] -= 1
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      @tail.update_position(direction) if @tail
    end

    if @head.current_coordinate[:x] == @current_coordinate[:x] - 2 &&
      @head.current_coordinate[:y] == @current_coordinate[:y] + 2
      puts "diagonal"
      @current_coordinate[:x] -= 1
      @current_coordinate[:y] += 1
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      @tail.update_position(direction) if @tail
    end

    if @head.current_coordinate[:x] > @current_coordinate[:x] + 1
      @current_coordinate[:x] += 1
      @current_coordinate[:y] = @head.current_coordinate[:y]
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      puts "moved knot #{knots.find_index(self)} to #{id_for_coordinate(@current_coordinate)}"
      @tail.update_position(direction, knots) if @tail
    end

    if @head.current_coordinate[:x] < @current_coordinate[:x] - 1
      @current_coordinate[:x] -= 1
      @current_coordinate[:y] = @head.current_coordinate[:y]
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      puts "moved knot #{knots.find_index(self)} to #{id_for_coordinate(@current_coordinate)}"
      @tail.update_position(direction, knots) if @tail
    end

    if @head.current_coordinate[:y] > @current_coordinate[:y] + 1
      @current_coordinate[:y] += 1
      @current_coordinate[:x] = @head.current_coordinate[:x]
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      puts "moved knot #{knots.find_index(self)} to #{id_for_coordinate(@current_coordinate)}"
      @tail.update_position(direction, knots) if @tail
    end

    if @head.current_coordinate[:y] < @current_coordinate[:y] - 1
      @current_coordinate[:y] -= 1
      @current_coordinate[:x] = @head.current_coordinate[:x]
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      puts "moved knot #{knots.find_index(self)} to #{id_for_coordinate(@current_coordinate)}"
      @tail.update_position(direction, knots) if @tail
    end
  end

  def id_for_coordinate(coordinate)
    "#{coordinate[:x]},#{coordinate[:y]}"
  end
end
parser = Day9Parser.new
parser.process_data