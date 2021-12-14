class Route

  #  def initialize(first_station = String.new(""), last_station = String.new(""))
  def initialize(first_station, last_station)
    @route =[first_station, last_station]
  end

  def add_station(station_name)
    @route.insert((@route.size - 1), station_name)
  end

  def del_station(station_name)
    
    if station_name == @route[0] || station_name == @route[-1]
      puts "Нельзя удалять начальную и конечную станции!!!"
    else
      @route.delete(station_name)
    end

  end

  def stations_list
    @route.each {|station| puts "#{station}"}
  end

end

