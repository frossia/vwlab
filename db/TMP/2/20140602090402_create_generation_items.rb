class CreateGenerationItems < ActiveRecord::Migration
  def change
    create_table :generation_items do |t|
      t.belongs_to :generation
      t.belongs_to :item

      t.decimal    :dop_price
    end
  end
end
