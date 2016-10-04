require_relative "journey_log"

class Journey

  attr_reader :history, :fare
  attr_accessor :current_trip

  def initialize
    clear_current_trip
    @logger = JourneyLog.new

  end

  def clear_current_trip
    @current_trip = ({entry_station: nil,
                      entry_zone: nil,
                      exit_station: nil,
                      exit_zone: nil})
  end

  def start_trip(station)
    clear_current_trip
    current_trip[:entry_station] = station.name
    current_trip[:entry_zone] = station.zone
  end

  def end_trip(station)
    current_trip[:exit_station] = station.name
    current_trip[:exit_zone] = station.zone
    @logger.record_trip(@current_trip)
  end

  def end_unfinished_trip
    @logger.record_trip(@current_trip)
  end

  def fare
    if @current_trip[:entry_station] == nil
      6
    elsif @current_trip[:exit_station] == nil
      6
    else
      zone_difference = (@current_trip[:entry_zone] - @current_trip[:exit_zone]).abs
      1 + zone_difference
    end
  end
end
