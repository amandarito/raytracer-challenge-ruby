module RT
  class Point < Tuple
    def initialize(x, y, z)
      super(x, y, z, 1)
    end
  end
end
