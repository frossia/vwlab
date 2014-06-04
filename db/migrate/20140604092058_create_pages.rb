class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :intro
      t.text :full
      t.boolean :pubished, :default => true

      t.timestamps
    end
  end
end
