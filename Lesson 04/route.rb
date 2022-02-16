class Route
  attr_accessor :name, :stations_list

  def initialize(name, first_station, last_station)
    @name = name
    @stations_list = [first_station, last_station]
  end

  def add_station(station)
    @stations_list.insert(-2, station)
  end

  def del_station(station)
    @stations_list.delete(station) unless [@stations_list.first, @stations_list.last].include?(station)
  end
end
