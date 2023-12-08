require "minitest/autorun"
require_relative "main.rb"

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
        a.point?
        a.vector?
    end

    def test_point_creation_method
        p = point(4, -4, 3)
        p1 = Tuple.new(4, -4, 3, 1)
        assert tuples_equal?(p, p1)
    end

    def test_vector_creation_method
        v = vector(4, -4, 3)
        v1 = Tuple.new(4, -4, 3, 0)
        assert tuples_equal?(v, v1)
    end

    def test_tuple_addition
        a1 = Tuple.new(3, -2, 5, 1)
        a2 = Tuple.new(-2, 3, 1, 0)
        a3 = Tuple.new(1, 1, 6, 1)
        assert a1 + a2 == a3
    end

    def test_tuple_subtraction
        p1 = point(3, 2, 1)
        p2 = point(5, 6, 7)
        p3 = vector(-2, -4, -6)
        assert p1 - p2 == p3
    end
end

