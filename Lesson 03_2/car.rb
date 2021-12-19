class Car
  attr_accessor :color
  attr_reader :drivers_names

  def initialize(number)
    @number = number
    @color = 'white'
    @drivers_names = []
  end

  def beep
    puts 'beep beep'
  end

  def add_driver(name)
    @drivers_names << name
  end

  def show_drivers
    @drivers_names.each { |name| puts name }
  end
end


for i in -1..1
  puts "#{@current_station + i}"
  puts "#{@route.route.size}"
  puts "#{@route.route[i].station}"
  puts "#{stations_names}"
  gets
  if @current_station + i < 0 || (@current_station + i + 1) > @route.route.size
    stations_names << nil
    stations_names2 << nil
  else
    stations_names << @route.route[i]
    stations_names2 << @route.route[i].station
  end
end
