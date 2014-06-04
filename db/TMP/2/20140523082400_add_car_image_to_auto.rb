class AddCarImageToAuto < ActiveRecord::Migration
  def change
    add_column :autos, :car_image, :string
  end
end
