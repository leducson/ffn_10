Rails.application.routes.draw do

  root "home#index"

  namespace :admin do
    root "dashboard#index"
  end

  get "/signup", to: "users#signup"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :account_activations, only: :edit

end
