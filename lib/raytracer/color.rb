require_relative "tuple.rb"

module RT
  class Color < Tuple
    alias :red :x
    alias :green :y
    alias :blue :z

    def initialize(r, g, b)
      super(r, g, b, 0)
    end

    def hm_product(other)
      Color.new(self.red * other.red, self.green * other.green, self.blue * other.blue)
    end

    def *(other)
      case other
      when Color then self.hm_product(other)
      else super(other) # calls scalar multiply
      end
    end
  end
end
