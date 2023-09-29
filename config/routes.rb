Rails.application.routes.draw do
  devise_for :users
  root to: "spaces#index"
  resources :spaces do
    resources :bookings, only: [:create] do
      resources :reviews, only: [:new, :create]
    end
    resources :bookings, only: [:index]
  end
end
