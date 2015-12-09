##
## @brief      Declares promotion rule for promotions per product. Checks
##             whether conditions are met, and gives a discount on a separate
##             product if they are.
##
class ProductPromotion < PromotionalRule
  monetize :reduced_price_pennies

  belongs_to :product
  validates :product, :quantity, :reduced_price_pennies, presence: true
  validates :quantity, :reduced_price_pennies, numericality: { greater_than: 0 }

  ##
  ## @brief      Verification against the product quantity.
  ##             If customer is intending to buy some quantity of products - the price is reduced.
  ##
  ## @param      {Product} product,            Product from customers basket
  ## @param      {Integer} purchased_quantity, Quantity of this products bought (including this product)
  ## @param      {Float}   current_total,      total price of customers purchases
  ##
  ## @return     {Float}   total,    total price of customers purchases including discounts on the promoted product
  ##
  def check product, purchased_quantity, current_total
    # Compare quantity of products specified in the rule to quantity which was purchased by user
    # if quantity, specified in the rule, is equal to the products quantity       - recalculate total due to the pricing delta
    # if quantity, specified in the rule, is not equal to the products quantity   - add either original or reduced price
    if purchased_quantity == quantity
      current_total + product.calculate_pricing_delta(purchased_quantity, reduced_price)
    else
      current_total + product.check_price
    end

  end
end
