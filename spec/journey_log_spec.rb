require 'journey'
require 'oystercard'
require 'station'
require 'journey_log'

describe JourneyLog do

  subject(:journey_log) {described_class.new}

  describe '#start' do
    it "creates a new journey" do
      journey_log.start(Station.new("Waterloo",1))
      expect(journey_log.current_journey).to eq({entry_station: "Waterloo", entry_zone: 1,
                       exit_station: nil, exit_zone: nil})
    end
  end

  describe '#finish' do
    it "records exit station of current journey" do
      journey_log.start(Station.new("Waterloo",1))
      journey_log.finish(Station.new("Paddington",1))
      expect(journey_log.journey_history.last).to eq({entry_station: "Waterloo", entry_zone: 1,
                       exit_station: "Paddington", exit_zone: 1})
    end
  end

  describe '#history_journey' do
    it 'saves a complete journey to the history journey array' do
      journey_log.start(Station.new("Waterloo",1))
      journey_log.finish(Station.new("Paddington",1))
      expect(journey_log.journey_history).to eq([{entry_station: "Waterloo", entry_zone: 1,
                                                  exit_station: "Paddington", exit_zone: 1}])
    end
  end

end
