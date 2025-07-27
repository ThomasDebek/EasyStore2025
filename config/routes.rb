Rails.application.routes.draw do
  namespace :admin do
    resources :products
    resources :categories
    resources :brands
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }
  resources :products, only: [:index, :show]

  root 'products#index', only: [:show, :index]
  get "up" => "rails/health#show", as: :rails_health_check


  resource :cart, only: [:show, :destroy] do
    post :add
    delete :remove_item
    patch :update_quantity
  end

end
