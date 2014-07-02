ActiveAdmin.register Catalog do

  config.sort_order = "id_asc"

  index do
    render 'catalog_tree'
  end

  # collection_action :index, :method => :get do
  #
  #   Auto.new
  # end

  controller do
    include TheSortableTreeController::Rebuild

    def manage
      @catalogs = Catalog.nested_set.select('id, name, parent_id').page(1).per(1000)
    end

    def index
      index! do |format|
        @collection = Catalog.nested_set.select('id, name, parent_id').page(1).per(1000)
        format.html
      end
    end

    # def index
    #   @catalogs = Catalog.nested_set.select('id, name, parent_id').all
    #   @collection = @catalogs.page(1).per(1000)
    # end

  end

  # index :as => :block do
  #   label :name
    # column :id
    # column :name
    # column :parent_id
    # column :lft
    # column :rgt
    # column :depth
    # actions
  # end

  form do |f|
    f.inputs 'Item' do
      f.input :parent_id, :as => :select, :collection => nested_set_options(Catalog) {|i| "#{'-' * i.level} #{i.name}" }
      f.input :name
      f.input :items, :input_html => { :class => "chosen-input" }, :as => :select, :collection => Item.all.map {|i| [" #{i.name}", i.id] }

      # f.select :catalogs, nested_set_options(Catalog) {|i| "#{'-' * i.level} #{i.name}" }
      # f.input :auto_ids, :as => :select, :collection => User.all.map{|u| ["#{u.last_name}, #{u.first_name}", u.id]}
      # f.input :autos, :as => :select, :multipart => true

    end
    f.actions
  end
  
end
