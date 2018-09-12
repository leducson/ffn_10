class Admin::TeamsController < Admin::BaseController
  before_action :load_team, except: %i(index new create)

  def index
    @teams = Team.newest.page(params[:page]).per(Settings.team_per)
  end

  def new
    @team = Team.new
  end

  def create
    if params[:team][:league_id].present?
      check_team_size params[:team][:league_id]
    else
      save_team
    end
  end

  def edit
    load_edit_params
  end

  def update
    if @team.update_attributes team_params
      flash[:info] = t ".success"
      redirect_to admin_teams_path
    else
      flash[:danger] = t ".error"
      load_edit_params
      render :edit
    end
  end

  def destroy
    if params[:league_id].present?
      update_league_nil
    else
      if @team.destroy
        flash[:info] = t ".success"
      else
        flash[:danger] = t ".error"
      end
      redirect_to admin_teams_path
    end
  end

  def set_league
    @league = League.find params[:league_id]
    if @league.teams.size >= @league.number_of_team
      render json: {message: t(".sizes"), type: Settings.error}
      return
    end
    update_league_params
  rescue ActiveRecord::RecordInvalid => ex
    render json: {message: ex.record.errors, type: Settings.error}
  end

  def load_players_by_team
    @players = @team.player_infos.pluck :id, :name, :number
    render json: @players
  end

  private

  def update_league_nil
    update_attributes_league_nil
    redirect_to edit_admin_league_path(id: params[:league_id])
  rescue ActiveRecord::RecordInvalid => ex
    flash[:danger] = ex.record.errors
    redirect_to edit_admin_league_path(id: params[:league_id])
  end

  def update_attributes_league_nil
    if @team.update_attributes(league_id: nil)
      if @team.rankings.present?
        @team.rankings.find_by(league_id: params[:league_id]).destroy
      end
      flash[:info] = t ".success"
    else
      flash[:info] = t ".error"
    end
  end

  def update_league_params
    if @team.update_attributes league_id: params[:league_id]
      @team.create_ranking
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  def load_edit_params
    @players =
      @team.player_infos.page(params[:player_page]).per Settings.player_per
    @player = @team.player_infos.build
  end

  def save_team
    @team = Team.new team_params
    respond_to do |format|
      respond_to_save_team format
    end
  end

  def check_team_size league_id
    @league = League.find league_id
    if @league.teams.size >= @league.number_of_team
      respond_to do |fo|
        fo.html{redirect_to new_admin_team_path, flash: {danger: t(".sizes")}}
        fo.json{render json: {message: t(".sizes", type: Settings.error)}}
      end
    else
      save_team
    end
  end

  def respond_to_save_team format
    save_step_end format
  rescue ActiveRecord::RecordInvalid => ex
    format.html do
      redirect_to new_admin_team_path, flash: {danger: ex.record.errors}
    end
    format.json{render json: {type: Settings.error, message: ex.record.errors}}
  end

  def save_step_end format
    if @team.save team_params
      @team.create_ranking
      format.html{redirect_to admin_teams_path, flash: {info: t(".success")}}
      format.json{render json: {type: Settings.success, message: t(".success")}}
    else
      format.html{redirect_to new_admin_team_path, flash: {danger: t(".error")}}
      format.json{render json: {type: Settings.error, message: t(".error")}}
    end
  end

  def load_team
    @team = Team.find params[:id]
  end

  def team_params
    params.require(:team).permit :name, :image, :address, :establish_year,
      :continent_id, :league_id, :country_id
  end
end
