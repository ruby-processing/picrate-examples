# frozen_string_literal: true
require 'picrate'
# Noise Wave
# by Daniel Shiffman.
#
# Using Simplex Noise to generate a wave-like pattern.
class NoiseWave < Processing::App

  attr_reader :y, :yoff, :inc, :smth # 2nd dimension of perlin noise

  def setup
    sketch_title 'Noise Wave'
    @yoff = 0.0
    @smth = false
    @inc = 0.005
  end

  def draw
    background(51)
    fill(255)
    # We are going to draw a polygon out of the wave points
    begin_shape
    # xoff = yoff # Option #2: 1D Noise
    # Iterate over horizontal pixels
    (0..width).step(10) do |x|
      # Calculate a y value according to noise, map to
      if smth
        @y = map1d(SmoothNoise.noise(x * inc, yoff), (-1.0..1.0), (200..300)) # Option #1: 2D Noise
      else
        @y = map1d(noise(x * inc, yoff), (-1.0..1.0), (200..300)) # Option #1: 2D Noise
      end
      # y = map1d(noise(xoff), (-1.0..1.0), (200..300))    # Option #2: 1D Noise
      # Set the vertex
      vertex(x, y)
      # Increment x dimension for noise
    end
    # increment y dimension for noise
    @yoff += 0.01
    vertex(width, height)
    vertex(0, height)
    end_shape(CLOSE)
  end

  def mouse_pressed
    @smth = !smth
  end

  def settings
    size(640, 360)
  end
end

NoiseWave.new
