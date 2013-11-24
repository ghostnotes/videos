require 'open-uri'
require 'json'
require 'nokogiri'
require "#{Rails.root}/lib/assets/utils_module"

module VideoSharingServices
  DEFAULT_MAX_TITLE_LENGTH = 30
  DEFAULT_MAX_CONTENT_LENGTH = 120
  DEFAULT_MAX_VIDEO_SIZE = 6

  class Youtube
    def self.get_feeds(category_id)
      feeds = []

      channels = Channel.where(category_id: category_id)
      channels.each do |channel|
        uri = URI(channel.feed_url)
        xml = Nokogiri::XML(uri.read)
        feed_doc = xml.root()

        author = feed_doc.children.search('author').first

        feed = {}
        feed[:channel_id] = channel.id
        feed[:channel_url] = channel.url
        feed[:channel_name] = author.children.search('name').text

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
            published: Utils::Strings.get_formatted_time(published.text),
            title: Utils::Strings.ellipse(media_title.text, DEFAULT_MAX_TITLE_LENGTH),
            thumbnail_url: media_thumbnails.first.attribute('url').to_s,
            description: Utils::Strings.ellipse(content.text, DEFAULT_MAX_CONTENT_LENGTH),
            url: media_player.attribute('url').to_s,
          }

          entries << entry
        end

        feed[:entries] = entries
        feeds << feed
      end

      feeds
    end

    def self.get_feeds_via_db(category_id)
      feeds = []

      channels = Channel.where(category_id: category_id)
      channels.each do |channel|
        feed = {}
        feed[:channel_id] = channel.id
        feed[:channel_url] = channel.url
        feed[:channel_name] = channel.name

        videos = Video.where(channel_id: channel.id)
        feed[:entries] = videos
        feeds << feed
      end

      feeds
    end
  end

  class Vimeo
  end
end