class PagesController < ApplicationController

  def index
    redirect_to :root
  end

  def show
    if Page.exists?(params[:id]) && Page.find(params[:id]).published
      @catalogs_all = Catalog.nested_set
      @page = Page.find(params[:id])
    else
      redirect_to :root
    end
  end

end
