class Route
  attr_accessor :route

  def initialize(first_station, last_station)
    @route =[first_station, last_station]
  end

  def add_station(station_name)
    route.insert((route.size - 1), station_name)
  end

  def del_station(station_name)
    
    if station_name == route.first || station_name == route.last
      puts "Нельзя удалять начальную или конечную станции!!!"
    else
      route.delete(station_name)
    end

  end

  def stations_list_to_scr #Вывод списка станций на консоль
    route.each {|station| puts "#{station}"}
  end

  def stations_list
    @route
  end

end

