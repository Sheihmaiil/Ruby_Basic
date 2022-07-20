#begin
module Manufacturer

  def set_manufacturer(name)
    puts "#{self.class}"
    puts name
    self.manufacturer = name
  end

  def manufacturer
    puts "#{self.class}"
    puts name
    self.manufacturer
  end
#end

  protected
  attr_accessor :manufacturer
end

class Car

  include Manufacturer
  
  attr_reader :current_rpm, :manufacturer

  @@my_list = []
  
  def self.all
    @@my_list
  end
    
  def initialize
    @current_rpm = 0
    @manufacturer = ""
    @@my_list << self
    puts @@my_list.size
  end

  def start_engine
    start_engine! if engine_stopped?
  end

  def engine_stopped?
    current_rpm.zero?
  end

  protected

  attr_writer :current_rpm

  def initial_rpm
    700
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end

  # остановить двигатель
end
