class Oystercard

attr_reader :balance
attr_reader :entry_station

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

  def touch_in(station)
    raise "You need at least #{MINIMUM} in balance to travel" if @balance < MINIMUM
    @entry_station = station
    @status = true
  end

  def touch_out(station)
    deduct
    @status = false
  end

  def in_journey?
    @status
  end

private

  def deduct
    @balance -= MINIMUM
  end


end
