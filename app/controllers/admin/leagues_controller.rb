class Admin::LeaguesController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_league, except: %i(index new create)

  def index
    @leagues = League.newest.page(params[:page]).per(Settings.league_per)
  end

  def show; end

  def new
    @league = League.new
  end

  def create
    @league = League.new league_params
    if @league.save
      flash[:info] = t ".create_success"
      redirect_to admin_leagues_path
    else
      flash[:danger] = t ".create_error"
      render :new
    end
  end

  def edit
    load_infos_edit
  end

  def update
    if @league.update league_params
      flash[:info] = t ".update_success"
      redirect_to admin_leagues_path
    else
      flash[:danger] = t ".update_error"
      load_infos_edit
      render :edit
    end
  end

  def destroy
    if @league.destroy
      flash[:info] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_error"
    end
    redirect_to admin_leagues_path
  end

  private

  def load_infos_edit
    @teams =
      @league.teams.newest.page(params[:team_page]).per(Settings.team_lg_per)
    @rounds =
      @league.rounds.newest.page(params[:round_page]).per(Settings.round_per)
    load_build_and_rankings
  end

  def load_build_and_rankings
    @team = @league.teams.build
    @round = @league.rounds.build
    @rankings =
      @league.rankings.newest.page(params[:rank_page]).per(Settings.rank_per)
  end

  def load_league
    @league = League.find params[:id]
  end

  def league_params
    params.require(:league).permit :name, :country_id, :start_date, :end_date,
      :continent_id, :number_of_match, :number_of_team,
      :match_time, :number_of_round, :image
  end
end
