module RT
  class Ray
    attr_accessor :origin, :direction

    def initialize(origin, direction)
      @origin = origin
      @direction = direction
    end

    def position(t)
      origin + direction * t
    end
  end
end
