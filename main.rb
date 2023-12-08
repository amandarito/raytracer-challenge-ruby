require "minitest/autorun"
EPSILON = 0.0001

# base classes
class Tuple
    attr_reader :x, :y, :z, :w

    def initialize(x, y, z, w)
        @x = x
        @y = y
        @z = z
        @w = w
    end

    def point?
        w == 1.0
    end

    def vector?
        w == 0.0
    end

    def ==(other)
        return (fp_equal?(self.x, other.x) and fp_equal?(self.y, other.y) and fp_equal?(self.z, other.z) and fp_equal?(self.w, other.w))
    end

    def +(other)
        Tuple.new(self.x + other.x, self.y + other.y, self.z + other.z, self.w + other.w)
    end

    def -(other)
        Tuple.new(self.x - other.x, self.y - other.y, self.z - other.z, self.w - other.w)
    end
end

class Point < Tuple
    def initialize(x, y, z)
        super(x, y, z, 1)
    end
end

def fp_equal?(a, b)
    return (a-b).abs < EPSILON
end

class Vector < Tuple
    def initialize(x, y, z)
        super(x, y, z, 0)
    end
end

def tuples_equal?(a, b)
    return (fp_equal?(a.x, b.x) and fp_equal?(a.y, b.y) and fp_equal?(a.z, b.z) and fp_equal?(a.w, b.w))
end

# factory functions
def point(x, y, z)
    Point.new(x, y, z)
end

def vector(x, y, z)
    Vector.new(x, y, z)
end