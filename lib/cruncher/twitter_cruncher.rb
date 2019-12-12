module Cruncher
  class TwitterCruncher
    require 'twitter'

    def initialize
      @client = ::Twitter::REST::Client.new do |config|
        # config.consumer_key    = Rails.application.credentials.twitter[:consumer_key]
        # config.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]
        # Only for the jury decision: API keys in plain text :(
        #TODO: Reset API keys!
        config.consumer_key    = 'SnxSPDeCj1LcDG5cuRljlxz7h'
        config.consumer_secret = 'ACGTioNBjnU9X8q1qkDoLjYerJTAAK0rHoRw6yovyYHf3qJTQ0'
      end
    end

    def update(lat:, long:, radius: "5km")
      # Call Twitter API to get tweets, parse JSON response
      geocode_parameter = "#{lat},#{long},#{radius}"
      options = {geocode: geocode_parameter,
                 count: 100,
                 result_type: 'recent'}

      api_result = @client.search("", option = options)

      parse_tweets(api_result)
    end

    private

    def parse_tweets(api_result)
      # puts api_result.first.inspect
      # pp api_result.first.attrs
      # api_result.first(10).map do |t|
      #   if t.geo.nil? && t.place
      #     pp t.attrs
      #   end
      # end

      compacted_tweets = api_result.first(20).collect do |t|
        if !t.geo.coordinates.nil?
          lat = t.geo.coordinates[0]
          long = t.geo.coordinates[1]
          geo_accuracy = 2
        elsif !t.place.nil?
          points = t.place.bounding_box.coordinates.flatten(1)
          lat, long = Geocoder::Calculations.geographic_center(points)
          geo_accuracy = 1
        else
          geo_accuracy = 0
        end

        if lat && long
          {screen_name: t.user.screen_name,
           real_name: t.user.name,
           text: t.text,
           # image: t.media.media_url,
           datetime: t.created_at,
           id: t.id,
           long: long,
           lat: lat,
           followers_count: t.user.followers_count,
           friends_count: t.user.friends_count,
           url: t.uri.to_s,
           geo_accuracy: geo_accuracy}
        end
      end

      compacted_tweets.compact
    end
  end
end
