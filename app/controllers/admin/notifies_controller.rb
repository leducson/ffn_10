class Admin::NotifiesController < Admin::BaseController
  load_and_authorize_resource
  def index
    @notifies =
      current_user.notifies.newest.page(params[:page]).per Settings.notify_per
  end
end
