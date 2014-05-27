class CreateAutosItems < ActiveRecord::Migration
  def change
    create_table :autos_items do |t|

      t.belongs_to :auto
      t.belongs_to :item

      t.timestamps
    end
  end
end
