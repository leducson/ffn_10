class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :authorize_admin!

  def authorize_admin!
    return if current_user.admin?
    flash[:danger] = t "notice.login_notice"
    redirect_to root_path
  end
end
