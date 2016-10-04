require "journey"

describe Journey do
  subject(:journey) {described_class.new}

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

  

  # describe '#start_journey' do
  #   it ""
  # end

end
