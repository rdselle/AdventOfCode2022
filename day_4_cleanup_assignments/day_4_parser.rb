require_relative 'Pair'

class Day4Parser
  def initialize
    file = File.open("input")
    @file_data = file.readlines.map(&:chomp)
  end

  def process_data
    total_full_contains = 0

    @file_data.each do |data|
        zones = data.split(",", 2)
        range1 = range_for_zone(zones[0])
        range2 = range_for_zone(zones[1])

        if range1.begin <= range2.begin && range1.end >= range2.end
            total_full_contains += 1
        elsif range2.begin <= range1.begin && range2.end >= range1.end
            total_full_contains += 1
        end
    end

    puts "Total full contains: #{total_full_contains}"
  end

  def process_data_part_2
    total_overlaps = 0

    @file_data.each do |data|
        zones = data.split(",", 2)
        range1 = range_for_zone(zones[0])
        range2 = range_for_zone(zones[1])

        if range2.begin <= range1.end && range2.end >= range1.begin
            total_overlaps += 1
        end 
    end

    puts "Total overlaps: #{total_overlaps}"
  end

  def range_for_zone(zone)
    range_strings = zone.split("-", 2)
    beginning = range_strings[0].to_i
    r_end = range_strings[1].to_i
    (beginning..r_end)
  end
end

parser = Day4Parser.new
parser.process_data
parser.process_data_part_2