#!/usr/bin/env jruby -v -w
# Description:
# Flight Patterns is that ol' Euruko 2008 demo.
# Reworked version for Processing
# Usage:
# Drag mouse to steer 'invisible' flock attractor, use 'f' key to toggle flee
# Mouse 'click' to toggle 'sphere' or 'circle' display
require 'picrate'

class FlightPatterns < Processing::App
  load_library :boids

  attr_reader :flee, :radius

  def settings
    size 1024, 750, P2D
  end

  def setup
    sketch_title 'Flight Patterns'
    sphere_detail 8
    color_mode RGB, 1.0
    no_stroke
    @radius = 0.02 * height
    @click = false
    @flee = false
    @flocks = (0..3).map { Boids.flock(n: 20, x: 0, y: 0, w: width, h: height) }
  end

  def mouse_pressed
    @click = !@click
  end

  def key_pressed
    return unless key == 'f'
    @flee = !@flee
  end

  def draw
    background 0.05
    @flocks.each_with_index do |flock, i|
      flock.goal(target: Vec2D.new(mouse_x, mouse_y), flee: @flee)
      flock.update(goal: 185, limit: 13.5)
      flock.each do |boid|
        case i
        when 0 then fill 0.85, 0.65, 0.65
        when 1 then fill 0.65, 0.85, 0.65
        when 2 then fill 0.65, 0.65, 0.85
        end
        push_matrix
        point_array = (boid.pos.to_a).map { |p| p - (radius / 2.0) }
        translate(*point_array)
        ellipse(0, 0, radius, radius)
        pop_matrix
      end
    end
  end
end

FlightPatterns.new
