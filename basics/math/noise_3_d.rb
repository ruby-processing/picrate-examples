# frozen_string_literal: true
require 'picrate'
# Noise3D.
#
# Using 3D noise to create simple animated texture.
# Here, the third dimension ('z') is treated as time.
class Noise3D < Processing::App
  attr_reader :bright, :inc, :z_increment, :smth

  def setup
    sketch_title 'Noise 3D'
    frame_rate 30
    @inc = 0.01
    @zoff = 0.0
    @z_increment = 0.02
  end

  def draw
    background 0
    load_pixels
    grid(width, height) do |x, y|
      if smth
        @bright = (SmoothNoise.noise(x * inc, y * inc, @zoff) + 1) * 128
      else
        @bright = (noise(x * inc, y * inc, @zoff) + 1) * 128
      end
      pixels[x + y * width] = color(bright, bright, bright)
    end
    update_pixels
    @zoff += z_increment
  end

  def mouse_pressed
    @smth = !smth
  end

  def settings
    size 640, 360
  end
end

Noise3D.new
