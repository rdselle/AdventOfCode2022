class Day11Parser
    def initialize
      file = File.open("day_11/test_input")
      @file_data = file.readlines.map(&:chomp)
      @monkeys = []
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
          puts "created monkey #{current_monkey.m_id}"
        when "Starting"
          (2..(split.length - 1)).each do |i|
            current_monkey.add_item(split[i].delete_suffix(",").to_i)
          end
        when "Operation:"
          current_monkey.add_operation(split[3], split[4], split[5])
          puts "monkey #{current_monkey.m_id} operation: #{current_monkey.operation}"
        when "Test:"
          current_monkey.test = split.last.to_i
          puts "monkey #{current_monkey.m_id} test: #{current_monkey.test}"
        when "If"
          if split[1] == "true:"
            current_monkey.throw_to_true = split.last.to_i
            puts "monkey #{current_monkey.m_id} throw to true: #{current_monkey.throw_to_true}"
          else
            current_monkey.throw_to_false = split.last.to_i
            puts "monkey #{current_monkey.m_id} throw to false: #{current_monkey.throw_to_false}"
          end
        end
      end
      @monkeys << current_monkey

      @monkeys.each do |monkey|
        monkey.items.each_with_index do |item, i|
          puts "monkey #{monkey.m_id} item #{item} operation result: #{monkey.perform_operation(i)}"
        end
      end
    end
end

class Monkey
  attr_accessor :m_id, :items, :operation, :test, :throw_to_true, :throw_to_false

  def initialize(m_id)
    @m_id = m_id
    @items = []
    @operation = []
    @test = 0
    @throw_to_true = 0
    @throw_to_false = 0
  end

  def add_item(item)
    puts "adding #{item} to monkey #{@m_id}"
    @items << item
  end

  def add_operation(element_1, element_2, element_3)
    @operation = [element_1, element_2, element_3]
  end

  def perform_operation(item_index)
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

    value
  end
end

parser = Day11Parser.new
parser.process_data