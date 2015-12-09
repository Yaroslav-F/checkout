require 'rails_helper'

RSpec.describe Checkout do
  before(:each) do
    @co = Checkout.new

    @first_product = FactoryGirl.create(:product, price_pennies: 1000)
    @second_product = FactoryGirl.create(:product, price_pennies: 2000)
    @third_product = FactoryGirl.create(:product, price_pennies: 3000)

    @product_rule = FactoryGirl.create(:product_promotion, product: @first_product, quantity: 2, reduced_price_pennies: 900)
    @limit_rule = FactoryGirl.create(:general_limit_promotion, limit_pennies: 9000, over_limit_discount: 10)

    @co.scan(@first_product)
  end

  describe "#initialize" do
    it "creates general limit promotion rules" do
      expect(@co.instance_variable_get(:@general_rules).to_a).to eql([@limit_rule])
    end

    it "creates product promotion rules" do
      expect(@co.instance_variable_get(:@per_product_rules).to_a).to eql([@product_rule])
    end

    it "creates total" do
      expect(@co.instance_variable_get(:@total)).to eql(Money.new(1000))
    end

    it "creates product ids array" do
      expect(@co.instance_variable_get(:@product_ids)).to eql([@first_product.id])
    end
  end

  describe "#scan" do
    it "checks product against per product rules and applies a rule if there's one" do
      @co.scan(@first_product)
      expect(@co.total).to eq(Money.new(1800))
    end

    it "checks product against per product rules and does not apply any rules if there's one" do
      @co.scan(@second_product)
      expect(@co.total).to eq(Money.new(3000))
    end
  end

  describe "#total" do
    it "checks total against general limit rules and applies discount if the limit was reached" do
      @co.scan(@third_product)
      @co.scan(@third_product)
      @co.scan(@third_product)
      expect(@co.total).to eq(Money.new(9000))
    end

    it "checks total against general limit rules and does not apply discount if the limit was not reached" do
      @co.scan(@third_product)
      @co.scan(@third_product)
      expect(@co.total).to eq(Money.new(7000))
    end

    it "checks total against general limit rules and retirns original total if there was no general limit rules" do
      expect(@co.total).to eq(Money.new(1000))
    end
  end

  describe "#apply_discounts" do
    it "applies general limit discount if there is one" do
      expect(@co.send(:apply_discounts, 10)).to eq(Money.new(900))
    end
  end
end