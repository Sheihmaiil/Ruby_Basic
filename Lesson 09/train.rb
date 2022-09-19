# frozen_string_literal: true

require_relative 'modules'
require_relative 'instancecounter'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors
  
  attr_accessor :name, :type, :current_station_index, :current_speed, :wagons, :manufacturer
  attr_reader :route
  strong_attr_accessor :current_speed, Integer

  NAME_FORMAT = /^[а-яa-z0-9]{3}-?[а-яa-z0-9]{2}$/i.freeze
  TYPE_FORMAT = /^[CP]{1}$/.freeze
  
  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(name, type, manufacturer)
    @name = name
    @type = type # 'C' - cargo, 'P' - passenger
    @wagons = []
    @current_speed = "a"
    @manufacturer = manufacturer
    validate!
  end

  def change_speed(speed)
    # Изменение скорости может быть отрицательным
    if (@current_speed + speed).negative?
      puts 'Нельзя уменьшить скорость меньше нуля!'
    else
      @current_speed += speed
    end
  end

  def stop
    @current_speed = 0
  end

  def add_wagon(places)
    return unless @current_speed.zero?

    @wagons << if type == 'P'
                 WagonPass.new(places)
               else
                 WagonCargo.new(places)
               end
  end

  def del_wagon
    @wagons.delete_at(-1) if @current_speed.zero?
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
  end

  def del_route
    @route = nil
  end

  def move_train_forward
    return unless next_station

    current_station.del_train(self)
    @current_station_index += 1
    current_station.add_train(self)
  end

  def move_train_backward
    return unless previos_station

    current_station.del_train(self)
    @current_station_index -= 1
    current_station.add_train(self)
  end

  def current_station
    @route.stations_list[@current_station_index]
  end

  def each_wagon(&block)
    if block_given?
      @wagons.each.with_index(1, &block)
    else
      puts 'Нет блока'
    end
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
