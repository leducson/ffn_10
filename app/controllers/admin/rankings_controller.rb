class Admin::RankingsController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_ranking, only: :update

  def update
    if @ranking.update_attributes ranking_params
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  private

  def load_ranking
    @ranking = Ranking.find params[:id]
  end

  def ranking_params
    params.require(:ranking).permit :rank, :league_id, :team_id
  end
end
