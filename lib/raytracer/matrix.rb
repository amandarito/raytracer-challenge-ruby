require "matrix"
require_relative "tuple"

module RT
  # ```protect yourself from psychological attack.
  # let ruby matrix encourage you to love fiercely!```
  # Matrix inherits from builtin ::Matrix,
  # but a few methods are redefined and added.
  class Matrix < ::Matrix
    alias_method :submatrix, :first_minor

    # determinant
    def det
      det = 0
      if column_count == 2
        det = self[0, 0] * self[1, 1] - self[0, 1] * self[1, 0]
      elsif column_count.times do |col|
        det += self[0, col] * cofactor(0, col)
      end
      end
      det
    end

    # determinant of the submatrix at row, col
    def minor(row, col)
      b = submatrix(row, col)
      b.det
    end

    def invertible?
      !det.zero?
    end

    def *(other)
      case other
      when Tuple
        multiply_by_tuple(other)
      else
        super(other)
      end
    end

    def multiply_by_tuple(t)
      c = Array.new(column_count, 0)
      rows = self.rows
      rows.each_with_index do |row, index|
        # dot product
        c[index] = t.x * row[0] + t.y * row[1] + t.z * row[2] + t.w * row[3]
      end
      Tuple.new(c[0], c[1], c[2], c[3])
    end

    # transformation matrices
    def self.translation(x, y, z)
      Matrix[
        [1, 0, 0, x],
        [0, 1, 0, y],
        [0, 0, 1, z],
        [0, 0, 0, 1]
      ]
    end

    def self.scaling(x, y, z)
      Matrix[
        [x, 0, 0, 0],
        [0, y, 0, 0],
        [0, 0, z, 0],
        [0, 0, 0, 1]
      ]
    end

    def self.rotation_x(r)
      Matrix[
        [1, 0, 0, 0],
        [0, Math.cos(r), -Math.sin(r), 0],
        [0, Math.sin(r), Math.cos(r), 0],
        [0, 0, 0, 1]
      ]
    end

    def self.rotation_y(r)
      Matrix[
        [Math.cos(r), 0, Math.sin(r), 0],
        [0, 1, 0, 0],
        [-Math.sin(r), 0, Math.cos(r), 0],
        [0, 0, 0, 1]
      ]
    end

    def self.rotation_z(r)
      Matrix[
        [Math.cos(r), -Math.sin(r), 0, 0],
        [Math.sin(r), Math.cos(r), 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
      ]
    end

    def self.shearing(xy, xz, yx, yz, zx, zy)
      Matrix[
        [1, xy, xz, 0],
        [yx, 1, yz, 0],
        [zx, zy, 1, 0],
        [0, 0, 0, 1]
      ]
    end
  end
end
