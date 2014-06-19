class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_filter :vars

  def vars
    @settings = YAML.load_file "config/settings.yml"
    @auto_brands = Brand.all
    @reception   = Reception.new
    I18n.locale = params[:locale] || I18n.default_locale
  end


end
