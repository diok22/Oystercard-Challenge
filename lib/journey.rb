class Journey

  attr_reader :history, :trip

  def initialize
    clear_trip
    @history = []
  end

  def clear_trip
    @trip = ({entry_station: nil,
              entry_zone: nil,
              exit_station: nil,
              exit_zone: nil})
  end

  def start_trip(station)
    trip[:entry_station] = station.name
    trip[:entry_zone] = station.zone
  end
end
