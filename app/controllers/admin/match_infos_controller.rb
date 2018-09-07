class Admin::MatchInfosController < Admin::BaseController
  before_action :load_match_info, except: :create

  def create
    @match_info = MatchInfo.new match_info_params
    if @match_info.save
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  def edit; end

  def update
    if @match_info.update_attributes match_info_params
      flash[:info] = t ".success"
      redirect_to edit_admin_match_path @match_info.match
    else
      falsh[:danger] = t ".error"
      render :edit
    end
  end

  def destroy
    if @match_info.destroy
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to edit_admin_match_path @match_info.match
  end

  private

  def load_match_info
    @match_info = MatchInfo.find params[:id]
  end

  def match_info_params
    params.require(:match_info).permit :message, :minutes,
      :type_info, :match_id, :team_id, :player_info_id
  end
end
