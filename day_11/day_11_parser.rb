class Day11Parser
    def initialize
      file = File.open("day_11/test_input")
      @file_data = file.readlines.map(&:chomp)
    end

    def process_data
      @file_data.each do |data|
        puts data
      end
    end
end

parser = Day11Parser.new
parser.process_data