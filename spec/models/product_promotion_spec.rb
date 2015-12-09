require 'rails_helper'

RSpec.describe ProductPromotion, type: :model do
  describe "#check" do
    before(:each) do
      @product = FactoryGirl.create(:product, price: 2000)
      @rule = FactoryGirl.create(:product_promotion, product: @product, quantity: 2, reduced_price_pennies: 1000)
    end

    it 'adds original product price to current_total if quantity was not reached' do
      expect(@rule.check(@product, 1, 0)).to eq(@product.price + 0)
    end

    it 'reduces current_total by delta and adds new price if quantity was reached' do
      current_total = Money.new(1000)
      result = @rule.check(@product, 2, current_total )

      product = FactoryGirl.create(:product, price: 2000)
      rule = FactoryGirl.create(:product_promotion, product: @product, quantity: 2, reduced_price_pennies: 1000)

      delta = product.calculate_pricing_delta(2, rule.reduced_price)
      expect( result ).to eq( current_total + delta )
    end
  end
end
