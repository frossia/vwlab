class CatalogsController < ApplicationController

  include TheSortableTreeController::Rebuild

  def index
    @catalogs_all = Catalog.nested_set.order('lft ASC')

    @catalog_items = Item.limit(10).order('created_at DESC')
  end

  def show
    @catalogs_all = Catalog.nested_set

    @catalog_items = Catalog.find(params[:id]).items.page(params[:page])
  end

end
