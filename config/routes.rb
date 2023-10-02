Rails.application.routes.draw do
  devise_for :users

  root to: "spaces#index"

  resources :spaces, only: [:index, :show]
  resources :bookings, only: [:index, :create, :show] do
    resources :reviews, only: [:new, :create]
  end
end
