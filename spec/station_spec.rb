require "station"

describe Station do
  it 'identifies the station, does not raise error' do
    station = Station.new("Aldgate East", 1)

    expect(station.name).to eq 'Aldgate East'
  end

  it 'identifies the zone it is in, does not raise error' do
    station = Station.new("Aldgate East", 1)

    expect(station.zone).to eq 1
  end
end
