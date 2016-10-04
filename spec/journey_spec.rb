require "journey"

describe Journey do
  subject(:journey) {described_class.new}

  before :each do
    @station = double(:station)
    allow(@station).to receive(:name).and_return('Waterloo')
    allow(@station).to receive(:zone).and_return(1)
    @station2 = double(:station)
    allow(@station2).to receive(:name).and_return('Paddington')
    allow(@station2).to receive(:zone).and_return(2)
  end

  describe '#initialize' do

    it "creates an empty history array" do
      expect(journey.history.empty?).to be true
    end

    it "contains a hash with empty keys" do
      expect(journey.trip).to eq ({entry_station: nil,
                                   entry_zone: nil,
                                   exit_station: nil,
                                   exit_zone: nil})
    end
  end

  describe '#start_trip' do
    it 'adds start station name and zone to trip' do
      journey.start_trip(@station)
      expect(journey.trip).to eq({entry_station: 'Waterloo',
                                  entry_zone: 1,
                                  exit_station: nil,
                                  exit_zone: nil})
    end
  end

  describe '#end_trip' do
    it 'adds end location and zone to trip' do
      journey.start_trip(@station)
      journey.end_trip(@station2)
      expect(journey.trip).to eq({entry_station: 'Waterloo',
                                  entry_zone: 1,
                                  exit_station: 'Paddington',
                                  exit_zone: 2})
    end

    it 'appends the trip to the history log' do
    end

    it 'calls fare method' do
    end
  end

  describe '#fare' do
  end

end
