ITEM = {
  rock: 1,
  paper: 2,
  scissors: 3
}

class Day2ParserLL
  def initialize
    file = File.open("day_2_rps/input")
    @file_data = file.readlines.map(&:chomp)
  end

  def process_data_part_1
    total = 0

    @file_data.each do |data|
      opponent = find_choice(data[0])
      my_choice = Item.new(find_choice(data[2]))

      total += my_choice.choice_points
      total += my_choice.match_points(opponent)
    end

    total
  end

  def process_data_part_2
    total = 0

    @file_data.each do |data|
      opponent = Item.new(find_choice(data[0]))
      my_choice = Item.new(find_choice_part_2(data[2], opponent))

      total += my_choice.choice_points
      total += my_choice.match_points(opponent.type)
    end

    total
  end

  def find_choice(input)
    case input
    when "X", "A"
      return ITEM[:rock]
    when "Y", "B"
      return ITEM[:paper]
    when "Z", "C"
      return ITEM[:scissors]
    else
      puts "invalid input to find_choice"
    end
  end

  def find_choice_part_2(input, opponent)
    case input
    when "X"
      opponent.beats
    when "Y"
      opponent.type
    when "Z"
      opponent.loses_to
    else
      puts "invalid find_choice_part_2 input"
    end
  end
end

class Item
  attr_accessor :beats, :loses_to
  attr_reader :type

  def initialize(item)
    @type = item
    case @type
    when ITEM[:rock]
      @beats = ITEM[:scissors]
      @loses_to = ITEM[:paper]
    when ITEM[:paper]
      @beats = ITEM[:rock]
      @loses_to = ITEM[:scissors]
    when ITEM[:scissors]
      @beats = ITEM[:paper]
      @loses_to = ITEM[:rock]
    else
      puts "invalid item initializer input"
    end
  end

  def choice_points
    @type
  end

  def match_points(opponent)
    case opponent
    when @beats
      6
    when @loses_to
      0
    when @type
      3
    else
      puts "invalid match_points input"
    end
  end
end

parser = Day2ParserLL.new
puts "Part 1: #{parser.process_data_part_1}"
puts "Part 2: #{parser.process_data_part_2}"