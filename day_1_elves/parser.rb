require_relative 'Elf'

class Parser
  attr_reader :elves

  def initialize
    file = File.open("day_1_elves/input")
    @file_data = file.readlines.map(&:chomp)
  end

  def process_data
    current_elf = Elf.new
    @elves = [current_elf]

    @file_data.each do |data|
      if data.length == 0
        @elves << current_elf
        current_elf = Elf.new
      else
        current_elf.add_food(FoodItem.new(data.to_i))
      end
    end
    @elves << current_elf

    @elves.sort_by!(&:total_calories)
    @elves.reverse!
  end

  def top_elf_calories
    @elves[0].total_calories
  end

  def top_three_elf_calories
    @elves[0].total_calories + @elves[1].total_calories + @elves[2].total_calories
  end
end

parser = Parser.new
parser.process_data
puts "Top calories: #{parser.top_elf_calories}"
puts "Top three calories: #{parser.top_three_elf_calories}"