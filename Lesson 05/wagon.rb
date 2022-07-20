require_relative 'modules'

class Wagon
  include Manufacturer
  attr_reader :type
  attr_accessor :manufacturer
  
  def initialize (type)
    @type = type
    @manufacturer = ""
  end
end

class WagonPass < Wagon
  def initialize(type = "P")
    super
  end
end

class WagonCargo < Wagon
  def initialize(type = "C")
    super
  end
end

