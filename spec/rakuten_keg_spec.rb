# coding: utf-8

require_relative 'spec_helper'
require_relative '../lib/rakuten_keg'

describe RakutenKeg do
  subject { RakutenKeg.new }

  describe '#create_tweet' do
    let(:item) { {
      'itemName' => '【熊本地ビール】阿蘇ビール　ライズエール　330ml 0711',
      'itemCaption' => '※こちらの商品の賞味期限は2013年7月11日となっております。 内容量 330ml 保存方法 冷蔵 度数 4.5% 製造者 株式会社阿蘇ファームランド',
      'affiliateUrl' => 'http://rakuten.com/beer/123'
    } }

    it 'removes unnecessary words' do
      expect(subject.create_tweet item).not_to match /※こちらの商品の賞味期限は/
      expect(subject.create_tweet item).not_to match /内容量/
      expect(subject.create_tweet item).not_to match /保存方法/
    end
  end
end
