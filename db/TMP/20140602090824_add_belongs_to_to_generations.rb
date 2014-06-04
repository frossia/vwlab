class AddBelongsToToGenerations < ActiveRecord::Migration
  def change
    add_column :generations, :auto, :belongs_to
  end
  def self.down

  end
end
