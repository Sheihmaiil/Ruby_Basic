require_relative 'wagon'
require_relative 'train'
require_relative 'station'
require_relative 'menu'
require_relative 'route'

qqq = Menu.new
qqq.start

=begin
puts "Список поездов"
#puts qqq.all_trains.size
qqq.all_trains.each do |i|
  puts "#{i.name}"
end
gets.chomp

puts "Список станций"
#puts qqq.all_stations.size
qqq.all_stations.each do |i|
  puts "#{i.name}"
end
gets.chomp

puts "Список маршрутов"
#puts qqq.all_routes.size
qqq.all_routes.each do |i|
  puts "#{i.name}"
  i.stations_list.each do |j|
    puts "#{j.name}"
  end
end

puts "Забавная попытка"
puts "#{qqq.found_station_by_name("Зеленый Дол").name}"
=end
