#!/usr/bin/env jruby -w
# frozen_string_literal: true

require 'picrate'
# Scratch
# by Andres Colubri.
#
# Move the cursor horizontally across the screen to set
# the position in the movie file.
class Scratch < Processing::App
  load_library :video
  include_package 'processing.video'

  attr_reader :mov

  def setup
    sketch_title 'Scratch'
    background(0)
    @mov = Movie.new(self, data_path('transit.mov'))
    # Pausing the video at the first frame.
    mov.play
    mov.jump 0
    mov.pause
  end

  def draw
    return unless mov.available

    mov.read
    # A new time position is calculated using the current mouse location:
    t = mov.duration * map1d(mouse_x, (0..width), (0..1.0))
    mov.play
    mov.jump(t)
    mov.pause
    image(mov, 0, 0)
  end

  def settings
    size 640, 360
  end
end

Scratch.new
