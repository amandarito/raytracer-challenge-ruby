EPSILON = 0.0001

def fp_equal?(a, b)
    (a-b).abs < EPSILON
end

def dot(a, b)
    a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
end

def cross(a, b)
    vector(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x)
end

def point(x, y, z)
    Point.new(x, y, z)
end

def vector(x, y, z)
    Vector.new(x, y, z)
end