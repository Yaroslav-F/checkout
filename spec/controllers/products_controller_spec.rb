require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before(:each) do
    @product = FactoryGirl.create(:product, price: 1000)
  end
  describe "GET #index" do
    before(:each) do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns products' do
      expect(assigns(:products)).to eq([@product])
    end

    it 'decorates products' do
      expect(assigns(:products)).to be_decorated
    end

    it 'renders index template' do
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    before(:each) do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns a new product" do
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "GET #edit" do
    before(:each) do
      @product = FactoryGirl.create(:product)
      get :edit, id: @product.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns correct product" do
      expect(assigns(:product)).to eq(@product)
    end
  end

  describe "POST #create" do
    it "saves the product" do
      expect {
        post :create, product: { name: "Product1", price_pennies: 1000, product_code: "00X" }
      }.to change(Product, :count).by(1)
      expect(response).to redirect_to(products_path)
    end
  end

  describe "PATCH #update" do
    before(:each) do
      patch :update, product: { name: "Product1" }, id: @product.id
    end

    it "saves new products name" do
      expect(@product.reload.name).to eq("Product1")
    end

    it "redirects to products list" do
      expect(response).to redirect_to(products_path)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      expect {
        delete :destroy, id: @product.id
      }.to change(Product, :count).by(-1)
      expect(response).to redirect_to(products_path)
    end
  end

  describe "GET #checkout" do
    it "returns total" do
      post :checkout, product_ids: [@product.id]
      expect(response.body).to eq({ total: @product.price.format }.to_json)
    end
  end
end
