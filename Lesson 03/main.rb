load './route.rb'
load './train.rb'

my_route = Route.new('111', '999')
my_route.add_station('222')
my_route.add_station('333')

my_train = Train.new('Midnight Express',"PASS",8)
my_train.add_route(my_route)
