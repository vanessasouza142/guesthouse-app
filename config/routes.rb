Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'
  get 'my-guesthouse', to: 'guesthouses#my_guesthouse'
  resources :guesthouses, only: [:new, :create, :show, :edit, :update] do
    post :activate, on: :member
    post :inactivate, on: :member
    get 'search_by_city', on: :collection
    resources :rooms, only: [:new, :create]
  end
  resources :rooms, only: [:show, :edit, :update] do
    post :set_available, on: :member
    post :set_unavailable, on: :member
    resources :custom_prices, only: [:index, :new, :create]
  end
  resources :custom_prices, only: [:edit, :update]

end
