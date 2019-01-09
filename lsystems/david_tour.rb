require 'picrate'
require 'arcball'
########################################################
# A David Tour fractal implemented using a
# Lindenmayer System in PiCrate by Martin Prout
########################################################
class DavidTourSketch < Processing::App
  load_library :grammar
  attr_reader :points

  def setup
    sketch_title 'David Tour'
    david = DavidTour.new(Vec2D.new(width * 0.65, height * 0.7))
    production = david.create_grammar(5)
    @points = david.translate_rules(production)
    no_loop
  end

  def draw
    background(0)
    stroke(255)
    points.each_slice(4) do |point|
      line(*point)
    end
  end

  def settings
    size(800, 900, P2D)
  end
end

# LSystems class uses grammar library
class DavidTour
  attr_reader :draw_length, :pos, :theta, :axiom, :grammar
  DELTA = Math::PI / 3 # 60 degrees

  def initialize(pos)
    @axiom = 'FX-XFX-XFX-XFX-XFX-XF'   # Axiom
    @theta = 0
    @grammar = Grammar.new(
      axiom,
      'F' => '!F!-F-!F!',              # Rules
      'X' => '!X'
    )
    @draw_length = 15
    @pos = pos
  end

  def create_grammar(gen)
    @draw_length *= draw_length * 0.5**gen
    grammar.generate(gen)
  end

  def translate_rules(prod)
    swap = false
    [].tap do |points| # An array to store lines as a flat array of points
      prod.each do |ch|
        case ch
        when 'F'
          new_pos = pos + Vec2D.from_angle(theta) * draw_length
          points << pos.x << pos.y << new_pos.x << new_pos.y
          @pos = new_pos
        when '-'
          @theta += swap ? DELTA : -DELTA
        when '!'
          swap = !swap
        when 'X'
        else
          puts("character '#{ch}' not in grammar")
        end
      end
    end
  end
end

DavidTourSketch.new
