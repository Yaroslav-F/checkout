##
## @brief      Used for handling product resource
##
class ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :destroy]

  ##
  ## @brief      GET /products
  ##
  def index
    @products = Product.all.page(params[:page]).decorate
  end

  ##
  ## @brief      GET /products/new
  ##
  def new
    @product = Product.new
  end

  ##
  ## @brief      POST /products
  ##
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  ##
  ## @brief      GET /products/:id/edit
  ##
  def edit
  end

  ##
  ## @brief      PATCH  /products/:id(.:format)
  ##             PUT    /products/:id(.:format)
  ##
  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  ##
  ## @brief      DELETE /products/:id(.:format)
  ##
  def destroy
    @product.destroy!
    redirect_to products_path
  end

  ##
  ## @brief      GET    /products/checkout(.:format)
  ##
  def checkout
    co = Checkout.new

    params[:product_ids].each do |product_id|
      item = Product.find(product_id)
      co.scan(item)
    end

    render json: { total: co.total.format }
  end

  private

  ##
  ## @brief      Product finder
  ##
  ## @return     {Product}@product - product with passed id
  ##
  def find_product
    @product = Product.find(params[:id])
  end

  ##
  ## @brief      Product strong params
  ##
  ## @return     {ActiveController::Params} - set of allowed params
  ##
  def product_params
    params.require(:product).permit(:product_code, :name, :price_pennies, :image)
  end
end
