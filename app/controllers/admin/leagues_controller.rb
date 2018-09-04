class Admin::LeaguesController < Admin::BaseController
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

  def edit; end

  def update
    if @league.update league_params
      flash[:info] = t ".update_success"
      redirect_to admin_leagues_path
    else
      flash[:danger] = t ".update_error"
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

  def load_league
    @league = League.find params[:id]
  end

  def league_params
    params.require(:league).permit :name, :country_id, :start_date, :end_date,
      :continent_id, :number_of_match, :number_of_team,
      :match_time, :number_of_round
  end
end
