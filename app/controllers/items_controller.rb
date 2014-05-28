class ItemsController < ApplicationController

  before_filter :viewed_items

  def show
    @item_catalog = Catalog.all.order(:lft)
    @item = Item.find(params[:id])
  end

  def viewed_items
    session[:items] ||= []
    if controller_name == 'items' && !session[:items].include?(params[:id])
      session[:items].delete_at(0) if session[:items].size >= 8
      session[:items] << params[:id]
    end
  end

end
