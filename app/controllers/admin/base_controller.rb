class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :check_user_with_namespace!

  def check_user_with_namespace!
    return if current_user.admin? || current_user.staff?
    flash[:danger] = t "notice.login_notice"
    redirect_to root_path
  end
end
