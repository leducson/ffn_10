class ProfilesController < ApplicationController
  layout "home"

  before_action :load_user, only: %i(show edit update)

  def show
    render "users/profile"
  end

  def edit
    render "users/edit"
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t(".update_user")
      redirect_to profile_path
    else
      render "users/edit"
    end
  end

  private

  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :fullname,
      :email, :gender, :password, :password_confirmation
  end
end
