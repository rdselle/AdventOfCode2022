require_relative 'File'

class Directory
    attr_accessor :directories, :files
    attr_reader :parent

    def initialize(parent)
        @parent = parent
        @directories = []
        @files = []
    end
end