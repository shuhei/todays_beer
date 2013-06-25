# coding: utf-8

require_relative 'spec_helper'
require_relative '../lib/rakuten_keg'

describe RakutenKeg do
  let(:keg) { RakutenKeg.new }

  describe '#create_tweet' do
    let(:item) { {
      'itemName' => '【熊本地ビール】阿蘇ビール　ライズエール　330ml 0711',
      'itemCaption' => '※こちらの商品の賞味期限は2013年7月11日となっております。 内容量 330ml 保存方法 冷蔵 度数 4.5% 製造者 株式会社阿蘇ファームランド 商品説明 ここから商品の説明です。',
      'affiliateUrl' => 'http://rakuten.com/beer/123'
    } }
    subject { keg.create_tweet item }

    it 'removes note about expiry date' do
      expect(subject).not_to match(/※こちらの商品の賞味期限は/)
    end

    it 'removes content label' do
      expect(subject).not_to match(/ 内容量 /)
    end

    it 'removes storage condition label' do
      expect(subject).not_to match(/ 保存方法 /)
    end

    it 'removes brewery label' do
      expect(subject).not_to match(/ 製造者 /)
    end

    it 'removes item description label' do
      expect(subject).not_to match(/ 商品説明 /)
    end

    it 'wraps brewery name in parentheses' do
      expect(subject).to match(/ \(株式会社阿蘇ファームランド\) /)
    end
  end
end
