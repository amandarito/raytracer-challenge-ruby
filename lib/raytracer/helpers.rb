EPSILON = 0.0001

def fp_equal?(a, b)
  (a - b).abs < EPSILON
end
