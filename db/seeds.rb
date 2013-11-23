# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# coding: utf-8

# delete all data in the database.
Channel.delete_all
Category.delete_all

# create Categories.
Videos::Category.all.each do |category_name|
  Category.create(name: category_name)
end

# create Channels.
Videos::Category.all.each do |category_name|
  category = Category.first(conditions: { name: category_name })
  channels = VideoSharingServices::Youtube::CHANNELS[category_name]

  channels.each do |username|
    Channel.create(
      category_id: category.id,
      username: username,
      url: "http://www.youtube.com/user/#{username}",
      feed_url: "http://gdata.youtube.com/feeds/api/users/#{username}/uploads",
    )
  end
end
