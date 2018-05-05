#!/usr/bin/env jruby -v -w
require 'picrate'

class Grapher < Processing::App
  # Grapher is based on a context free art design
  # by ColorMeImpressed (takes a bit of time to run)
  # http://www.contextfreeart.org/gallery/view.php?id=2844
  #
  CMIN = -2.0 # Important to specify float else get random int from range?
  CMAX = 2.0
  FUZZ = 0.04
  SZ = 5

  def settings
    size 600, 600
  end

  def setup
    sketch_title 'Grapher'
    no_stroke
    color_mode(HSB, 1.0)
    background(0)
    frame_rate(4_000)
  end

  def draw
    translate(width / 2, height / 2)
    dot(rand(-180..180), rand(-180..180), rand(CMIN..CMAX)) unless frame_count > 200_000
  end

  def dot(px, py, c)
    func = DegLut.sin(px) + DegLut.sin(py) + c
    # change function to change the graph eg.
    # func = DegLut.cos(px) + DegLut.sin(py) + c
    if func.abs <= FUZZ
      fill(((CMIN - c) / (CMIN - CMAX)), 1, 1)
      ellipse px * width / 360, py * height / 360, SZ, SZ
    else
      dot(rand(-180..180), rand(-180..180), rand(CMIN..CMAX))
    end
  end
end

Grapher.new
