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

end
