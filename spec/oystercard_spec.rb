require 'oystercard'

describe Oystercard do

  it 'has a balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'can add to the balance' do
    expect(subject.top_up(4)).to eq(4)
  end

  it 'can not have a balance over CARD_LIMIT' do
    expect { subject.top_up(Oystercard::CARD_LIMIT + 1) }.to raise_error("Balance over #{Oystercard::CARD_LIMIT}")
  end

  it 'can have an amount deducted from the balance' do
    subject.top_up(20)
    expect(subject.deduct(20)).to eq(0)
  end

  it 'can touch in at a station' do
    expect(subject.touch_in("Kennington")).to be true
  end

  it 'can touch out at a station' do
    expect(subject.touch_out("Stockwell")).to eq(false)
  end

  it 'has a status to indicate when user is on a journey' do
    subject.touch_in("Oxford Circus")
    expect(subject.in_journey?).to be true
  end

end
