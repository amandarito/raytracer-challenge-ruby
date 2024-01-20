# jan 19, 2024
# amandarito
# ch 5 milestone: unshaded sphere

require_relative "../lib/raytracer/point"
require_relative "../lib/raytracer/vector"
require_relative "../lib/raytracer/matrix"
require_relative "../lib/raytracer/canvas"
require_relative "../lib/raytracer/sphere"
require_relative "../lib/raytracer/intersection"
require_relative "../lib/raytracer/ray"

module RT
  ray_origin = Point.new(0, 0, -5)
  canvas_size = 100
  wall_z = 10
  wall_size = 7.0
  pixel_size = wall_size / canvas_size
  half = wall_size / 2

  canvas = Canvas.new(canvas_size, canvas_size)
  color = Color.new(0.8, 0.5, 1)
  shape = Sphere.new

  for y in (0...canvas_size)
    world_y = half - pixel_size * y
    for x in (0..canvas_size)
      world_x = -half + pixel_size * x

      position = Point.new(world_x, world_y, wall_z)
      r = Ray.new(ray_origin, (position - ray_origin).normalized)
      xs = shape.intersect(r)

      if Intersection.hit(xs)
        canvas.write_pixel(x, y, color)
      end
    end
  end

  File.open("./exports/unshaded_sphere.ppm", "w") { |file|
    file.write(canvas.to_ppm)
  }
end