Rails.application.routes.draw do
  resources :products do
    collection do
      get :checkout
    end
  end

  resources :promotional_rules, only: [:index, :create]
  resources :general_limit_promotions, :controller => :promotional_rules, :type => "GeneralLimitPromotion", except: [:index, :show]
  resources :product_promotions, :controller => :promotional_rules, :type => "ProductPromotion", except: [:index, :show]

  root 'products#index'
end
