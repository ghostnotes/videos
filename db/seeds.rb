# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# coding: utf-8
require 'csv'

# delete all data in the database.
Channel.delete_all
Category.delete_all

# create Categories.
CSV.foreach('db/categories.csv') do |row|
  Category.create(name: row[0])
end

categories = Category.all

categories.each do |category|
  CSV.foreach("db/channels_#{category.name}.csv") do |row|
    username = row[0]
    Channel.create(
      category_id: category.id,
      username: username,
      url: "http://www.youtube.com/user/#{username}",
      feed_url: "http://gdata.youtube.com/feeds/api/users/#{username}/uploads",
    )
  end
end
