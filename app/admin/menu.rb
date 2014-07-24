ActiveAdmin.register Menu do

  menu :parent => "Контент"

  actions :all, except: [:show]

  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported
  sortable # creates the controller action which handles the sorting

  index do
    sortable_handle_column
    column :title
    column :url
    column :published
    actions
  end

end
