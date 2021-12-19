class Station
  attr_accessor :station
  attr_reader :trains_list

  def initialize(station_name)
    @station = station_name
    @trains_list = []
  end

  def add_train(train)
    @trains_list << train
  end

  def del_train(train)
    index = @trains_list.index(train)
    if index != nil
      @trains_list.slice!(index)
    else
      puts "На станции нет поезда #{train.train_name}"
    end
  end

#этот метод для меня
  def trains_list_to_scr(train_type = 'A')
    if @trains_list.size == 0
      puts "На станции нет поездов!"
    else
      if train_type == 'A'
        @trains_list.each {|x| puts "#{x.train_name}"}
      else
        @trains_list.each {|x| puts "#{x.train_name}" if x.train_type == train_type}
      end
    end
  end

  def trains_list_by_type(train_type)
    trains_list_by_type = []
    @trains_list.each do |x|
      if x.train_type == train_type
        trains_list_by_type << x
      end      
    end
    return trains_list_by_type
  end

  def trains_qty_by_type(train_type)
    trains_qty_by_type = 0
    @trains_list.each do |x|
      if x.train_type == train_type
        trains_qty_by_type += 1
      end      
    end
    return trains_qty_by_type
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
      if @stations_list.index(station) == nil
        puts "В маршруте нет станции #{station.station}"
      else
        @stations_list.delete(station)
      end
    end

  end

  def stations_list_to_scr #Вывод списка станций на консоль
    @stations_list.each {|station| puts "#{station.station}"}
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
    @route = nil
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
      puts "Операция невозможно - поезд в движении!"
    elsif wagon.abs > 1
      puts "Операция невозможна - вагонов больше одного!"
    elsif @wagon_qty + wagon < 0
      puts "Операция невозможна - вагонов в составе нет!"
    else
      @wagon_qty += wagon
    end      
  end

  def add_route(route)
    if @route == nil
      @current_station = 0
      @route = route
    else
      puts "Поезду уже присвоен маршрут!"
    end
  end

  def move_train(qty) #количество станций может быть отрицательным
    if @route == nil
      puts "Перемещение невозможно - не задан маршрут!"
    elsif qty.abs > 1
      puts "Перемешение невозможно более чем на одну станцию!"
    elsif @current_station + qty < 0
      puts "Перемещение невозможно - достигнута начальная станция!"
    elsif @current_station + qty + 1 > @route.route.size
      puts "Перемещение невозможно - достигнута конечная станция!"
    else
      @current_station += qty
    end
  end
  
  def return_stations
    stations_names = []
    for i in -1..1
      if @current_station + i < 0 || (@current_station + i + 1) > @route.route.size
        stations_names << nil
      else
        stations_names << @route.route[@current_station + i]
      end
    end
    return stations_names
  end

end

first = Station.new('First')
second = Station.new('Second')
third = Station.new('Third')

train1 = Train.new('Midnight Express', 'P', 5)
train2 = Train.new('North Star', 'P', 7)
train3 = Train.new('Cargo1', 'C', 12)
train4 = Train.new('Cargo2', 'C')

first.add_train(train1)
first.add_train(train2)
first.add_train(train3)
first.add_train(train4)

route1 = Route.new(first, third)
route1.add_station(second)

train1.add_route(route1)
