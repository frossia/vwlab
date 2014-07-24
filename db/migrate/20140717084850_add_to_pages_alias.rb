class AddToPagesAlias < ActiveRecord::Migration
  def change
    add_column :pages, :alias, :string, :unique => true
  end
end
