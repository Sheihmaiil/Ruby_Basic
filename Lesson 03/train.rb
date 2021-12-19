class Train
  attr_accessor :train
  attr_accessor :train_name
  attr_accessor :train_type
  attr_accessor :current_station
  attr_accessor :current_speed
  attr_accessor :wagon_qty

  def initialize(train_name, train_type, wagon_qty, route = '')
    @train = train_name
    @train_type = train_type
    @wagon_qty = wagon_qty
    @route = route
    @current_station = 0
    @current_speed = 0
  end

  def change_speed(speed) #изменение скорости может быть отрицательным
    if @current_speed + speed < 0
      puts "Нельзя уменьшить скорость меньше нуля!"
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
    @current_station = 0
    @route = route
  end

  def move_train(qty) #количество станций может быть отрицательным
    if @route == ''
      puts "Перемещение невозможно - не задан маршрут!"
    elsif qty.abs > 1
      puts "Перемешение невозможно более чем на одну станцию!"
    elsif @current_station + qty < 0
      puts "Перемещение невозможно - достигнута начальная станция!"
    elsif @current_station + qty > @route.stations_list.size
      puts "Перемещение невозможно - достигнута конечная станция!"
    else
      @current_station += qty
    end
  end

end
