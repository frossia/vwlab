class CreateGenerations < ActiveRecord::Migration
  def change
    create_table :generations do |t|
      t.string :name
      t.float  :manhour
      t.belongs_to :auto

      t.timestamps
    end
  end
end
