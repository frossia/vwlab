class AddColorsToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :color, :string
  end
end
