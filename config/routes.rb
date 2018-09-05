Rails.application.routes.draw do
  namespace :admin do
    root "dashboard#index"
    resources :football_news
    resources :users
    resources :leagues
    resources :countries
    resources :continents do
      get "load_countries", on: :member
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
end
