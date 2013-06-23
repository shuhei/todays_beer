# encoding:utf-8

require_relative 'lib/rakuten'

class RakutenKeg
  def random_tweet
  end

  def random_beer
    client = Rakuten::IchibaItem.new application_id: ENV['RAKUTEN_APP_ID'],
      affiliate_id: ENV['RAKUTEN_AFFILIATE_ID'],
      version: '20130424'
    result = client.search keyword: 'ビール', shop_code: 'sake-taniguchi'
  end
end
