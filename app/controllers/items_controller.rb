class ItemsController < ApplicationController

  before_action :authenticate_admin_user!, except: [:show, :index]
  before_filter :viewed_items

  def index
    @item_catalog = Catalog.all
    @searched_items = Item.search(params[:search])
    @ajax_search = []
    @searched_items.each_with_index do |item, i|
      ii = item.attributes
      ii['catalog'] = item.catalog.name
      @ajax_search << ii
    end
    if @ajax_search
      respond_to do |format|
        format.html
        format.json{
          render :json => @ajax_search.to_json
        }
      end

    else
      format.json{
        render :status => "Something went wrong with your upload!", :error => "Something went wrong with your upload!"
      }
    end
  end

  def show
    @item_catalog = Catalog.all.order(:lft)
    @item = Item.find(params[:id])
  end

  def viewed_items
    session[:items] ||= []
    if controller_name == 'items' && !session[:items].include?(params[:id])
      session[:items].delete_at(0) if session[:items].size >= 9
      session[:items] << params[:id]
    end
  end

  def update
    sleep 1.5
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update_attributes(params[:item])
        x = {}
        x = { :catalog => Catalog.find(@item.catalog_id), :item => @item }
        format.json { render :json => x }
      end
    end
  end

  def new
    @item = Item.new
    respond_to do |format|
      format.json { render json: @item}
    end
  end

  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.json { render :json => @item }
      end
    end
  end


end
