##
## @brief      Products, available on our website
##
class Product < ActiveRecord::Base
  # Virtual attribute
  attr_accessor :discounted_price

  has_many :product_promotions

  monetize :price_pennies
  mount_uploader :image, ImageUploader

  validates :product_code, :name, :price_pennies, presence: true
  validates :price_pennies, numericality: { greater_than: 0 }

  paginates_per 10
  ##
  ## @brief      Calculates the number, by which the total price should be reduced. Fills new @discounted_price.
  ##
  ## @param      {Integer} quantity,    Quantity of products purchased
  ## @param      {Float}   reduced_price, new reduced price regarding per-product rule
  ##
  ## @return     {Float}   number to add to customers total regarding per-product discount
  ##
  def calculate_pricing_delta quantity, reduced_price
    # Calculate delta between old and new prices
    delta = pricing_delta(reduced_price)
    # Re-assing discounted price for future usage with new discounts
    @discounted_price = reduced_price

    @discounted_price - delta * (quantity - 1)
  end

  ##
  ## @brief      Checks if discount was made and if so - returns reduced price of product
  ##
  ## @return     {Float} reduced or original product price
  ##
  def check_price
    @discounted_price || price
  end

  private

  ##
  ## @brief      Calculate delta between old and new prices
  ##
  ## @param      reduced_price  newest product price regarding the latest rule applied
  ##
  ## @return     {Float} delta, difference between current price and reduced price
  ##
  def pricing_delta reduced_price
    if @discounted_price
      @discounted_price - reduced_price
    else
      price - reduced_price
    end
  end
end
