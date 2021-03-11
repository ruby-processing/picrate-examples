# frozen_string_literal: true

require 'picrate'

class DeJongAttractor < Processing::App
  B = -2.3
  attr_reader :x, :y, :xn, :yn, :timer

  def settings
    size(450, 450)
  end

  def setup
    sketch_title 'De Jong Attractor'
    @x = @y = @a = @c = 0
    @timer = 0
    stroke(255)
    stroke_weight(3)
  end

  def draw
    @timer += 0.01
    background(0, 0, 200)
    c = 3 * sin(timer)
    a = 3 * cos(timer)
    3_000.times do
      @xn = x
      @yn = y
      @x = sin(a * yn) - cos(B * xn)
      @y = sin(a * xn) - cos(c * yn)
      point(width / 2 + 100 * x, height / 2 + 100 * y)
    end
  end
end
DeJongAttractor.new