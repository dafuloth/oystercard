class Oystercard
  attr_reader :balance, :in_use, :entry_station , :exit_station , :history
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  def initialize
    
    @balance = 0
    @in_use = false
    @history = []
  end

  def top_up(amount)
    raise "Top-up aborted. Would exceed #{MAXIMUM_LIMIT} limit." if over_limit?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    return false unless @in_use

    true
  end

  def touch_in(station = nil)
    raise "Insufficient Funds Available" if under_limit?

    deduct(6) if exit_station.nil? && @in_use

    @in_use = true
    @entry_station = station
  end

  def touch_out(exit_station = nil)
    @in_use = false
    deduct(MINIMUM_LIMIT)
    @exit_station = exit_station
    history << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil  
  end

  private

  def over_limit?(amount)
    return false unless (@balance + amount) > MAXIMUM_LIMIT

    true
  end

  def under_limit?
    return false unless @balance < MINIMUM_LIMIT

    true
  end
end
