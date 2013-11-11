class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :channel, index: true, null: false
      t.foreign_key :channels
      t.string :published
      t.string :title
      t.string :thumbnail_url
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
