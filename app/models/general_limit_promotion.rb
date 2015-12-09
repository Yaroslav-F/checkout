##
## @brief      Declares promotion rule that should check total spendings and do
##             a percentage discount
##
class GeneralLimitPromotion < PromotionalRule
  monetize :limit_pennies

  validates :limit_pennies, :over_limit_discount, presence: true, numericality: { greater_than: 0 }
  ##
  ## @brief      Verification against the limit. If limit is passed, returns percentage to reduce the price
  ##
  ## @param      {Float} total, total price of customers purchases
  ##
  ## @return     {Float || NIlClass} value if buying limit is passed or nil if limit is not reached
  ##
  def check total
    over_limit_discount if total > limit
  end
end
