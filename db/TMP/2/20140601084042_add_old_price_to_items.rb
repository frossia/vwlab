class AddOldPriceToItems < ActiveRecord::Migration
  def change
    add_column :items, :old_price, :decimal
    add_column :items, :partial_price, :decimal
  end
end
