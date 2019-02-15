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
    is_complete? ? MIN_FARE : MAX_FARE
  end

  def is_complete?
    (@entry_station && @end_station) ? true : false
  end
end