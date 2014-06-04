class ItemsController < ApplicationController

  before_filter :viewed_items

  def index
    @item_catalog = Catalog.all
    @searched_items = Item.search(params[:search])
  end

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

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item_id])
      redirect_to :controller => "/admin/items",:action => "index"
    else
      redirect_to polymorphic_path([:admin, @item.owner])
    end
  end

end
