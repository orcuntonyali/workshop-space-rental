# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  root to: "spaces#index"

  resources :spaces, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :bookings, only: [:index, :create, :edit, :update, :show, :destroy] do
    resources :reviews, only: [:new, :create, :destroy]
  end
end
