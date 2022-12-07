class Day7Parser
    def initialize
      file = File.open("test_input")
      @file_data = file.readlines.map(&:chomp)
      @current_directory = Directory.new(nil, "/")
      @root = @current_directory
    end

    def process_data
      @file_data.each do |data|
        elements = data.split(" ")
        case elements[0]
        when "$"
            process_command(elements)
        when "dir"
            process_directory(elements)
        else
            process_file(elements)
        end
      end

      puts "current directory: #{@current_directory.name}"
      puts "files: #{@current_directory.files}"
      puts "subs: #{@current_directory.directories}"
      puts "size: #{@current_directory.total_size}"
      puts "size less than 100001: #{@current_directory.total_size_lt_100001}"
      puts "----------"
    end

    def process_command(elements)
        case elements[1]
        when "cd"
            if elements[2] == "/"
                @current_directory = @root
            elsif elements[2] == ".."
                @current_directory = @current_directory.parent
            else
                @current_directory = @current_directory.directories[elements[2]]
            end
        when "ls"
            #do nothing
        end
    end

    def process_directory(elements)
        @current_directory.directories[elements[1]] = Directory.new(@current_directory, elements[1])
    end

    def process_file(elements)
        @current_directory.files[elements[1]] = SFile.new(elements[1], elements[0].to_i)
    end
end

class Directory
    attr_accessor :directories, :files
    attr_reader :parent, :name

    def initialize(parent, name)
        @parent = parent
        @name = name
        @directories = {}
        @files = {}
    end

    def total_size_lt_100001
        total = 0
        if total_size < 100001
            total += total_size
        end

        @directories.each_value do |directory|
            total += directory.total_size_lt_100001
        end

        total
    end

    def total_size
        total = 0
        @files.each_value do |file|
            total += file.size
        end
        @directories.each_value do |directory|
            total += directory.total_size
        end
        total
    end
end

class SFile
    attr_reader :name, :size

    def initialize(name, size)
        @name = name
        @size = size
    end
end

parser = Day7Parser.new
parser.process_data