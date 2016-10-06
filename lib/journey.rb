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
    return DEFAULT_PENALTY if @current_journey[:entry_station] == nil ||  @current_journey[:exit_station] == nil
    zone_difference = (@current_journey[:entry_zone] - @current_journey[:exit_zone])
    MINIMUM_FARE + zone_difference.abs
  end
end
