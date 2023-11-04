Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'home#index'
  get 'my-guesthouse', to: 'guesthouses#my_guesthouse'
  resources :guesthouses, only: [:index, :new, :create, :show, :edit, :update] do
    resources :rooms, only: [:index, :new, :create]
    # ou resources :rooms, shallow: true
  end
  resources :rooms, only: [:show, :edit, :update]
end
