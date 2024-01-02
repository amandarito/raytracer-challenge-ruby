require_relative "tuple"

module RT
  class Vector < Tuple
    def initialize(x, y, z)
      super(x, y, z, 0)
    end

    def dot(b)
      self.x * b.x + self.y * b.y + self.z * b.z + self.w * b.w
    end

    def cross(b)
      Vector.new(self.y * b.z - self.z * b.y, self.z * b.x - self.x * b.z, self.x * b.y - self.y * b.x)
    end
  end
end
