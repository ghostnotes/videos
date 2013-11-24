require 'open-uri'
require 'json'
require 'nokogiri'
require "#{Rails.root}/lib/assets/video_sharing_services_module"

DEFAULT_MAX_TITLE_LENGTH = 30
DEFAULT_MAX_CONTENT_LENGTH = 120
DEFAULT_MAX_VIDEO_SIZE = 6

class CategoriesController < ApplicationController
  def show
    @categories = Category.all

    @current_category = nil
    if request.path == '/'
      @current_category = @categories.first
    else
      requested_category_name = params[:id]
      @current_category = Category.where(name: requested_category_name).first
    end

    if @current_category.nil?
      render file: 'public/404.html'
      return
    end

    feed_channels = Channel.where(category_id: @current_category.id)

    @feeds = []

    feed_channels.each do |channel|
      uri = URI(channel.feed_url)
      xml = Nokogiri::XML(uri.read)
      feed_doc = xml.root()

      author = feed_doc.children.search('author').first

      feed = {}
      feed[:channel_name] = author.children.search('name').text
      feed[:channel_url] = channel.url

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