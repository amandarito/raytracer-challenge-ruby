# jan 9, 2024
# amandarito
# ch 1 + 2 milestone: projectile demo

require_relative "../lib/raytracer/tuple"
require_relative "../lib/raytracer/point"
require_relative "../lib/raytracer/vector"
require_relative "../lib/raytracer/color"
require_relative "../lib/raytracer/canvas"
require_relative "../lib/raytracer/helpers"

projectile = Struct.new(:position, :velocity).new(Point.new(0, 1, 0),
  Vector.new(10, 5, 0).normalized * 10)

environment = Struct.new(:gravity, :wind).new(Vector.new(0, -0.1, 0),
  Vector.new(-0.1, 0, 0))

image = Canvas.new(205, 55, Color.new(0.1, 0.1, 0.1))

def tick(env, proj)
  position = proj.position + proj.velocity
  velocity = proj.velocity + env.gravity + env.wind
  Struct.new(:position, :velocity).new(position, velocity)
end

count = 1
puts "starting position: #{projectile.position}\nstarting velocity: #{projectile.velocity}"
while (projectile.position.y > 0)
  puts "t#{count}\t| position = #{projectile.position}  velocity = #{projectile.velocity}"

  xpos = (projectile.position.x / 2).round
  ypos = (image.height - projectile.position.y / 2 - 1).round
  px_color = Color.new(projectile.position.x / image.width / 2,
    projectile.position.y / image.height / 2, 0.9)

  image.write_pixel(xpos, ypos, px_color)
  projectile = tick(environment, projectile)
  count += 1
end

# to file.
File.open("./exports/projectile0.ppm", "w") { |file|
  file.write(image.to_ppm)
}
