Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'
  get 'my-guesthouse', to: 'guesthouses#my_guesthouse'
  get 'guesthouses_by_city/:city', to: 'guesthouses#by_city', as: 'guesthouses_by_city'
  resources :guesthouses, only: [:new, :create, :show, :edit, :update] do
    post :activate, on: :member
    post :inactivate, on: :member
    get 'search', on: :collection
    resources :rooms, only: [:new, :create]
  end
  resources :rooms, only: [:show, :edit, :update] do
    post :set_available, on: :member
    post :set_unavailable, on: :member
    resources :custom_prices, only: [:index, :new, :create]
    resources :bookings, only: [:new, :create] do
      post 'check_availability', on: :collection
    end
  end
  resources :custom_prices, only: [:edit, :update]
  get 'confirm_booking', to: 'bookings#confirm_booking'
end
