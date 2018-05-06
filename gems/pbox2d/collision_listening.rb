#!/usr/bin/env jruby -v -W2
require 'picrate'
require 'pbox2d'
require 'forwardable'
require_relative 'lib/custom_listener'
require_relative 'lib/particle'
require_relative 'lib/boundary'

# Holder for vector values
Vect = Struct.new(:x, :y)
# The sketch class
class CollisionListening < Processing::App
  attr_reader :box2d, :particles, :wall

  def setup
    sketch_title 'Collision Listening'
    @box2d = WorldBuilder.build(app: self)
    box2d.add_listener(CustomListener.new)
    @particles = []
    @wall = Boundary.new(box2d, Vect.new(width / 2, height - 5), Vect.new(width, 10))
  end

  def draw
    background(255)
    particles << Particle.new(self, rand(width), 20, rand(4..8)) if rand < 0.1
    particles.each(&:display)
    particles.reject!(&:done)
    wall.display
  end

  def settings
    size 400, 400
  end
end

CollisionListening.new
