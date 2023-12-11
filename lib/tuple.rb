# Tuple is the fundamental point / vector class.
# Attributes (x, y, z, w) where w is 1 for points and 0 for vectors.
class Tuple
    attr_reader :x, :y, :z, :w

    def initialize(x, y, z, w)
        @x = x
        @y = y
        @z = z
        @w = w
    end

    def to_s
        "(#{'%.3f' % @x}, #{'%.3f' % @y}, #{'%.3f' % @z}, #{'%.0f' % @w})"
    end

    def point?
        w == 1.0
    end

    def vector?
        w == 0.0
    end

    def magnitude
        Math.sqrt(@x ** 2 + @y ** 2 + @z ** 2 + @w ** 2)
    end

    def normalized
        mag = self.magnitude
        Tuple.new(@x / mag, @y / mag, @z / mag, @w / mag)
    end

    def ==(other)
        (fp_equal?(@x, other.x) and fp_equal?(@y, other.y) and fp_equal?(@z, other.z) and fp_equal?(@w, other.w))
    end

    def +(other)
        Tuple.new(@x + other.x, @y + other.y, @z + other.z, @w + other.w)
    end

    def -(other)
        Tuple.new(@x - other.x, @y - other.y, @z - other.z, @w - other.w)
    end

    def *(scalar)
        Tuple.new(@x * scalar, @y * scalar, @z * scalar, @w * scalar)
    end

    def /(scalar)
        self * (1.0 / scalar)
    end

    def -@
        vector(0, 0, 0) - self
    end
end