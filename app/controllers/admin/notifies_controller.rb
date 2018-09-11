class Admin::NotifiesController < Admin::BaseController
  def index
    @notifies =
      current_user.notifies.newest.page(params[:page]).per Settings.notify_per
  end
end
