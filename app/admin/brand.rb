ActiveAdmin.register Brand do

  menu :priority => 3

  index do
    selectable_column
    column :name
    column :image
    column :image_32
    actions
  end
  
end
