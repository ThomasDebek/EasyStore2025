Rails.application.routes.draw do
  namespace :admin do
    resources :brands
  end
  devise_for :users

  root 'products#index'
  resources :products
  get "up" => "rails/health#show", as: :rails_health_check

end
