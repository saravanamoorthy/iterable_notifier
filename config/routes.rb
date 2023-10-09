Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :sessions
  resources :registrations
  match "/signup", to: "registrations#new", via: :get, as: :signup
  match "/signup", to: "registrations#create", via: :post
  match "/login", to: "sessions#new", via: :get, as: :login
  match "/logout", to: "sessions#destroy", via: :delete, as: :logout
  root "sessions#new"
  resources :events, only: [:index, :create]
end
