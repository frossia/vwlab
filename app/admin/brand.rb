ActiveAdmin.register Brand do

  menu :parent => "Автомобили"
  # menu :priority => 1

  index do
    selectable_column
    column :name
    column :image
    column :image_32
    actions
  end
  
end
