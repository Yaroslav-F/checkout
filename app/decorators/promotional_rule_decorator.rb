##
## @brief      { class_description }
##
class PromotionalRuleDecorator < Draper::Decorator
  delegate_all

  ##
  ## @brief      adds :name method to return products name for product rule or nil if there's no product specified
  ##
  ## @return     {String || NilClass} - products name for product rule
  ##
  def product_name
    product.try(:name)
  end

  ##
  ## @brief      decorator for over_limit_discount attribute, which should be shown with the '%' sign
  ##
  ## @return     {String} - over_limit_discount with percentage sign
  ##
  def discount_percentage
    "#{over_limit_discount} %"
  end
end
