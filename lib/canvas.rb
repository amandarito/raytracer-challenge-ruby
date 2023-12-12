require_relative "color.rb"

class Canvas
    attr_reader :width, :height, :pixels

    def initialize(width, height)
        @width = width
        @height = height
        @pixels = Array.new(width) { Array.new(height, Color.new(0, 0, 0)) }
    end

    def write_pixel(x, y, color)
        self.pixels[x][y] = color
    end
end