Rails.application.routes.draw do
  namespace :admin do
    resources :products
    resources :categories
    resources :brands
  end
  devise_for :users
  resources :products, only: [:index, :show]

  root 'products#index', only: [:show, :index]
  get "up" => "rails/health#show", as: :rails_health_check

end
