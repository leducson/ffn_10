class Admin::RoundsController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_round, except: :create

  def create
    if params[:round][:league_id].present?
      check_round_size params[:round][:league_id]
    else
      save_round
    end
  end

  def update
    if @round.update_attributes round_params
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  def destroy
    if @round.destroy
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to edit_admin_league_path(@round.league)
  end

  private

  def check_round_size league_id
    @league = League.find league_id
    if @league.rounds.size >= @league.number_of_round
      render json: {message: t(".sizes"), type: Settings.error}
    else
      save_round
    end
  end

  def save_round
    @round = Round.new round_params
    if @round.save
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  def load_round
    @round = Round.find params[:id]
  end

  def round_params
    params.require(:round).permit :name, :league_id
  end
end
