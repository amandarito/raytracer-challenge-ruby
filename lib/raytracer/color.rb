require_relative "tuple"

module RT
  # Color stores `(red, gree, blue)` values, inheriting from Tuple.
  class Color < Tuple
    alias_method :red, :x
    alias_method :green, :y
    alias_method :blue, :z

    def initialize(r, g, b)
      super(r, g, b, 0)
    end

    def hm_product(other)
      Color.new(red * other.red, green * other.green, blue * other.blue)
    end

    def *(other)
      case other
      when Color then hm_product(other)
      else super(other) # calls scalar multiply
      end
    end
  end
end
