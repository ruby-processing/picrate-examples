require 'picrate'
require 'geomerative'

class HelloSvgToPDF < Processing::App
  load_library :pdf
  include_package 'processing.pdf'
  attr_reader :grp, :pdf

  def settings
    size(400, 400)
  end

  def setup
    sketch_title 'SVG to PDF sketch'
    RG.init(self)
    @grp = RG.load_shape(data_path('bot1.svg'))
    @pdf = create_graphics(width, height, 'processing.pdf.PGraphicsPDF', data_path('bot1.pdf'))
  end

  def draw
    background(255)
    grp.draw
    pdf.begin_draw
    pdf.background(255)
    grp.draw(pdf)
    pdf.dispose
    pdf.end_draw
  end
end

HelloSvgToPDF.new
