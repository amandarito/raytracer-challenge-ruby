require_relative "tuple"

module RT
  # Vector is a Tuple with component `w` set to `0`.
  class Vector < Tuple
    def initialize(x, y, z)
      super(x, y, z, 0)
    end

    def cross(b)
      Vector.new(y * b.z - z * b.y, z * b.x - x * b.z, x * b.y - y * b.x)
    end
  end
end
