class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :vars

  def vars
    @auto_brands = Brand.all

    session[:items] ||= []
    if controller_name == 'items' && !session[:items].include?(params[:id])
      session[:items].delete_at(0) if session[:items].size >= 8
      session[:items] << params[:id]
    end
  end

end
