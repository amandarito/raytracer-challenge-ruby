require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/canvas.rb"

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
end