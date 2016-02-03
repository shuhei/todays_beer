require_relative 'spec_helper'
require_relative '../lib/paginator'

describe 'Paginator' do
  subject { Paginator.new(832, 100, 30) }

  describe '#min_per_page' do
    it 'calculates minimum per page' do
      expect(subject.min_per_page).to eq(9)
    end
  end

  describe '#at' do
    let(:position) { subject.at(123) }

    it 'calculates page number starting from 0' do
      expect(position.page).to eq(13)
    end

    it 'calculates index in page starting from 0' do
      expect(position.index_in_page).to eq(5)
    end
  end

  describe '$random' do
    before :each do
      expect(subject).to receive(:rand).and_return(123)
    end

    it 'returns a position at random index' do
      expect(subject.random).to be_a(Paginator::Position)
    end

    it 'calculates page number' do
      expect(subject.random.page).to eq(13)
    end

    it 'calculates index in page' do
      expect(subject.random.index_in_page).to eq(5)
    end
  end
end
