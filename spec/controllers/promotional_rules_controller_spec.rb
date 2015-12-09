require 'rails_helper'

RSpec.describe PromotionalRulesController, type: :controller do

  before(:each) do
    @product = FactoryGirl.create(:product, price_pennies: 1000)

    @product_rule = FactoryGirl.create(:product_promotion, product: @product, quantity: 2, reduced_price_pennies: 900)
    @limit_rule = FactoryGirl.create(:general_limit_promotion, limit_pennies: 3000, over_limit_discount: 10)
  end
  describe "GET #index" do
    before(:each) do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns rules' do
      expect(assigns(:general_rules)).to eq([@limit_rule])
      expect(assigns(:product_rules)).to eq([@product_rule])
    end

    it 'decorates rules' do
      expect(assigns(:general_rules)).to be_decorated
      expect(assigns(:product_rules)).to be_decorated
    end

    it 'renders index template' do
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    it "saves the product" do
      expect {
        post :create, type: "GeneralLimitPromotion", general_limit_promotion: { limit_pennies: 6000, over_limit_discount: 10 }
      }.to change(PromotionalRule, :count).by(1)
    end

    it "redirects to products path" do
      post :create, type: "GeneralLimitPromotion", general_limit_promotion: { limit_pennies: 6000, over_limit_discount: 10 }
      expect(response).to redirect_to(promotional_rules_path)
    end
  end

  describe "GET #edit" do
    before(:each) do
      get :edit, id: @limit_rule.id, type: "GeneralLimitPromotion"
    end

    it "renders a template" do
      expect(response).to render_template("edit")
    end
  end
end
