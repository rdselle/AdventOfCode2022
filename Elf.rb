require_relative 'FoodItem'

class Elf
  attr_accessor :food_items

  def initialize
    @food_items = []
  end

  def add_food(food_item)
    food_items << food_item
  end

  def total_calories
    total = 0
    food_items.each { |item| total += item.calories }
    total
  end
end
