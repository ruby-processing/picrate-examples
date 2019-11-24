#!/usr/bin/env jruby -w
require 'picrate'
# Mirror 2
# by Daniel Shiffman.
#
# Each pixel from the video source is drawn as a rectangle with size based
# on brightness.
class Mirror2 < Processing::App
  load_library :video
  include_package 'processing.video'

  CELL_SIZE = 15

  attr_reader :video

  def setup
    sketch_title 'Mirror2'
    # Set up columns and rows
    color_mode(RGB, 255, 255, 255, 100)
    rect_mode(CENTER)
    # This the default video input, see the GettingStartedCapture
    # example if it creates an error
    @video = Capture.new(self, width, height, "UVC Camera (046d:0825)")
    # Start capturing the images from the camera
    video.start
    background(0)
  end

  def draw
    return unless video.available

    video.read
    video.load_pixels
    background(0, 0, 255)
    # Begin loop for columns
    grid(width, height, CELL_SIZE, CELL_SIZE) do |x, y|
      loc = (width - x - 1) + y * width
      # Each rect is colored white with a size determined by brightness
      c = video.pixels[loc]
      sz = (brightness(c) / 255.0) * CELL_SIZE
      fill(255)
      no_stroke
      rect(x + CELL_SIZE / 2, y + CELL_SIZE / 2, sz, sz)
    end
  end

  def settings
    size(480, 360, P2D)
  end
end

Mirror2.new
