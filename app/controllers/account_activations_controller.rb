class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = t ".activated"
      redirect_to root_path
    else
      flash[:danger] = t ".link_invalid"
      redirect_to signup_path
    end
  end
end
