module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate (var_name, type) #Метод класса
      puts var_name
    end
  end

  module InstanceMethods
    def debug(log)
      self.class.debug(log)
    end
  end

end

class Test
#  extend Accessors
  include Validation
  
#  def initialize
#     validate :qqq, :presence
#  end
  
#  strong_attr_accessor :qqq, String
  validate :qqq, :presence
  
end
