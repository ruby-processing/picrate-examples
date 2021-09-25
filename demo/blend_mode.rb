#!/usr/bin/env jruby -w

# frozen_string_literal: true

require 'picrate'

class BlendModeSketch < Processing::App
  java_import 'com.jogamp.opengl.GL3'
  java_import 'com.jogamp.opengl.GLContext'

  HALF = 300

  attr_reader :gl
  def setup
    sketch_title 'Blend Mode Difference P2D'
    noStroke
    fill(255)
    # DIFFERENCE is not supported in P2D / P3D
    # blendMode(DIFFERENCE)
    # @gl = GLContext.getCurrentGL.getGL3 # x86_64
    @gl = GLContext.getCurrentGL.getGL2 # RaspberryPi aarch64
  end

  def draw
    background(255)
    # This provides blendMode(DIFFERENCE) in P2D / P3D
    gl.glEnable(GL3::GL_BLEND)
    gl.glBlendFunc(GL3::GL_ONE_MINUS_DST_COLOR, GL3::GL_ZERO)
    20.times do |i|
      sz = 50 + (i % 4) * 50
      x = HALF * noise(i * 0.527 + millis * 0.0003)
      y = HALF * noise(i * 0.729 + millis * 0.0001)
      circle(x + HALF, y + HALF, sz)
    end
  end

  def settings
    size(2 * HALF, 2 * HALF, P2D)
    smooth(8)
  end
end

BlendModeSketch.new
