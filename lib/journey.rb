require_relative 'oystercard'

class Journey

  DEFAULT_PENALTY = 6
  MINIMUM_FARE = 1

  attr_accessor :current_journey

  def initialize
    # @journey_history = JourneyLog.new
    @current_journey = {entry_station: nil, entry_zone: nil,
                        exit_station: nil, exit_zone: nil}
  end



  def fare
    if @current_journey[:entry_station] == nil
      DEFAULT_PENALTY
    elsif @current_journey[:exit_station] == nil
      DEFAULT_PENALTY
    else
      zone_difference = (@current_journey[:exit_zone] - @current_journey[:entry_zone])
      MINIMUM_FARE + zone_difference.abs
    end
  end

end
