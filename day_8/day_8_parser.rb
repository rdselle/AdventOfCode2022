class Day8Parser
  def initialize
    file = File.open("day_8/input")
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
    
    puts "high score: #{find_highest_score(@grid)}"
  end

  def find_visible(grid)
    (0..(grid.number_of_rows - 1)).each do |i|
        row = grid.row_for_index(i)
        reverse = row.reverse
        count_visible(row, false, false)
        count_visible(reverse, false, true)
    end

    (0..(grid.number_of_columns - 1)).each do |i|
        column = grid.column_for_index(i)
        reverse = column.reverse
        count_visible(column, true, false)
        count_visible(reverse, true, true)
    end
  end

  def count_visible(trees, column, reverse)
    row_max = 0
    trees.each_with_index do |tree, index|
      if column
        if reverse
          tree.reverse_column = simple_trees(trees)
          tree.reverse_column_index = index
        else
          tree.column = simple_trees(trees)
          tree.column_index = index
        end
      else
        if reverse
          tree.reverse_row = simple_trees(trees)
          tree.reverse_row_index = index
        else
          tree.row = simple_trees(trees)
          tree.row_index = index
        end
      end
      
      if tree.visible == false && tree.height > row_max
          tree.visible = true
      end
      row_max = tree.height if tree.height > row_max
    end
  end
  
  def simple_trees(trees)
    return_trees = []
    trees.each do |tree|
      return_trees << SimpleTree.new(tree.height)
    end
    return_trees
  end
  
  def find_highest_score(grid)
    highest_score = 0
    grid.trees_row.each do |row|
      row.each do |tree|
        highest_score = tree.view_score if tree.view_score > highest_score
      end 
    end
    highest_score
  end
end

class Grid
    attr_accessor :number_of_columns, :trees_row

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
    attr_accessor :height, :visible 
    attr_writer :treedex, :column, :column_index, :row, :row_index, :reverse_column, :reverse_column_index, :reverse_row, :reverse_row_index

    def initialize(height, treedex)
        @height = height
        @treedex = treedex
        visible = false
    end
  
    def view_score
      score_for(@column, @column_index) * score_for(@row, @row_index) * score_for(@reverse_column, @reverse_column_index) * score_for(@reverse_row, @reverse_row_index)
    end
  
    private
  
    def score_for(trees, index)
      score = 0
      while index < trees.length - 1
        score += 1
        if index + 1 < trees.length && trees[index + 1].height < @height
          index += 1
        else
          break
        end
      end
      score
    end
end

class SimpleTree
  attr_reader :height
  def initialize(height)
    @height = height
  end
end

t1 = Time.now
parser = Day8Parser.new
parser.process_data
t2 = Time.now
puts "time: #{t2 - t1}"