require 'journey_log'

describe JourneyLog do

  before :each do
    @hash = {entry_station: nil,
             entry_zone: nil,
             exit_station: nil,
             exit_zone: nil}
  end

  subject(:journey_log) { described_class.new}

  describe "#record_trip" do
    it "pushes current trip to history logger" do
      journey_log.record_trip(@hash)
      expect(journey_log.log).to eq([@hash])
    end
  end

end
