# frozen_string_literal: true

module Manufacturer
  def manufacturer_name(name)
    self.manufacturer = name
  end

  def manufacturer
    manufacturer
  end

  protected

  attr_accessor :manufacturer
end
