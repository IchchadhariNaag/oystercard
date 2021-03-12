require 'oystercard'

describe Oystercard do

  describe 'structure' do

    it 'has a balance of zero when created' do
      expect(subject.balance).to eq(0)
    end

    it 'starts with an empty journey history' do
      expect(subject.journeys).to be_empty
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
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.balance).to eq(0)
    end
  end

  describe 'touch_in' do

    let(:entry_station) { double(:station) }
    let(:exit_station) { double(:station) }

    let(:entry_journey) { {entry: entry_station} }

    it 'can touch in at a station' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'has to have at least the minimum fare in balance to touch in' do
      expect { subject.touch_in(entry_station) }.to raise_error("You need at least #{Oystercard::MINIMUM} in balance to travel")
    end

    it 'stores an entry_station upon touching in' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end

    it 'sets the exit_station nil upon touching in' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.exit_station).to eq(nil)
    end

    it 'adds the entry_station to a new hash to start a journeys history' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.journeys.last).to eq(entry_journey)
    end

  end

  describe 'touch_out' do

    let(:exit_station) { double(:station) }
    let(:entry_station) { double(:station) }

    let(:journey) { {entry: entry_station, exit: exit_station} }

    it 'can touch out at a station' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq(false)
    end

    it 'removes the minimum fare from balance when touching out' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM)
    end

    it 'forgets the entry_station after touching out' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq(nil)
    end

    it 'sets the exit_station after touching out' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end

    it 'stores the exit_station to the last hash in the journeys' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys.last).to eq(journey)
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
