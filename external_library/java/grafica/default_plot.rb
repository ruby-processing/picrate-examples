# frozen_string_literal: true

require 'picrate'

class DefaultPlot < Processing::App
  load_library :grafica
  java_import 'grafica.GPlot'
  java_import 'grafica.GPointsArray'
  POINTS = 100

  def settings
    size(500, 350)
  end

  def setup
    sketch_title 'default plot'
    background(150)
    # Prepare the points for the plot
    points = GPointsArray.new(POINTS)
    POINTS.times do |i|
      points.add(i, 10 * noise(0.1 * i))
    end
    # Create a new plot and set its position on the screen
    plot = GPlot.new(self)
    plot.set_pos(25, 25)
    # Set the plot title and the axis labels
    plot.set_points(points)
    plot.getXAxis.set_axis_label_text('x axis')
    plot.getYAxis.set_axis_label_text('y axis')
    plot.set_title_text('A very simple example')
    # Draw it!
    plot.default_draw
  end
end

DefaultPlot.new
