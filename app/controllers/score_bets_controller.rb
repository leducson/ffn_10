class ScoreBetsController < ApplicationController
  def create
    check_login
    @bet_amount = params[:price]
    @sugest = ScoreSugest.find params[:sugest_id]
    if params[:price].to_f <= current_user.money.to_f
      create_score_bet
    else
      render json: {message: t(".current_amount"), type: "error"}
    end
  end

  private

  def check_login
    return render json: {message: t(".login"), type: "error"} unless logged_in?
  end

  def create_score_bet
    if current_user.score_bets.create!(price: params[:price].to_f,
        match_id: @sugest.match_id, score_sugest_id: @sugest.id)
      current_user.deduction params[:price].to_f
      render json: {message: t(".success_bet"), type: "success"}
    else
      render json: {message: t(".fail_bet"), type: "error"}
    end
  end
end
