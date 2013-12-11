require "#{Rails.root}/lib/assets/video_sharing_services_module"

namespace :videos do
  task get_feeds: :environment do
    puts 'Started getting feeds ...'
    Video.delete_all

    categories = Category.all
    categories.each do |category|
      puts "  requesting to category [ #{category.name} ] ..."
      feeds = VideoSharingServices::Youtube.get_feeds(category.id)
      feeds.each do |feed|
        puts "    processing the channel \"#{feed[:channel_name]}\" ..."
        channel = Channel.find(feed[:channel_id])
        channel.touch
        channel.update(name: feed[:channel_name])

        entries = feed[:entries]
        entries.each do |entry|
          Video.create(
            channel_id: feed[:channel_id],
            published: entry[:published],
            title: entry[:title],
            thumbnail_url: entry[:thumbnail_url],
            description: entry[:description],
            url: entry[:url],
          )
        end
      end
    end

    puts 'Finished.'
  end
end
