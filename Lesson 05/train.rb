require_relative 'modules'
require_relative 'InstanceCounter'

class Train
  include Manufacturer
  include InstanceCounter
  attr_accessor :name, :type, :current_station_index, :current_speed, :wagons, :manufacturer
  attr_reader :route

  @@trains = []
  
  def initialize(name, type, manufacturer)
    @name = name
    @type = type # 'C' - cargo, 'P' - passenger
    @wagons = []
    @current_speed = 0
    @manufacturer = manufacturer
    @@trains << self
    register_instance
  end

  def self.find(name)
    result = @@trains.select { |i| i.name == name }
    puts result.first.name unless result.empty?
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

  def add_wagon
    if @current_speed.zero?
       if type == "P"
         @wagons << WagonPass.new
       else
         @wagons << WagonCargo.new
       end
    end
  end

  def del_wagon()
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
    if next_station
      current_station.del_train(self)
      @current_station_index += 1
      current_station.add_train(self)
    end
  end

  def move_train_backward
    if previous_station
      current_station.del_train(self)
      @current_station_index -= 1
      current_station.add_train(self)
    end
  end

  def current_station
    @route.stations_list[@current_station_index]
  end

  private

  def previous_station
    return if @current_station_index.zero?

    @route.stations_list[@current_station_index - 1]
  end

  def next_station
    return if @current_station_index + 1 == @route.stations_list.size

    @route.stations_list[@current_station_index + 1]
  end

end
