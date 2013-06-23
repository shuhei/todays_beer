# encoding:utf-8

require 'dotenv'
Dotenv.load
require 'twitter'
require_relative 'lib/amazon_keg'
require_relative 'lib/rakuten_keg'

Twitter.configure do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.oauth_token = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
end

class TodaysBeer
  def initialize keg
    @keg = keg
  end

  def tweet
    message = @keg.random_tweet
    puts message
    Twitter.update message
  end
end
