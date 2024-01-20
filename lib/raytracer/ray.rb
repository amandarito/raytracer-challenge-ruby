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

    def transform(transform)
      new_origin = transform * origin
      new_direction = transform * direction
      Ray.new(new_origin, new_direction)
    end
  end
end
