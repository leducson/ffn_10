class ScoreBetsController < ApplicationController
  def create
    if logged_in?
      @bet_amount = params[:price]
      @sugest = ScoreSugest.find params[:sugest_id]
      if params[:price].to_f <= current_user.money.to_f
        check_match_date
      else
        render json: {message: t(".current_amount"), type: "error"}
      end
    else
      render json: {message: t(".login"), type: "error"}
    end
  end

  private

  def create_score_bet
    if @sugest.create_bet current_user, params[:price].to_f
      render json: {message: t(".success_bet"), type: "success"}
    else
      render json: {message: t(".fail_bet"), type: "error"}
    end
  end

  def check_match_date
    if @sugest.match.date_of_match >= Time.now && !@sugest.match.finish?
      create_score_bet
    else
      render json: {message: t(".time_limit"), type: Settings.error}
    end
  end
end
