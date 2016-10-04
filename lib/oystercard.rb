class Oystercard

	MAXIMUM_LIMIT = 90
	MINIMUM_FARE = 1

	attr_reader :balance, :entry_station, :history
	attr_accessor :in_journey

	def initialize(balance = 0)
		@balance = balance
		@history = []
		@entry_station = nil
	end

	def top_up(amount)
		top_up_balance = @balance + amount
		raise "The maximum balance you can have is £#{MAXIMUM_LIMIT}!" if top_up_balance > MAXIMUM_LIMIT
		@balance += amount
	end

	def touch_in(entry_station)
		@entry_station = entry_station
		raise "Insufficient funds" if @balance < MINIMUM_FARE
		@in_journey = true
	end

	def touch_out(exit_station)
		deduct(MINIMUM_FARE)
		@in_journey = false
		journey = {entry_station: @entry_station, exit_station: exit_station}
		@history << journey
		@entry_station = nil
		journey
	end

	def in_journey?
		@in_journey
	end

	private

		def deduct(amount)
			@balance -= amount
		end
end
