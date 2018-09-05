class Admin::TeamsController < Admin::BaseController
  before_action :load_team, except: %i(index new create)

  def new
    @team = Team.new
  end

  def create
    @league = League.find params[:league_id]
    if @league.teams.create team_params
      flash[:info] = t ".create_success"
      redirect_to edit_admin_league_path(@league)
    else
      flash[:danger] = t "create_error"
      render :new
    end
  end

  def edit; end

  def update
    if @team.update_attributes team_params
      flash[:info] = t ".update_success"
      redirect_to edit_admin_league_path(@team.league)
    else
      flash[:danger] = t ".update_error"
      render :new
    end
  end

  def destroy
    if @team.destroy
      flash[:info] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_error"
    end
    redirect_to edit_admin_league_path(@team.league)
  end

  private

  def load_team
    @team = Team.find params[:id]
  end

  def team_params
    params.require(:team).permit :name, :address, :establish_year,
      :continent_id, :league_id, :country_id
  end
end
