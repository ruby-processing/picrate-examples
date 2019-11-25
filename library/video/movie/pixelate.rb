# frozen_string_literal: true

require 'picrate'
# features PiCrate grid method (avoids nested loops)
class Pixelate < Processing::App
  load_library :video
  java_import 'processing.video.Movie'

  BLOCK_SIZE = 10
  attr_reader :mov, :num_pixels_wide, :num_pixels_high

  def setup
    noStroke
    @mov = Movie.new(self, data_path('launch2.mp4'))
    mov.loop
    @num_pixels_wide = width / BLOCK_SIZE
    @num_pixels_high = height / BLOCK_SIZE
    puts num_pixels_wide
  end

  # Display values from movie
  def draw
    return unless mov.available

    mov.read
    mov.load_pixels
    mov_colors [] # start with an empty Array
    grid(height, width, BLOCK_SIZE, BLOCK_SIZE) do |j, i|
      mov_colors << mov.get(i, j)
    end
    background(255)
    grid(num_pixels_high, num_pixels_wide) do |j, i|
      fill(mov_colors[j * num_pixels_wide + i])
      rect(i * BLOCK_SIZE, j * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE)
    end
  end

  def settings
    size(560, 406)
  end
end

Pixelate.new
