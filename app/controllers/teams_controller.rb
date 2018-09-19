class TeamsController < ApplicationController
  layout "home"

  before_action :load_continent, only: :load_countries

  def index
    @teams = Team.newest.page(params[:page]).per(Settings.team_per)
  end

  def search
    @teams = Team.newest.by_country(params[:country_id])
    @teams = pagination params[:page], Settings.team_per, @teams
  end

  def details
    @team = Team.find params[:id]
    @player_infos = @team.player_infos.newest
    @matchs = @team.team1_matchs + @team.team2_matchs
  end

  def load_countries
    @countries = @continent.countries.pluck(:name, :id) || []
    respond_to do |format|
      format.json{render json: @countries}
    end
  end

  private

  def load_continent
    @continent = Continent.find params[:id]
  end
end
