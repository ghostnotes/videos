class AddTitleToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :title, :string
  end
end
