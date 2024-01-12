require_relative "helpers"

module RT
  # Tuple is the base class for Point and Vector.
  # Stored as `(x, y, z, w)`.
  class Tuple
    attr_reader :x, :y, :z, :w

    def initialize(x, y, z, w)
      @x = x
      @y = y
      @z = z
      @w = w
    end

    def to_s
      "(#{"%.3f" % @x}, #{"%.3f" % @y}, #{"%.3f" % @z}, #{"%.0f" % @w})"
    end

    def point?
      w == 1
    end

    def vector?
      w == 0
    end

    def magnitude
      Math.sqrt(@x**2 + @y**2 + @z**2 + @w**2)
    end

    def normalized
      mag = magnitude
      Tuple.new(@x / mag, @y / mag, @z / mag, @w / mag)
    end

    def dot(b)
      x * b.x + y * b.y + z * b.z + w * b.w
    end

    def ==(other)
      fp_equal?(@x, other.x) and fp_equal?(@y, other.y) \
      and fp_equal?(@z, other.z) and fp_equal?(@w, other.w)
    end

    def +(other)
      Tuple.new(@x + other.x, @y + other.y, @z + other.z, @w + other.w)
    end

    def -(other)
      Tuple.new(@x - other.x, @y - other.y, @z - other.z, @w - other.w)
    end

    def *(other)
      Tuple.new(@x * other, @y * other, @z * other, @w * other)
    end

    def /(other)
      self * (1.0 / other)
    end

    def -@
      Tuple.new(0, 0, 0, 0) - self
    end
  end
end
