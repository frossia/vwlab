class ChangeManhours < ActiveRecord::Migration
  def change
    change_column :generations, :manhour, :float, :default => 0, :null => false
  end
end
