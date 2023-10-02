Rails.application.routes.draw do
  resources :products
  devise_for :users
  root to: "spaces#index"
  resources :spaces do
    resources :bookings, only: [:create] do
      resources :reviews, only: [:new, :create]
    end
    resources :bookings, only: [:index]
  end
  get 'spaces_search', to: 'spaces#search'
end
