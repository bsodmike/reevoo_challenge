require_relative 'rule'
require_relative 'product'
require 'pry'

class Checkout
  def initialize(rules, items)
    @rules = rules
    @items = items
    @basket = []
  end

  def scan(item_code)
    price = @items.find(item_code.to_sym)[:price]
    @basket << {item: item_code.to_s, op: "DR", amount: price}
  end

  def total
    apply_discounts
    total = 0.00
    @basket.flatten.each do |transaction|
      if transaction[:op] == "DR"
        total += transaction[:amount]
      elsif transaction[:op] == "CR"
        total -= transaction[:amount]
      end
    end
    total/100
  end

  def basket
    @basket
  end

  private
  def scan_multiples
    tree = {}
    @basket.each do |transaction|
      key = :"#{transaction[:item]}"
      if tree.has_key?(key)
        tree[key] = tree[key] << transaction
      else
        tree = tree.merge({ :"#{transaction[:item]}" => [transaction]})
      end
    end
    tree
  end

  def apply_discounts
    @rules.all.each do |rule|
      item_code = rule[:item].to_sym
      count = rule[:count]
      discount = rule[:discount]
      if !scan_multiples[item_code].nil? && scan_multiples[item_code].size >= count
        if rule[:apply_each] == true
          scan_multiples[item_code].size.times do
            @basket << {item: item_code.to_s, op: "CR", amount: (@items.find(item_code)[:price] * (discount/100.0)).floor}
          end
        elsif rule[:apply_multiple] == true
          (scan_multiples[item_code].size / count).times do
            @basket << {item: item_code.to_s, op: "CR", amount: (@items.find(item_code)[:price] * (discount/100.0)).floor}
          end
        else
          @basket << {item: item_code.to_s, op: "CR", amount: (@items.find(item_code)[:price] * (discount/100.0)).floor}
        end
      end
    end
  end
end


