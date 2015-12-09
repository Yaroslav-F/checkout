FactoryGirl.define do
  factory :promotional_rule do
    type ""
    factory :general_limit_promotion, class: 'GeneralLimitPromotion' do
      type 'GeneralLimitPromotion'
      limit_pennies 6000
      over_limit_discount 10
    end
    factory :product_promotion, class: 'ProductPromotion' do
      type 'ProductPromotion'
      association :product, factory: :product
      quantity 2
      reduced_price_pennies 850
    end
  end
end
