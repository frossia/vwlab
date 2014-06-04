class AutosController < ApplicationController

  def index
    redirect_to :root
  end

  def show
    @auto = Auto.find(params[:id])
    unless params[:catalog_id].blank?
      # @auto_items = Item.includes(:catalogs).where('catalogs.id' => params[:catalog_id])
      @auto_items = Item.joins(:catalogs, :generations).where('catalogs.id' => params[:catalog_id], 'generations.auto_id' => params[:id])
      @cat_name = Catalog.find(params[:catalog_id])
    else
      @auto_items = Item.includes(:generations).where('generations.auto_id' => @auto.id)
    end

    # @auto_catalog = Catalog.all.order(:lft)
    @auto_catalog = []
    Catalog.roots.each do |root|
      children = Catalog.includes(items: :generations).where('catalogs.parent_id' => root.id, 'generations.auto_id' => params[:id]).order(:lft)
      if children.any?
        @auto_catalog << root
        children.each do |child|
          @auto_catalog << child
        end
      end
    end
    # @auto_catalog = Catalog.autos_items(params[:id])
  end


end
