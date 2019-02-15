require_relative '../lib/oystercard'

describe Oystercard do

  let (:journey_double) {double(:journey_double, start: nil, end: nil) }

  let (:journey) {double(:journey, new: journey_double)}

  let (:card) { Oystercard.new(journey) }
  
  let (:entry_station) {double}

  let (:exit_station) {double}

  it 'has a balance of 0 when newly initialized' do
    expect(card.balance).to eq 0
  end

  describe 'top-up' do
    it 'When top up the amount is added to the balance' do
      
      expect { card.top_up(Oystercard::MAXIMUM_LIMIT) }.to change { card.balance }.by Oystercard::MAXIMUM_LIMIT
    end

    it 'cannot be topped up above the limit' do
      expect { card.top_up(900) }.to raise_error "Top-up aborted. Would exceed #{Oystercard::MAXIMUM_LIMIT} limit."
    end
  end

  describe '#deduct' do
    it 'reduces the total by an amount when deducted' do
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      expect { card.deduct(40) }.to change { card.balance }.by -40
    end

    it 'reduces the balance by the amount, at the end of the journey' do
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_out
      expect(card.balance).to eq Oystercard::MAXIMUM_LIMIT-1

    end
  end

  describe 'in use:' do

    it 'the Oystercard is not in use' do
      expect(card.in_journey?).to eq false
    end

    xit 'is touched in' do
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      expect { card.touch_in }.to change { card.in_use }.from(false).to(true)
    end

    xit 'is touched in and shows as in use' do
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_in
      expect(card.in_journey?).to eq true
    end

    xit 'is touched out' do
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_in
      expect { card.touch_out }.to change { card.in_use }.from(true).to(false)
    end

    xit 'is touched out and no longer shows as in use' do
      card.touch_out
      expect(card.in_journey?).to eq false
    end

    it 'Raises an error if touched in with a balance less than the minimum' do
      expect { card.touch_in }.to raise_error('Insufficient Funds Available')
    end

    xit 'records the entry station' do
      
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_in(entry_station)
      expect(card.entry_station).to eq entry_station
    end

    xit "records the exit station when touch out" do
      ()
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.exit_station).to be exit_station
    end

    xit "Records the journey" do
      ()
      card.top_up(50)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      journey = {:entry_station => entry_station , :exit_station => exit_station}
      expect(card.history).to include journey
    end

    xit "is touched but then not touched out. Penalty is applied" do      
      
      card.top_up(90)
      aldgate = Station.new('Aldgate', 1)

      card.touch_in(aldgate)

      # User does not touch out
      card.touch_in(aldgate)

      expect(card.balance).to eq 84
    end
  end

  describe 'uses Journey object' do

    describe 'to record' do

      it 'starting station at touch-in' do
        card.top_up(Oystercard::MAXIMUM_LIMIT)
        card.touch_in(entry_station)
        expect(journey_double).to have_received(:start).with(entry_station)
      end

      it 'end station at touch-out' do
        card.touch_out(exit_station)
        expect(journey_double).to have_received(:end).with(exit_station)
      end
    end
  end
end
