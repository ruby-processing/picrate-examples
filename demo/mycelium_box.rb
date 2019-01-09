require 'picrate'
require 'arcball'
# Simple recursive branching system inspired by mycelium growth
# After an original by Karsten Schmidt
# The vanilla processing sketch was part of the SAC 2013 workshop project
# translated to PiCrate by Martin Prout 2018
class MyceliumBox < Processing::App
  load_library :branch3D

  attr_reader :renderer, :root

  def setup
    sketch_title 'Mycelium Box'
    Processing::ArcBall.init self
    @renderer = AppRender.new(self)
    @root = Branch.new(
      self,
      Vec3D.new(0, 10, 10),
      Vec3D.new(1, 0, 0),
      6.0
    )
  end

  def draw
    background(0)
    no_fill
    stroke_weight 2
    stroke(200, 0, 0, 100)
    box(1200, 300, 300)
    root.run
  end

  def settings
    size(1280, 600, P3D)
  end
end

MyceliumBox.new