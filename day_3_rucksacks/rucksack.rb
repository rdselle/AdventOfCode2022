class Rucksack
  attr_reader :matched_item

  def initialize
    @compartment1 = []
    @compartment2 = []
  end

  def process_input(input)
    items = input.chars
    @compartment1, @compartment2 = items.each_slice(items.size / 2).to_a
    @matched_item = find_match
  end

  def find_match
    @compartment1.each do |item1|
      @compartment2.each do |item2|
        return item1 if item1 == item2
      end
    end
  end
end
