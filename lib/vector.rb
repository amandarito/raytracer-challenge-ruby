require_relative "tuple.rb"

class Vector < Tuple
    def initialize(x, y, z)
        super(x, y, z, 0)
    end
end