ActiveAdmin.register Item do

  # default_scope -> { joins('autos').includes(:auto) }
  actions :all, except: [:show]

  filter :catalog, :input_html => { :class => "chosen-input" }, :as => :select, :collection => proc { grouped_options_for_select(grouped_options, (@catalog.id if @catalog)) }
  filter :name
  filter :price

  scope :all, :default => true

  scope 'Товары без категории' do |item|
    item.where(catalog: nil)
  end

  scope 'Акции' do |item|
    item.where.not(old_price: nil)
  end

  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  # config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable # creates the controller action which handles the sorting


  controller do
    before_filter :remove_favorites, only: :destroy

    def remove_favorites
      session[:favorite_items].delete(params[:id].to_i)
    end

    def scoped_collection
      Item.includes(generations: :auto)
    end

    def add_all_generations
      if params[:id]
        @item = Item.find(params[:item])
      else
        @item = Item.new
      end

      @item.generation_items.build
      @generations = Generation.all.order('auto_id ASC')
      respond_to do |format|
        format.js #add_question.js.erb
      end
    end
  end


  form :partial => "form"

  index do
    sortable_handle_column
    column :position
    column '' do |item|
      unless item.item_attachments.blank?
        image_tag item.item_attachments.first.image.small_thumb, class:'small_thumb'
      end
    end
    column :name
    column :price do |p|
      span number_to_currency(p.price, locale: :ru), style: ('color:#E20000; font-weight: bold;' if p.old_price), class:'price-label'
    end
    column :catalog do |c|
      if c.catalog
        link_to c.catalog.name, edit_admin_catalog_path(c.catalog.id)
      else
        link_to "Товар без кагории!", edit_admin_item_path(c), style: 'color: red;'
      end
    end
    actions
  end

end
