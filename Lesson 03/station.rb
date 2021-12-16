class Station
  attr_accessor :station

  def initialize(station)
    @station = station
    @trains_list = []
    @trains_type = []
  end

  def trains_list(train_type)
    if @trains_list.empty?
      puts 'На станции нет поездов'
    else
      if train_type == "ВСЕ"
        @trains_list.each {|x| puts "#{x}"}
      else
        for i in 0..@trains_list.size
          if train_type == @trains_type[i]
            puts "#{@trains_list[i]}"
          end
        end
      end
    end
  end

  def add_train(train_id, train_type)
    @trains_list << train_id
    @trains_type << train_type
  end

  def del_train(train_id)
    index = @trains_list.index(train_id)

    if index != nil
      @trains_list.slice!(index)
      @trains_type.slice!(index)
    else
      puts "На станции нет поездов #{train_id}"
    end

  end
 
end

