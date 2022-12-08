class Day8Parser
  attr_reader :elves

  def initialize
    file = File.open("test_input")
    @file_data = file.readlines.map(&:chomp)
  end

  def process_data
    @file_data.each do |data|
      puts data
    end
  end
end

parser = Day8Parser.new
parser.process_data