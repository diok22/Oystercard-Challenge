require 'journey'
require 'oystercard'
require 'station'

describe Journey do

  subject(:journey) {described_class.new}

  describe '#initialize' do
    it 'by default the current journey is empty' do
      expect(journey.current_journey).to eq({entry_station: nil, entry_zone: nil,
                                             exit_station: nil, exit_zone: nil})
    end
  end

  describe "#fare" do
    it "deducts the minimum fare for a complete single journey" do
      journey.current_journey = {entry_station: "Waterloo", entry_zone: 1,
                                 exit_station: "Euston", exit_zone: 1}
      expect(journey.fare).to eq(1)
    end

    it "deducts the penalty fare for an incomplete journey" do
      journey.current_journey = {entry_station: "Waterloo", entry_zone: 1,
                                 exit_station: nil, exit_zone: nil}
      expect(journey.fare).to eq(6)
    end

    context "different zone trip fares" do
      it "2 pounds trip for moving one zone" do
      journey.current_journey = {entry_station: "Waterloo", entry_zone: 1,
                          exit_station: "Euston", exit_zone: 2}
      expect(journey.fare).to eq(2)
      end
    end
  end




end
