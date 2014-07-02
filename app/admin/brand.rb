ActiveAdmin.register Brand do


  index do
    selectable_column
    column :name
    column :image
    column :image_32
    actions
  end
  
end
