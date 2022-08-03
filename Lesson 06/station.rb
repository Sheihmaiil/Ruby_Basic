require_relative 'instancecounter'

class Station
  include InstanceCounter
  attr_accessor :name
  attr_reader :trains_list, :stations
  
  @@stations = []

  def self.all
    @@stations
  end
  
  def initialize(station_name)
    @name = station_name
    @trains_list = []
    @@stations << self
    register_instance
    validate!
  end
  
  def valid?
    validate!
    true
  rescue	    
    false     
  end
  
  def add_train(train)
    @trains_list << train
  end

  def del_train(train)
    @trains_list.delete(train)
  end

  private  
  
  def trains_list_by_type(train_type)
    @trains_list.select do |train|
      train.type == train_type
    end
  end

  def trains_qty_by_type(train_type)
    trains_list_by_type(train_type).count
  end
  
  protected
  
  def validate!
    raise "Имя станции не может быть пустым" if station_name == ""
  end
  
end
