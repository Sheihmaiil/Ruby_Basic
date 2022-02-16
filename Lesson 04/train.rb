class Train
  attr_accessor :name, :type, :current_station_index, :current_speed, :wagons
  attr_reader :route

  def initialize(name, type)
    @name = name
    @type = type # 'C' - cargo, 'P' - passenger
    @wagons = []
    @current_speed = 0
  end
  
  def change_speed(speed) #изменение скорости может быть отрицательным
    if (@current_speed + speed).negative?
      puts "Нельзя уменьшить скорость меньше нуля!"
    else
      @current_speed += speed
    end
  end

  def stop
    @current_speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @current_speed.zero? && wagon.type == type
    #нужна проверка на повторное добавление того же вагона???
  end

  def del_wagon() #wagon)
    #@wagons.delete(wagon) if @current_speed.zero?
    @wagons.delete_at(-1) if @current_speed.zero?
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
  end

  def del_route()
    @route = nil
  end

  def move_train_forward
    @current_station_index += 1 if next_station
  end

  def move_train_backward
    @current_station_index -= 1 if previous_station
  end

  #
  def move_train_forward_1(train)
    if next_station
      current_station.del_train(train)
      @current_station_index += 1
      current_station.add_train(train)
    end
  end

  def move_train_backward_1(train)
    if previous_station
      current_station.del_train(train)
      @current_station_index -= 1
      current_station.add_train(train)
    end
  end
  #

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
