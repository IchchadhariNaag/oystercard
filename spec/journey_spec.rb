require 'journey'

describe Journey do

  describe 'has structure' do

    let(:exit_station) { double(:station) }
    let(:entry_station) { double(:station) }

    it 'has an entry station' do
      expect(subject).to respond_to :start_journey
    end

    it 'has an exit station' do
      expect(subject).to respond_to :end_journey
    end



  end

  describe 'start_journey' do

    let(:exit_station) { double(:station) }
    let(:entry_station) { double(:station) }

    it 'stores a station at the start of the journey' do
      subject.start_journey(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end

    it 'checks if the previous journey was completed with both an entry and exit station' do
      subject.instance_variable_set(:@journey_completed, true)
      subject.end_journey(exit_station)
      expect(subject.start_journey).to change { subject.journey_complete? }.to eq(false)
    end

  end

  describe 'end_journey' do

    let(:exit_station) { double(:station) }
    let(:entry_station) { double(:station) }

    it 'stores a station at the end of the journey' do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end

    it 'checks if the previous journey was completed with both an entry and exit station' do
      subject.start_journey(entry_station)
      expect(subject.end_journey(exit_station)).to change { subject.journey_complete? }.to eq(true)
    end

  end

  describe 'journey_complete?' do

    let(:exit_station) { double(:station) }
    let(:entry_station) { double(:station) }

    it 'tracks whether or not a journey is complete' do
      subject.start_journey(entry_station)
      expect(subject.journey_complete?).to eq(false)
    end
  end



end
