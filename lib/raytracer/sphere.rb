require_relative "intersection"

module RT
  class Sphere
    def intersect(ray)
      # calculate discriminant...
      sphere_to_ray = ray.origin - Point.new(0, 0, 0)
      a = ray.direction.dot(ray.direction)
      b = 2 * ray.direction.dot(sphere_to_ray)
      c = sphere_to_ray.dot(sphere_to_ray) - 1
      discriminant = b**2 - 4 * a * c

      # return based on if intersected or not.
      if discriminant < 0
        []
      else
        t = []
        t[0] = (-b - Math.sqrt(discriminant)) / (2 * a)
        t[1] = (-b + Math.sqrt(discriminant)) / (2 * a)

        t.sort.map { |item|
          Intersection.new(item, self)
        }
      end
    end
  end
end
