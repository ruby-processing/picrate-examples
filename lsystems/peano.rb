require 'picrate'
########################################################
# A Peano fractal implemented using a
# Lindenmayer System in PiCrate by Martin Prout
########################################################
class PeanoSketch < Processing::App
  load_libraries :grammar
  attr_reader :points

  def setup
    sketch_title 'Peano'
    peano = Peano.new(Vec2D.new(width * 0.65, height * 0.05))
    production = peano.generate 4 # 4 generations looks OK
    @points = peano.translate_rules(production)
    no_loop
  end

  def draw
    background(0)
    render points
  end

  def render(points)
    no_fill
    stroke 200.0
    stroke_weight 3
    begin_shape
    points.each_slice(2) do |v0, v1|
      v0.to_vertex(renderer)
      v1.to_vertex(renderer)
    end
    end_shape
  end

  def renderer
    @renderer ||= AppRender.new(self)
  end

  def settings
    size(800, 800)
  end
end

# Peano class
class Peano
  include Processing::Proxy
  attr_reader :draw_length, :pos, :theta, :axiom, :grammar
  DELTA = PI / 3 # 60 degrees
  def initialize(pos)
    @axiom = 'XF' # Axiom
    rules = {
      'X' => 'X+YF++YF-FX--FXFX-YF+', # LSystem Rules
      'Y' => '-FX+YFYF++YF+FX--FX-Y'
    }
    @grammar = Grammar.new(axiom, rules)
    @theta = 0
    @draw_length = 100
    @pos = pos
  end

  def generate(gen)
    @draw_length = draw_length * 0.6**gen
    grammar.generate gen
  end

  def forward(pos)
    pos + Vec2D.from_angle(theta) * draw_length
  end

  def translate_rules(prod)
    [].tap do |pts| # An array to store line vertices as Vec2D
      prod.each do |ch|
        case ch
        when 'F'
          new_pos = forward(pos)
          pts << pos << new_pos
          @pos = new_pos
        when '+'
          @theta += DELTA
        when '-'
          @theta -= DELTA
        when 'X', 'Y'
        else
          puts("character #{ch} not in grammar")
        end
      end
    end
  end
end

PeanoSketch.new
