##
## @brief      Used for handling promotional rules
##
class PromotionalRulesController < ApplicationController
  before_action :find_rule, only: [:edit, :update, :destroy]

  ##
  ## @brief      GET    /promotional_rules(.:format)
  ##
  def index
    @general_rules, @product_rules = GeneralLimitPromotion.all.decorate, ProductPromotion.includes(:product).all.decorate
  end

  ##
  ## @brief      GET    /general_limit_promotions/new(.:format)
  ##             GET    /product_promotions/new(.:format)
  ##
  def new
    @rule = PromotionalRule.new(type: params[:type])
  end

  ##
  ## @brief      POST   /general_limit_promotions(.:format)
  ##             POST   /promotional_rules(.:format)
  ##
  def create
    @rule = PromotionalRule.new(rule_params)

    if @rule.save
      redirect_to promotional_rules_path
    else
      render :new
    end
  end

  ##
  ## @brief      GET    /general_limit_promotions/:id/edit(.:format)
  ##             GET    /product_promotions/:id/edit(.:format)
  ##
  def edit
  end

  ##
  ## @brief      PATCH  /general_limit_promotions/:id(.:format)
  ##             PUT    /general_limit_promotions/:id(.:format)
  ##             PATCH  /product_promotions/:id(.:format)
  ##             PUT    /product_promotions/:id(.:format)
  ##
  def update
    if @rule.update(rule_params)
      redirect_to promotional_rules_path
    else
      render :edit
    end
  end

  ##
  ## @brief      DELETE /general_limit_promotions/:id(.:format)
  ##             DELETE /product_promotions/:id(.:format)
  ##
  def destroy
    @rule.destroy!
    redirect_to promotional_rules_path
  end

  private
  ##
  ## @brief      Promotional Rule finder
  ##
  ## @return     {GeneralLimitPromotion || ProductPromotion}@rule - rule with passed id
  ##
  def find_rule
    @rule = PromotionalRule.find(params[:id])
  end

  ##
  ## @brief      PromotionalRule strong params
  ##
  ## @return     {ActiveController::Params} - set of allowed params
  ##
  def rule_params
    rule_attributes = params.require(params[:type].underscore).permit(:limit_pennies, :over_limit_discount, :type, :product_id, :quantity, :reduced_price_pennies)
    rule_attributes.merge(type: params[:type])
  end
end
