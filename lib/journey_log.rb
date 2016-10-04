class JourneyLog

  attr_reader :log

  def initialize
    @log = []
  end

  def record_trip(hash)
    @log << hash
  end
end
