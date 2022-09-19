# frozen_string_literal: true

require_relative 'instancecounter'
require_relative 'modules'

class Station
  include InstanceCounter
  include Validation
  
  attr_accessor :name
  attr_reader :trains_list
  
  validate :name, :type, String
  validate :name, :presence

  def initialize(station_name)
    @name = station_name
    @trains_list = []
    validate!
  end

  def add_train(train)
    @trains_list << train
  end

  def del_train(train)
    @trains_list.delete(train)
  end

  def each_train(&block)
    if block_given?
      @trains_list.each(&block)
    else
      puts 'Нет блока'
    end
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
end
