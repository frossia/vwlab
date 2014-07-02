class AddInstallHoursToGenerationItems < ActiveRecord::Migration
  def change
    add_column :generation_items, :install_hours, :float, :default => 0, :null => false
  end
end
