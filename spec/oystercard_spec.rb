require 'oystercard'

describe Oystercard do

	subject(:oystercard) { described_class.new }

	before(:each) do
		@maximum_limit = Oystercard::MAXIMUM_LIMIT
		@minimum_fare = Oystercard::MINIMUM_FARE
		@error1 = "The maximum balance you can have is £#{@maximum_limit}!"
	end

	it 'initializes with a balance of 0' do
		expect(oystercard.balance).to eq(0)
	end

	describe "#top_up" do

		it 'oystercard with given amount' do
			amount = rand(5..20) # can take various amounts
			oystercard.top_up(amount)
			expect(oystercard.balance).to eq(amount)
		end

		it 'allows balance to top up maximum of £90' do
			oystercard.top_up(60)
			expect { oystercard.top_up(31) }.to raise_error @error1
			expect(oystercard.balance).to eq(60)
		end

		it 'has a maximum top up limit of £90' do
			expect(@maximum_limit).to eq(90)
		end
	end

	describe '#touch_in' do

		it "starts the journey" do
			oystercard.top_up(5)
			oystercard.touch_in
			expect(oystercard).to be_in_journey
		end

		it "raises an error when balance is under the minimum amount" do
			oystercard.top_up(0.5)
			expect {oystercard.touch_in}.to raise_error "Insufficient funds"
		end

		it "has a minimum fare of 1" do
			expect(@minimum_fare).to eq(1)
		end

		it "records entry station" do
			oystercard.top_up(5)
			oystercard.touch_in('Waterloo')
			expect(oystercard.entry_station).to eq('Waterloo')
		end
	end

	describe '#touch_out' do

		it 'ends the journey' do
			oystercard.top_up(5)
			oystercard.touch_in
			oystercard.touch_out
			expect(oystercard).to_not be_in_journey
		end

		it 'charges minumum fare' do
			oystercard.top_up(5)
			oystercard.touch_in
			expect {oystercard.touch_out}.to change{oystercard.balance}.by(-1)
		end

		it 'clears entry station' do
			oystercard.top_up(5)
			oystercard.touch_in('Waterloo')
			oystercard.touch_out
			expect(oystercard.entry_station).to be nil
		end
	end
end
