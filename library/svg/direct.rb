#!/usr/bin/env jruby
require 'picrate'

class SVGExample < Processing::App
  load_library :svg



def settings
  size(400, 400, SVG, data_path('filename.svg'))
end

def draw
  # Draw something good here
  line(0, 0, width/2, height)

  # Exit the program
  puts 'Finished.'
  exit
end
end

SVGExample.new
