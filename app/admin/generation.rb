ActiveAdmin.register Generation do

  actions :all, except: [:show]

  scope :all, :default => true do
    Generation.order('auto_id ASC')
  end

  index do
    selectable_column
    column :name do |i|
      best_in_place i, :name, :type => :input, :path => [:admin, i]
    end
    column :auto_id do |auto|
      best_in_place auto, :auto_id, :type => :select, :path =>[:admin,auto], :collection => Auto.all.map{|i| [i.id, "#{i.name}"]}
    end
    column :manhour do |i|
      best_in_place i, :manhour, :type => :input, :path => [:admin, i]
    end
    actions
  end

end
