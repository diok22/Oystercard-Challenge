require 'oystercard'

describe Oystercard do

	subject(:oystercard) { described_class.new }

	before(:each) do
		@maximum_limit = Oystercard::MAXIMUM_LIMIT
		@error1 = "The maximum balance you can have is £#{@maximum_limit}!"
	end

	it 'initializes with a balance of 0' do
		expect(oystercard.balance).to eq(0)
	end

	it 'tops up oystercard with given amount' do
		amount = rand(5..20) # can take various amounts
		oystercard.top_up(amount)
		expect(oystercard.balance).to eq(amount)
	end

	it 'has a maximum top up limit of £90' do
		expect(@maximum_limit).to eq(90)
	end

	it 'allows balance to top up maximum of £90' do
		oystercard.top_up(60)
		expect { oystercard.top_up(31) }.to raise_error @error1
		expect(oystercard.balance).to eq(60)
	end

	it "deducts given amount from balance" do
		oystercard.top_up(40)
		oystercard.deduct(20)
		expect(oystercard.balance).to eq 20
	end

	it "touch_in would start the journey" do
		oystercard.touch_in
		expect(oystercard).to be_in_journey
	end

	it 'touch_out would end the journey' do
		oystercard.touch_in
		oystercard.touch_out
		expect(oystercard).to_not be_in_journey
	end

end
