class Admin::ScoreSugestsController < Admin::BaseController
  before_action :load_sugest, only: [:update, :destroy]

  def create
    @sugest = ScoreSugest.new sugest_params
    if @sugest.save
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  def update
    if @sugest.update_attributes sugest_params
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  def destroy
    if @sugest.destroy
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to edit_admin_match_path @sugest.match
  end

  private

  def load_sugest
    @sugest = ScoreSugest.find params[:id]
  end

  def sugest_params
    params.require(:score_sugest).permit :score_win, :score_lost,
      :ratio, :match_id
  end
end
