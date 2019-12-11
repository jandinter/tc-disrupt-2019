module Cruncher
  class TwitterCruncher
    require 'twitter'

    def initialize
      @client = ::Twitter::REST::Client.new do |config|
        config.consumer_key    = Rails.application.credentials.twitter[:consumer_key]
        config.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]
      end
    end

    def update(lat:, long:, radius: "5km")
      # Call Twitter API to get tweets, parse JSON response
      geocode_parameter = "#{lat},#{long},#{radius}"
      options = {geocode: geocode_parameter,
                 count: 100}

      puts "API search parameters: #{options}"

      api_result = @client.search("", option = options)

      puts "Tweets: #{api_result.count}"

      parse_tweets(api_result)
    end

    private

    def parse_tweets(api_result)
      # puts api_result.first.inspect
      # pp api_result.first.attrs

      compacted_tweets = api_result.first(20).collect do |t|
        {screen_name: t.user.screen_name,
         real_name: t.user.name,
         text: t.text,
         datetime: t.created_at,
         id: t.id,
         long: t.geo.coordinates[0],
         lat: t.geo.coordinates[1],
         followers_count: t.user.followers_count,
         friends_count: t.user.friends_count,
         url: t.uri.to_s }
      end

      pp compacted_tweets
      compacted_tweets
    end
  end
end
