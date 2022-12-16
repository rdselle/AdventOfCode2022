class Day11Parser
    def initialize
      file = File.open("day_11/input")
      @file_data = file.readlines.map(&:chomp)
      @monkeys = []
      @lcm = 1
    end

    def process_data
      current_monkey = nil
      @file_data.each do |data|
        if data.length == 0
          @monkeys << current_monkey
          next
        end

        split = data.split(" ")
        case split[0]
        when "Monkey"
          current_monkey = Monkey.new(split[1].chars[0].to_i)
        when "Starting"
          (2..(split.length - 1)).each do |i|
            current_monkey.add_item(split[i].delete_suffix(",").to_i)
          end
        when "Operation:"
          current_monkey.add_operation(split[3], split[4], split[5])
        when "Test:"
          current_monkey.test = split.last.to_i
        when "If"
          if split[1] == "true:"
            current_monkey.throw_to_true = split.last.to_i
          else
            current_monkey.throw_to_false = split.last.to_i
          end
        end
      end
      @monkeys << current_monkey
      
      @monkeys.each { |monkey| @lcm *= monkey.test }
    end

    def perform_rounds
      #part 1
      # (1..20).each do |i|
      #part 2
      (1..10000).each do |i|
        @monkeys.each do |monkey|
          monkey.items.each_with_index do |item, i|
            inspected_worry = monkey.perform_inspection(i)
            inspected_worry %= @lcm
            if inspected_worry % monkey.test == 0
              @monkeys[monkey.throw_to_true].add_item(inspected_worry)
            else
              @monkeys[monkey.throw_to_false].add_item(inspected_worry)
            end
          end
          monkey.items = []
        end
      end
    end

    def monkey_business
      @monkeys.sort! { |x, y| y.inspection_count <=> x.inspection_count}
      @monkeys.each do |monkey|
        puts "monkey #{monkey.m_id} inspected #{monkey.inspection_count} items"
      end
      @monkeys[0].inspection_count * @monkeys[1].inspection_count
    end
end

class Monkey
  attr_accessor :m_id, :items, :operation, :test, :throw_to_true, :throw_to_false, :inspection_count

  def initialize(m_id)
    @m_id = m_id
    @items = []
    @operation = []
    @test = 0
    @throw_to_true = 0
    @throw_to_false = 0
    @inspection_count = 0
  end

  def add_item(item)
    @items << item
  end

  def add_operation(element_1, element_2, element_3)
    @operation = [element_1, element_2, element_3]
  end

  def perform_inspection(item_index)
    @inspection_count += 1
    value = 0
    left = @operation[0] == "old" ? @items[item_index] : @operation[0].to_i
    operator = @operation[1]
    right = @operation[2] == "old" ? @items[item_index] : @operation[2].to_i

    case operator
    when "+"
      value = left + right
    when "*"
      value = left * right
    end

    #part 1
    # value / 3

    #part 2
    value
  end
end

parser = Day11Parser.new
parser.process_data
parser.perform_rounds
puts "total monkey business: #{parser.monkey_business}"