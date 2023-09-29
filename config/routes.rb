Rails.application.routes.draw do
  resources :products
  devise_for :users
  root to: "spaces#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :spaces do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index]
  # Defines the root path route ("/")
  # root "articles#index"
end
