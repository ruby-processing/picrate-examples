class PenroseSnowflake
  include Processing::Proxy

  attr_accessor :axiom, :grammar, :start_length, :theta, :production,
                :draw_length, :pos
  DELTA = 36.radians

  def initialize(pos)
    @axiom = 'F2-F2-F2-F2-F'
    @grammar = Grammar.new(axiom, 'F' => 'F2-F2-F5-F+F2-F')
    @start_length = 450.0
    @theta = 0
    @pos = pos
    @draw_length = start_length
  end

  ##############################################################################
  # Parses the production string, and draws a line when 'F' is found, uses
  # trignometry to calculate dx and dy rather than processing transforms
  ##############################################################################

  def render
    repeats = 1
    production.scan(/./) do |element|
      case element
      when 'F'
        new_pos = pos + Vec2D.from_angle(theta) * draw_length
        line(pos.x, pos.y, new_pos.x, new_pos.y)
        @pos = new_pos
        repeats = 1
      when '+'
        @theta += DELTA * repeats
        repeats = 1
      when '-'
        @theta -= DELTA * repeats
        repeats = 1
      when '2', '5'
        repeats = element.to_i
      else
        puts "Character '#{element}' is not in grammar"
      end
    end
  end

  ##########################################
  # adjust draw length with number of repeats
  # uses grammar to set production string
  # see 'grammar.rb'
  ##########################################

  def create_grammar(gen)
    @draw_length *= 0.4**gen
    @production = grammar.generate gen
  end
end
