# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# coding: utf-8

TECHNOLOGY_CHANNELS = Array[
  'xdadevelopers',
  'jon4lakers',
  'SoldierKnowsBest',
  'revision3',
  'TheTechFeed',
  'geekbeattv',
  'engadget',
  'marquesbrownlee',
  'phonedog',
  'Rev3Games',
]

ENGLISH_CHANNELS = Array[
  'cyoshida1231',
]

BUSINESS_CHANNELS = Array[
  'takaponjp',
]

CATEGORY_CHANNELS = {
  Technology: TECHNOLOGY_CHANNELS,
  Business: BUSINESS_CHANNELS,
  English: ENGLISH_CHANNELS,
}

# delete all data in the database.
Category.delete_all
Channel.delete_all

# create Categories.
CATEGORY_CHANNELS.keys.each do |category|
  Category.create(name: category)
end

# create Channels.
CATEGORY_CHANNELS.keys.each do |category_name|
  category = Category.find(:first, conditions: { name: category_name })
  channels = CATEGORY_CHANNELS[category_name]

  channels.each do |username|
    Channel.create(
      category_id: category.id,
      username: username,
      url: "http://www.youtube.com/user/#{username}",
      feed_url: "http://gdata.youtube.com/feeds/api/users/#{username}/uploads",
    )
  end
end
