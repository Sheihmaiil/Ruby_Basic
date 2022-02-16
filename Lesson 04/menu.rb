class Menu
  attr_reader :all_stations, :all_trains, :all_wagons, :all_routes

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
    "1. Список станций/поездов на станциях", #надо дописать список поездов на станции
    "2. Список поездов",
    "3. Список маршутов",
    "0. В предыдущее меню"
  ]

  def initialize
    @all_stations = []
    @all_trains = []
    @all_routes = []
  end

  def found_station_by_name(name)
    counter = 0
    @all_stations.each do |i|
      break if i.name == name
      counter += 1
    end
    @all_stations[counter]
  end   

  def stations_list()
    counter = 0
    @all_stations.each do |i|
      puts "#{(counter + 1).to_s + '. ' + i.name}"
      counter += 1
    end
  end

  def trains_list()
    counter = 0
    @all_trains.each do |i|
      puts "#{(counter + 1).to_s + '. ' + i.name}"
      counter += 1
    end
  end

  def routes_list()
    counter = 0
    @all_routes.each do |i|
      puts "#{(counter + 1).to_s + '. ' + i.name}"
      counter += 1
    end
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
          when "1"
            print "Введите название станции: \n"
            st = gets.chomp
            @all_stations << Station.new(st)
          when "2"
            print "Введите название поезда: \n"
            tr = gets.chomp
            print "Задайте тип поезда ('C' - cargo, 'P' - passenger): \n"
            tr_type = gets.chomp
            @all_trains << Train.new(tr, tr_type)
          when "3"
            puts "Список станций:"
            stations_list()
            puts "Введите номер первой станции"
            first_station = gets.chomp.to_i
            if (1..@all_stations.size).include?(first_station)
              puts "Введите номер последней станции"
              last_station = gets.chomp.to_i
                if (1..@all_stations.size).include?(last_station)
                  @all_routes << Route.new(@all_stations[first_station - 1].name + ' - ' + @all_stations[last_station - 1].name, @all_stations[first_station - 1], @all_stations[last_station - 1])
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
            route_number = gets.chomp.to_i
            if (1..@all_routes.size).include?(route_number)            
              curr_route = @all_routes[route_number - 1]
              puts "Список станций"
              stations_list()
              puts "Ведите  номер станции"
              station_number = gets.chomp.to_i
              if (1..@all_stations.size).include?(station_number)
                curr_route.add_station(@all_stations[station_number - 1])
              else
                puts "Введена неверная станция"
              end
            else
              puts "Введен неверный маршрут"
            end
          when "2" #Удалить станцию из маршрута
            puts "Список маршрутов"
            routes_list()
            puts "Введите номер маршрута"
            route_number = gets.chomp.to_i
            if (1..@all_routes.size).include?(route_number)            
              curr_route = @all_routes[route_number - 1]
              puts "Список станций"
              stations_list()
              puts "Ведите номер станции"
              station_number = gets.chomp.to_i
              if (1..@all_stations.size).include?(station_number)
                puts "#{curr_route}"
                curr_route.del_station(@all_stations[station_number - 1])
              else
                puts "Введена неверная станция"
              end
            else
              puts "Введен неверный маршрут"
            end            
          when "3" #Добавить вагон в поезд
            puts "Список поездов"
            trains_list()
            puts "Введите номер поезда"
            train_number = gets.chomp.to_i
              if (1..@all_trains.size).include?(train_number) 
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
            trains_list()
            puts "Введите номер поезда"
            train_number = gets.chomp.to_i
            if (1..@all_trains.size).include?(train_number)
              all_trains[train_number - 1].del_wagon()
            else
              puts "Введен неверный поезд"
            end
          when "5" #Присвоить маршрут поезду
            puts "Список поездов"
            trains_list()
            puts "Введите номер поезда"
            train_number = gets.chomp.to_i
            if (1..@all_trains.size).include?(train_number)              
              puts "Список маршрутов"
              routes_list()
              puts "Введите маршрут"
              route_number = gets.chomp.to_i
              if (1..@all_routes.size).include?(route_number)            
                curr_route = @all_routes[route_number - 1]
                @all_trains[train_number - 1].add_route(curr_route)
                curr_route.stations_list[0].add_train(@all_trains[train_number - 1])
              else
                puts "Введен неверный маршрут"
              end
            else
              puts "Введен неверный поезд"
            end
          when "6" #Отменить маршрут у поезда
            puts "Список поездов"
            trains_list()
            puts "Введите номер поезда"
            train_number = gets.chomp.to_i
            if (1..@all_trains.size).include?(train_number) 
              if @all_trains[train_number - 1].route.nil?
                puts "Поезду не присвоен маршрут"
              else
                @all_trains[train_number - 1].del_route
              end
            else
              puts "Введен неверный поезд"
            end
          when "7" #Переместить поезд вперед по маршруту
            puts "Список поездов"
            trains_list()
            puts "Введите номер поезда"
            train_number = gets.chomp.to_i
            if (1..@all_trains.size).include?(train_number) 
              if @all_trains[train_number - 1].route.nil?
                puts "Поезду не присвоен маршрут"
              else ###
                @all_trains[train_number - 1].move_train_forward_1(@all_trains[train_number - 1])
              end
            else
              puts "Введен неверный поезд"
            end
          when "8" #Переместить поезд назад по маршруту
            puts "Список поездов"
            trains_list()
            puts "Введите номер поезда"
            train_number = gets.chomp.to_i
            if (1..@all_trains.size).include?(train_number) 
              if @all_trains[train_number - 1].route.nil?
                puts "Поезду не присвоен маршрут"
              else ###
                @all_trains[train_number - 1].move_train_backward_1(@all_trains[train_number - 1])
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
            all_stations.each do |station|
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
            trains_list()
          when "3"
            routes_list()
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
