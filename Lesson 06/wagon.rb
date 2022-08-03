require_relative 'modules'

class Wagon
  include Manufacturer
  attr_reader :type
  attr_accessor :manufacturer
  
  TYPE_FORMAT = /^[CP]{1}$/
  
  def initialize (type)
    @type = type
    @manufacturer = ""
    validate!
  end
  
  def valid?
    validate!
    true
  rescue	    
    false     
  end
  
  protected
  
  def validate!
    raise "Тип вагона долженб быть C - Cargo или P - Passenger" unless type =~ TYPE_FORMAT
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

