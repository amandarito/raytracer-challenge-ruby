require_relative "tuple.rb"
require_relative "point.rb"
require_relative "vector.rb"
require_relative "color.rb"
require_relative "canvas.rb"
require_relative "helpers.rb"

# projectile console demo

projectile = Struct.new(:position, :velocity).new(Point.new(0, 1, 0), Vector.new(10, 5, 0).normalized * 10)

environment = Struct.new(:gravity, :wind).new(Vector.new(0, -0.1, 0), Vector.new(-0.1, 0, 0))

image = Canvas.new(405, 110, Color.new(0, 0, 0))

def tick(env, proj)
  position = proj.position + proj.velocity
  velocity = proj.velocity + env.gravity + env.wind
  Struct.new(:position, :velocity).new(position, velocity)
end

count = 1
puts "starting position: #{projectile.position}\nstarting velocity: #{projectile.velocity}"
while (projectile.position.y > 0)
  puts "t#{count}\t| position = #{projectile.position}  velocity = #{projectile.velocity}"

  xpos = projectile.position.x
  ypos = image.height - projectile.position.y
  px_color = Color.new(1, xpos / image.width, ypos / image.height)
  image.write_pixel(xpos, ypos, px_color)
  projectile = tick(environment, projectile)
  count += 1
end

# to file.
File.open("./exports/projectile0.ppm", "w") { |file|
  file.write(image.to_ppm)
}
