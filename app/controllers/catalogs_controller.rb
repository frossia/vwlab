class CatalogsController < ApplicationController

  def index
    @catalog_items = Item.all
    @catalog_all = Catalog.all.order(:lft)
  end

  def show
    @catalog_all = Catalog.all.order(:lft)
    @catalog_items = Catalog.find(params[:id]).items
  end

end
