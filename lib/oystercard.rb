class Oystercard

	MAXIMUM_LIMIT = 90
	MINIMUM_FARE = 1

	attr_reader :balance, :entry_station, :history, :journey
	attr_accessor :in_journey

	def initialize(balance = 0)
		@balance = balance
		clears_journey
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
		journey_entry(@entry_station)
		journey_exit(exit_station)
		@history << @journey
		@entry_station = nil
		clears_journey
	end

	def in_journey?
		@in_journey
	end

	def journey_entry(entry_station)
		@journey[:entry_station] = entry_station
	end

	def journey_exit(exit_station)
		@journey[:exit_station] = exit_station
	end

	def clears_journey
		@journey = {:entry_station => nil, :exit_station => nil}
	end

	private

		def deduct(amount)
			@balance -= amount
		end
end
