Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'
  get 'my-guesthouse', to: 'guesthouses#my_guesthouse'
  resources :guesthouses, only: [:new, :create, :show, :edit, :update] do
    patch :activate, on: :member
    patch :inactivate, on: :member
    resources :rooms, only: [:new, :create]
  end
  resources :rooms, only: [:show, :edit, :update] do
    patch :set_available, on: :member
    patch :set_unavailable, on: :member
    resources :custom_prices, only: [:index, :new, :create]
  end
end
