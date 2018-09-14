class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_locale
  rescue_from ActiveRecord::RecordNotFound, with: :not_found?

  def load_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def not_found?
    render file: "#{Rails.root}/public/404.html", status: 403, layout: false
  end

  private
  def after_sign_in_path_for(resource)
		root_path
	end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
