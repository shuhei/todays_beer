# encoding:utf-8

require_relative 'rakuten'
require_relative 'paginator'

class RakutenKeg
  def initialize
    @client = Rakuten::IchibaItem.new application_id: ENV['RAKUTEN_APP_ID'],
      affiliate_id: ENV['RAKUTEN_AFFILIATE_ID'],
      version: '20130424'
  end

  def random_tweet
    create_tweet random_beer
  end

  def random_beer
    search_options = { keyword: '地ビール', shop_code: 'sake-taniguchi' }
    count = total_count search_options

    paginator = Paginator.new count, Rakuten::MAX_PAGE, Rakuten::MAX_PER_PAGE
    position = paginator.random

    random_options = { page: position.page + 1, hits: paginator.min_per_page }

    result = @client.search search_options.merge(random_options)
    result['Items'][position.index_in_page]['Item']
  end

  def total_count options
    result = @client.search options
    result['count']
  end

  def create_tweet item
    name = item['itemName']
    caption = item['itemCaption']
    affiliate_url = item['affiliateUrl']

    "「#{name}」#{caption}"[0...110] + '... ' + affiliate_url
  end
end