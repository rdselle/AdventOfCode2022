require_relative 'Elf'

file = File.open("input")
file_data = file.readlines.map(&:chomp)

current_elf = Elf.new()
elves = [current_elf]

file_data.each do |data|
  if data.length == 0
    elves << current_elf
    current_elf = Elf.new()
  else
    current_elf.add_food(FoodItem.new(data.to_i))
  end
end
elves << current_elf

elves.sort_by!(&:total_calories)
elves.reverse!

elves.each { |elf| puts elf.total_calories }

puts elves[0].total_calories + elves[1].total_calories + elves[2].total_calories