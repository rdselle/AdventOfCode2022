require_relative 'Rucksack'
require_relative 'Group'

class Day3Parser
  def initialize
    file = File.open("day_3_rucksacks/input")
    @file_data = file.readlines.map(&:chomp)
    @rucksacks = []
    @groups = []
  end

  def process_data
    current_group = Group.new
    @file_data.each do |data|
      rucksack = Rucksack.new
      rucksack.process_input(data)
      @rucksacks << rucksack
      current_group.rucksacks << rucksack
      if current_group.rucksacks.count == 3
        @groups << current_group
        current_group = Group.new
      end
    end
  end

  def process_groups
    total = 0

    @groups.each do |group|
      total += process_group(group)
    end

    total
  end

  def process_group(group)
    group.rucksacks[0].all_items.each do |item1|
      group.rucksacks[1].all_items.each do |item2|
        if item1 == item2
          group.rucksacks[2].all_items.each do |item3|
            if item1 == item3
              return find_value_for_item(item1)
            end
          end
        end
      end
    end
  end

  def sum_rucksack_points
    total = 0

    @rucksacks.each do |rucksack|
      total += find_value_for_item(rucksack.matched_item)
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
puts "total for groups: #{parser.process_groups}"