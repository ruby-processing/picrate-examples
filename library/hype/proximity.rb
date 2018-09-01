#!/usr/bin/env jruby
require 'picrate'

# The sketch class
class HypeProximity < Processing::App

  load_libraries :hype, :color_group
  %w[H HCanvas HRect].freeze.each do |klass|
    java_import "hype.#{klass}"
  end
  %w[HProximity HOscillator].freeze.each do |klass|
    java_import "hype.extended.behavior.#{klass}"
  end

  PALETTE = %w[#242424 #00FF00 #FF3300 #4D4D4D].freeze
  KEY = %i[background fill_one fill_two stroke].freeze

  attr_reader :colors

  def settings
    size(640, 640)
  end

  def setup
    sketch_title 'Hype Proximity'
    group = ColorGroup.from_web_array(PALETTE)
    @colors = KEY.zip(group.colors).to_h
    H.init(self)
    H.background(colors[:background])
    canvas = H.add(HCanvas.new.auto_clear(false).fade(5))
    r1 = HRect.new(5)
    r1.no_stroke
    .fill(colors[:fill_one])
    .loc(width/2, height/2)
    .rotate(45)
    .anchor_at(H::CENTER)
    canvas.add(r1)
    r2 = HRect.new(5, 10)
    .rounding(4)
    r2.no_stroke
    .fill(colors[:fill_two])
    .x(40)
    .y(height / 2)
    .anchor_at(H::CENTER)
    canvas.add(r2)
    HProximity.new
    .target(r2)
    .neighbor(r1)
    .property(H::HEIGHT)
    .spring(0.99)
    .ease(0.7)
    .min(10)
    .max(200)
    .radius(250)
    HOscillator.new
    .target(r2)
    .property(H::X)
    .range(40, 600)
    .speed(5)
    .freq(0.5)
    .current_step(-180)
  end

  def draw
    H.draw_stage
    # outline to show area of proximity
    ellipse_mode(CENTER)
    stroke(colors[:stroke])
    no_fill
    ellipse(width / 2, height / 2, 500, 500)
  end
end

HypeProximity.new
