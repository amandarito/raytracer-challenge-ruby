require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/raytracer"
require_relative "../lib/raytracer/point"
require_relative "../lib/raytracer/vector"
require_relative "../lib/raytracer/matrix"
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

    def test_intersect_sets_object_on_intersection
      r = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
      s = Sphere.new
      xs = s.intersect(r)
      assert_equal xs[0].object, s
      assert_equal xs[1].object, s
    end

    def test_sphere_default_transformation
      s = Sphere.new
      assert_equal s.transform, Matrix.identity(4)
    end

    def test_changing_sphere_transformation
      s = Sphere.new
      t = Matrix.translation(2, 3, 4)
      s.transform = t
      assert_equal s.transform, t
    end

    def test_intersecting_scaled_sphere_with_ray
      r = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
      s = Sphere.new
      s.transform = Matrix.scaling(2, 2, 2)
      xs = s.intersect(r)
      assert_equal xs.size, 2
      assert_equal xs[0].t, 3
      assert_equal xs[1].t, 7
    end

    def test_intersecting_translated_sphere_with_ray
      r = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
      s = Sphere.new
      s.transform = Matrix.translation(5, 0, 0)
      xs = s.intersect(r)
      assert_equal xs.size, 0
    end
  end
end
