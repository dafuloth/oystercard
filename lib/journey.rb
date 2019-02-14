class Journey
  attr_reader :entry_station, :end_station
  MAX_FARE = 6
  MIN_FARE = 1
  def start(station)
    @entry_station = station
  end

  def end(station)
    @end_station = station    
  end

  def fare
    (@entry_station.nil?) || (@end_station.nil?) ? MAX_FARE : MIN_FARE
  end
end