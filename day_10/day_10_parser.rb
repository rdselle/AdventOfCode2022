class Day10Parser
    def initialize
      file = File.open("day_10/test_input")
      @file_data = file.readlines.map(&:chomp)
    end

    def process_data
      @file_data.each do |data|
        puts data
      end
    end
end

parser = Day10Parser.new
parser.process_data