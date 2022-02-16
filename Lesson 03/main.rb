class Station
  attr_accessor :name
  attr_reader :trains_list

  def initialize(station_name)
    @name = station_name
    @trains_list = []
  end

  def add_train(train)
    @trains_list << train
  end

  def del_train(train)
    @trains_list.delete(train)
  end

  def trains_list_by_type(train_type)
    @trains_list.select do |train|
      train.type == train_type
    end
  end

  def trains_qty_by_type(train_type)
    trains_list_by_type(train_type).count
  end
end

class Route
  attr_accessor :stations_list

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
  end

  def add_station(station)
    @stations_list.insert(-2, station)
  end

  def del_station(station)
    @stations_list.delete(station) unless [@stations_list.first, @stations_list.last].include?(station)
  end
end

class Train
  attr_accessor :name, :type, :current_station_index, :current_speed, :wagon_qty
  attr_reader :route

  def initialize(name, type, wagon_qty = 0)
    @name = name
    @type = type
    @wagon_qty = wagon_qty
    @current_speed = 0
  end
  
  def change_speed(speed) #изменение скорости может быть отрицательным
    if (@current_speed + speed).negative?
      puts "Нельзя уменьшитьскорость меньше нуля!"
    else
      @current_speed += speed
    end
  end

  def stop
    @current_speed = 0
  end

  def add_wagon
    @wagon_qty += 1 if @current_speed.zero?
  end

  def del_wagon
    @wagon_qty -= 1 if @current_speed.zero? && wagon_qty.positive?
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
  end

  def move_train_forward
    #@current_station_index += 1 if @route.nil? && (@current_station_index + 1 != @route.stations_list.size)
    @current_station_index += 1 if next_station
  end

  def move_train_backward
    #@current_station_index -= 1 if @route.nil? && (@current_station_index != 0)
    @current_station_index -= 1 if previous_station
  end

  def current_station
    @route.stations_list[@current_station_index]
  end

  def previous_station
    return if @current_station_index.zero?

    @route.stations_list[@current_station_index - 1]
  end

  def next_station
    return if @current_station_index + 1 == @route.stations_list.size

    @route.stations_list[@current_station_index + 1]
  end

end
