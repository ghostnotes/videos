require 'open-uri'
require 'json'
require 'nokogiri'

#require 'category'

DEFAULT_MAX_TITLE_LENGTH = 30
DEFAULT_MAX_CONTENT_LENGTH = 120
DEFAULT_MAX_VIDEO_SIZE = 6

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

class CategoriesController < ApplicationController
  CHANNELS = {
#    Category::TECHNOLOGY => TECHNOLOGY_CHANNELS,
#    Category::ENGLISH =>  ENGLISH_CHANNELS,
#    Category::BUSINESS => BUSINESS_CHANNELS,
    'Technology' => TECHNOLOGY_CHANNELS,
    'English' =>  ENGLISH_CHANNELS,
    'Business' => BUSINESS_CHANNELS,
  }

  def show
    @categories = Category.find(:all)

    if request.path == '/'
      @current_category = @categories.first
    else
      @current_category = find_category(params[:id], @categories)
    end

    if @current_category.nil?
      render file: 'public/404.html'
      return
    end

    feed_channels = CHANNELS[@current_category.name]

    @feeds = []

    feed_channels.each do |channel|
      uri = URI("http://gdata.youtube.com/feeds/api/users/#{channel}/uploads")
      xml = Nokogiri::XML(uri.read)
      feed_doc = xml.root()

      author = feed_doc.children.search('author').first

      feed = {}
      feed[:channel_name] = author.children.search('name').text
      feed[:channel_url] = "http://www.youtube.com/user/#{channel}"

      entries = []
      feed_doc.search('entry').each_with_index do |entry, i|
        if i >= DEFAULT_MAX_VIDEO_SIZE
          break
        end

        published = entry.children.search('published')
        content = entry.children.search('content')
        media_title = entry.xpath('media:group/media:title')
        media_thumbnails = entry.xpath('media:group/media:thumbnail')
        media_player = entry.xpath('media:group/media:player')
        entry = {
            published: get_formatted_time(published.text),
            title: substring(media_title.text, DEFAULT_MAX_TITLE_LENGTH),
            image: media_thumbnails.first.attribute('url').to_s,
            content: substring(content.text, DEFAULT_MAX_CONTENT_LENGTH),
            player: media_player.attribute('url').to_s,
        }

        entries << entry
      end

      feed[:entries] = entries
      @feeds << feed
    end
  end

  private

  def find_category(category_name, categories)
    categories.each do |category|
      if category_name == category.name
        return category
      end
    end

    nil
  end

  def exists_category(category_name, categories)
    categories.each do |category|
      if category_name == category.name
        return true
      end
    end

    return false
  end

  def substring(text, max_length)
    if text.length > max_length
      text[0..max_length] + '...'
    else
      text
    end
  end

  def get_formatted_time(date_str)
    date = DateTime.parse(date_str)
    date.strftime('%Y/%m/%d %H:%M:%S')
  end
end