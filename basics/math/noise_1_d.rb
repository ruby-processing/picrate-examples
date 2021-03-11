# frozen_string_literal: true
require 'picrate'

class Noise1D < Processing::App

  def setup
    sketch_title 'Noise 1D'
    @xoff = 360
    @x_increment = 0.01
    background 0
    no_stroke
  end

  def draw
    fill 0, 10
    rect 0, 0, width, height
    n = noise(@xoff) * width
    @xoff += @x_increment
    fill 200
    ellipse n, height / 2, 64, 64
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

Noise1D.new
