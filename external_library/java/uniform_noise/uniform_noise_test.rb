#!/usr/bin/env jruby
require 'picrate'

class UniformNoiseTest < Processing::App
  load_library :uniform_noise

  java_import 'micycle.uniformnoise.UniformNoise'
  java_import 'java.awt.Color'

  OCTAVES = 4

  def setup
    sketch_title 'Uniform Noise Test'
    load_pixels
    @unoise = UniformNoise.new
  end

  def draw
    grid(width, height) do |x, y|
      val = if x < width / 2
              (SmoothNoise.noise(x * 0.015, y * 0.015, frame_count * 0.035) + 1) / 2
            else
              @unoise.uniform_noise(x * 0.0085, y * 0.0085, frame_count * 0.01, OCTAVES, 0.5)
            end
      pixels[y * width + x] = Color.HSBtoRGB(val, 1, 1)
    end
    update_pixels
  end

  def settings
    size(800, 800, P2D)
  end
end

UniformNoiseTest.new
