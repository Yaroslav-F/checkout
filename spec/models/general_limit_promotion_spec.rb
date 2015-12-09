require 'rails_helper'

RSpec.describe GeneralLimitPromotion, type: :model do
  describe "#check" do
    before(:each) do
      @rule = FactoryGirl.create(:general_limit_promotion, limit_pennies: 1000, over_limit_discount: 10)
    end
    it 'returns over_limit_discount if the limit was exceeded' do
      expect(@rule.check(Money.new(1200))).to eq(10)
    end

    it 'returns nil if the limit was not exceeded' do
      expect(@rule.check(Money.new(900))).to be_nil
    end
  end
end
