#!/usr/bin/env jruby
# After an idea by Kevin Workman and processing.py example by Jorg Kantel
# https://happycoding.io/examples/p5js/images/image-palette
# http://blog.schockwellenreiter.de/2021/08/2021080401.html

require 'picrate'

class ImagePalette < Processing::App
  WIDTH = 800
  HALF = 400
  HEIGHT = 640
  attr_reader :img, :img2, :palette, :pixel_array
  MIN = 999_999
  WEB = %w[#264653 #2a9d8f #e9c46a #f4a261 #e76f51].freeze

  def settings
    size(WIDTH, HEIGHT)
  end

  def setup
    sketch_title('Image Palette')
    @img = load_image(data_path('akt.jpg'))
    @img2 = create_image(HALF, height, RGB)
    @palette = web_to_color_array(WEB)
    img.load_pixels
    img2.load_pixels
    no_loop
  end

  def draw
    grid(HALF, height) do |x, y|
      img_color = img.pixels[x + y * HALF]
      img2.pixels[x + y * HALF] = get_palette_color(img_color)
    end
    image(img, 0, 0)
    image(img2, HALF, 0)
  end

  def get_palette_color(img_color)
    min_distance = MIN
    img_r = img_color >> 16 & 0xFF
    img_g = img_color >> 8 & 0xFF
    img_b = img_color & 0xFF
    target_color = 0
    palette.each do |c|
      palette_r = c >> 16 & 0xFF
      palette_g = c >> 8 & 0xFF
      palette_b = c & 0xFF
      color_distance = dist(img_r, img_g, img_b,
                            palette_r, palette_g, palette_b)
      if color_distance < min_distance
        target_color = c
        min_distance = color_distance
      end
    end
    target_color
  end
end

ImagePalette.new
