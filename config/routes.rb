Rails.application.routes.draw do
  namespace :admin do
    root "dashboard#index"
    resources :football_news
    resources :users
    resources :leagues do
      resources :teams, only: [:create, :destroy]
    end
    resources :teams do
      patch "set_league", on: :member
    end
    resources :rounds
    resources :countries
    resources :continents do
      get "load_countries", on: :member
    end
    resources :matches do
      get "load_rounds", on: :collection
    end
  end

  root "home#index"

  get "/signup", to: "users#signup"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "upload_image" => "upload_froala#upload_image_froala", as: :upload_image

  resources :account_activations, only: :edit
  resources :password_resets, except: :destroy
  resources :profiles, only: [:show, :edit, :update]
  resources :football_news, only: [:index, :show]
  resources :comment, only: :create
  resources :score_bets, only: :create
end
