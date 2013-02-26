require 'spec_helper'

describe Checkout do
  before(:all) do
    @rules = Rule.new [{:item => 'fr1', :count => 2, :discount => 100}]
    @rules.add_rule({:item => 'sr1', :count => 3, :discount => 10, :apply_each => true})

    @items = Product.new({fr1: {name: "Fruit tea", price: 311}})
    @items.add_item({sr1: {name: "Strawberries", price: 500}})
    @items.add_item({cf1: {name: "Coffee", price: 1123}})
  end

  it "should discount the second fruit tea" do
    co = Checkout.new(@rules, @items)
    co.scan(:fr1)
    co.scan(:sr1)
    co.scan(:fr1)
    co.scan(:cf1)
    co.total.should == 19.34
  end

  context "when purchasing two fruit teas" do
    it "should discount the second fruit tea" do
      co = Checkout.new(@rules, @items)
      co.scan(:fr1)
      co.scan(:fr1)
      co.total.should == 3.11
    end
  end

  context "when purchasing three Strawberries, Fruit tea, and Coffee" do
    it "should" do
      co = Checkout.new(@rules, @items)
      co.scan(:sr1)
      co.scan(:sr1)
      co.scan(:fr1)
      co.scan(:sr1)
      co.total.should == 16.61
    end
  end

  it "should bulk discount the Strawberreis and second Fruit tea" do
    co = Checkout.new(@rules, @items)
    co.scan(:fr1)
    co.scan(:sr1)
    co.scan(:sr1)
    co.scan(:fr1)
    co.scan(:sr1)
    co.scan(:sr1)
    co.total.should == 21.11
  end


  it "should not apply any discounts" do
    co = Checkout.new(@rules, @items)
    co.scan(:fr1)
    co.scan(:sr1)
    co.scan(:cf1)
    co.total.should == 19.34
  end

end
