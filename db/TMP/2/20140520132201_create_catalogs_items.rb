class CreateCatalogsItems < ActiveRecord::Migration
  def change
    create_table :catalogs_items do |t|

      t.belongs_to :catalog
      t.belongs_to :item

      t.timestamps
    end
  end
end
