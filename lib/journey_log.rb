require_relative 'journey'
require_relative 'station'

class JourneyLog

  attr_reader :current, :journey_history

  def initialize
    clear_current_journey
    @journey_history = []
  end

  def clear_current_journey
    @current = Journey.new
  end

  def start(entry_station)
    
    @current.current_journey[:entry_station] = entry_station.name
    @current.current_journey[:entry_zone] = entry_station.zone
  end

  def finish(exit_station)
    @current.current_journey[:exit_station] = exit_station.name
    @current.current_journey[:exit_zone] = exit_station.zone
    history_journey
  end

  def history_journey
    @journey_history << @current.current_journey
  end

end
