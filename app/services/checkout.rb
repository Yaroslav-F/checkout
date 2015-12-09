##
## @brief      Declares checkout system for the marketplace
##
class Checkout
  ##
  ## @brief      Constructor of the checkout system
  ##
  def initialize
    @total = 0
    @general_rules = GeneralLimitPromotion.all
    @per_product_rules = ProductPromotion.all
    @product_ids = []
  end
  ##
  ## @brief      Scans a purchase
  ##
  ## @param      {Product} product  Newly bought product
  ##
  ## @return     {Float}   @total,   total price of customers purchases including discounts on the promoted product
  ##
  def scan product
    # Array of products in the basket
    @product_ids << product.id
    # Quantity of currently scanned product
    product_quantity = @product_ids.count(product.id)

    total = @per_product_rules.map do |rule|
      # Check if rule was written for this product
      # if yes - check against this rule
      # if no  - skip the rule and just add price of product to total checkout
      if rule.product_id == product.id
        # binding.pry
        rule.check( product, product_quantity, @total )
      else
        @total + product.price
      end
    end
    # Refresh the total due to per-product rules, fetching the least price for the product if there were multiple rules for the same product
    # or fetching product original price if there are no per-product rules
    @total = total.min || product.price
  end

  ##
  ## @brief      Calculates total price of customers purchases
  ##
  ## @return     {Float}    total price of customers purchases including discounts on the promoted products and discounts due to general limit
  ##
  def total
    # Iterate through general limit rules, checking the total against each
    discounts = @general_rules.map{ |rule| rule.check(@total) }.compact
    apply_discounts(discounts.max)
  end

  private

  ##
  ## @brief      Applies discoutn to current total price
  ##
  ## @param      {Float} discount, Percentage discount to be applied
  ##
  ## @return     {Float} @total,    Total price of customers purchases including discounts on the promoted products and discounts due to general limit
  ##
  def apply_discounts discount
    # If discount is in action, calculate total value due to discount
    if discount
      @total = Money.new(@total.fractional - @total.fractional * discount / 100)
    else
      @total
    end
  end
end