Rails.application.routes.draw do
  devise_for :users

  root 'products#index'
  resources :products
  get "up" => "rails/health#show", as: :rails_health_check

end
