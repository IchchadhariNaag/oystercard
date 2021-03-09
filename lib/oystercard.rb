class Oystercard

attr_reader :balance
CARD_LIMIT = 90

  def initialize()
    @balance = 0
  end

  def top_up(amount)
    raise "Balance over #{CARD_LIMIT}" if @balance + amount > CARD_LIMIT
    @balance += amount
  end

end
