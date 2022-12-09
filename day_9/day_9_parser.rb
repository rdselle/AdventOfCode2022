class Day9Parser
    def initialize
      file = File.open("day_9/test_input")
      @file_data = file.readlines.map(&:chomp)
      @instructions = []
      @knots = [Knot.new(Knot.new(nil))]
      1.times do |i|
        new_knot = Knot.new(@knots[i])
        @knots << new_knot
        @knots[i - 1].tail = new_knot
      end
      # puts @knots.length
      # @knots.each do |knot|
      #   puts "knot.  head: #{knot.head}"
      # end
    end

    def process_data
      @file_data.each do |data|
        direction, distance = data.split(" ")
        @instructions << Instruction.new(direction, distance.to_i)
        # puts @instructions
      end

      @instructions.each do |instruction|
        @knots.first.move_head(instruction)
      end

      puts "visited spaces: #{@knots.last.visited_coordinates.keys.count}"
    end
end

class Instruction
  attr_reader :direction, :distance

  def initialize(direction, distance)
    @direction = direction
    @distance = distance
    # puts "#{direction} #{distance}"
  end
end

class Knot
  attr_reader :visited_coordinates, :current_coordinate, :head
  attr_writer :tail

  def initialize(head)
    @current_coordinate = {:x => 0, :y => 0}
    starting_coordinate_id = id_for_coordinate(@current_coordinate)
    @visited_coordinates = {starting_coordinate_id => @current_coordinate}
    @head = head
  end

  def move_head(instruction)
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
      update_position(instruction.direction)
    end
  end

  def update_position(direction)
    # puts "head x: #{@head.current_coordinate[:x]} head y: #{@head.current_coordinate[:y]}"
    if @head.current_coordinate[:x] > @current_coordinate[:x] + 1
      @current_coordinate[:x] += 1
      @current_coordinate[:y] = @head.current_coordinate[:y]
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      @tail.move_head(Instruction.new(direction, 1)) if @tail
    end

    if @head.current_coordinate[:x] < @current_coordinate[:x] - 1
      @current_coordinate[:x] -= 1
      @current_coordinate[:y] = @head.current_coordinate[:y]
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      @tail.move_head(Instruction.new(direction, 1)) if @tail
    end

    if @head.current_coordinate[:y] > @current_coordinate[:y] + 1
      @current_coordinate[:y] += 1
      @current_coordinate[:x] = @head.current_coordinate[:x]
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      @tail.move_head(Instruction.new(direction, 1)) if @tail
    end

    if @head.current_coordinate[:y] < @current_coordinate[:y] - 1
      @current_coordinate[:y] -= 1
      @current_coordinate[:x] = @head.current_coordinate[:x]
      current_id = id_for_coordinate(@current_coordinate)
      @visited_coordinates[current_id] = @current_coordinate
      @tail.move_head(Instruction.new(direction, 1)) if @tail
    end
    # puts "current x: #{@current_coordinate[:x]} current y: #{@current_coordinate[:y]}"
    # puts "-----"
    # @visited_coordinates.each_key do |key|
    #   puts "key: #{key}"
    # end
  end

  def id_for_coordinate(coordinate)
    "#{coordinate[:x]},#{coordinate[:y]}"
  end
end
parser = Day9Parser.new
parser.process_data