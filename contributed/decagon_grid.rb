#!/usr/bin/env jruby

require 'picrate'
# Example of a grid of decagons with perlin noise after Lenny Herzog
class DecagonGrid < Processing::App
  NOISE_STRENGTH = 80.0
  THETA = 36
  attr_reader :version, :noise_generator

  def setup
    sketch_title 'Decagon Grid'
    frame_rate 24
    @version = 0
    @save = false
    @noise_generator = lambda do |x, y, seed|
      NOISE_STRENGTH * noise(
        x / 150.0,
        y / 150.0 + seed * 2,
        seed
      ) - 100
    end
  end

  def draw
    background(255)
    no_fill
    stroke(0)
    stroke_weight(1)
    grid(height + 100, width + 100, 50, 50) do |cy, cx|
      begin_shape
      (0..360).step(THETA) do |angle|
        x = (DegLut.cos(angle) * 60) + cx
        y = (DegLut.sin(angle) * 60) + cy
        noise_value = noise_generator.call(x, y, millis / 5_000.0)
        x += noise_value
        y += noise_value
        vertex(x, y)
      end
      end_shape(CLOSE)
    end
  end

  def mouse_pressed
    noise_mode NoiseMode::OPEN_SMOOTH
  end

  def mouse_pressed
    noise_mode NoiseMode::DEFAULT
  end

  def settings
    size(1000, 1000)
  end
end

DecagonGrid.new
