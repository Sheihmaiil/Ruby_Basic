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
    index = @trains_list.index(train)
    if index
      @trains_list.slice!(index)
    else
      puts "На станции нет поезда #{train.train_name}"
    end
  end

  def trains_list_by_type(train_type)
    @trains_list.select do |train|
      train.train_type == train_type
    end
  end

  def trains_qty_by_type(train_type)
    @trains_list.select do |train|
      train.train_type == train_type
    end.count
  end
end

class Route
  attr_accessor :stations_list

  def initialize(first_station, last_station)
    @stations_list =[first_station, last_station]
  end

  def add_station(station)
    @stations_list.insert((@stations_list.size - 1), station)
  end

  def del_station(station)
    if station == @stations_list.first || station == @stations_list.last
      puts "Нельзя удалять начальную или конечную станции!!!"
    else
      if @stations_list.index(station).nil?
        puts "В маршруте нет станции #{station.name}"
      else
        @stations_list.delete(station)
      end
    end
  end

  def stations_list_to_scr #Вывод списка станций на консоль
    @stations_list.each { |station| puts "#{station.name}"}
  end
end

class Train
  attr_accessor :train_name
  attr_accessor :train_type
  attr_accessor :current_station
  attr_accessor :current_speed
  attr_accessor :wagon_qty
  attr_reader :route

  def initialize(train_name, train_type, wagon_qty = 0)
    @train_name = train_name
    @train_type = train_type
    @wagon_qty = wagon_qty
    @current_speed = 0
  end
  
  def change_speed(speed) #изменение скорости может быть отрицательным
    if @current_speed + speed < 0
      puts "Нельзя уменьшитьскорость меньше нуля!"
    else
      @current_speed += speed
    end
  end

  def stop
    @current_speed = 0
  end

  def change_wagon_qty(wagon) #количество вагонов может быть отрицательным
    if @current_speed != 0
      puts "Операция невозможна - поезд в движении!"
    elsif wagon.abs > 1
      puts "Операция невозможна - вагонов больше одного!"
    elsif @wagon_qty + wagon < 0
      puts "Операция невозможна - вагонов в составе нет!"
    else
      @wagon_qty += wagon
    end      
  end

  def add_route(route)
    @route = route
    @current_station = 0
  end

  def move_train(qty) #количество станций может быть отрицательным
    if @route == nil
      puts "Перемещение невозможно - не задан маршрут!"
    elsif qty.abs > 1
      puts "Перемешение невозможно более чем на одну станцию!"
    elsif @current_station + qty < 0
      puts "Перемещение невозможно - достигнута начальная станция!"
    elsif @current_station + qty + 1 > @route.stations_list.size
      puts "Перемещение невозможно - достигнута конечная станция!"
    else
      @current_station += qty
    end
  end

  def return_stations
    stations_names = []
    for i in -1..1
      if @current_station + i < 0 || (@current_station + i + 1) > @route.stations_list.size
        stations_names << nil
      else
        stations_names << @route.stations_list[@current_station + i]
      end
    end

    return stations_names
  end
end
