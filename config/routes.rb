Rails.application.routes.draw do
  namespace :admin do
    root "dashboard#index"
    resources :football_news
    resources :users
    resources :leagues do
      resources :teams, only: [:create, :destroy]
    end
    resources :teams do
      member do
        patch "set_league"
        get "load_players_by_team"
      end
      resources :player_infos, path: "player", except: %i(index new)
    end
    resources :rounds
    resources :countries
    resources :continents do
      get "load_countries", on: :member
    end
    resources :matches do
      get "load_rounds_and_teams", on: :collection
    end
    resources :match_infos, except: %i(index show new)
    resources :score_sugests, only: %i(create update destroy)
    resources :player_infos, path: "players" do
      patch "set_player_by_team", on: :member
    end
    resources :rankings, only: :update
    resources :score_bets, only: %i(index update)
    resources :notifies, only: :index
    resources :credits do
      patch "quick_set_type", on: :member
    end
    resources :match_results, only: %i(create update destroy)
  end

  root "home#index"

  devise_for :users

  post "upload_image" => "upload_froala#upload_image_froala", as: :upload_image

  resources :account_activations, only: :edit
  resources :password_resets, except: :destroy
  resources :users, only: [:show, :edit, :update]
  resources :football_news, only: [:index, :show]
  resources :comment, only: :create
  resources :score_bets, only: :create
  resources :teams, only: :index do
    get "load_countries", on: :collection
    get "/search", to: "teams#search", on: :collection
    get "/details", to: "teams#details", on: :collection
  end
  resources :rankings, only: [:index, :show]
end
