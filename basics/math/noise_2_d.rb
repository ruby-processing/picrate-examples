# frozen_string_literal: true
require 'picrate'

class Noise2D < Processing::App
  # Noise2D
  # by Daniel Shiffman.
  #
  # Using 2D noise to create simple texture.

  def setup
    sketch_title 'Noise 2D'
    @increment = 0.02
  end

  def draw
    background 0
    load_pixels
    xoff = 0.0
    (0...width).each do |x|
      xoff += @increment
      yoff = 0.0
      (0...height).each do |y|
        yoff += @increment
        bright = noise(xoff, yoff) * 255
        pixels[x + y * width] = color(bright)
      end
    end
    update_pixels
  end

  def mouse_pressed
    mode = NoiseMode::OPEN_SMOOTH
    sketch_title mode.description
    noise_mode mode
  end

  def mouse_released
    mode = NoiseMode::DEFAULT
    sketch_title mode.description
    noise_mode mode
  end

  def settings
    size 640, 360
  end
end

Noise2D.new
