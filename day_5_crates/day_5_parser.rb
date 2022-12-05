class Day5Parser
  attr_writer :part2
  
  def initialize
    file = File.open("day_5_crates/input")
    @file_data = file.readlines.map(&:chomp)
    @stacks = []
    @part2 = false
  end

  def process_data
    initial_line_length = @file_data[0].length
    create_stacks((initial_line_length + 1) / 4)
    
    @file_data.each do |data|
      if data.length == initial_line_length
        parse_stack_row(data)
      elsif data.length == initial_line_length -1 || data.length == 0
      #do nothing
      else
        if !@part2
          execute_instruction_row(data)
        else
          execute_instruction_row_part_2(data)
        end  
      end
    end
    heads = ""
    @stacks.length.times do|i|
      heads += @stacks[i][0]
    end
    puts heads
  end
  
  def create_stacks(count)
    count.times do |count|
      @stacks[count] = []
    end
  end
  
  def parse_stack_row(input)
    input.chars.each_with_index do |character, index|
      if character.match?(/[[:alpha:]]/)
        @stacks[(index - 1) / 4] << character
      end
    end
  end
  
  def execute_instruction_row(input)
    split_input = input.split(" ")
    split_input[1].to_i.times do
      character = @stacks[split_input[3].to_i - 1].shift
      @stacks[split_input[5].to_i - 1].prepend(character)
    end
  end
  
  def execute_instruction_row_part_2(input)
    split_input = input.split(" ")
    characters = @stacks[split_input[3].to_i - 1].shift(split_input[1].to_i)
    characters.reverse.each{ |character| @stacks[split_input[5].to_i - 1].prepend(character) }
  end
end

parser = Day5Parser.new
parser.process_data

parser2 = Day5Parser.new
parser2.part2 = true
parser2.process_data