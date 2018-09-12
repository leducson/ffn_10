class RankingsController < ApplicationController
  layout "home"

  def index
    @leagues = League.newest.includes(rankings: :team)
  end

  def show
    load_league
    load_ranking_by_league
  end

  private

  def load_league
    @league = League.find params[:id]
  end

  def load_ranking_by_league
    @rankings = @league.rankings.newest
  end
end
