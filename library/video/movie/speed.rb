#!/usr/bin/env jruby -w
# frozen_string_literal: true

require 'picrate'
# Speed.
# drag mouse down screen to increase speed
# drag mouse up screen to decrease speed
# Uses the Movie.speed method to change
# the playback speed.
class Speed < Processing::App
  load_libraries :video
  java_import 'processing.video.Movie'

  attr_reader :mov

  def setup
    sketch_title 'Speed'
    background(0)
    @mov = Movie.new(self, data_path('transit.mov'))
    mov.loop
  end

  def draw
    return unless mov.available
    
    mov.read    
    image(mov, 0, 0)
    new_speed = map1d(mouse_y, (0..height), (0.1..2))
    mov.speed(new_speed)
    fill(255)
    text(format('%.2fX', new_speed), 10, 30)
  end

  def settings
    size 640, 360
  end
end

Speed.new
