ActiveAdmin.register Page do

  actions :all, except: [:show]

  index do
    column :id
    column :title
    column :published
    column :created_at
    column :updated_at
    actions
  end
  
end
