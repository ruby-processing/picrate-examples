require 'picrate'
############################
# pentagonal.rb here I roll one of my own
###########################
class PentagonalFractal < Processing::App
  load_library :grammar


  #  Empirically determined position adjustments
  ADJUST = [[0, 50], [250, 500], [250, 500], [500, 280]]

  attr_reader :pentagonal, :pentive

  def setup
    sketch_title 'Pentagonal'
    @pentagonal = Pentagonal.new
    pentagonal.create_grammar 2
    @pentive = pentagonal.make_shape
    pentive.translate(ADJUST[1][0], ADJUST[1][1])
  end

  def draw
    background 0
    shape(pentive)
  end

  def key_pressed
    case key
    when '1', '2', '3', '4' # key corresponds to generation
      gen = key.to_i
      @pentagonal = Pentagonal.new
      pentagonal.create_grammar gen
      @pentive = pentagonal.make_shape
      pentive.translate(ADJUST[gen - 1][0], ADJUST[gen - 1][1])
    else
      @pentagonal = Pentagonal.new
      pentagonal.create_grammar 2
      @pentive = pentagonal.make_shape
      pentive.translate(ADJUST[1][0], ADJUST[1][1])
    end
  end

  def settings
    size 800, 800, P2D
  end
end

PentagonalFractal.new

##
# A Pentagonal Fractal created using a
# Lindenmayer System in PiCrate by Martin Prout
###
class Pentagonal
  include Processing::Proxy
  DELTA = PI / 2.5 #  72 degrees
  attr_accessor :draw_length
  attr_reader :axiom, :grammar, :theta, :production, :pos
  def initialize
    @axiom = 'F-F-F-F-F'
    @grammar = Grammar.new(axiom, 'F' => 'F+F+F-F-F-F+F+F')
    @draw_length = 400
    @theta = 0
    @pos = Vec2D.new
  end

  ##############################
  # create grammar from axiom and
  # rules (adjust scale)
  ##############################

  def create_grammar(gen)
    @draw_length *= 0.25**gen
    @production = grammar.generate gen
  end

  def forward(pos)
    pos + Vec2D.from_angle(theta) * draw_length
  end

  def make_shape
    no_fill
    create_shape.tap do |shape|
      shape.begin_shape
      shape.stroke 200
      shape.stroke_weight 3
      shape.vertex(pos.x, pos.y)
      production.each do |element|
        case element
        when 'F'
          @pos = forward(pos)
          shape.vertex(pos.x, pos.y)
        when '+'
          @theta += DELTA
        when '-'
          @theta -= DELTA
        else puts 'Grammar not recognized'
        end
      end
      shape.end_shape
    end
  end
end
