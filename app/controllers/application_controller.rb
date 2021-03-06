class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_filter :vars

  def vars
    Settings.title ||= 'VWLab.ru'

    @settings = YAML.load_file "config/settings.yml"
    @auto_brands = Brand.all
    @reception   = Reception.new
    I18n.locale = params[:locale] || I18n.default_locale

    @links = [
        { name: 'test1', url: '/pages/1' },
        { name: 'test2', url: '/pages/2' }
    ]

    session[:favorite_items] ||= []
  end


end
