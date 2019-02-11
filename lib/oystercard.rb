class Oystercard
  attr_reader :balance
  MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top-up aborted. Would exceed #{MAXIMUM_LIMIT} limit." if over_limit?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private
  def over_limit?(amount)
    return false unless (@balance + amount) > MAXIMUM_LIMIT
    true
  end
end
