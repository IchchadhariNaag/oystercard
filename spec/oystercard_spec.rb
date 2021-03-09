require 'oystercard'

describe Oystercard do

  it 'has a balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'can add to the balance' do
    expect(subject.top_up(4)).to eq(4)
  end

end
