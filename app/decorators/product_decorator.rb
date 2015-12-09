##
## @brief      Used to create additional methods on Product object
##
class ProductDecorator < Draper::Decorator
  delegate :current_page, :total_pages, :limit_value, :model_name, :total_count, :id, :product_code, :image, :name, :price, to: :source
end
