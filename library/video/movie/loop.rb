#!/usr/bin/env jruby -w
require 'picrate'
# Loop.
#
# Shows how to load and play a QuickTime movie file.
class Loop < Processing::App
  load_libraries :video
  include_package 'processing.video'

  attr_reader :movie

  def setup
    sketch_title 'Loop'
    background(0)
    # Load and play the video in a loop
    @movie = Movie.new(self, data_path('transit.mov'))
    movie.loop
  end

  def draw
    return unless movie.available
    movie.read
    image(movie, 0, 0, width, height)
  end

  def settings
    size 640, 360
  end
end

Loop.new
