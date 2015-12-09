require 'rails_helper'

RSpec.describe PromotionalRule, type: :model do
  describe "#check" do
    it 'raises an NotImplementedError' do
      rule = FactoryGirl.create(:promotional_rule)
      expect { rule.check }.to raise_error(NotImplementedError, "This method should be overriden and return a result of comparation with the promotional rule.")
    end
  end
end
