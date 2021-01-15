# frozen_string_literal: true

require 'picrate'
# Gravitational Attraction (3D)
# by Daniel Shiffman.
# Simulating gravitational attraction
# G ---> universal gravitational constant
# m1 --> mass of object #1
# m2 --> mass of object #2
# d ---> distance between objects
# F = (G*m1*m2)/(d*d)
# For the basics of working with Vec3D, see
# https://ruby-processing.github.io/PiCrate/classes/vec3d/
# as well as examples in library/vecmath/vec3d

class GravitationalAttraction3D < Processing::App
  attr_reader :planets, :sun, :angle

  def setup
    sketch_title 'Gravitational Attraction (3D)'
    @planets = (0..10).map do
      Planet.new(
        rand(0.15..1.8),
        rand(-width / 2..width / 2),
        rand(-height / 2..height / 2),
        rand(-100..100)
      )
    end
    @sun = Sun.new
    @angle = 0
  end

  def draw
    background(0, 0, 100)
    # Setup the scene
    sphere_detail(12)
    lights
    translate(width / 2, height / 2)
    rotate_y(angle)
    # Display the Sun
    sun.display(g)
    # All the Planets
    planets.each do |planet|
      # Sun attracts Planets
      force = sun.attract(planet)
      planet.apply_force(force)
      # Update and draw Planets
      planet.update
      planet.display(g)
    end
    # Rotate around the scene
    @angle += 0.005
  end

  def settings
    size(640, 360, P3D)
  end
end

GravitationalAttraction3D.new

# Gravitational Attraction (3D)
# Daniel Shiffman <http://www.shiffman.net>
# A class for an orbiting Planet
class Planet

  attr_reader :position, :velocity, :acceleration, :mass

  def initialize(m, x, y, z)
    @mass = m
    @position = Vec3D.new(x, y, z)
    @velocity = Vec3D.new(1, 0, 0) # Arbitrary starting velocity
    @acceleration = Vec3D.new
  end

  # Newton's 2nd Law (F = M*A) applied
  def apply_force(force)
    @acceleration += (force / mass)
  end

  # Our motion algorithm (aka Euler Integration)
  def update
    @velocity += acceleration # Velocity changes with acceleration
    @position += velocity # position changes with velocity
    @acceleration *= 0
 end

  # Draw the Planet
  def display(graphics)
    graphics.no_stroke
    graphics.fill(255)
    graphics.push_matrix
    graphics.translate(position.x, position.y, position.z)
    graphics.sphere(mass * 8)
    graphics.pop_matrix
  end
end
# Gravitational Attraction (3D)
# Daniel Shiffman <http://www.shiffman.net>
# A class for an attractive body in our world
class Sun
  G = 0.4
  attr_reader :mass, :position

  def initialize
    @position = Vec3D.new
    @mass = 20
  end

  def attract(other)
    (position - other.position).tap do |force| # Calculate direction of force
      # d = force.mag # Distance between objects
      # Limit the distance to avoid very close or very far objects
      distance = force.mag.clamp(7.0, 25.0) # clamp available since ruby 2.4
      # Calculate gravitional force magnitude
      strength = (G * mass * other.mass) / (distance * distance)
      force.set_mag(strength) # force vector --> magnitude * direction
    end
  end

  # Draw Sun
  def display(graphics)
    graphics.no_stroke
    graphics.fill(200, 200, 0)
    graphics.push_matrix
    graphics.translate(position.x, position.y, position.z)
    graphics.sphere(mass * 2)
    graphics.pop_matrix
  end
end
