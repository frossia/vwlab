class ItemsController < ApplicationController

  def show
    @item_catalog = Catalog.all.order(:lft)
    @item = Item.find(params[:id])
  end

end
