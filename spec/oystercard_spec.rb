require 'oystercard'

describe Oystercard do

  describe 'structure' do

    it 'has a balance' do
      expect(subject).to respond_to(:balance)
    end
  end

  describe 'top_up' do

    it 'can add to the balance' do
      subject.top_up(4)
      expect(subject.balance).to eq(4)
    end

    it 'can not have a balance over CARD_LIMIT' do
      expect { subject.top_up(Oystercard::CARD_LIMIT + 1) }.to raise_error("Balance over #{Oystercard::CARD_LIMIT}")
    end
  end

  describe 'deduct' do

    let(:station){ double(:station) }

    it 'can have an amount deducted from the balance' do
      subject.top_up(1)
      subject.touch_out(station)
      expect(subject.balance).to eq(0)
    end
  end

  describe 'touch_in' do

    let(:station){ double(:station) }

    it 'can touch in at a station' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'has to have at least the minimum fare in balance to touch in' do
      expect { subject.touch_in(station) }.to raise_error("You need at least #{Oystercard::MINIMUM} in balance to travel")
    end

    it 'stores an entry_station upon touching in' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

  end

  describe 'touch_out' do

    let(:station){ double(:station) }

    it 'can touch out at a station' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq(false)
    end

    it 'removes the minimum fare from balance when touching out' do
      subject.top_up(1)
      subject.touch_in(station)
      expect { subject.touch_out("Oval") }.to change { subject.balance }.by(-Oystercard::MINIMUM)
    end

    it 'forgets the entry_station after touching out' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to eq(nil)
    end
  end

  describe 'in_journey?' do

    let(:station){ double(:station) }

    it 'has a status to indicate when user is on a journey' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end
  end





end
