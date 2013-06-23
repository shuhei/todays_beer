# coding: utf-8

require_relative 'spec_helper'
require_relative '../lib/rakuten'

describe Rakuten::Client do
  let(:client) { Rakuten::Client.new params }

  describe '#request_url' do
    context 'without target' do
      let(:params) { { version: '20130424' } }

      it 'raises an error' do
        expect { client.request_url 'verb', {} }.to raise_error
      end
    end

    context 'without version' do
      let(:params) { { target: 'IchibaItem' } }

      it 'raises an error' do
        expect { client.request_url 'verb', {} }.to raise_error
      end
    end

    context 'with target and version' do
      let(:params) { { target: 'IchibaItem', version: '20130424' } }
      let(:url) { client.request_url 'verb', {} }

      it 'does not raise error' do
        expect { client.request_url 'verb', {} }.to_not raise_error
      end

      it 'includes target, verb and version in the path' do
        expect(url).to include 'https://app.rakuten.co.jp/services/api/IchibaItem/Verb/20130424?'
      end

      context 'with application ID and affiliate ID' do
        let(:params) { { target: 'IchibaItem', version: '20130424', application_id: 'app' } }

        it 'sets application ID as a parameter' do
          expect(url).to match /application_id=app/
        end
      end
    end
  end
end

describe Rakuten::IchibaItem do
  describe '.new' do
    subject { Rakuten::IchibaItem.new({}) }

    it 'sets target' do
      expect(subject.instance_variable_get '@target').to eq 'IchibaItem'
    end
  end
end

describe Rakuten::IchibaGenre do
  describe '.new' do
    subject { Rakuten::IchibaGenre.new({}) }

    it 'sets target' do
      expect(subject.instance_variable_get '@target').to eq 'IchibaGenre'
    end
  end
end
