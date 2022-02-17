class Menu

  MAIN_MENU = [
    "1. Создать новый объект",
    "2. Редактировать объект",
    "3. Информация об объекте",
    "4. Создать тестовый набор объектов",
    "0. Окончание работы"
  ]
    
  CREATE_MENU = [
    "1. Создать станцию",
    "2. Создать поезд",
    "3. Создать маршрут",
    "0. В предыдущее меню"
  ]

  EDIT_OBJECTS = [
    "1. Добавить станцию в маршрут",
    "2. Удалить станцию из маршрута",
    "3. Добавить вагон в поезд",
    "4. Удалить вагон из поезда", 
    "5. Присвоить маршрут поезду",
    "6. Отменить маршрут у поезда",
    "7. Переместить поезд вперед по маршруту",
    "8. Переместить поезд назад по маршруту",
    "0. В предыдущее меню"
  ]
  
  OBJECTS_INFO = [
    "1. Список станций/поездов на станциях",
    "2. Список поездов",
    "3. Список маршутов/станций в маршруте",
    "0. В предыдущее меню"
  ]

  def initialize
    @all_stations = []
    @all_trains = []
    @all_routes = []
  end

  def start()
    loop do
      puts MAIN_MENU
      choice = gets.chomp
      case choice
      when "0" then break
      when "1" #Создание объектов - CREATE_MENU
        loop do
          puts CREATE_MENU
          choice = gets.chomp
          case choice
          when "0" then break
          when "1" #Создать станцию
            print "Введите название станции: \n"
            st = gets.chomp
            @all_stations << Station.new(st)
          when "2" #Создать поезд
            print "Введите название поезда: \n"
            tr = gets.chomp
            print "Задайте тип поезда ('C' - cargo, 'P' - passenger): \n"
            tr_type = gets.chomp
            @all_trains << Train.new(tr, tr_type)
          when "3" #Создать маршрут
            puts "Список станций:"
            num_list(@all_stations)
            puts "Введите номер первой станции"
            first_station = must_be_int()
            curr_station1 = @all_stations[first_station - 1]
            if curr_station1
              puts "Введите номер последней станции"
              last_station = must_be_int()
              curr_station2 = @all_stations[last_station - 1]
              if curr_station2
                @all_routes << Route.new(curr_station1.name + ' - ' + curr_station2.name, curr_station1, curr_station2)
              else
                puts "Введена неверная станция"
              end
            else
              puts "Введена неверная станция"
            end
          end  
        end
      when "2" #Редактирование объектов - EDIT_MENU
        loop do
          puts EDIT_OBJECTS
          choice = gets.chomp
          case choice
          when "0" then break
          when "1" #Добавить станцию в маршрут
            puts "Список маршрутов"
            routes_list()
            puts "Введите номер маршрута"
            route_number = must_be_int()
            curr_route = @all_routes[route_number - 1]
            if curr_route
              puts "Список станций"
              num_list(@all_stations)
              puts "Ведите  номер станции"
              station_number = must_be_int()
              curr_station = @all_stations[station_number - 1]
              if curr_station
                curr_route.add_station(curr_station)
              else
                puts "Введена неверная станция"
              end
            else
              puts "Введен неверный маршрут"
            end
          when "2" #Удалить станцию из маршрута
            puts "Список маршрутов"
            num_list(@all_routes)
            puts "Введите номер маршрута"
            route_number = must_be_int()
            curr_route = @all_routes[route_number - 1]
            if curr_route
              curr_route = @all_routes[route_number - 1]
              puts "Список станций"
              num_list(curr_route.stations_list)
              puts "Ведите номер станции"
              station_number = must_be_int()
              curr_station = curr_route.stations_list[station_number - 1]
              if curr_station
                curr_route.del_station(curr_station)
              else
                puts "Введена неверная станция"
              end
            else
              puts "Введен неверный маршрут"
            end            
          when "3" #Добавить вагон в поезд
            puts "Список поездов"
            num_list(@all_trains)
            puts "Введите номер поезда"
            train_number = must_be_int()
            curr_train = @all_trains[train_number - 1]
              if curr_train
                if all_trains[train_number - 1].type == "C"
                  all_trains[train_number - 1].add_wagon(WagonCargo.new)
                else
                  all_trains[train_number - 1].add_wagon(WagonPass.new)
                end
              else
                puts "Введен неверный поезд"
              end
          when "4" #Удалить вагон из поезда
            puts "Список поездов"
            num_list(@all_trains)
            puts "Введите номер поезда"
            train_number = must_be_int()
            curr_train = @all_trains[train_number - 1]
            if curr_train
              all_trains[train_number - 1].del_wagon()
            else
              puts "Введен неверный поезд"
            end
          when "5" #Присвоить маршрут поезду
            puts "Список поездов"
            num_list(@all_trains)
            puts "Введите номер поезда"
            train_number = must_be_int()
            curr_train = @all_trains[train_number - 1]
            if curr_train
              puts "Список маршрутов"
              num_list(@all_routes)
              puts "Введите маршрут"
              route_number = must_be_int()
              curr_route = @all_routes[route_number - 1]
              if curr_route
                curr_train.current_station.del_train(curr_train) if curr_train.route
                curr_train.add_route(curr_route)
                curr_route.stations_list.first.add_train(curr_train)
              else
                puts "Введен неверный маршрут"
              end
            else
              puts "Введен неверный поезд"
            end
          when "6" #Отменить маршрут у поезда
            puts "Список поездов"
            num_list(@all_trains)
            puts "Введите номер поезда"
            train_number = must_be_int()
            curr_train = @all_trains[train_number - 1]
            if curr_train
              #puts "#{curr_train.name}"
              #puts "#{curr_train.route.name}"
              #puts "#{curr_train.route.class}"
              if curr_train.route.nil? ###Вопрос - не работает с условием curr_train.route
                puts "Поезду не присвоен маршрут"
              else
                curr_train.current_station.del_train(curr_train)
                curr_train.del_route
              end
            else
              puts "Введен неверный поезд"
            end
          when "7" #Переместить поезд вперед по маршруту
            puts "Список поездов"
            num_list(@all_trains)
            puts "Введите номер поезда"
            train_number = must_be_int()
            curr_train = @all_trains[train_number - 1] 
            if curr_train
              if curr_train.route.nil?
                puts "Поезду не присвоен маршрут"
              else
                curr_train.move_train_forward
              end
            else
              puts "Введен неверный поезд"
            end
          when "8" #Переместить поезд назад по маршруту
            puts "Список поездов"
            num_list(@all_trains)
            puts "Введите номер поезда"
            train_number = must_be_int()
            curr_train = @all_trains[train_number - 1]
            if curr_train
              if curr_train.route.nil?
              else
                curr_train.move_train_backward
              end
            else
              puts "Введен неверный поезд"
            end
          end
        end

      when "3" #Информационное меню - OBJECTS_INFO
        loop do
          puts OBJECTS_INFO
          choice = gets.chomp
          case choice
          when "0" then break
          when "1"
            @all_stations.each do |station|
              puts "#{station.name}"
              if station.trains_list.size == 0
                puts "   На станции нет поездов"
              else
                station.trains_list.each do |train|
                  puts "   #{train.name}"
                end
              end
            end
          when "2"
            @all_trains.each do |train|
              puts "#{train.name}"
              puts "   Количество вагонов - #{train.wagons.size}"
              puts "   Тип - #{train.type}"
              if train.route
                puts "   Маршрут - #{train.route.name}"
              else
                puts "   Маршрут не присвоен"
              end
            end
          when "3"
            @all_routes.each do |route|
              puts "#{route.name}"
              route.stations_list.each do |station|
                 puts "   #{station.name}"
              end
            end
          end
        end
      when "4"
        @all_stations << Station.new("Казань")
        @all_stations << Station.new("Зеленый Дол")
        @all_stations << Station.new("Канаш")
        @all_stations << Station.new("Муром")
        @all_stations << Station.new("Москва")
        @all_trains << Train.new("Татарстан", "P")
        @all_trains << Train.new("Пассажирский", "P")
        @all_trains << Train.new("Грузовой 1", "C")
        @all_trains << Train.new("Грузовой 2", "C")        
        @all_routes << Route.new("Казань - Москва", found_station_by_name("Казань"), found_station_by_name("Москва"))
      end
    end
  end
end

private 

attr_reader :all_stations, :all_trains, :all_wagons, :all_routes

def num_list(arr)
  counter = 0
  arr.each do |i|
    puts "#{(counter + 1).to_s + '. ' + i.name}"
    counter += 1
  end
end

def must_be_int()
  i = "" #Почему без инициализации выдает ошибку что не знает переменной i???
  loop do
    i = gets.chomp
    if i.to_i.to_s == i
      break
    else
      puts "Введенное значение долно быть числом!"
    end
  end
  i.to_i
end

def found_station_by_name(name)
  counter = 0
  @all_stations.each do |i|
    break if i.name == name
    counter += 1
  end
  @all_stations[counter]
end   
