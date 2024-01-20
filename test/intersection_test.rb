require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/raytracer"
require_relative "../lib/raytracer/point"
require_relative "../lib/raytracer/vector"
require_relative "../lib/raytracer/ray"
require_relative "../lib/raytracer/sphere"
require_relative "../lib/raytracer/intersection"

module RT
  class IntersectionTest < Minitest::Test
    def test_intersection_object
      s = Sphere.new
      i = Intersection.new(3.5, s)
      assert_equal i.t, 3.5
      assert_equal i.object, s
    end

    def test_intersection_aggregation
      s = Sphere.new
      i1 = Intersection.new(1, s)
      i2 = Intersection.new(2, s)
      xs = [i1, i2]
      assert_equal xs[0].t, 1
      assert_equal xs[1].t, 2
    end

    def test_hit_when_all_intersections_positive_t
      s = Sphere.new
      i1 = Intersection.new(1, s)
      i2 = Intersection.new(2, s)
      xs = [i1, i2]
      i = Intersection.hit(xs)
      assert_equal i, i1
    end

    def test_hit_when_some_intersections_negative_t
      s = Sphere.new
      i1 = Intersection.new(-1, s)
      i2 = Intersection.new(1, s)
      xs = [i1, i2]
      i = Intersection.hit(xs)
      assert_equal i, i2
    end

    def test_hit_when_all_intersections_negative_t
      s = Sphere.new
      i1 = Intersection.new(-1, s)
      i2 = Intersection.new(-2, s)
      xs = [i1, i2]
      i = Intersection.hit(xs)
      assert_nil i
    end

    def test_hit_always_lowest_nonnegative_intersection
      s = Sphere.new
      i1 = Intersection.new(5, s)
      i2 = Intersection.new(7, s)
      i3 = Intersection.new(-3, s)
      i4 = Intersection.new(2, s)
      xs = [i1, i2, i3, i4]
      i = Intersection.hit(xs)
      assert_equal i, i4
    end
  end
end
