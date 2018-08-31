class SessionsController < ApplicationController
  layout "users"

  def login; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      rememberable user
      after_sign_in_path user
    else
      flash.now[:danger] = t ".error"
      render :login
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def rememberable user
    if params[:session][:remember_me] == Settings.sessions.remember_me
      remember user
    else
      forget user
    end
  end
end
