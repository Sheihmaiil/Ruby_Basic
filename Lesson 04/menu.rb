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
    "3. Создать вагон",
    "4. Создать маршрут",
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
    "1. Список станций", #надо дописать список поездов на станции
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
      if i.name == name
         break
      end
      counter += 1
    end
    @all_stations[counter]
  end

  def found_train_by_name(name)
    counter = 0
    @all_trains.each do |i|
      if i.name == name
         break
      end
      counter += 1
    end
    @all_trains[counter]
  end

  def found_route_by_name(name)
    counter = 0
    @all_routes.each do |i|
      if i.name == name
         break
      end
      counter += 1
    end
    @all_routes[counter]
  end

  def stations_list()
    @all_stations.each do |i|
      puts "#{i.name}"
    end
  end

  def trains_list()
    all_trains.each do |i|
      puts "#{i.name}"
    end
  end

  def routes_list()
    all_routes.each do |i|
      puts "#{i.name}"
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
            print "Задайте тип вагона ('C' - cargo, 'P' - passenger): \n"
            vg_type = gets.chomp
            @all_wagons << Wagon.new(vg_type)
          when "4"
            puts "Список станций:"
            stations_list()
            puts "Введите имя первой станции"
            tmp1 = gets.chomp
            puts "Введите имя последней станции"
            tmp2 = gets.chomp
            
            @all_routes << Route.new(tmp1 + ' - ' + tmp2, found_station_by_name(tmp1), found_station_by_name(tmp2))

          end  
        end
      when "2" #Редактирование объектов - EDIT_MENU
        loop do
          puts EDIT_OBJECTS
          choice = gets.chomp
          case choice
          when "0" then break
          when "1"
            puts "Список маршрутов"
            routes_list()
            puts "Введите маршрут"
            tmp1 = gets.chomp
            tmp2 = found_route_by_name(tmp1)
            puts "Список станций"
            stations_list()
            puts "Ведите имя станции"
            tmp3 =gets.chomp
            tmp4 = found_station_by_name(tmp3)
            tmp2.add_station(tmp4)
          when "2"
            puts "Список маршрутов"
            routes_list()
            puts "Введите маршрут"
            tmp1 = gets.chomp
            tmp2 = found_route_by_name(tmp1)
            puts "Список станций"
            tmp2.stations_list.each do |i|
              puts "#{i.name}"
            end
            puts "Ведите имя станции"
            tmp3 = gets.chomp
            tmp4 = found_station_by_name(tmp3)
            tmp2.del_station(tmp4)
          when "3"
            puts "Список поездов"
            trains_list()
            puts "Введите поезд"
            tmp1 = gets.chomp
            tmp2 = found_train_by_name(tmp1)
            if tmp2.type == "C"
              tmp2.add_wagon(WagonCargo.new)
            else
              tmp2.add_wagon(WagonPass.new)
            end
          when "4"
            puts "Список поездов"
            trains_list()
            puts "Введите поезд"
            tmp1 = gets.chomp
            found_train_by_name(tmp1).del_wagon()         
          when "5"
            puts "Список поездов"
            trains_list()
            puts "Введите поезд"
            tmp1 = gets.chomp
            tmp2 = found_train_by_name(tmp1)
            ###
            puts "qqq" if tmp2.nil?
            puts "Список маршрутов"
            routes_list()
            puts "Введите маршрут"
            tmp3 = gets.chomp
            tmp4 = found_route_by_name(tmp3)
            if tmp2.nil?
            else
              tmp2.add_route(tmp4)
              tmp4.stations_list[0].add_train(tmp2)
            end
          when "6"
            puts "Список поездов"
            trains_list()
            puts "Введите поезд"
            tmp1 = gets.chomp
            tmp2 = found_train_by_name(tmp1)
            puts "#{tmp2.route.nil?}" if tmp2.route.nil?
            if tmp2.route.nil?
            else
              #как удалить из station.trains_list
              tmp2.del_route
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
            stations_list()
          when "2"
            trains_list()
          when "3"
            all_routes.each do |i|
              puts "#{i.name}"
              i.stations_list.each do |j|
                puts "#{j.name}"
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
