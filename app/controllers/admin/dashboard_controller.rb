class Admin::DashboardController < Admin::BaseController
  authorize_resource class: false

  def index; end
end
