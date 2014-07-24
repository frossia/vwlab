class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :url
      t.boolean :published, :default => true
      t.integer :position

      t.timestamps
    end
  end
end
