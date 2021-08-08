require 'picrate'
# Mandelbrot Set example
# by Jordan Scales (http://jordanscales.com)
# Modified to use map1d (instead of map), and somewhat
# optimized (update_pixels instead of set)
# no need to loop
class Mandelbrot < Processing::App
  load_library :jcomplex
  def setup
    sketch_title 'Mandelbrot'
    load_pixels
    no_loop
  end

  # main drawing method
  def draw
    grid(900, 600) do |x, y|
      c = JComplex.new(
        map1d(x, (0...900), (-2.5..1.3)), map1d(y, (0...600), (-1.3..1.3))
      )
      # mandel will return 0..20 (20 is strong) map this to 255..0 (NB: reverse)
      pixels[x + y * 900] = color(map1d(mandel(c, 20), (0..20), (255..0)).to_i)
    end
    update_pixels
  end

  # calculates the "accuracy" of a given point in the mandelbrot set
  # how many iterations the number survives without becoming chaotic
  def mandel(z, max = 10)
    score = 0
    c = z
    while score < max
      # z = z^2 + c
      z = z.mul(z).add(c)
      break if z.abs2 > 4
      score += 1
    end
    score
  end

  def settings
    size 900, 600
  end
end

Mandelbrot.new