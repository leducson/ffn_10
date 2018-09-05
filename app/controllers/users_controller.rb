class UsersController < ApplicationController
  layout "users"

  def signup
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_email"
      redirect_to signup_path
    else
      render :signup
    end
  end

  def logged_in_user
    return if logged_in?
    store_location
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit :fullname, :email, :gender,
      :password, :password_confirmation
  end
end
