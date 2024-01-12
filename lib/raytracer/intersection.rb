module RT
  class Intersection
    attr_accessor :t, :object

    def initialize(t, object)
      @t = t
      @object = object
    end
  end
end
