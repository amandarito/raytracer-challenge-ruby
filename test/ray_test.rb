require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/raytracer"
require_relative "../lib/raytracer/point"
require_relative "../lib/raytracer/vector"
require_relative "../lib/raytracer/ray"

module RT
  class RayTest < Minitest::Test
    def test_ray_creation_and_query
      origin = Point.new(1, 2, 3)
      direction = Vector.new(4, 5, 6)
      r = Ray.new(origin, direction)
      assert_equal r.origin, origin
      assert_equal r.direction, direction
    end

    def test_computing_point_from_distance
      r = Ray.new(Point.new(2, 3, 4), Vector.new(1, 0, 0))
      assert_equal r.position(0), Point.new(2, 3, 4)
      assert_equal r.position(1), Point.new(3, 3, 4)
      assert_equal r.position(-1), Point.new(1, 3, 4)
      assert_equal r.position(2.5), Point.new(4.5, 3, 4)
    end
  end
end
