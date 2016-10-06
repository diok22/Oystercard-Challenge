require_relative 'station'
require_relative 'journey'

class JourneyLog

  attr_reader :journey_logger

  def initialize
    @journey = Journey.new
    @journey_logger = []
  end

  def start(station)
    
    # @journey_logger << @journey.start_journey(station)
  end

  def finish(station)
  end

  def journeys
  end


  private

  def current_journey
    @current_journey = {entry_station: nil, entry_zone: nil,
                     exit_station: nil, exit_zone: nil}
  end

end
