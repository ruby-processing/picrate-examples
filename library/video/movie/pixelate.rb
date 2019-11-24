#!/usr/bin/env jruby -w
require 'picrate'
#
# Pixelate
# by Hernando Barragan.
#
# Load a QuickTime file and display the video signal
# using rectangles as pixels by reading the values stored
# in the current video frame pixels array.
class Pixelate < Processing::App
  load_library :video
  include_package 'processing.video'

  BLOCK_SIZE = 10

  attr_reader :mov, :num_pixels_wide, :num_pixels_high

  def setup
    sketch_title 'Pixelate'
    no_stroke
    @mov = Movie.new(self, data_path('transit.mov'))
    @num_pixels_wide = width / BLOCK_SIZE
    @num_pixels_high = height / BLOCK_SIZE
    mov.loop
  end

  # Display values from movie
  def draw
    return unless mov.available

    movie_color = []
    mov.read
    mov.load_pixels
    grid(width, height, BLOCK_SIZE, BLOCK_SIZE) do |i, j|
      movie_color << mov.get(i, j)
    end
    grid(num_pixels_wide, num_pixels_high) do |i, j|
      fill(movie_color[j * num_pixels_wide + i])
      rect(i * BLOCK_SIZE, j * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE)
    end
  end

  def settings
    size 640, 360, P2D
  end
end

Pixelate.new
