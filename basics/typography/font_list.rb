#!/usr/bin/env jruby
# frozen_string_literal: true

require 'picrate'

# PiCrate Sketch
class FontList < Processing::App

  def settings
    size(200, 200)
  end

  def setup
    # Uncomment the following two lines to see the available fonts
    Java::ProcessingCore::PFont.list.each { |fot| puts fot }
    my_font = create_font('Noto Sans', 32)
    text_font(my_font)
    text_align(CENTER, CENTER)
    text('!@#$%', width / 2, height / 2)
  end
end

FontList.new
