class ItemsController < ApplicationController

  before_action :authenticate_admin_user!, only: [:new, :update, :create, :remove_image]
  before_filter :viewed_items

  def index
    if params[:promo].present?
      @item_catalog = Item.all
      @item_catalog = Catalog.all
      @catalogs_all = Catalog.nested_set.order('lft ASC')
      @searched_items = Item.where.not(old_price: nil)
    elsif params[:search].present?
      @item_catalog = Catalog.all
      @catalogs_all = Catalog.nested_set.order('lft ASC')
      @searched_items = Item.search(params[:search])
      @ajax_search = []
      if @searched_items.any?
        @searched_items.each_with_index do |item, i|
          ii = item.attributes
          ii['catalog'] = item.catalog.name if item.catalog
          @ajax_search << ii
        end
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
  end

  def show
    @catalogs_all = Catalog.nested_set.order('lft ASC')
    @item = Item.find(params[:id])
    if params[:auto_id]
      @auto = Auto.find(params[:auto_id])
    end
  end

  def viewed_items
    session[:items] ||= []
    if controller_name == 'items' && !session[:items].include?(params[:id])
      session[:items].delete_at(0) if session[:items].size >= 9
      session[:items] << params[:id]
    end
  end

  def add_to_favorites
    session[:favorite_items] ||= []

    if !session[:favorite_items].include?(params[:item].to_i)
      @item = Item.find(params[:item])
      @item.item_attachments.any? ? (image = @item.item_attachments.first.image.url(:small_thumb)) : image = '/assets/item_no_image.png'
      session[:favorite_items] << params[:item].to_i
    end

    respond_to do |format|
      format.json{
        if @item
          render json: {id: @item.id, name: @item.name, :image => image}
          # render @item.to_json(:only => [:id,:name], :image => @item.item_attachments.first.image.small_thumb)
        end
      }
    end
  end

  def remove_from_favorites
    session[:favorite_items].delete(params[:item].to_i)
    respond_to do |format|
      format.json{
        render :json =>  {id: params[:item].to_i, items: session[:favorite_items]}.to_json
      }
    end
  end

  def clear_favorites
    session[:favorite_items] = []
    redirect_to :root
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
