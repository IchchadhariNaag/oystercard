class Oystercard

attr_reader :balance
CARD_LIMIT = 90
MINIMUM = 1

  def initialize()
    @balance = 0
    @status = false
  end

  def top_up(amount)
    raise "Balance over #{CARD_LIMIT}" if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    raise "You need at least #{MINIMUM} in balance to travel" if @balance < MINIMUM
    @status = true
  end

  def touch_out(station)
    @status = false
  end

  def in_journey?
    @status
  end

end
