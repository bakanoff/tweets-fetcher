class TweetCreator < ApplicationService
  attr_reader :hashtag
  
  def initialize(hashtag)
    @hashtag = hashtag
  end

  def call
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end

    client.search(@hashtag, result_type: "recent").take(7).collect do |tweet|
      {
        user_name: tweet.user.screen_name,
        tweet_text: tweet.text,
        retweets_count: tweet.retweet_count,
        url: tweet.uri.to_s
      }
    end
  end
end