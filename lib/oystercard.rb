class Oystercard

	MAXIMUM_LIMIT = 90

	attr_reader :balance

	def initialize(balance = 0)
		@balance = balance
	end

	def top_up(amount)
		top_up_balance = @balance + amount
		raise "The maximum balance you can have is £#{MAXIMUM_LIMIT}!" if top_up_balance > MAXIMUM_LIMIT
		@balance += amount
	end

	def deduct(amount)
		@balance -= amount
	end

end
