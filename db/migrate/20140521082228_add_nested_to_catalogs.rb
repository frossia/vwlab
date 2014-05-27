class AddNestedToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :parent_id, :integer # Comment this line if your project already has this column
    add_column :catalogs, :lft      , :integer
    add_column :catalogs, :rgt      , :integer
    add_column :catalogs, :depth    , :integer  # this is optional.
  end
end
