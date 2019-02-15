class Oystercard
  attr_reader :balance, :in_use, :entry_station , :exit_station , :history
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  def initialize(journey_class)
    @balance = 0
    @in_use = false
    @history = []
    @journey_class = journey_class
  end

  def top_up(amount)
    raise "Top-up aborted. Would exceed #{MAXIMUM_LIMIT} limit." if over_limit?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end


  def touch_in(station = nil)
    raise "Insufficient Funds Available" if under_limit?
    
    if @current_journey.nil?
      @current_journey = @journey_class.new
    elsif !@current_journey.is_complete?
      @current_journey.fare
      # if recording journey to log, do something here
      @current_journey = @journey_class.new
    end

    @current_journey.start(station)


    
  end

  def touch_out(exit_station = nil)
    (@current_journey = @journey_class.new) if @current_journey.nil?

    @in_use = false
    deduct(MINIMUM_LIMIT)

    @current_journey.end(exit_station)

    #@entry_station = nil  
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
