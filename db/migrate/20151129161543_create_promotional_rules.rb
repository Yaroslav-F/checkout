class CreatePromotionalRules < ActiveRecord::Migration
  def change
    create_table :promotional_rules do |t|
      t.monetize :limit
      t.float :over_limit_discount
      t.belongs_to :product, index: true, foreign_key: true
      t.integer :quantity
      t.monetize :reduced_price, amount: { null: true, default: nil }
      t.string :type, default: "GeneralLimitPromotion"

      t.timestamps null: false
    end
  end
end
