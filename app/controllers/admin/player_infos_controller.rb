class Admin::PlayerInfosController < Admin::BaseController
  before_action :load_player, except: %i(index new create)

  def index
    @players = PlayerInfo.newest.page(params[:page]).per Settings.player_per
  end

  def new
    @player = PlayerInfo.new
  end

  def create
    @player = PlayerInfo.new player_params
    save_player @player
  end

  def edit; end

  def update
    if @player.update_attributes player_params
      flash[:info] = t ".success"
      if params[:team_id].present?
        redirect_to edit_admin_team_path(@player.team)
      else
        redirect_to admin_player_infos_path
      end
    else
      flash[:danger] = t ".error"
      render :edit
    end
  end

  def destroy
    if params[:team_id].present?
      if @player.update_attributes team_id: nil
        flash[:info] = t ".success"
      else
        flash[:danger] = t ".error"
      end
      redirect_to edit_admin_team_path(id: params[:team_id])
    else
      if @player.destroy
        flash[:info] = t ".success"
      else
        flash[:danger] = t ".error"
      end
      redirect_to admin_player_infos_path
    end
  end

  def set_player_by_team
    if @player.update_attributes team_id: params[:team_id]
      render json: {message: t(".success"), type: Settings.success}
    else
      render json: {message: t(".error"), type: Settings.error}
    end
  end

  private

  def save_player player
    respond_to do |format|
      if player.save
        format.html do
          redirect_to admin_player_infos_path, flash: {info: t(".success")}
        end
        format.json do
          render json: {message: t(".success"), type: Settings.success}
        end
      else
        format.html do
          redirect_to new_admin_player_info_path, flash: {danger: t(".error")}
        end
        format.json{render json: {message: t(".error"), type: Settings.error}}
      end
    end
  end

  def load_player
    @player = PlayerInfo.find params[:id]
  end

  def player_params
    params.require(:player_info).permit :name, :date_of_birth, :gender, :weight,
      :height, :position, :team_id, :number
  end
end
