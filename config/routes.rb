Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'
  get 'my-guesthouse', to: 'guesthouses#my_guesthouse'
  get 'guesthouses_by_city/:city', to: 'guesthouses#by_city', as: 'guesthouses_by_city'

  resources :guesthouses, only: [:new, :create, :show, :edit, :update] do
    post :activate, on: :member
    post :inactivate, on: :member
    get 'search', on: :collection
    get 'bookings', on: :member
    get 'active_stays', on: :member
    get 'reviews', on: :member
    get 'all_reviews', on: :member
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
  get 'my-bookings', to: 'bookings#my_bookings'

  resources :bookings, only: [:show] do
    post :set_in_progress, on: :member
    post :set_finished, on: :member
    get 'payment', on: :member
    patch 'register_payment', on: :member
    delete 'host_cancel', on: :member
    delete 'guest_cancel', on: :member
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [] do
    get 'answer', on: :member
    patch 'register_answer', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :guesthouses, only: [:index, :show] do
        resources :rooms, only: [:index]
      end
      resources :rooms, only: [] do
        resources :bookings, only: [] do
          post 'check_availability', on: :collection
        end
      end
    end
  end

end
