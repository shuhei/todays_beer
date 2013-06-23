# encoding:utf-8

require 'dotenv'
Dotenv.load
require 'twitter'
require_relative 'amazon_keg'
require_relative 'rakuten_keg'

Twitter.configure do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.oauth_token = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
end

class TodaysBeer
  def tweet
    keg = AmazonKeg.new
    message = keg.random_tweet
    puts message
    Twitter.update message
  end
end
