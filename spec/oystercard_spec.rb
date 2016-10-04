require 'oystercard'
require 'station'

describe Oystercard do

	subject(:oystercard) { described_class.new }

	before(:each) do
		@maximum_limit = Oystercard::MAXIMUM_LIMIT
		@minimum_fare = Oystercard::MINIMUM_FARE
		@error1 = "The maximum balance you can have is £#{@maximum_limit}!"
		@station1 = double(:station)
		@station2 = double(:station)
		allow(@station1).to receive(:name).and_return('Paddington')
		allow(@station1).to receive(:zone).and_return(1)
		allow(@station2).to receive(:name).and_return('Euston Square')
		allow(@station2).to receive(:zone).and_return(2)
	end

	describe '#initialize' do

		it 'initializes with a balance of 0' do
			expect(oystercard.balance).to eq(0)
		end

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
			oystercard.touch_in(@station1)
			expect(oystercard).to be_in_journey
		end

		it "raises an error when balance is under the minimum amount" do
			oystercard.top_up(0.5)
			expect {oystercard.touch_in(@station1)}.to raise_error "Insufficient funds"
		end

		it "has a minimum fare of 1" do
			expect(@minimum_fare).to eq(1)
		end

		it "charges 6 if the user does not touch out, and attempts to touch in again" do
			oystercard.top_up(10)
			oystercard.touch_in(@station1)
			oystercard.touch_in(@station2)
			expect(oystercard.balance).to eq(4)
		end

	end

	describe '#touch_out' do

		it 'ends the journey' do
			oystercard.top_up(5)
			oystercard.touch_in(@station1)
			oystercard.touch_out(@station2)
			expect(oystercard).to_not be_in_journey
		end

		it 'charges minumum fare' do
			oystercard.top_up(5)
			oystercard.touch_in(@station1)
			expect {oystercard.touch_out(@station2)}.to change{oystercard.balance}.by(-1)
		end
	end

end
