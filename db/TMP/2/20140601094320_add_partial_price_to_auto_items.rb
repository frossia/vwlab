class AddPartialPriceToAutoItems < ActiveRecord::Migration
  def change
    remove_column :items, :partial_price, :decimal
  end
end
