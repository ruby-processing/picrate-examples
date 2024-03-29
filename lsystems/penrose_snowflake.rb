require 'picrate'
# Lindenmayer System in PiCrate by Martin Prout
class Snowflake < Processing::App
  load_libraries :grammar, :snowflake
  attr_reader :penrose

  def setup
    sketch_title 'Penrose Snowflake'
    stroke 255
    @penrose = PenroseSnowflake.new(Vec2D.new(width * 0.25, height * 0.95))
    penrose.create_grammar 4
    no_loop
  end

  def draw
    background 0
    penrose.render
  end

  def settings
    size 1000, 900
  end
end

Snowflake.new
