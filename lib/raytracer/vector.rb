require_relative "tuple"

module RT
  class Vector < Tuple
    def initialize(x, y, z)
      super(x, y, z, 0)
    end

    def dot(b)
      x * b.x + y * b.y + z * b.z + w * b.w
    end

    def cross(b)
      Vector.new(y * b.z - z * b.y, z * b.x - x * b.z, x * b.y - y * b.x)
    end
  end
end