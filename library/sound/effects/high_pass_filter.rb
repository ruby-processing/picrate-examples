# frozen_string_literal: true

require 'picrate'
# Play a sound sample and pass it through a tape source, changing the source
# parameters based on the mouse position.
class HighPassFilter < Processing::App
  load_library :sound
  java_import 'processing.sound.WhiteNoise'
  java_import 'processing.sound.HighPass'

  attr_reader :filter, :source

  def settings
    size(640, 360)
  end

  def setup
    background(255)
    sketch_title 'High Pass Filter'
    # Create the noise generator + filter
    @filter = HighPass.new(self)
    @source = WhiteNoise.new(self)
    # Connect the filter to the source unit
    source.play
    filter.process(source)
  end

  def draw
    # Map the left/right mouse position to a cutoff frequency between 10 and 15000 Hz
    cutoff = map1d(mouseX, 0..width, 10..15_000)
    filter.freq(cutoff)
    # Draw a circle indicating the position + width of the frequencies passed through
    background(125, 255, 125)
    noStroke
    fill(255, 0, 150)
    ellipse(0, height, 2 * (width - mouseX), 2 * (width - mouseX))
  end
end

HighPassFilter.new
