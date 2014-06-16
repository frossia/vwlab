class RenamePagePubished < ActiveRecord::Migration
  def change
    rename_column :pages, :pubished, :published
  end
end
