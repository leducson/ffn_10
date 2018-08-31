class HomeController < ApplicationController
  def index
    @leagues = League.includes(:rounds, :teams, :rankings)
      .page(params[:page]).per(Settings.leagues)
  end
end
