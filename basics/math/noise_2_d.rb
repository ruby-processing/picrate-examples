# frozen_string_literal: true
require 'picrate'

# Noise2D
# by Daniel Shiffman.
#
# Using 2D noise to create simple texture.
class Noise2D < Processing::App
  attr_reader :smth

  def setup
    sketch_title 'Noise 2D'
    @inc = 0.02
    @smth = false
  end

  def draw
    background 0
    load_pixels
    grid(width, height) do |x, y|
      if smth
        bright = (SmoothNoise.noise(x * @inc, y * @inc) + 1) * 128
      else
        bright = (noise(x * @inc, y * @inc) + 1) * 128
      end
      pixels[x + y * width] = color(bright)
    end
    update_pixels
  end

  def mouse_pressed
    @smth = !smth
  end

  def settings
    size 640, 360
  end
end

Noise2D.new
