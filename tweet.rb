require 'twitter'
require 'dotenv'
require 'json'

Dotenv.load

Twitter.configure do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.oauth_token = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
end

def tweet_beer
  path = File.join File.dirname(__FILE__), 'random_beer.json'
  body = File.read  path
  json = JSON.parse body

  id = json['data']['id']
  name = json['data']['name']
  abv = json['data']['abv']
  style = json['data']['style']['name']

  message = "#{name}, #{abv}%, #{style}"

  Twitter.update message
end

tweet_beer
