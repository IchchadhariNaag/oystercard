class Oystercard

attr_reader :balance, :entry_station, :exit_station, :journeys

CARD_LIMIT = 90
MINIMUM = 1

  def initialize()
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "Balance over #{CARD_LIMIT}" if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "You need at least #{MINIMUM} in balance to travel" if @balance < MINIMUM
    @entry_station = station
    @exit_station = nil
    @journeys.push( {entry: entry_station} )
  end

  def touch_out(station)
    deduct
    @entry_station = nil
    @exit_station = station
    @journeys.last.merge!( {exit: exit_station} )
  end

  def in_journey?
    return true if @entry_station != nil
    return false if @entry_station == nil
  end

private

  def deduct
    @balance -= MINIMUM
  end


end
