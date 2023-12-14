require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/canvas"

class CanvasTest < Minitest::Test
  def test_canvas_creation
    c = Canvas.new(10, 20)
    assert_equal c.width, 10
    assert_equal c.height, 20
    c.pixels.each do |row|
      row.each do |px|
        assert_equal px, Color.new(0, 0, 0)
      end
    end
  end

  def test_canvas_pixel_writing
    c = Canvas.new(10, 20)
    red = Color.new(1, 0, 0)
    c.write_pixel(2, 3, red)
    assert_equal c.pixel_at(2, 3), red
  end

  def test_ppm_header_creation
    c = Canvas.new(5, 3)
    ppm = c.ppm_header
    assert_equal ppm,
                 <<~TEXT
                   P3
                   5 3
                   255
                 TEXT
  end

  def test_ppm_pixel_data_creation
    c = Canvas.new(5, 3)
    c1 = Color.new(1.5, 0, 0)
    c2 = Color.new(0, 0.5, 0)
    c3 = Color.new(-0.5, 0, 1)
    c.write_pixel(0, 0, c1)
    c.write_pixel(2, 1, c2)
    c.write_pixel(4, 2, c3)
    ppm_content = c.to_ppm
    assert_equal ppm_content, <<~TEXT
                   P3
                   5 3
                   255
                   255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                   0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
                   0 0 0 0 0 0 0 0 0 0 0 0 0 0 255
                 TEXT
  end

  def test_ppm_auto_line_splitting
    c1 = Color.new(1, 0.8, 0.6)
    c = Canvas.new(10, 2, c1)
    ppm = c.content_to_ppm
    assert_equal ppm, <<~TEXT
                   255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153
                   255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204 153
                 TEXT
  end

  def test_ppm_ends_in_newline
    c = Canvas.new(5, 3)
    ppm = c.to_ppm
    assert_equal ppm[-1], "\n"
  end
end
