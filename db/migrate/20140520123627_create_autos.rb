class CreateAutos < ActiveRecord::Migration
  def change
    create_table :autos do |t|

      t.string :name
      t.string :color
      t.belongs_to :brand

      t.timestamps
    end
  end
end
