class HomeController < ApplicationController
  def index
    @leagues = League.includes(:rounds,
      :rankings).page(params[:page]).per(Settings.leagues)
  end
end
