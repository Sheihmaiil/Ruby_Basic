class Station
  attr_accessor :station
  attr_reader :trains_list

  def initialize(station_name)
    @station = station_name
    @trains_list = []
  end

  def add_train(train)
    @trains_list << train
  end

  def del_train(train)
    index = @trains_list.index(train)
    if index != nil
      @trains_list.slice!(index)
    else
      puts "На станции нет поезда #{train.train_name}"
    end
  end

#этот метод для меня
  def trains_list_to_scr(train_type = 'A')
    if @trains_list.size == 0
      puts "На станции нет поездов!"
    else
      if train_type == 'A'
        @trains_list.each {|x| puts "#{x.train_name}"}
      else
        @trains_list.each {|x| puts "#{x.train_name}" if x.train_type == train_type}
      end
    end
  end

  def trains_list_by_type(train_type)
    trains_list_by_type = []
    @trains_list.each do |x|
      if x.train_type == train_type
        trains_list_by_type << x
      end      
    end
    return trains_list_by_type
  end

  def trains_qty_by_type(train_type)
    trains_qty_by_type = 0
    @trains_list.each do |x|
      if x.train_type == train_type
        trains_qty_by_type += 1
      end      
    end
    return trains_qty_by_type
  end

end
