require_relative "tuple.rb"
require_relative "point.rb"
require_relative "vector.rb"
require_relative "color.rb"
require_relative "helpers.rb"

# projectile console demo

projectile = Struct.new(:position, :velocity).new(point(0, 1, 0), vector(10, 5, 0).normalized)

environment = Struct.new(:gravity, :wind).new(vector(0, -0.1, 0), vector(-0.1, 0, 0))

def tick(env, proj)
    position = proj.position + proj.velocity
    velocity = proj.velocity + env.gravity + env.wind
    Struct.new(:position, :velocity).new(position, velocity)
end

count = 1
while (projectile.position.y > 0)
    puts "t#{count}\t| position = #{projectile.position}  velocity = #{projectile.velocity}"
    projectile = tick(environment, projectile)
    count += 1
end