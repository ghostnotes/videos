class RenameColumnTitle < ActiveRecord::Migration
  def up
    rename_column :channels, :title, :name
  end

  def down
    rename_column :channels, :name, :title
  end
end
