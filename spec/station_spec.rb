require 'station'

describe Station do

  subject(:waterloo_station) { described_class.new('Waterloo', '1')}

  before :each do
  end

  describe '#initialize' do

    it 'saves name to Waterloo' do
      expect(waterloo_station.name).to eq('Waterloo')
    end
    it 'sets zone to "1" ' do
      expect(waterloo_station.zone).to eq('1')
    end
  end
end
