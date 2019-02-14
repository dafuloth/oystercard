require_relative '../lib/oystercard'

describe Oystercard do
  it 'has a balance of 0 when newly initialized' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  describe 'top-up' do
    it 'When top up the amount is added to the balance' do
      card = Oystercard.new
      expect { card.top_up(Oystercard::MAXIMUM_LIMIT) }.to change { card.balance }.by Oystercard::MAXIMUM_LIMIT
    end

    it 'cannot be topped up above the limit' do
      card = Oystercard.new
      expect { card.top_up(900) }.to raise_error "Top-up aborted. Would exceed #{Oystercard::MAXIMUM_LIMIT} limit."
    end
  end

  describe '#deduct' do
    it 'reduces the total by an amount when deducted' do
      card = Oystercard.new
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      expect { card.deduct(40) }.to change { card.balance }.by -40
    end

    it 'reduces the balance by the amount, at the end of the journey' do
      card = Oystercard.new
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_out
      expect(card.balance).to eq Oystercard::MAXIMUM_LIMIT-1

    end
  end

  describe 'in use:' do
    let (:station) {double}
    let (:station2) {double}

    it 'the Oystercard is not in use' do
      expect(subject.in_journey?).to eq false
    end

    it 'is touched in' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      expect { subject.touch_in }.to change { subject.in_use }.from(false).to(true)
    end

    it 'is touched in and shows as in use' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it 'is touched out' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.in_use }.from(true).to(false)
    end

    it 'is touched out and no longer shows as in use' do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

    it 'Raises an error if touched in with a balance less than the minimum' do
      expect { subject.touch_in }.to raise_error('Insufficient Funds Available')
    end

    it 'records the entry station' do
      card = Oystercard.new
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end

    it "records the exit station when touch out" do
      card = Oystercard.new()
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_in(station)
      card.touch_out(station2)
      expect(card.exit_station).to be station2
    end

    it "Records the journey" do
      card = Oystercard.new()
      card.top_up(50)
      card.touch_in(station)
      card.touch_out(station2)
      journey = {:entry_station => station , :exit_station => station2}
      expect(card.history).to include journey
    end

    it "is touched but then not touched out. Penalty is applied" do      
      card = Oystercard.new
      card.top_up(90)
      aldgate = Station.new('Aldgate', 1)

      card.touch_in(aldgate)

      # User does not touch out
      card.touch_in(aldgate)

      expect(card.balance).to eq 84
    end
  end
end
