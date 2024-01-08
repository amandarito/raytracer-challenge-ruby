require_relative "color"
require "word_wrap"

module RT
  # Canvas is a 2d grid of `Color` with rows = height and cols = width.
  class Canvas
    attr_reader :width, :height, :pixels

    def initialize(width, height, color = Color.new(0, 0, 0))
      @width = width
      @height = height
      @pixels = Array.new(height) { Array.new(width, color) }
    end

    def write_pixel(x, y, color)
      pixels[y][x] = color
    end

    # use this function instead of [] operator.
    def pixel_at(x, y)
      pixels[y][x]
    end

    # debugging
    def print_grid
      pixels.each do |row|
        row.each do |color|
          p color
        end
        puts
      end
    end

    def to_ppm
      ppm_header + content_to_ppm
    end

    def ppm_header
      <<~TEXT
        P3
        #{width} #{height}
        255
      TEXT
    end

    def content_to_ppm
      content = []
      pixels.each do |row|
        content.append(row_to_ppm(row))
      end
      content.join
    end

    def format_num(x)
      (x * 255).round.clamp(0, 255)
    end

    def row_to_ppm(row)
      s = ""

      row.each do |color|
        s += "#{format_num(color.red)} #{format_num(color.green)} #{format_num(color.blue)} "
      end

      WordWrap.ww(s, 70)
      s.strip!
      s += "\n"
    end
  end
end
