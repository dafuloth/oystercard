require_relative '../lib/oystercard'

describe Oystercard do
  it 'has a balance of 0 when newly initialized' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  it 'When top up the ammount is added to the balance' do
    card = Oystercard.new
    current_balance = card.balance
    expect{card.top_up(100)}.to change{card.balance}.by 100
  end
end
