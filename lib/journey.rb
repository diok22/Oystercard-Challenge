require_relative 'oystercard'

class Journey

  DEFAULT_PENALTY = 6
  MINIMUM_FARE = 1

  attr_reader :history_journey, :clear_current_journey, :current_journey

  def initialize
    # @journey_history = JourneyLog.new
  end



  def fare
    if @current_journey[:entry_station] == nil
      DEFAULT_PENALTY
    elsif @current_journey[:exit_station] == nil
      DEFAULT_PENALTY
    else
      MINIMUM_FARE
    end
  end

end
