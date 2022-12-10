class Day10Parser
    def initialize
      file = File.open("day_10/input")
      @file_data = file.readlines.map(&:chomp)
      @X = 1
      @cycle = 0
      @strengths = []
      @screen = ""
    end

    def process_data
      @file_data.each do |data|
        input = data.split(" ")
        if input.length == 2
            process_addx(input[1].to_i)
        else
            process_noop
        end
      end

      puts "signal strength sum: #{@strengths.sum}"
      puts @screen
    end

    def process_addx(add)
        execute_cycle
        execute_cycle
        @X += add
    end

    def process_noop
        execute_cycle
    end

    def execute_cycle
        @screen += "\n" if @cycle % 40 == 0
        @cycle += 1
        if [20, 60, 100, 140, 180, 220].include?(@cycle)
            @strengths << @cycle * @X
        end
        @screen += render
    end

    def render
        if (@X..(@X + 2)).include?(@cycle % 40)
            "#"
        else
            "."
        end
    end
end

parser = Day10Parser.new
parser.process_data