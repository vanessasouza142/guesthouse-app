Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'
  get 'my-guesthouse', to: 'guesthouses#my_guesthouse'
  resources :guesthouses, only: [:index, :new, :create, :show, :edit, :update]
  resources :rooms, only: [:new, :create]
end
