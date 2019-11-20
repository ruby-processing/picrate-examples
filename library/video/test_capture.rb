#!/usr/bin/env jruby
require 'picrate'

# Test Class for Video Library
class TestCapture < Processing::App

  load_library :video, :video_event

  include_package 'processing.video'

  attr_reader :cam

  def setup
    sketch_title 'Test Capture'
    cameras = Capture.list
    fail 'There are no matching cameras.' if cameras.length.zero?
    start_capture(cameras[0])
  end

  def start_capture(cam_string)
    # The camera can be initialized directly using an
    # element from the array returned by list:
    @cam = Capture.new(self, cam_string)
    p format('Using camera %s', cam_string)
    cam.start
  end

  def draw
    return unless cam.available
    cam.read
    image(cam, 0, 0, width, height)
    # The following does the same, and is faster when just drawing the image
    # without any additional resizing, transformations, or tint.
    # set(0, 0, cam)
  end

  def settings
    size 960, 720, P2D
  end
end

TestCapture.new
