class AddManhourToAutos < ActiveRecord::Migration
  def change
    add_column :autos, :manhour, :float
    add_column :items, :install_hours, :float
  end
end
