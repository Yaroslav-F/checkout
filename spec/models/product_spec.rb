require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @product = FactoryGirl.create(:product, price_pennies: 1000)
  end

  describe "#pricing_delta" do
    it "calculates delta between current and reduced prices" do
      reduced_price = Money.new(800)

      expect(@product.send(:pricing_delta, reduced_price)).to eq(Money.new(200))
    end

    it "calculate new delta using new discounted price" do
      quantity = 3
      reduced_price = Money.new(800)
      new_reduced_price = Money.new(700)
      @product.calculate_pricing_delta(quantity, reduced_price)

      expect(@product.send(:pricing_delta, new_reduced_price)).to eq(Money.new(100))
    end
  end

  describe "#calculate_pricing_delta" do
    before(:each) do
      @quantity = 3
      @reduced_price = Money.new(700)
    end

    it "reduces current price by delta" do
      expect(@product.calculate_pricing_delta(@quantity, @reduced_price)).to eq(Money.new(100))
    end

    it "calculates new delta from reduced price, not the original one" do
      @product.calculate_pricing_delta(@quantity, @reduced_price)

      expect(@product.send(:pricing_delta, Money.new(600))).to eq(Money.new(100))
      expect(@product.calculate_pricing_delta(@quantity, Money.new(600))).to eq(Money.new(400))
    end
  end

  describe "#check_price" do
    before(:each) do
      @quantity = 3
      @reduced_price = Money.new(700)
    end

    it "returns products original price when there was no discount" do
      expect(@product.check_price).to eq(Money.new(1000))
    end

    it "returns products reduced price when there was a discount" do
      @product.calculate_pricing_delta(@quantity, @reduced_price)

      expect(@product.check_price).to eq(Money.new(700))
    end
  end
end
