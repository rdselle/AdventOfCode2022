class Day8Parser
  attr_reader :elves

  def initialize
    file = File.open("input")
    @file_data = file.readlines.map(&:chomp)
    @grid = Grid.new
  end

  def process_data
    treedex = 1
    @file_data.each_with_index do |data, index|
        trees = []
        @grid.number_of_columns ||= data.length
        data.chars.each_with_index do |character, sub_index|
            trees[sub_index] = Tree.new(character.to_i, treedex)
            treedex += 1
            if index == 0 || 
                sub_index == 0 || 
                sub_index == @grid.number_of_columns - 1 ||
                index == @file_data.length - 1
                trees[sub_index].visible = true
            else
                trees[sub_index].visible = false
            end
        end
        @grid.add_row(trees, index)
    end

    puts "initial visible: #{@grid.visible_count}"

    find_visible(@grid)

    puts "total visible: #{@grid.visible_count}"
  end

  def find_visible(grid)
    (1..(grid.number_of_rows - 2)).each do |i|
        row = grid.row_for_index(i)
        reverse = row.reverse
        count_visible(row)
        count_visible(reverse)
    end

    (1..(grid.number_of_columns - 2)).each do |i|
        column = grid.column_for_index(i)
        reverse = column.reverse
        count_visible(column)
        count_visible(reverse)
    end
  end

  def count_visible(trees)
    row_max = 0
    trees.each_with_index do |tree, index|
        if tree.visible == false && tree.height > row_max
            tree.visible = true
        end
        row_max = tree.height if tree.height > row_max
    end
  end
end

class Grid
    attr_accessor :number_of_columns

    def initialize
        @trees_row = []
    end

    def number_of_rows
        @trees_row.length
    end

    def add_row(row, index)
        @trees_row[index] = row
    end

    def visible_count
        total_visible = 0
        @trees_row.each do |row|
            row.each do |tree|
                total_visible += 1 if tree.visible
            end
        end
        total_visible
    end

    def row_for_index(index)
        @trees_row[index]
    end

    def column_for_index(index)
        column = []
        @trees_row.each do |row|
            column << row[index]
        end
        column
    end
end

class Tree
    attr_accessor :height, :visible, :treedex

    def initialize(height, treedex)
        @height = height
        @treedex = treedex
        visible = false
    end
end

parser = Day8Parser.new
parser.process_data