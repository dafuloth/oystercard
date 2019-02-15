require_relative '../lib/journey'

describe Journey do
let (:station_double) { double( :station ) }
let (:journey) { Journey.new }

  it 'starts a journey and records entry station' do
    expect{ journey.start(station_double) }
      .to change { journey.entry_station }.from(nil).to(station_double)
  end

  it 'ends a journey and records exit station' do
    expect{ journey.end(station_double) }
      .to change { journey.end_station }.from(nil).to(station_double)    
  end

  describe '#is_complete?' do
    it 'determines that the journey is complete' do
      journey.start(station_double)
      journey.end(station_double)

      expect(journey.is_complete?).to eq true
    end

    it 'determines that the journey is incomplete (no touch-out)' do
      journey.start(station_double)

      expect(journey.is_complete?).to eq false
    end

    it 'determines that the journey is incomplete (no touch-in)' do
      journey.end(station_double)

      expect(journey.is_complete?).to eq false
    end
  end

  describe '#fare calculates the fare of' do
    it 'a complete journey' do
      journey.start(station_double)
      journey.end(station_double)
      
      expect(journey.fare).to eq 1
    end

    it 'an incomplete journey (no touch-out)' do
      journey.start(station_double)

      expect(journey.fare).to eq 6
    end

    it 'an incomplete journey (no touch-in)' do
      journey.end(station_double)

      expect(journey.fare).to eq 6
    end
  end
end