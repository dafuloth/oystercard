class Oystercard
  attr_reader :balance
  MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top-up aborted. Would exceed #{MAXIMUM_LIMIT} limit." if (@balance + amount) > MAXIMUM_LIMIT

    @balance += amount
  end
end
