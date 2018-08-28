class PasswordResetsController < ApplicationController
  layout "users"

  before_action :load_user, :check_expire, :valid_user, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".sent_email"
      redirect_to root_path
    else
      flash[:danger] = t ".not_address"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t(".pass_blank")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t ".success_reset"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by email: params[:email]
    return if @user.present?
    flash[:danger] = t ".user_exist"
    render :new
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])
    flash[:danger] = t ".user_valid"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def check_expire
    return unless @user.password_reset_expired?
    flash[:danger] = t ".reset_expire"
    redirect_to new_password_reset_path
  end
end
