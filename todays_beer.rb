# encoding:utf-8

require 'twitter'
require 'dotenv'
require 'amazon/ecs'
require 'htmlentities'
require 'sanitize'

Dotenv.load

Twitter.configure do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.oauth_token = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
end

Amazon::Ecs.configure do |options|
  options[:associate_tag] = ENV['ASSOCIATE_TAG']
  options[:AWS_access_key_id] = ENV['AWS_ACCESS_KEY']
  options[:AWS_secret_key] = ENV['AWS_SECRET_KEY']
end

class TodaysBeer
  def random_beer
    res = Amazon::Ecs.item_search 'クラフトビール -セット',
      country: 'jp', search_index: 'Grocery', maximum_price: 1500,
      response_group: 'ItemAttributes,EditorialReview', item_page: rand(1..10)

    res.items[rand 0...res.items.size]
  end

  def create_tweet item
    title = item.get('ItemAttributes/Title').split('（')[0].strip
    url = item.get 'DetailPageURL'

    desc = item.get 'EditorialReviews/EditorialReview/Content'
    desc = HTMLEntities.new.decode desc
    desc = Sanitize.clean desc
    # Remove unnecessary spaces.
    desc = desc.gsub(/\r?\n/, ' ').gsub(/([、。])\s+/, '\1').gsub(/\s+/, ' ')

    "「#{title}」#{desc}"[0...110] + '... ' + url
  end

  def tweet
    message = create_tweet random_beer
    puts message
    Twitter.update message
  end
end
