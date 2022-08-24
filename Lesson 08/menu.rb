# frozen_string_literal: true

class Menu
  MAIN_MENU = [
    '1. Создать новый объект',
    '2. Редактировать объект',
    '3. Информация об объекте',
    '4. Создать тестовый набор объектов',
    '0. Окончание работы'
  ].freeze

  CREATE_MENU = [
    '1. Создать станцию',
    '2. Создать поезд',
    '3. Создать маршрут',
    '0. В предыдущее меню'
  ].freeze

  EDIT_OBJECTS = [
    '1. Добавить станцию в маршрут',
    '2. Удалить станцию из маршрута',
    '3. Добавить вагон в поезд',
    '4. Удалить вагон из поезда',
    '5. Присвоить маршрут поезду',
    '6. Отменить маршрут у поезда',
    '7. Переместить поезд вперед по маршруту',
    '8. Переместить поезд назад по маршруту',
    '9. Добавить производителя поезда',
    '10. Добавить производителя вагона',
    '11. Занять место в вагоне',
    '0. В предыдущее меню'
  ].freeze

  OBJECTS_INFO = [
    '1. Список станций/поездов на станциях',
    '2. Список поездов',
    '3. Список маршутов/станций в маршруте',
    '4. Список вагонов в поезде',
    '5. Возвращает все станции',
    '6. Возвращает объект поезд по имени',
    '0. В предыдущее меню'
  ].freeze

  TEST_STATIONS = [
    'Казань',
    'Зеленый Дол',
    'Канаш',
    'Муром',
    'Москва'
  ].freeze

  TEST_TRAINS = [
    ['Тат-11', 'P', ''],
    ['Пас-22', 'P', ''],
    ['Гру-11', 'C', ''],
    ['Гру-22', 'C', '']
  ].freeze

  def initialize
    @all_stations = []
    @all_trains = []
    @all_routes = []
  end

  def start
    loop do
      puts MAIN_MENU
      case gets.chomp
      when '0' then break
      when '1' then create_objects
      when '2' then manage_objects
      when '3' then objects_info
      when '4' then test_objects
      end
    end
  end

  private

  attr_reader :all_stations, :all_trains, :all_routes

  def num_list(arr)
    arr.each.with_index(1) { |i, index| puts "#{index}. #{i.name}" }
  end

  def must_be_int
    loop do
      result = Integer(gets.chomp)

      return result
    rescue ArgumentError
      puts 'Введенное значение должно быть числом!'
    end
  end

  def create_station
    print "Введите название станции: \n"
    @all_stations << Station.new(gets.chomp)
  rescue RuntimeError => e
    puts e
  end

  def create_train
    print "Введите название поезда: \n"
    tr = gets.chomp
    print "Задайте тип поезда ('C' - cargo, 'P' - passenger): \n"
    tr_type = gets.chomp
    @all_trains << Train.new(tr, tr_type, '')
  rescue RuntimeError => e
    puts e
  end

  def create_route
    curr_station1 = get_station('Введите номер первой станции')
    curr_station2 = get_station('Введите номер последней станции')
    @all_routes << Route.new("#{curr_station1.name} - #{curr_station2.name}", curr_station1, curr_station2)
  end

  def create_objects
    loop do
      puts CREATE_MENU
      case gets.chomp
      when '0' then break
      when '1' then create_station # Создать станцию
      when '2' then create_train # Создать поезд
      when '3' then create_route # Создать маршрут
      end
    end
  end

  def manage_objects
    loop do
      puts EDIT_OBJECTS
      case gets.chomp
      when '0' then break
      when '1' then add_station_to_route # Добавить станцию в маршрут
      when '2' then del_station_from_route # Удалить станцию из маршрута
      when '3' then add_wagon_to_train # Добавить вагон в поезд
      when '4' then del_wagon_from_train # Удалить вагон из поезда
      when '5' then add_route_to_train # Присвоить маршрут поезду
      when '6' then del_route_from_train # Отменить маршрут у поезда
      when '7' then move_train_forward_on_route # Переместить поезд вперед по маршруту
      when '8' then move_train_backward_on_route # Переместить поезд назад по маршруту
      when '9' then add_manufacturer_to_train # Добавить производителя поезда
      when '10' then add_manufacturer_to_wagon # Добавить производителя вагона
      when '11' then take_place_in_wagon # Занять место в вагоне
      end
    end
  end

  def stations_trains_info
    Station.all.each do |station|
      puts station.name.to_s
      if station.trains_list.size.positive?
        puts 'На станции нет поездов'
      else
        station.each_train do |train|
          puts "Название поезда: #{train.name}. Производитель: #{train.manufacturer}. Тип: #{train.type}. Вагонов в поезде: #{train.wagons.size}"
        end
      end
    end
  end

  def trains_info
    @all_trains.each do |train|
      puts "Название поезда: #{train.name}."
      train.each_wagon do |wagon, index|
        puts "Номер вагона: #{index}. Производитель : #{wagon.manufacturer}. Тип: #{wagon.type}. Свободно мест: #{wagon.places - wagon.taken_places} из #{wagon.places}."
      end
      if train.route
        puts "   Маршрут - #{train.route.name}"
      else
        puts '   Маршрут не присвоен'
      end
    end
  end

  def routes_stations_list
    @all_routes.each do |route|
      puts route.name.to_s
      route.stations_list.each do |station|
        puts "   #{station.name}"
      end
    end
  end

  def objects_info
    loop do
      puts OBJECTS_INFO
      case gets.chomp
      when '0' then break
      when '1' then stations_trains_info # Список станций/поездов на станциях
      when '2' then trains_info # Список поездов
      when '3' then routes_stations_list # Список маршутов/станций в маршруте
      when '4' then wagons_list # Список вагонов в поезде
      when '5' then puts Station.all # Возвращает все станции
      when '6' then Train.find(select_train.name) # Возвращает объект поезд по имени
      end
    end
  end

  def test_objects
    TEST_STATIONS.each { |i| @all_stations << Station.new(i) }
    TEST_TRAINS.each { |i| @all_trains << Train.new(i[0], i[1], i[2]) }
    @all_routes << Route.new('Казань - Москва', @all_stations[0], @all_stations[4])
    [20, 10].each { |i| @all_trains[0].add_wagon(i) }
    ['111', '222'].each.with_index(0) { |i, index| @all_trains[0].wagons[index].manufacturer_name(i) }
    @all_trains[0].add_route(@all_routes[0])
    @all_routes[0].stations_list.first.add_train(@all_trains[0])
  end

  def get_station(text = 'Ведите номер станции')
    unless text == 'Введите номер последней станции'
      puts 'Список станций'
      num_list(@all_stations)
    end
    puts text
    station_number = 0
    loop do
      station_number = must_be_int

      break if (1..@all_stations.size).include?(station_number)
    end
    @all_stations[station_number - 1]
  end

  def select_route
    puts 'Список маршрутов'
    num_list(@all_routes)
    puts 'Введите номер маршрута'
    route_number = 0
    loop do
      route_number = must_be_int
      break if (1..@all_routes.size).include?(route_number)

      puts 'Введен неверный маршрут'
    end
    @all_routes[route_number - 1]
  end

  def select_train
    puts 'Список поездов'
    num_list(@all_trains)
    puts 'Введите номер поезда'
    train_number = 0
    loop do
      train_number = must_be_int
      break if (1..@all_trains.size).include?(train_number)

      puts 'Введен неверный поезд'
    end
    @all_trains[train_number - 1]
  end

  def add_station_to_route
    curr_route = select_route
    curr_station = get_station
    curr_route.add_station(curr_station)
  end

  def del_station_from_route
    curr_route = select_route
    puts 'Список станций'
    num_list(curr_route.stations_list)
    puts 'Ведите номер станции'
    station_number = 0
    loop do
      station_number = must_be_int
      if (1..curr_route.stations_list.size).include?(station_number)
        curr_station = curr_route.stations_list[station_number - 1]
        curr_get_stroute.del_station(curr_station)
        break
      else
        puts 'Введена неверная станция'
      end
    end
  end

  def add_wagon_to_train
    curr_train = select_train
    puts 'Введите количество мест:'
    result = must_be_int
    curr_train.add_wagon(result)
  rescue RuntimeError => e
    puts e
  end

  def del_wagon_from_train
    curr_train = select_train
    curr_train.del_wagon
  end

  def add_route_to_train
    curr_train = select_train
    curr_route = select_route
    curr_train.current_station.del_train(curr_train) if curr_train.route
    curr_train.add_route(curr_route)
    curr_route.stations_list.first.add_train(curr_train)
  end

  def del_route_from_train
    curr_train = select_train
    if curr_tget_strain.route.nil?
      puts 'Поезду не присвоен маршрут'
    else
      curr_train.current_station.del_train(curr_train)
      curr_train.del_route
    end
  end

  def move_train_forward_on_route
    curr_train = select_train
    if curr_train.route.nil?
      puts 'Поезду не присвоен маршрут'
    else
      curr_train.move_train_forward
    end
  end

  def move_train_backward_on_route
    curr_train = select_train
    if curr_train.route.nil?
      puts 'Поезду не присвоен маршрут'
    else
      curr_train.move_train_backward
    end
  end

  def add_manufacturer_to_train
    curr_train = select_train
    puts "Введите наименование произодителя поезда: \n"
    manufacturer = gets.chomp
    curr_train.manufacturer_name(manufacturer)
  end

  def add_manufacturer_to_wagon
    curr_train = select_train
    return puts 'В поезде нет вагонов' unless curr_train.wagons.size.positive?

    puts "В поезде #{curr_train.wagons.size} вагонов. Выберите номер вагона:"
    wagon_number = must_be_int
    puts "Введите наименование производителя вагона: \n"
    manufacturer = gets.chomp
    curr_train.wagons[wagon_number - 1].manufacturer_name(manufacturer)
  end

  def wagons_list
    curr_train = select_train
    return puts 'В поезде нет вагонов' unless curr_train.wagons.size.positive?

    curr_train.wagons.each.with_index(1) do |i, index|
      puts "Вагон номер #{index}"
      puts "Тип вагона - #{i.type}"
      puts "Производитель вагона - #{i.manufacturer}"
      puts "Всего мест в вагоне - #{i.places} из них свободно - #{i.empty_places}"
    end
  end

  def take_place_in_wagon
    curr_train = select_train
    return puts 'В поезде нет вагонов' unless curr_train.wagons.size.positive?

    puts "В поезде #{curr_train.wagons.size} вагонов. Выберите номер вагона: \n"
    wagon_number = must_be_int
    if curr_train.type == 'P'
      result = 1
    else
      puts 'Введите требуемое количество места'
      result = must_be_int
    end
    curr_train.wagons[wagon_number - 1].take_place(result)
  rescue RuntimeError => e
    puts e
  end
end
