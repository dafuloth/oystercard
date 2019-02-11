class Oystercard
  attr_reader :balance, :in_use
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  def initialize
    @balance = 0
    @in_use = false
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

  def touch_in
    raise "Insufficient Funds Available" if under_limit?
    @in_use = true
  end

  def touch_out
    @in_use = false
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
