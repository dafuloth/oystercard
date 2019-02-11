require_relative '../lib/oystercard'

describe Oystercard do
  it 'has a balance of 0 when newly initialized' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  describe 'top-up' do
    it 'When top up the amount is added to the balance' do
      card = Oystercard.new
      expect { card.top_up(90) }.to change { card.balance }.by 90
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
      expect { card.deduct(40) }.to change { card.balance }.by -40
    end
  end

  describe 'in use:' do
    it 'the Oystercard is not in use' do
      expect(subject.in_journey?).to eq false
    end

    it 'is touched in' do
      expect { subject.touch_in }.to change { subject.in_use }.from(false).to(true)
    end

    it 'is touched in and shows as in use' do
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it 'is touched out' do
      subject.touch_in
      expect { subject.touch_out }.to change { subject.in_use }.from(true).to(false)
    end

    it 'is touched out and no longer shows as in use' do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end
end
