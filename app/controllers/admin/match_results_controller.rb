class Admin::MatchResultsController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_result, only: %i(update destroy)

  def create
    @result = MatchResult.new result_params
    @check = MatchResult.check_score @result.match_id, @result.team_id
    if @check.present?
      render json: {message: t(".team_present"), type: Settings.error}
    elsif @result.save
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  def update
    if @result.update_attributes result_params
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t("error"), type: Settings.error}
    end
  end

  def destroy
    if @result.destroy
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to edit_admin_match_path @result.match
  end

  private

  def load_result
    @result = MatchResult.find params[:id]
  end

  def result_params
    params.require(:match_result).permit :score, :team_id, :match_id
  end
end
