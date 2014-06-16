class CatalogsController < ApplicationController

  def index
    @catalog_all = Catalog.all.order(:lft).where('items.any', '1')

    @catalog_items = Item.limit(10)
  end

  def show
    @catalog_all = Catalog.all.order(:lft)

    @catalog_items = Catalog.find(params[:id]).items.page(params[:page])
  end

end
