require_relative 'journey'
require_relative 'station'

class JourneyLog

  attr_reader :current_journey, :journey_history

  def initialize
    clear_current_journey
    @journey_history = []
  end

  def clear_current_journey
    @current_journey = {entry_station: nil, entry_zone: nil,
                     exit_station: nil, exit_zone: nil}
  end

  def start(entry_station)
    if @current_journey[:entry_station] != nil
      history_journey
      clear_current_journey
    end
    @current_journey[:entry_station] = entry_station.name
    @current_journey[:entry_zone] = entry_station.zone
  end

  def finish(exit_station)
    @current_journey[:exit_station] = exit_station.name
    @current_journey[:exit_zone] = exit_station.zone
    history_journey
    clear_current_journey
  end

  def history_journey
    @journey_history << @current_journey
  end

end
