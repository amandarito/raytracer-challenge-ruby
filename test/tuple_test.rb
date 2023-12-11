require "minitest/autorun"
require_relative "../lib/main.rb"

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
        p0 = point(4, -4, 3)
        p1 = Tuple.new(4, -4, 3, 1)
        assert_equal p0, p1
    end

    def test_vector_creation_method
        v0 = vector(4, -4, 3)
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
        p1 = point(3, 2, 1)
        p2 = point(5, 6, 7)
        p3 = vector(-2, -4, -6)
        assert_equal p1 - p2, p3
    end

    def test_subtract_from_zero
        v0 = vector(0, 0, 0)
        v1 = vector(1, -2, 3)
        v2 = vector(-1, 2, -3)
        assert_equal v0 - v1, v2
    end

    def test_negate_self
        t1 = Tuple.new(1, -2, 3, -4)
        assert_equal (-t1), Tuple.new(-1, 2, -3, 4)
    end

    def test_multiply_by_scalar
        a = Tuple.new(1, -2, 3, -4)
        assert_equal a * 3.5, Tuple.new(3.5, -7, 10.5, -14)
    end

    def test_multiply_by_fraction
        a = Tuple.new(1, -2, 3, -4)
        assert_equal a * 0.5, Tuple.new(0.5, -1, 1.5, -2)
    end

    def test_divide_by_scalar
        a = Tuple.new(1, -2, 3, -4)
        assert_equal a / 2, Tuple.new(0.5, -1, 1.5, -2)
    end

    def test_vector_magnitude_0
        v = vector(1, 0, 0)
        assert_equal v.magnitude, 1
    end

    def test_vector_magnitude_1
        v = vector(0, 1, 0)
        assert_equal v.magnitude, 1
    end

    def test_vector_magnitude_2
        v = vector(0, 0, 1)
        assert_equal v.magnitude, 1
    end

    def test_vector_magnitude_3
        v = vector(1, 2, 3)
        assert_equal v.magnitude, Math.sqrt(14)
    end

    def test_vector_magnitude_4
        v = vector(-1, -2, -3)
        assert_equal v.magnitude, Math.sqrt(14)
    end

    def test_normalize_vector_simple
        v = vector(4, 0, 0)
        assert_equal v.normalized, vector(1, 0, 0)
    end

    def test_normalize_vector_complex
        v = vector(1, 2, 3)
        assert_equal v.normalized, vector(1/Math.sqrt(14), 2/Math.sqrt(14), 3/Math.sqrt(14))
    end

    def test_magnitude_of_normalized_vector
        v = vector(1, 2, 3)
        assert_equal v.normalized.magnitude, 1
    end

    def test_dot_product
        a = vector(1, 2, 3)
        b = vector(2, 3, 4)
        assert_equal dot(a,b), 20
    end

    def test_cross_product
        a = vector(1, 2, 3)
        b = vector(2, 3, 4)
        assert_equal cross(a, b), vector(-1, 2, -1)
        assert_equal cross(b, a), vector(1, -2, 1)
    end
end

