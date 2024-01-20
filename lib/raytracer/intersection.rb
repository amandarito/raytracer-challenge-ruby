module RT
  class Intersection
    attr_accessor :t, :object

    def initialize(t, object)
      @t = t
      @object = object
    end

    def self.hit(intersections)
      intersections.reject! { |i| i.t.negative? }
      intersections.min_by(&:t)
    end
  end
end
