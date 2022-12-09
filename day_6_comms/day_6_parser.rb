class Day6Parser
    def initialize
      file = File.open("day_6_comms/input")
      @file_data = file.readlines.map(&:chomp)
    end

    def process_data
      @file_data.each do |data|
        process_line(data, 14)
      end
    end

    def process_line(line, count_to_check)
      processor = count_to_check - 1
      index = processor
      characters = line.chars
      characters.each_with_index do |character, index|
        next if index < processor

        characters_to_check = [character]
        matched = false
        processor.times do |i|
          if characters_to_check.include?(characters[index - i - 1])
            matched = true
          else
            characters_to_check << characters[index - i - 1]
          end
        end

        if !matched
          puts "message starting at #{index + 1}"
          break
        end
      end
    end
end

parser = Day6Parser.new
parser.process_data