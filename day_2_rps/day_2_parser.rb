CHOICE = {
  rock: 1,
  paper: 2,
  scissors: 3,
  unknown: 4
}

class Day2Parser
  attr_reader :elves

  def initialize
    file = File.open("day_2_rps/input")
    @file_data = file.readlines.map(&:chomp)
  end

  def process_data
    total = 0

    @file_data.each do |data|
      total += choice_points(data)
      total += outcome_points(data)
    end

    puts "Total: #{total}"
  end

  def process_data_modified
    total = 0

    @file_data.each do |data|
      modified_data = convert_input(data)
      total += choice_points(modified_data)
      total += outcome_points(modified_data)
    end

    puts "Modified total: #{total}"
  end

  def convert_input(input)
    return "#{input[0]} #{convert_from_a_to_x(input[0])}" if input[2] == "Y"

    case input[2]
    when "X"
      case input[0]
      when "A"
        return "#{input[0]} Z"
      when "B"
        return "#{input[0]} X"
      when "C"
        return "#{input[0]} Y"
      else
        puts "invalid convert_input input"
        return ""
      end
    when "Z"
      case input[0]
      when "A"
        return "#{input[0]} Y"
      when "B"
        return "#{input[0]} Z"
      when "C"
        return "#{input[0]} X"
      else
        puts "invalid convert_input input"
        return ""
      end
    else
      puts "invalid convert_input input"
      return ""
    end
  end

  def convert_from_a_to_x(input)
    case input
    when "A"
      return "X"
    when "B"
      return "Y"
    when "C"
      return "Z"
    else
      puts "invalid convert_from_a_to_x input"
      return " "
    end
  end

  def choice_points(input)
    case input[2]
    when "X"
      return 1
    when "Y"
      return 2
    when "Z"
      return 3
    else
      puts "invalid input to choice_points: #{input}"
      return 0
    end
  end

  def outcome_points(input)
    opponent_choice = find_choice(input[0])
    my_choice = find_choice(input[2])

    return 3 if my_choice == opponent_choice

    case my_choice
    when 1
      return opponent_choice == 3 ? 6 : 0
    when 2
      return opponent_choice == 1 ? 6 : 0
    when 3
      return opponent_choice == 2 ? 6 : 0
    else
      puts "invalid my_choice"
      return 0
    end
  end

  def find_choice(input)
    case input
    when "X", "A"
      return CHOICE[:rock]
    when "Y", "B"
      return CHOICE[:paper]
    when "Z", "C"
      return CHOICE[:scissors]
    else
      puts "invalid input to find_choice"
      return CHOICE[:unknown]
    end
  end

  def find_modified_choice(opponent_choice, input)

  end
end

parser = Day2Parser.new
parser.process_data
parser.process_data_modified