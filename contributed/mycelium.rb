require 'picrate'

# Simple recursive branching system inspired by mycelium growth
# After an original by Karsten Schmidt
# The vanilla processing sketch was part of the SAC 2013 workshop project
# translated to PiCrate by Martin Prout 2018
class Mycelium < Processing::App
  load_library :branch

  attr_reader :renderer, :root

  def setup
    @renderer = AppRender.new(self)
    @root = Branch.new(
      self,
      Vec2D.new(0, height / 2),
      Vec2D.new(1, 0),
      10.0
    )
  end

  def draw
    background(0)
    root.run
  end

  def settings
    full_screen
  end
end

Mycelium.new
