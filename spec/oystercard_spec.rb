require_relative '../lib/oystercard'

describe Oystercard do

  describe 'top-up' do
    it 'has a balance of 0 when newly initialized' do
      card = Oystercard.new
      expect(card.balance).to eq 0
    end

    it 'When top up the ammount is added to the balance' do
      card = Oystercard.new
      expect { card.top_up(90) }.to change{ card.balance }.by 90
    end

    it 'cannot be topped up above the limit' do
      card = Oystercard.new
      expect { card.top_up(900) }.to raise_error "Top-up aborted. Would exceed #{Oystercard::MAXIMUM_LIMIT} limit."
    end
  end
end
