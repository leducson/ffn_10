class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :authenticate_user!

  def authorize_admin!
    return if current_user.admin?
    flash[:danger] = t "notice.login_notice"
    redirect_to root_path
  end
end
