require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/raytracer"
require_relative "../lib/raytracer/point"
require_relative "../lib/raytracer/vector"
require_relative "../lib/raytracer/ray"
require_relative "../lib/raytracer/sphere"

module RT
  class SphereTest < Minitest::Test
    def test_ray_through_sphere_intersection
      r = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
      s = Sphere.new
      xs = s.intersect(r)
      assert_equal xs.size, 2
      assert_equal xs[0].t, 4.0
      assert_equal xs[1].t, 6.0
    end

    def test_ray_tangent_sphere_intersection
      r = Ray.new(Point.new(0, 1, -5), Vector.new(0, 0, 1))
      s = Sphere.new
      xs = s.intersect(r)
      assert_equal xs.size, 2
      assert_equal xs[0].t, 5.0
      assert_equal xs[1].t, 5.0
    end

    def test_ray_misses_sphere_intersection
      r = Ray.new(Point.new(0, 2, -5), Vector.new(0, 0, 1))
      s = Sphere.new
      xs = s.intersect(r)
      assert xs.size.zero?
    end

    def test_ray_inside_sphere_intersection
      r = Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1))
      s = Sphere.new
      xs = s.intersect(r)
      assert_equal xs.size, 2
      assert_equal xs[0].t, -1.0
      assert_equal xs[1].t, 1.0
    end

    def test_sphere_behind_ray_intersection
      r = Ray.new(Point.new(0, 0, 5), Vector.new(0, 0, 1))
      s = Sphere.new
      xs = s.intersect(r)
      assert_equal xs.size, 2
      assert_equal xs[0].t, -6.0
      assert_equal xs[1].t, -4.0
    end
  end
end
