class Admin::MatchesController < Admin::BaseController
  before_action :load_match, only: %i(edit update destroy)

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

  def edit; end

  def update
    if @match.update_attributes match_params
      flash[:info] = t ".success"
      redirect_to admin_matches_path
    else
      flash[:danger] = t ".error"
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

  def match_params
    params.require(:match).permit :date_of_match, :extra_time1,
      :extra_time2, :time, :team1_id, :team2_id, :round_id, :status
  end
end
