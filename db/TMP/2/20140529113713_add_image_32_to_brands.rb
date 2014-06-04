class AddImage32ToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :image_32, :string
  end
end
