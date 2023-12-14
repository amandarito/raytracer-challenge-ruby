require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/tuple"
require_relative "../lib/point"
require_relative "../lib/vector"
require_relative "../lib/color"

class TupleTest < Minitest::Test
  def test_tuple_with_w1_is_a_point
    a = Tuple.new(4.3, -4.2, 3.1, 1.0)
    assert_equal a.x, 4.3
    assert_equal a.y, -4.2
    assert_equal a.z, 3.1
    assert_equal a.w, 1.0
    assert a.point?
    refute a.vector?
  end

  def test_tuple_with_w0_is_a_vector
    a = Tuple.new(4.3, -4.2, 3.1, 0.0)
    assert_equal a.x, 4.3
    assert_equal a.y, -4.2
    assert_equal a.z, 3.1
    assert_equal a.w, 0.0
    refute a.point?
    assert a.vector?
  end

  def test_point_creation_method
    p0 = Point.new(4, -4, 3)
    p1 = Tuple.new(4, -4, 3, 1)
    assert_equal p0, p1
  end

  def test_vector_creation_method
    v0 = Vector.new(4, -4, 3)
    v1 = Tuple.new(4, -4, 3, 0)
    assert_equal v0, v1
  end

  def test_tuple_addition
    a1 = Tuple.new(3, -2, 5, 1)
    a2 = Tuple.new(-2, 3, 1, 0)
    a3 = Tuple.new(1, 1, 6, 1)
    assert_equal a1 + a2, a3
  end

  def test_tuple_subtraction
    p1 = Point.new(3, 2, 1)
    p2 = Point.new(5, 6, 7)
    p3 = Vector.new(-2, -4, -6)
    assert_equal p1 - p2, p3
  end

  def test_vector_subtract_from_zero
    v0 = Vector.new(0, 0, 0)
    v1 = Vector.new(1, -2, 3)
    v2 = Vector.new(-1, 2, -3)
    assert_equal v0 - v1, v2
  end

  def test_tuple_negation
    t1 = Tuple.new(1, -2, 3, -4)
    assert_equal(-t1, Tuple.new(-1, 2, -3, 4))
  end

  def test_tuple_scalar_multiplication
    a = Tuple.new(1, -2, 3, -4)
    assert_equal a * 3.5, Tuple.new(3.5, -7, 10.5, -14)
  end

  def test_tuple_fraction_multiplication
    a = Tuple.new(1, -2, 3, -4)
    assert_equal a * 0.5, Tuple.new(0.5, -1, 1.5, -2)
  end

  def test_tuple_scalar_division
    a = Tuple.new(1, -2, 3, -4)
    assert_equal a / 2, Tuple.new(0.5, -1, 1.5, -2)
  end

  def test_vector_magnitude_0
    v = Vector.new(1, 0, 0)
    assert_equal v.magnitude, 1
  end

  def test_vector_magnitude_1
    v = Vector.new(0, 1, 0)
    assert_equal v.magnitude, 1
  end

  def test_vector_magnitude_2
    v = Vector.new(0, 0, 1)
    assert_equal v.magnitude, 1
  end

  def test_vector_magnitude_3
    v = Vector.new(1, 2, 3)
    assert_equal v.magnitude, Math.sqrt(14)
  end

  def test_vector_magnitude_4
    v = Vector.new(-1, -2, -3)
    assert_equal v.magnitude, Math.sqrt(14)
  end

  def test_vector_normalize_simple
    v = Vector.new(4, 0, 0)
    assert_equal v.normalized, Vector.new(1, 0, 0)
  end

  def test_vector_normalize_complex
    v = Vector.new(1, 2, 3)
    assert_equal v.normalized, Vector.new(1 / Math.sqrt(14), 2 / Math.sqrt(14), 3 / Math.sqrt(14))
  end

  def test_vector_normalize_then_magnitude
    v = Vector.new(1, 2, 3)
    assert_equal v.normalized.magnitude, 1
  end

  def test_vector_dot_product
    a = Vector.new(1, 2, 3)
    b = Vector.new(2, 3, 4)
    assert_equal dot(a, b), 20
  end

  def test_vector_cross_product
    a = Vector.new(1, 2, 3)
    b = Vector.new(2, 3, 4)
    assert_equal cross(a, b), Vector.new(-1, 2, -1)
    assert_equal cross(b, a), Vector.new(1, -2, 1)
  end

  def test_color_is_rgb_tuple
    c = Color.new(-0.5, 0.4, 1.7)
    assert_equal c.red, -0.5
    assert_equal c.green, 0.4
    assert_equal c.blue, 1.7
  end

  def test_color_addition
    c1 = Color.new(0.9, 0.6, 0.75)
    c2 = Color.new(0.7, 0.1, 0.25)
    assert_equal c1 + c2, Color.new(1.6, 0.7, 1.0)
  end

  def test_color_subtraction
    c1 = Color.new(0.9, 0.6, 0.75)
    c2 = Color.new(0.7, 0.1, 0.25)
    assert_equal c1 - c2, Color.new(0.2, 0.5, 0.5)
  end

  def test_color_scalar_multiplication
    c = Color.new(0.2, 0.3, 0.4)
    assert_equal c * 2, Color.new(0.4, 0.6, 0.8)
  end

  def test_color_multiplication
    c1 = Color.new(1, 0.2, 0.4)
    c2 = Color.new(0.9, 1, 0.1)
    assert_equal c1 * c2, Color.new(0.9, 0.2, 0.04)
  end
end
