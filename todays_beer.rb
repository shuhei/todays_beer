require 'dotenv'
Dotenv.load
require 'twitter'
require_relative 'lib/amazon_keg'
require_relative 'lib/rakuten_keg'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.access_token = ENV['OAUTH_TOKEN']
  config.access_token_secret = ENV['OAUTH_TOKEN_SECRET']
end

class TodaysBeer
  def initialize(keg)
    @keg = keg
  end

  def tweet
    message = @keg.random_tweet
    puts message
    # client.update(message)
  end
end
