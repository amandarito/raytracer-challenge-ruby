require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/raytracer"
require_relative "../lib/raytracer/matrix"

module RT
  # in these test names, (44, 33, 22) means (4x4, 3x3, 2x2) matrices.
  class MatrixTest < Minitest::Test
    def test_matrix_44_construction
      m = Matrix[
        [1, 2, 3, 4],
        [5.5, 6.5, 7.5, 8.5],
        [9, 10, 11, 12],
        [13.5, 14.5, 15.5, 16.5]]
      assert_equal m[0, 0], 1
      assert_equal m[0, 3], 4
      assert_equal m[1, 0], 5.5
      assert_equal m[1, 2], 7.5
      assert_equal m[2, 2], 11
      assert_equal m[3, 0], 13.5
      assert_equal m[3, 2], 15.5
    end

    def test_matrix_33_construction
      m = Matrix[
        [-3, 5, 0],
        [1, -2, -7],
        [0, 1, 1]]
      assert_equal m[0, 0], -3
      assert_equal m[1, 1], -2
      assert_equal m[2, 2], 1
    end

    def test_matrix_22_construction
      m = Matrix[
        [-3, 5],
        [1, -2]]
      assert_equal m[0, 0], -3
      assert_equal m[0, 1], 5
      assert_equal m[1, 0], 1
      assert_equal m[1, 1], -2
    end

    def test_same_matrix_equality
      a = Matrix[
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 8, 7, 6],
        [5, 4, 3, 2]]
      b = Matrix[
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 8, 7, 6],
        [5, 4, 3, 2]]
      assert a == b
    end

    def test_matrix_multiplication
      a = Matrix[
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 8, 7, 6],
        [5, 4, 3, 2]]
      b = Matrix[
        [-2, 1, 2, 3],
        [3, 2, 1, -1],
        [4, 3, 6, 5],
        [1, 2, 7, 8]]
      c = Matrix[
        [20, 22, 50, 48],
        [44, 54, 114, 108],
        [40, 58, 110, 102],
        [16, 26, 46, 42]]
      assert_equal a * b, c
    end

    def test_matrix_tuple_multiplication
      a = Matrix[
        [1, 2, 3, 4],
        [2, 4, 4, 2],
        [8, 6, 4, 1],
        [0, 0, 0, 1]]
      b = Tuple.new(1, 2, 3, 1)
      c = Tuple.new(18, 24, 33, 1)
      assert_equal a * b, c
    end

    def test_matrix_identity_multiplication
      a = Matrix[
        [1, 2, 3, 4],
        [2, 4, 4, 2],
        [8, 6, 4, 1],
        [0, 0, 0, 1]]
      identity = Matrix.identity(4)
      assert_equal a * identity, a
    end

    def test_matrix_transposition
      a = Matrix[
        [0, 9, 3, 0],
        [9, 8, 0, 8],
        [1, 8, 5, 3],
        [0, 0, 5, 8]]
      a_t = Matrix[
        [0, 9, 1, 0],
        [9, 8, 8, 0],
        [3, 0, 5, 5],
        [0, 8, 3, 8]]
      assert_equal a.transpose, a_t
    end

    def test_matrix_22_determinant
      a = Matrix[
        [1, 5],
        [-3, 2]]
      assert_equal a.det, 17
    end

    def test_matrix_33_submatrix
      a = Matrix[
        [1, 5, 0],
        [-3, 2, 7],
        [0, 6, -3]]
      a_sub = Matrix[
        [-3, 2],
        [0, 6]]
      assert_equal a.submatrix(0, 2), a_sub
    end

    def test_matrix_44_submatrix
      a = Matrix[
        [-6, 1, 1, 6],
        [-8, 5, 8, 6],
        [-1, 0, 8, 2],
        [-7, 1, -1, 1]]
      a_sub = Matrix[
        [-6, 1, 6],
        [-8, 8, 6],
        [-7, -1, 1]]
      assert_equal a.submatrix(2, 1), a_sub
    end

    def test_matrix_33_minor
      a = Matrix[
        [3, 5, 0],
        [2, -1, -7],
        [6, -1, 5]]
      b = a.submatrix(1, 0)
      assert_equal b.det, 25
      assert_equal a.minor(1, 0), 25
    end

    def test_matrix_cofactor
      a = Matrix[
        [3, 5, 0],
        [2, -1, -7],
        [6, -1, 5]]
      assert_equal a.minor(0, 0), -12
      assert_equal a.cofactor(0, 0), -12
      assert_equal a.minor(1, 0), 25
      assert_equal a.cofactor(1, 0), -25
    end

    def test_matrix_33_determinant
      a = Matrix[
        [1, 2, 6],
        [-5, 8, -4],
        [2, 6, 4]]
      assert_equal a.cofactor(0, 0), 56
      assert_equal a.cofactor(0, 1), 12
      assert_equal a.cofactor(0, 2), -46
      assert_equal a.det, -196
    end

    def test_matrix_44_determinant
      a = Matrix[
        [-2, -8, 3, 5],
        [-3, 1, 7, 3],
        [1, 2, -9, 6],
        [-6, 7, 7, -9]]
      assert_equal a.cofactor(0, 0), 690
      assert_equal a.cofactor(0, 1), 447
      assert_equal a.cofactor(0, 2), 210
      assert_equal a.cofactor(0, 3), 51
      assert_equal a.det, -4071
    end

    def test_matrix_invertible_true
      a = Matrix[
        [6, 4, 4, 4],
        [5, 5, 7, 6],
        [4, -9, 3, -7],
        [9, 1, 7, -6]]
      assert_equal a.det, -2120
      assert a.invertible?
    end

    def test_matrix_invertible_false
      a = Matrix[
        [-4, 2, -2, 3],
        [9, 6, 2, 6],
        [0, -5, 1, 5],
        [0, 0, 0, 0]]
      assert_equal a.det, 0
      refute a.invertible?
    end

    def test_matrix_44_inverse0
      a = Matrix[
        [-5, 2, 6, -8],
        [1, -5, 1, 8],
        [7, 7, -6, -7],
        [1, -3, 7, 4]]
      b = a.inverse
      assert_equal a.det, 532
      assert_equal a.cofactor(2, 3), -160
      assert_in_delta b[3, 2], -160 / 532.0, EPSILON
      assert_equal a.cofactor(3, 2), 105
      assert_in_delta b[2, 3], 105 / 532.0, EPSILON

      # kind of an awkward comparison
      a_inv = Matrix[
        [0.21805, 0.45113, 0.24060, -0.04511],
        [-0.80827, -1.45677, -0.44361, 0.52068],
        [-0.07895, -0.22368, -0.05263, -0.19737],
        [-0.52256, -0.81391, -0.30075, 0.30639]]
      a_inv.column_count.times do |i|
        i.times do |j|
          assert_in_delta a_inv[i, j], b[i, j], EPSILON
        end
      end
    end

    def test_matrix_44_inverse1
      a = Matrix[
        [8, -5, 9, 2],
        [7, 5, 6, 1],
        [-6, 0, 9, 6],
        [-3, 0, -9, -4]]
      b = a.inverse
      a_inv = Matrix[
        [-0.15385, -0.15385, -0.28205, -0.53846],
        [-0.07692, 0.12308, 0.02564, 0.03077],
        [0.35897, 0.35897, 0.43590, 0.92308],
        [-0.69231, -0.69231, -0.76923, -1.92308]]
      a_inv.column_count.times do |i|
        i.times do |j|
          assert_in_delta a_inv[i, j], b[i, j], EPSILON
        end
      end
    end

    def test_matrix_product_times_inverse
      a = Matrix[
        [3, -9, 7, 3],
        [3, -8, 2, -9],
        [-4, 4, 4, 1],
        [-6, 5, -1, 1]
      ]
      b = Matrix[
        [8, 2, 2, 2],
        [3, -1, 7, 0],
        [7, 0, 5, 4],
        [6, -2, 0, 5]
      ]
      c = a * b
      assert_equal c * b.inverse, a
    end
  end
end
