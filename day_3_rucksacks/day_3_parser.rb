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
    total2 = 0

    t1 = Time.now
    @groups.each do |group|
      total += process_group(group)
    end
    t2 = Time.now
    puts "Method 1 group time: #{t2 - t1}"

    t3 = Time.now
    @groups.each do |group|
      total2 += process_group_2(group)
    end
    t4 = Time.now
    puts "Method 2 group time: #{t4 - t3}"
    
    puts "total2: #{total2}"

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

  def process_group_2(group)
    #TRASH
    # sack1 = group.rucksacks[0].all_items.sort { |x, y| find_value_for_item(x)<=>find_value_for_item(y) }
    # sack2 = group.rucksacks[1].all_items.sort { |x, y| find_value_for_item(x)<=>find_value_for_item(y) }
    # sack3 = group.rucksacks[2].all_items.sort { |x, y| find_value_for_item(x)<=>find_value_for_item(y) }

    #good stuff
    find_value_for_item((group.rucksacks[0].all_items & group.rucksacks[1].all_items & group.rucksacks[2].all_items).first)
  end

  def sum_rucksack_points
    total = 0

    @rucksacks.each do |rucksack|
      total += find_value_for_item(rucksack.matched_item)
    end

    total
  end

  def find_value_for_item(item)
    ord = item.ord
    if ord < 97
      return ord - 38
    else
      return ord - 96
    end
  end
end

parser = Day3Parser.new
parser.process_data
puts "total for matches: #{parser.sum_rucksack_points}"
puts "total for groups: #{parser.process_groups}"