Rails.application.routes.draw do
  namespace :admin do
    root "dashboard#index"
  end

  root "home#index"

  get "/signup", to: "users#signup"
  post "/signup", to: "users#create"

  resources :account_activations, only: :edit
end
