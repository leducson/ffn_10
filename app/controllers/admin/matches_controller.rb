class Admin::MatchesController < Admin::BaseController
  before_action :load_match, only: %i(edit update destroy load_infos)

  def index
    @matches = Match.newest.page(params[:page]).per Settings.match_per
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

  def edit
    load_infos
  end

  def update
    if @match.update_attributes match_params
      flash[:info] = t ".success"
      redirect_to admin_matches_path
    else
      flash[:danger] = t ".error"
      load_infos
      render :edit
    end
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
    @match_result = @match.match_result
    @match_info = @match.match_infos.build
    @score_sugest = @match.score_sugests.build
  end

  def match_params
    params.require(:match).permit :date_of_match, :extra_time1,
      :extra_time2, :time, :team1_id, :team2_id, :round_id, :status
  end
end
