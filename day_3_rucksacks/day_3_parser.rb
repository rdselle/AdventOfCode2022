require_relative 'Rucksack'

class Day3Parser
  def initialize
    file = File.open("day_3_rucksacks/input")
    @file_data = file.readlines.map(&:chomp)
    @rucksacks = []
  end

  def process_data
    @file_data.each do |data|
      rucksack = Rucksack.new
      rucksack.process_input(data)
      @rucksacks << rucksack
    end
  end

  def sum_rucksack_points
    total = 0

    @rucksacks.each do |rucksack|
      total += find_value_for_item(rucksack.matched_item)
      # puts "to I: #{rucksack.matched_item.ord} #{rucksack.matched_item}"
      # puts "A: #{"A".ord} a: #{"a".ord} Z: #{"Z".ord} z: #{"z".ord} P: #{"P".ord} p: #{"p".ord}"
    end

    total
  end

  def find_value_for_item(item)
    if item.ord < 97
      return item.ord - 38
    else
      return item.ord - 96
    end
  end
end

parser = Day3Parser.new
parser.process_data
puts "total for matches: #{parser.sum_rucksack_points}"