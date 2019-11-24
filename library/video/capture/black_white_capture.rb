#!/usr/bin/env jruby -w
require 'picrate'

# hold down mouse to see unfiltered output
class BWCapture < Processing::App
  load_libraries :video

  attr_reader :cam, :my_shader

  def setup
    sketch_title 'Black & White Capture'
    @my_shader = load_shader(data_path('bwfrag.glsl'))
    start_capture(width, height)
  end

  def start_capture(w, h)
    @cam = Java::ProcessingVideo::Capture.new(self, w, h, "UVC Camera (046d:0825)")
    cam.start
  end

  def draw
    return unless cam.available

    cam.read
    image(cam, 0, 0)
    return if mouse_pressed?
    filter(my_shader)
  end

  def settings
    size(960, 544, P2D)
  end
end

BWCapture.new
