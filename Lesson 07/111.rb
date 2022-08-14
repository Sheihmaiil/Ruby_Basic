require_relative 'wagon'
require_relative 'train'
require_relative 'station'
require_relative 'menu'
require_relative 'route'

qqq = Station.new('111')
www = Station.new('222')

tr1 = Train.new('qqq11', 'C', '')
tr2 = Train.new('www22', 'C', '')
tr3 = Train.new('ppp00', 'P', '')

qqq.add_train(tr1)
qqq.add_train(tr2)
www.add_train(tr3)

block = Proc.new {|train| puts "Название поезда: #{train.name}. Тип: #{train.type}. Вагонов в поезде: #{train.wagons.size}"}

qqq.each_train(&block)
#www.each_train(&block)

