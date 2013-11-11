# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131111063134) do

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "channels", force: true do |t|
    t.integer  "category_id", null: false
    t.string   "username",    null: false
    t.string   "url"
    t.string   "feed_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channels", ["category_id"], name: "index_channels_on_category_id", using: :btree
  add_index "channels", ["username"], name: "index_channels_on_username", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.integer  "channel_id",    null: false
    t.string   "published"
    t.string   "title"
    t.string   "thumbnail_url"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["channel_id"], name: "index_videos_on_channel_id", using: :btree

  add_foreign_key "channels", "categories", name: "channels_category_id_fk"

  add_foreign_key "videos", "channels", name: "videos_channel_id_fk"

end
