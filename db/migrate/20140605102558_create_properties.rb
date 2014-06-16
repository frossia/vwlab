class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :value
      t.belongs_to :item

      t.timestamps
    end
  end
end
