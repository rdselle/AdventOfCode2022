class Day9Parser
    def initialize
      file = File.open("day_9/input")
      @file_data = file.readlines.map(&:chomp)
    end

    def process_data
      @file_data.each do |data|
        puts data
      end
    end
end

parser = Day9Parser.new
parser.process_data