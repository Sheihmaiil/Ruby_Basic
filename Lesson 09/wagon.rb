# frozen_string_literal: true

require_relative 'modules'

class Wagon
  include Manufacturer
  attr_reader :type
  attr_accessor :manufacturer, :places, :taken_places

  TYPE_FORMAT = /^[CP]{1}$/.freeze

  def initialize(places, type)
    @type = type
    @places = places
    @manufacturer = ''
    @taken_places = 0
    validate!
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def take_place(place)
    raise 'Не хватает свободного места!!!' if @taken_places + place > @places

    @taken_places += place
  end

  def empty_places
    @places - @taken_places
  end

  protected

  def validate!
    raise 'Тип вагона должен быть C - Cargo или P - Passenger' unless type =~ TYPE_FORMAT
    raise 'Количество места не может быть равным 0' if @places.zero?
  end
end

class WagonPass < Wagon
  def initialize(places, type = 'P')
    super
  end
end

class WagonCargo < Wagon
  def initialize(places, type = 'C')
    super
  end
end
