ActiveAdmin.register Catalog do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  actions :all, except: [:show]

  index do
    column :id
    column :name
    column :parent_id
    column :lft
    column :rgt
    column :depth
    actions
  end

  form do |f|
    f.inputs 'Item' do
      f.input :parent_id, :as => :select, :collection => nested_set_options(Catalog) {|i| "#{'-' * i.level} #{i.name}" }
      f.input :name
      f.input :items, :input_html => { :class => "chosen-input" }, :as => :select, :collection => Item.all.map {|i| ["#{i.name}", i.id] }

      # f.select :catalogs, nested_set_options(Catalog) {|i| "#{'-' * i.level} #{i.name}" }
      # f.input :auto_ids, :as => :select, :collection => User.all.map{|u| ["#{u.last_name}, #{u.first_name}", u.id]}
      # f.input :autos, :as => :select, :multipart => true

    end
    f.actions
  end
  
end
