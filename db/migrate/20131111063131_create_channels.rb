class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.references :category, index: true, null: false
      t.foreign_key :categories
      t.string :username, null: false
      t.string :url
      t.string :feed_url

      t.timestamps
    end

    add_index :channels, [ :username ], unique: true
  end
end
