ActiveAdmin.register Item do

  # default_scope -> { joins('autos').includes(:auto) }

  scope :all, :default => true

  scope :without_categories do |item|
    item.where(catalog: nil)
  end

  controller do
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

  actions :all, except: [:show]

  form :partial => "form"

  # form do |f|
  #   f.inputs 'Item' do
  #
  #     f.input :catalog_ids, :input_html => { :class => "chosen-input" }, :as => :select, :collection => nested_set_options(Catalog) {|i| "#{'-' * i.level} #{i.name}" }
  #     f.input :name
  #     f.input :description, as: :text
  #     f.input :price, as: :number
  #     f.input :old_price
  #     f.has_many :generation_items do |g|
  #       g.input :generation_id, :input_html => { :class => "chosen-input" }, :as => :select, :collection => Generation.all.map{|u| ["#{u.auto.name} -- #{u.name}", u.id]}
  #       g.input :dop_price
  #       g.input :_destroy, :as => :boolean
  #     end
  #     f.has_many :properties do |g|
  #       '<table><tbody><tr>#{cdasca}</tr></tbody></table>'
  #       g.input :name
  #       g.input :value
  #       g.input :_destroy, :as => :boolean
  #     end
  #     # f.inputs :name => 'NESTED', :for => :generation_items do |ff|
  #     #   ff.input :generation_id, :as => :select, :collection => Generation.all.map{|u| ["#{u.auto.name} -- #{u.name}", u.id]}
  #     #   ff.input :dop_price
  #     # end
  #     # f.has_many :auto_items
  #     # f.select :catalogs, nested_set_options(Catalog) {|i| "#{'-' * i.level} #{i.name}" }
  #     # f.input :auto_ids, :as => :select, :collection => User.all.map{|u| ["#{u.last_name}, #{u.first_name}", u.id]}
  #     # f.input :autos, :as => :select, :multipart => true, :input_html => { :size => 20}
  #
  #   end
  #   f.actions
  # end

end
