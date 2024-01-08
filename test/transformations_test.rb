require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/raytracer"
require_relative "../lib/raytracer/point"
require_relative "../lib/raytracer/vector"
require_relative "../lib/raytracer/matrix"

module RT
  class TransformationsTest < Minitest::Test
    def test_translation_matrix_point_multiplication
      transform = Matrix.translation(5, -3, 2)
      p = Point.new(-3, 4, 5)
      assert_equal transform * p, Point.new(2, 1, 7)
    end

    def test_translation_inverse_multiplication
      transform = Matrix.translation(5, -3, 2)
      inv = transform.inverse
      p = Point.new(-3, 4, 5)
      assert_equal inv * p, Point.new(-8, 7, 3)
    end

    def test_translation_vector_multiplication
      transform = Matrix.translation(5, -3, 2)
      v = Vector.new(-3, 4, 5)
      assert_equal transform * v, v
    end

    def test_scaling_point_application
      transform = Matrix.scaling(2, 3, 4)
      p = Point.new(-4, 6, 8)
      assert_equal transform * p, Point.new(-8, 18, 32)
    end

    def test_scaling_vector_application
      transform = Matrix.scaling(2, 3, 4)
      v = Vector.new(-4, 6, 8)
      assert_equal transform * v, Vector.new(-8, 18, 32)
    end

    def test_scaling_inverse_application
      transform = Matrix.scaling(2, 3, 4)
      inv = transform.inverse
      v = Vector.new(-4, 6, 8)
      assert_equal inv * v, Vector.new(-2, 2, 2)
    end

    def test_reflection_as_negative_scaling
      transform = Matrix.scaling(-1, 1, 1)
      p = Point.new(2, 3, 4)
      assert_equal transform * p, Point.new(-2, 3, 4)
    end

    def test_point_x_axis_rotation
      p = Point.new(0, 1, 0)
      half_quarter = Matrix.rotation_x(Math::PI / 4)
      full_quarter = Matrix.rotation_x(Math::PI / 2)
      assert_equal half_quarter * p,
        Point.new(0, Math.sqrt(2) / 2, Math.sqrt(2) / 2)
      assert_equal full_quarter * p, Point.new(0, 0, 1)
    end

    def test_x_axis_inverse_rotation
      p = Point.new(0, 1, 0)
      half_quarter = Matrix.rotation_x(Math::PI / 4)
      inv = half_quarter.inverse
      assert_equal inv * p,
        Point.new(0, Math.sqrt(2) / 2, -Math.sqrt(2) / 2)
    end

    def test_point_y_axis_rotation
      p = Point.new(0, 0, 1)
      half_quarter = Matrix.rotation_y(Math::PI / 4)
      full_quarter = Matrix.rotation_y(Math::PI / 2)
      assert_equal half_quarter * p,
        Point.new(Math.sqrt(2) / 2, 0, Math.sqrt(2) / 2)
      assert_equal full_quarter * p, Point.new(1, 0, 0)
    end

    def test_point_z_axis_rotation
      p = Point.new(0, 1, 0)
      half_quarter = Matrix.rotation_z(Math::PI / 4)
      full_quarter = Matrix.rotation_z(Math::PI / 2)
      assert_equal half_quarter * p,
        Point.new(-Math.sqrt(2) / 2, Math.sqrt(2) / 2, 0)
      assert_equal full_quarter * p, Point.new(-1, 0, 0)
    end

    def test_shearing_xy
      transform = Matrix.shearing(1, 0, 0, 0, 0, 0)
      p = Point.new(2, 3, 4)
      assert_equal transform * p, Point.new(5, 3, 4)
    end

    def test_shearing_xz
      transform = Matrix.shearing(0, 1, 0, 0, 0, 0)
      p = Point.new(2, 3, 4)
      assert_equal transform * p, Point.new(6, 3, 4)
    end

    def test_shearing_yx
      transform = Matrix.shearing(0, 0, 1, 0, 0, 0)
      p = Point.new(2, 3, 4)
      assert_equal transform * p, Point.new(2, 5, 4)
    end

    def test_shearing_yz
      transform = Matrix.shearing(0, 0, 0, 1, 0, 0)
      p = Point.new(2, 3, 4)
      assert_equal transform * p, Point.new(2, 7, 4)
    end

    def test_shearing_zx
      transform = Matrix.shearing(0, 0, 0, 0, 1, 0)
      p = Point.new(2, 3, 4)
      assert_equal transform * p, Point.new(2, 3, 6)
    end

    def test_shearing_zy
      transform = Matrix.shearing(0, 0, 0, 0, 0, 1)
      p = Point.new(2, 3, 4)
      assert_equal transform * p, Point.new(2, 3, 7)
    end

    def test_transformations_sequential_application
      p = Point.new(1, 0, 1)
      a = Matrix.rotation_x(Math::PI / 2)
      b = Matrix.scaling(5, 5, 5)
      c = Matrix.translation(10, 5, 7)

      # rotation
      p2 = a * p
      assert_equal p2, Point.new(1, -1, 0)

      # scaling
      p3 = b * p2
      assert_equal p3, Point.new(5, -5, 0)

      # translation
      p4 = c * p3
      assert_equal p4, Point.new(15, 0, 7)
    end

    # T == C * B * A:
    # x = T * p
    # x = C * B * A * p
    # x = C * (B * (A * p))
    # the last multiplied (A) gets applied first.
    def test_transformations_chained_reversed
      p = Point.new(1, 0, 1)
      a = Matrix.rotation_x(Math::PI / 2)
      b = Matrix.scaling(5, 5, 5)
      c = Matrix.translation(10, 5, 7)
      t = c * b * a
      assert_equal t * p, Point.new(15, 0, 7)
    end
  end
end
