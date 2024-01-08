require_relative "tuple"

module RT
  # Point is a Tuple with component `w` set to `1`.
  class Point < Tuple
    def initialize(x, y, z)
      super(x, y, z, 1)
    end
  end
end
