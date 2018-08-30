class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def load_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
