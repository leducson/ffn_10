class ApplicationController < ActionController::Base
  layout :load_layout_devise
  protect_from_forgery with: :exception
  before_action :load_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :not_found?

  def load_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def not_found?
    render file: "#{Rails.root}/public/404.html", status: 403, layout: false
  end

  private

  def after_sign_in_path_for(resource)
    return admin_root_path if resource.admin?
    return root_path
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: User::USER_PARAMS)
   devise_parameter_sanitizer.permit(:update_account, keys: User::USER_PARAMS)
  end

  def load_layout_devise
    "users" if devise_controller?
  end
end
