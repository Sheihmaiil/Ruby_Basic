class Wagon
  attr_reader :type
  def initialize (type)
    @type = type
  end
end

class WagonPass < Wagon
  def initialize(type = "P")
    super
  end
end

class WagonCargo < Wagon
  def initialize(type = "C")
    super
  end
end

