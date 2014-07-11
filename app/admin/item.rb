ActiveAdmin.register Item do

  # default_scope -> { joins('autos').includes(:auto) }
  actions :all, except: [:show]

  scope :all, :default => true

  scope :without_categories do |item|
    item.where(catalog: nil)
  end

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
    column :id
    column :name
    column :price
    column :catalog
    actions
  end

end
