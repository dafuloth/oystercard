require_relative '../lib/oystercard'

describe Oystercard do

  it 'has a balance of 0 when newly initialized' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  describe 'top-up' do
    it 'When top up the amount is added to the balance' do
      card = Oystercard.new
      expect { card.top_up(90) }.to change{ card.balance }.by 90
    end

    it 'cannot be topped up above the limit' do
      card = Oystercard.new
      expect { card.top_up(900) }.to raise_error "Top-up aborted. Would exceed #{Oystercard::MAXIMUM_LIMIT} limit."
    end
  end

  describe 'deduct' do
    it 'reduces the total by an amount when deducted' do
      card = Oystercard.new
      card.top_up(90)
      expect { card.deduct(40) }.to change{ card.balance }.by -40
    end
  end
end
