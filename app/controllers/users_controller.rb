class UsersController < ApplicationController
  load_and_authorize_resource
  layout "home"

  before_action :load_user, only: %i(show edit update)

  def show
    @score_bets = current_user.score_bets
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      sign_in @user, bypass: true
      flash[:success] = t(".update_user")
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :fullname,
      :email, :password, :password_confirmation
  end
end
