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
    "9. Добавить производителя поезда",
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

  def start
    loop do
      puts MAIN_MENU
      choice = gets.chomp
      case choice
      when "0" then break
      when "1"
        create_objects
      when "2"
        manage_objects
      when "3"
        objects_info
      when "4"
        test_objects
      end
    end
  end

  private

  attr_reader :all_stations, :all_trains, :all_routes

  def num_list(arr)
    counter = 1
    arr.each do |i|
      puts "#{counter}. #{i.name}"
      counter += 1
    end
  end

  def must_be_int
    loop do
      result = Integer(gets.chomp)
      return result
  rescue ArgumentError
      puts "Введенное значение должно быть числом!"
    end
  end

  def found_station_by_name(name)
    counter = 0
    @all_stations.each do |i|
      break if i.name == name
      counter += 1
    end
    @all_stations[counter]
  end

  def create_objects
    loop doк 
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
        @all_trains << Train.new(tr, tr_type, "")
      when "3" #Создать маршрут
        curr_station1 = get_station("Введите номер первой станции")
        if curr_station1
          curr_station2 = get_station("Введите номер последней станции")
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
  end

  def manage_objects
    loop do
      puts EDIT_OBJECTS
      choice = gets.chomp
      case choice
      when "0" then break
      when "1" #Добавить станцию в маршрут
        add_station_to_route
      when "2" #Удалить станцию из маршрута
        del_station_from_route
      when "3" #Добавить вагон в поезд
        add_wagon_to_train
      when "4" #Удалить вагон из поезда
        del_wagon_from_train
      when "5" #Присвоить маршрут поезду
        add_route_to_train
      when "6" #Отменить маршрут у поезда
        del_route_from_train
      when "7" #Переместить поезд вперед по маршруту
        move_train_forward_on_route
      when "8" #Переместить поезд назад по маршруту
        move_train_backward_on_route
      when "9" #Добавить производителя поезда
        add_manufacturer_to_train
      when "10" #Добавить производителя вагона
        add_manufacturer_to_wagon
      end
    end
  end
  
  def objects_info
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
          puts "   Производитель - #{train.manufacturer}"
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
  end

  def test_objects
    @all_stations << Station.new("Казань")
    @all_stations << Station.new("Зеленый Дол")
    @all_stations << Station.new("Канаш")
    @all_stations << Station.new("Муром")
    @all_stations << Station.new("Москва")
    @all_trains << Train.new("Татарстан", "P", "")
    @all_trains << Train.new("Пассажирский", "P","")
    @all_trains << Train.new("Грузовой 1", "C","")
    @all_trains << Train.new("Грузовой 2", "C", "")        
    @all_routes << Route.new("Казань - Москва", found_station_by_name("Казань"), found_station_by_name("Москва"))
  end

  def get_station(text = "Ведите номер станции")
    unless text == "Введите номер последней станции"
      puts "Список станций"
      num_list(@all_stations)
    end    
    puts text
    station_number = must_be_int
    @all_stations[station_number - 1]
  end

  def get_route()
    puts "Список маршрутов"
    num_list(@all_routes)
    puts "Введите номер маршрута"
    route_number = must_be_int
    @all_routes[route_number - 1]
  end

  def get_train
    puts "Список поездов"
    num_list(@all_trains)
    puts "Введите номер поезда"
    train_number = must_be_int()
    @all_trains[train_number - 1]
  end

  def add_station_to_route
    curr_route = get_route
    if curr_route
      curr_station = get_station
      if curr_station
        curr_route.add_station(curr_station)
      else
        puts "Введена неверная станция"
      end
    else
      puts "Введен неверный маршрут"
    end
  
  end

  def del_station_from_route
    curr_route = get_route
    if curr_route
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
  end

  def add_wagon_to_train
    curr_train = get_train
    if curr_traincurr_train = get_train
      if curr_train
        curr_train.del_wagon
      else
        puts "Введен неверный поезд"
      end
    else
      puts "Введен неверный поезд"
    end
  end

  def del_wagon_from_train
    curr_train = get_train
    if curr_train
      curr_train.del_wagon
    else
      puts "Введен неверный поезд"
    end
  end

  def add_route_to_train
    curr_train = get_train
    if curr_train
      curr_route = get_route
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
  end

  def del_route_from_train
    curr_train = get_train
    if curr_train
      if curr_train.route.nil?
        puts "Поезду не присвоен маршрут"
      else
        curr_train.current_station.del_train(curr_train)
        curr_train.del_route
      end
    else
      puts "Введен неверный поезд"
    end
  end

  def move_train_forward_on_route
    curr_train = get_train
    if curr_train
      if curr_train.route.nil?
        puts "Поезду не присвоен маршрут"
      else
        curr_train.move_train_forward
      end
    else
      puts "Введен неверный поезд"
    end
  end

  def move_train_backward_on_route
    curr_train = get_train
    if curr_train
      if curr_train.route.nil?
      else
        curr_train.move_train_backward
      end
    else
      puts "Введен неверный поезд"
    end
  end
  
  def add_manufacturer_to_train
    curr_train = get_train
    if curr_train
      puts "Введите наименование произодителя поезда: \n"
      manufacturer = gets.chomp
      curr_train.set_manufacturer(manufacturer)
    else
      puts "Введен неверный поезд"
    end
  end
