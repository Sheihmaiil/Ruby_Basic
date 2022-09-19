# frozen_string_literal: true

module Manufacturer
  def manufacturer_name(name)
    self.manufacturer = name
  end

  def manufacturer
    manufacturer
  end

  protected

  attr_writer :manufacturer
end

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(var_name_history) }

      define_method("#{name}_history=".to_sym) { |value| instance_variable_set(var_name_history, value) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        if instance_variable_defined?(var_name_history)
          instance_variable_get(var_name_history) << value
        else
          instance_variable_set(var_name_history, [value])
        end
      end
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Ошибка типа переменной' unless value.instance_of?(type)

      instance_variable_set(var_name, value)
    end
  end
  
end

module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
  
    attr_accessor :validations
  
    def validate (var_name, validation_type, param = nil)
      @validations ||= []
      @validations << [var_name, validation_type, param]
    end
  end

  module InstanceMethods
    def validate!
      params = self.class.validations
      params.each do |x|
        self.send("validate_#{x[1]}", x[0], x[2])
      end
    end

    private

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
    
    def validate_presence(var_name, param = nil)
      local_var_name = instance_variable_get("@#{var_name}".to_sym)
      puts "var_name => #{var_name}"
      puts "local_var_name => #{local_var_name}"
      raise "Имя не может быть пустым или nil" if local_var_name.nil? || local_var_name.empty?    
    end
    
    def validate_format(var_name, param = nil)
      local_var_name = instance_variable_get("@#{var_name}".to_sym)
      raise 'Ошибка формата' unless local_var_name =~ param
    end
    
    def validate_type(var_name, param = nil)
      local_var_name = instance_variable_get("@#{var_name}".to_sym)
      raise 'Ошибка класса' unless local_var_name.is_a?param
    end 
    
  end

end

class Test
  extend Accessors
  include Validation
  
  strong_attr_accessor :qqq, String
  validate :qqq, :presence
  validate :qqq, :format, /A-Z{0-3}/
  validate :qqq, :class, Integer
 
  def initialize
    validate!
  end  
end
