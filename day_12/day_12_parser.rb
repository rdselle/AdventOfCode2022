class Day12Parser
    attr_accessor :locations, :start

    def initialize
      file = File.open("day_12/test_input")
      @file_data = file.readlines.map(&:chomp)
      @width = @file_data[0].chars.length
      @height = @file_data.length
      puts "#{@width} x #{@height}"
      @locations = Array.new(@width){Array.new(@height)}
      @end_found = false
      @absolute_step_counter = 0
    end

    def process_data
      @file_data.each_with_index do |data, row_index|
        data.chars.each_with_index do |char, column_index|
            new_location = nil
            case char
            when "S"
                new_location = Location.new(height_for("a"), {x: column_index, y: row_index})
                @start = new_location
            when "E"
                new_location = Location.new(height_for("z"), {x: column_index, y: row_index})
                new_location.goal = true
            else
                new_location = Location.new(height_for(char), {x: column_index, y: row_index})
            end
            add_location(new_location)
        end
      end

      puts "locations #{@locations.length} #{@locations[0].length}"
      puts "width #{@width} height #{@height}"
    end

    def height_for(char)
        char.ord - 96
    end

    def traverse_map(location, path)
        location.visited = true
        # puts "adding location #{location.coordinates} to"
        # path.steps.each_with_index do |step, index|
        #     puts "step #{index} #{step.coordinates}"
        # end
        path.steps << location
        if !@end_found
            if location.coordinates[:x] > 0
                puts "x - 1, y: #{@locations[location.coordinates[:x] - 1][location.coordinates[:y]].coordinates}, steps: #{path.steps.length}"

                new_path = Path.new(path.steps)
                process_next(location.height, @locations[location.coordinates[:x] - 1][location.coordinates[:y]], new_path)
            end

            if location.coordinates[:x] < @width - 1
                puts "x + 1, y: #{@locations[location.coordinates[:x] + 1][location.coordinates[:y]].coordinates}, steps: #{path.steps.length}"

                new_path = Path.new(path.steps)
                process_next(location.height, @locations[location.coordinates[:x] + 1][location.coordinates[:y]], new_path)
            end

            if location.coordinates[:y] > 0
                puts "x, y - 1: #{@locations[location.coordinates[:x]][location.coordinates[:y] - 1].coordinates}, steps: #{path.steps.length}"

                new_path = Path.new(path.steps)
                process_next(location.height, @locations[location.coordinates[:x]][location.coordinates[:y] - 1], new_path)
            end

            if location.coordinates[:y] < @height - 1
                puts "x, y + 1: #{@locations[location.coordinates[:x]][location.coordinates[:y] + 1].coordinates}, steps: #{path.steps.length}"

                new_path = Path.new(path.steps)
                process_next(location.height, @locations[location.coordinates[:x]][location.coordinates[:y] + 1], new_path)
            end
        end
    end

    def process_next(current_height, new_location, path)
        @absolute_step_counter += 1

        if new_location.height <= current_height + 1  && !path.steps.include?(new_location)
            if new_location.goal
                path.steps << new_location
                puts "we won in #{path.steps.length} steps #{new_location.coordinates}"
                # path.steps.each_with_index do |step, index|
                #     puts "step #{index}: #{step.coordinates} #{step.height}"
                # end
                # @end_found = true
            else new_location.height <= current_height + 1  && !path.steps.include?(new_location)
                # puts "traversing to #{new_location.coordinates} #{new_location.height} from #{path.steps.last.coordinates} #{current_height}"
                traverse_map(new_location, path)
            end
        else
            # puts "didn't step.  #{@absolute_step_counter}"
            # path.steps.each_with_index do |step, index|
            #     puts "step #{index}: #{step.coordinates} #{step.height}"
            # end
            # puts "dead end.  going from #{current_height} to #{new_location.height}"
        end
    end

    def add_location(location)
        @locations[location.coordinates[:x]][location.coordinates[:y]] = location
    end
end

class Path
    attr_accessor :steps

    def initialize(steps)
        @steps = steps
    end
end

class Location
    attr_accessor :coordinates, :visited, :goal, :height

    def initialize(height, coordinates)
        @height = height
        @coordinates = coordinates
        @visited = false
        @goal = false
    end

    def ==(other_object)
        return @coordinates[:x] == other_object.coordinates[:x] && @coordinates[:y] == other_object.coordinates[:y]
    end
end

parser = Day12Parser.new
parser.process_data
# parser.locations.each do |row|
#     row.each do |location|
#         puts "height: #{location.height}"
#     end
# end
parser.traverse_map(parser.start, Path.new([]))