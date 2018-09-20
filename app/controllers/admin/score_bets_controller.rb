class Admin::ScoreBetsController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_bet, except: %i(index new create)

  def index
    @bets =
      ScoreBet.load_includes.page(params[:page]).per Settings.bet_per
  end

  def update
    if @bet.update_attributes bet_params
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  private

  def load_bet
    @bet = ScoreBet.find params[:id]
  end

  def bet_params
    params.require(:score_bet).permit :price, :status, :score_sugest_id,
      :match_id, :user_id
  end
end
