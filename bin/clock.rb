# jan 9, 2024
# amandarito
# ch 3 + 4 milestone: rotated point

require_relative "../lib/raytracer/point"
require_relative "../lib/raytracer/vector"
require_relative "../lib/raytracer/matrix"
require_relative "../lib/raytracer/canvas"

module RT
  SIZE = 100
  image = Canvas.new(SIZE, SIZE)
  color = Color.new(255, 255, 255)
  p0 = Point.new(0, SIZE / 3, 0)
  rotate_30 = Matrix.rotation_z(Math::PI / 6)

  12.times do
    puts p0
    p0 = rotate_30 * p0
    image.write_pixel(p0.x + SIZE / 2, p0.y + SIZE / 2, color)
  end

  File.open("./exports/clock.ppm", "w") { |file|
    file.write(image.to_ppm)
  }
end