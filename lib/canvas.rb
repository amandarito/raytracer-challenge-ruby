require_relative "color.rb"
require "word_wrap"

# Canvas is a 2d grid of Colors with rows = height and cols = width.
class Canvas
  attr_reader :width, :height, :pixels

  def initialize(width, height, color = Color.new(0, 0, 0))
    @width = width
    @height = height
    @pixels = Array.new(height) { Array.new(width, color) }
  end

  def write_pixel(x, y, color)
    self.pixels[y][x] = color
  end

  # use this function instead of [] operator.
  def pixel_at(x, y)
    self.pixels[y][x]
  end

  # debugging
  def print_grid
    self.pixels.each do |row|
      row.each do |color|
        p color
      end
      puts
    end
  end

  def to_ppm
    ppm = ""
    ppm += self.ppm_header
    ppm += self.content_to_ppm
  end

  def ppm_header
    <<~TEXT
      P3
      #{self.width} #{self.height}
      255
    TEXT
  end

  def content_to_ppm
    content = []
    self.pixels.each do |row|
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
