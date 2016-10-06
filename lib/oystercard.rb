require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :current_journey, :entry_station, :exit_station
  attr_accessor :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = 50
    @journey = JourneyLog.new
  end


  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    no_touch_out
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    deduct(@journey.current.fare)
    @journey.clear_current_journey
  end


  private

  def no_touch_out
    if @journey.current.current_journey[:entry_station] != nil
      @journey.history_journey
      deduct(@journey.current.fare)
      @journey.clear_current_journey
    end
  end

  def deduct(fare)
    @balance -= fare
  end

end
