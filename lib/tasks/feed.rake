namespace :feed do
  task :get_feed_data => :environment do
    puts "getting feed data... #{ENV['DB_USERNAME']} #{ENV['DB_PASSWORD']}"

  end
end
