class FootballNewsController < ApplicationController
  layout "home"

  def index
    @football_news =
      FootballNew.newest.page(params[:page]).per(Settings.football_new_per)
  end

  def show
    @football_new = FootballNew.find params[:id]
    @comments = @football_new.comments.newest
  end
end
