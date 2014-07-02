ActiveAdmin.register Auto do

  actions :all, except: [:show]

  scope :all, :default => true do
    Auto.order('brand_id ASC, id ASC')
  end
  # scope :vw do |auto|
  #   auto.includes(:brand).where( :id => '1' ).order('created_at DESC')
  # end

  scope :vw do |autos|
    autos.where(:brand_id => 1)
  end

  scope :skoda do |autos|
    autos.where(:brand_id => 2)
  end

  scope :seat do |autos|
    autos.where(:brand_id => 3)
  end


  index do
    selectable_column
    column :name
    column :brand
    actions
  end

  form do |f|
    f.inputs 'Autos' do
      f.input :brand
      f.input :name
      f.input :car_image
      # f.input :generations
      # f.input :items, :input_html => { :size => 20}
      # f.select :catalogs, nested_set_options(Catalog) {|i| "#{'-' * i.level} #{i.name}" }
      # f.input :catalog_ids, :as => :select, :collection => nested_set_options(Catalog) {|i| "#{'-' * i.level} #{i.name}" }
      # f.input :auto_ids, :as => :select, :collection => User.all.map{|u| ["#{u.last_name}, #{u.first_name}", u.id]}
      # f.input :autos, :as => :select, :multipart => true

    end
    f.actions
  end


end
