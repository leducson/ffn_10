class Admin::MatchesController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_match, only: %i(edit update destroy load_infos)
  before_action :load_infos, only: :edit

  def index
    @q = Match.newest.includes(:team1, :team2).ransack params[:q]
    @matches = @q.result.page(params[:page]).per Settings.match_per
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new match_params
    if @match.save
      flash[:info] = t ".success"
      redirect_to admin_matches_path
    else
      flash[:danger] = t ".error"
      render :new
    end
  end

  def edit; end

  def update
    @old_status = @match.finish?
    if @match.update_attributes match_params
      @match.check_finish_match if @old_status == false && @match.finish?
      flash[:info] = t ".success"
      redirect_to admin_matches_path
    else
      flash[:danger] = t ".error"
      render :edit
    end
  rescue ActiveRecord::RecordInvalid => ex
    flash[:danger] = ex.record.errors
    render :edit
  end

  def destroy
    if @match.destroy
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to admin_matches_path
  end

  def load_rounds
    @rounds = Round.by_league(params[:league_id]).pluck(:name, :id) || []
    render json: @rounds
  end

  private

  def load_match
    @match = Match.find params[:id]
  end

  def load_infos
    @match_infos =
      @match.match_infos.newest.page(params[:match_page]).per Settings.info_per
    @score_sugests =
      @match.score_sugests.newest.page(params[:sugest]).per Settings.sugest_per
    @match_results = @match.match_results
    @match_info = @match.match_infos.build
    @score_sugest = @match.score_sugests.build
  end

  def match_params
    params.require(:match).permit :date_of_match, :extra_time1,
      :extra_time2, :time, :team1_id, :team2_id, :round_id, :status
  end
end
