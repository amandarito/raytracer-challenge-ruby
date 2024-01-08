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
  end
end
